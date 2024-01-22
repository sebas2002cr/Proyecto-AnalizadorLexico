package semantic;

import java.util.ArrayList;
import compilation.Compilable;
import compilation.Compilador;

public class ArbolSintactico implements Compilable {
	public ArrayList<Funcion> funciones = new ArrayList<Funcion>();
	private ArrayList<String> literalesString = new ArrayList<String>();
	private ArrayList<ArrayList<Variable>> matrizVariables = new ArrayList<ArrayList<Variable>>();
	private ArrayList<BloqueCodigo> bloquesCodigo = new ArrayList<BloqueCodigo>();
	private ArrayList<ArrayList<Expresion>> matrizExpresiones = new ArrayList<ArrayList<Expresion>>();
	private ArrayList<Condicional> condicionales = new ArrayList<Condicional>();

	// Añade una función
	public void agregar(Funcion funcion) {
		funciones.add(funcion);
	}

	// Almacena la declaración de una variable
	public void agregar(Variable variable) {
		if(matrizVariables.size() == 0){
			matrizVariables.add(new ArrayList<Variable>());
		}
		matrizVariables.get(matrizVariables.size() - 1).add(variable);
	}

	// Añade un nuevo bloque de código a la pila
	public void agregar(BloqueCodigo bloque) {
		bloquesCodigo.add(bloque);
	}

	// Añade una nueva expresión al listado
	public void agregar(Expresion expresion) {
		if(matrizExpresiones.size() == 0){
			matrizExpresiones.add(new ArrayList<Expresion>());
		}
		matrizExpresiones.get(matrizExpresiones.size() - 1).add(expresion);
		if(expresion.getClass() == Literal.class) {
			Literal literal = (Literal)expresion;
			if(literal.tipo.nombre == Tipos.STRING) this.literalesString.add(literal.valor);
		}
	}

	// Añade una línea de código al último bloque de código de la pila
	public void agregar(LineaCodigo lineaCodigo) {
		bloquesCodigo.get(bloquesCodigo.size() - 1).agregar(lineaCodigo);
	}

	public void agregar(Condicional condicional) {
		condicionales.get(condicionales.size() - 1).siNoAcierta(condicional);
	}

	public void agregar(If objetoIf) {
		bloquesCodigo.get(bloquesCodigo.size() - 1).agregar(objetoIf);
		condicionales.add(objetoIf);
	}

	public void nuevasVariables() {
		matrizVariables.add(new ArrayList<Variable>());
	}

	// Añade una nueva lista de expresiones a la matriz
	public void nuevasExpresiones(){
		matrizExpresiones.add(new ArrayList<Expresion>());
	}

	// Devuelve las declaraciones de variables almacenadas y elimina las ultimas
	public ArrayList<Variable> variables(boolean pop) {
		matrizVariables.remove(matrizVariables.size() - 1);
		if(matrizVariables.size() > 0){
			return matrizVariables.remove(matrizVariables.size() - 1);
		}
		return new ArrayList<Variable>();
	}

	public ArrayList<Variable> variables() {
		int ultimoIndice = matrizVariables.size() - 1;
		ArrayList<Variable> oldVariables = new ArrayList<Variable>();
		for(Variable variable : this.matrizVariables.get(ultimoIndice)) oldVariables.add(variable);
		this.matrizVariables.get(ultimoIndice).clear();
		return oldVariables;
	}

	// Quita el último bloque de código de la pila y lo retorna
	public BloqueCodigo bloqueCodigo() {
		BloqueCodigo bloque = bloquesCodigo.remove(bloquesCodigo.size() - 1);
		return bloque;
	}

	// Elimina la última condicional de la pila
	public void condicional() {
		condicionales.remove(condicionales.size() - 1);
	}

	public ArrayList<Expresion> expresiones(boolean eliminarDos) {
		if(eliminarDos) matrizExpresiones.remove(matrizExpresiones.size() - 1);
		if(matrizExpresiones.size() > 0){
			ArrayList<Expresion> removida = matrizExpresiones.remove(matrizExpresiones.size() - 1);
			return this.agruparExpresiones(removida);
		}
		return new ArrayList<Expresion>();
	}

	public ArrayList<Expresion> expresiones() {
		int ultimoIndice = matrizExpresiones.size() - 1;
		ArrayList<Expresion> oldExpresiones = new ArrayList<Expresion>();
		for(Expresion expresion : this.matrizExpresiones.get(ultimoIndice)) oldExpresiones.add(expresion);
		this.matrizExpresiones.get(ultimoIndice).clear();
		return this.agruparExpresiones(oldExpresiones);
	}

	private ArrayList<Expresion> agruparExpresiones(ArrayList<Expresion> expresiones) {
		ArrayList<Expresion> nuevasExpresiones = new ArrayList<Expresion>();
		ArrayList<Expresion> grupoExpresiones = new ArrayList<Expresion>();
		int indice = 0;
		while(indice < expresiones.size()) {
			Expresion expresion = expresiones.get(indice);
			if(expresion.getClass() != Separador.class){
				grupoExpresiones.add(expresion);
			} else {
				if(grupoExpresiones.size() == 1) {
					nuevasExpresiones.add(grupoExpresiones.get(0));
				}
				if(grupoExpresiones.size() > 1) {
					nuevasExpresiones.add(new Operacion(grupoExpresiones));
				}
				grupoExpresiones.clear();
			}
			indice++;
		}
		return nuevasExpresiones;
	}

	public void compilar(Compilador compilador) {
		compilador.addLine(".data");
		compilador.addLine("salto_linea: .asciiz \"\\n\"");
		compilador.addLine("resultado_read: .space 100");
		for (String literalString : this.literalesString) {
			String nombreVariable = "string_" + compilador.randomString();
			if(compilador.stringGlobales.get(literalString) == null) {
				compilador.stringGlobales.put(literalString, nombreVariable);
				compilador.addLine(nombreVariable + ": .asciiz " + literalString);
			}
		}
		compilador.addLine();
		compilador.addLine(".text");
		for (Funcion funcion : this.funciones) {
			funcion.compilar(compilador);
		}
		compilador.addLine();
		compilador.addLine(
		"imprimir_salto_linea:" + "\n" +
		"	li, $v0, 4" + "\n" +
		"	la $a0, salto_linea" + "\n" +
		"	syscall" + "\n" +
		"	jr $ra" + "\n" +
		"\n" +
		"potencia_entera:" + "\n" +
		"	# $t1: base" + "\n" +
		"	# $t0: exponente" + "\n" +
		"	# $t0 -> resultado" + "\n" +
		"	li $t2, 1" + "\n" +
		"	multiplicar_potencia:" + "\n" +
		"	beq $t0, $zero, salir_potencia" + "\n" +
        "		mul $t2, $t2, $t1" + "\n" +
        "		addi $t0, $t0, -1" + "\n" +
        "		j multiplicar_potencia" + "\n" +
		"	salir_potencia:" + "\n" +
		"		move $t0, $t2" + "\n" +
		"		jr $ra" + "\n" +
		"\n" +
		"potencia_flotante:" + "\n" +
		"	# $f1: base" + "\n" +
		"	# $f0: exponente" + "\n" +
		"	# $f0 -> resultado" + "\n" +
		"	li.s $f2, 1.0" + "\n" +
		"	li.s $f30, 0.0" + "\n" +
		"	li.s $f31, 1.0" + "\n" +
		"	loop_potencia_float:" + "\n" +
		"       c.eq.s $f0, $f30" + "\n" +
		"		bc1t fin_potencia_float" + "\n" +
		"		mul.s $f2, $f2, $f1" + "\n" +
		"		sub.s $f0, $f0, $f31" + "\n" +
		"		j loop_potencia_float" + "\n" +
		"	fin_potencia_float:" + "\n" +
		"       mov.s $f0, $f2" + "\n" +
		"       jr $ra"
		);
	}
}