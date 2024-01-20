package semantic;

import java.util.ArrayList;

import compilation.Compilador;

public class Operacion extends Expresion {
	ArrayList<Expresion> elementos = new ArrayList<Expresion>();
	Expresion valor;
	Operacion izquierda;
	Operando operando;
	Operacion derecha;

	Operacion() {}

	Operacion(ArrayList<Expresion> elementos) {
		this.priorizarParentesis(elementos);
		// System.out.println(this.print(0));
	}

	Operacion(Expresion valor) {
		this.valor = valor;
	}

	public static Operando operando(String simbolo) {
		return new Operando(simbolo);
	}

	private void priorizarParentesis(ArrayList<Expresion> elementos) {
		ArrayList<ArrayList<Expresion>> subOperaciones = new ArrayList<ArrayList<Expresion>>();
		subOperaciones.add(this.nuevaSubExpresion());
		for (Expresion elemento : elementos) {
			// Añadir el elemento actual a la última operación de cada sub-operación
			for (ArrayList<Expresion> subOperacion : subOperaciones) {
				Expresion ultima = this.ultimaExpresion(subOperacion);
				if(ultima.getClass() == Operacion.class){
					((Operacion)ultima).elementos.add(elemento);
				}
			}

			// Tratamiento para operandos
			if(elemento.getClass() == Operando.class) {
				Operando operando = (Operando)elemento;
				// Si es un paréntesis abierto se añade una nueva sub-operación
				if(operando.tipo == Operandos.PARENTESIS_ABIERTO) {
					ultimaOperacion(subOperaciones).elementos.add(elemento);
					subOperaciones.add(this.nuevaSubExpresion());
				}

				// Si es un paréntesis cerrado, prioriza por signo
				// Quitamos la última sub-operación
				// Copiamos el resultado de la priorización por signo en el último elemento de la última sub-operación
				else if(operando.tipo == Operandos.PARENTESIS_CERRADO) {
					Operacion operacion = this.priorizarSignos(this.ultimaSubExpresion(subOperaciones));
					subOperaciones.remove(subOperaciones.size() - 1);
					this.ultimaOperacion(subOperaciones).copiar(operacion);
				}

				// Caso para operandos, añadimos el operando y una nueva operación a la última sub-operación
				else {
					var ultima = this.ultimaSubExpresion(subOperaciones);
					ultima.add(operando);
					ultima.add(new Operacion());
				}
			}

			// Tratamiento para no operandos(operadores)
			else {
				var ultima = this.ultimaOperacion(subOperaciones);
				ultima.elementos.add(elemento);
				ultima.valor = elemento;
			}
		}
		var operacion = this.priorizarSignos(subOperaciones.get(0));
		this.copiar(operacion);
	}

	private Operacion priorizarSignos(ArrayList<Expresion> subOperacion) {
		// Si hay sólo un elemento se devuelve como valor
		if(subOperacion.size() == 1) {
			var operacion = (Operacion)subOperacion.get(0);
			return operacion;
		}

		// Buscamos el índice menos prioritario
		int menosPrioritario = subOperacion.size() - 2;
		for (int i = subOperacion.size() - 1; i >= 0; i--) {
			var elemento = subOperacion.get(i);
			if(elemento.getClass() == Operando.class) {
				var operandoActual = (Operando)elemento;
				var operandoMenosPrioritario = (Operando)subOperacion.get(menosPrioritario);
				if(operandoActual.prioridad() < operandoMenosPrioritario.prioridad()) {
					menosPrioritario = i;
				}
			}
		}

		// Creamos la nueva operación a devolver
		var operacion = new Operacion();
		operacion.izquierda = this.priorizarSignos(subSubExpresion(subOperacion, 0, menosPrioritario));
		operacion.operando = (Operando)subOperacion.get(menosPrioritario);
		operacion.derecha = this.priorizarSignos(subSubExpresion(subOperacion, menosPrioritario + 1, subOperacion.size()));
		return operacion;
	}

	private void copiar(Operacion origen) {
		this.valor = origen.valor;
		this.izquierda = origen.izquierda;
		this.operando = origen.operando;
		this.derecha = origen.derecha;
	}

	private String print(int nivel) {
		if(this.operando != null) {
			return
				((this.izquierda != null) ? "(" + this.izquierda.print(nivel + 1) + ")" : "") +
				this.operando.toString() +
				((this.derecha != null) ? "(" + this.derecha.print(nivel + 1) + ")" : "");
		}
		if(this.valor != null) {
			return this.valor.toString();
		}
		return "";
	}

	private ArrayList<Expresion> ultimaSubExpresion(ArrayList<ArrayList<Expresion>> subExpresiones) {
		return subExpresiones.get(subExpresiones.size() - 1);
	}

	private Expresion ultimaExpresion(ArrayList<Expresion> expresiones) {
		return expresiones.get(expresiones.size() - 1);
	}

	private Operacion ultimaOperacion(ArrayList<ArrayList<Expresion>> subOperaciones) {
		return (Operacion)ultimaExpresion(ultimaSubExpresion(subOperaciones));
	}

	private ArrayList<Expresion> nuevaSubExpresion() {
		ArrayList<Expresion> subOperacion = new ArrayList<Expresion>();
		subOperacion.add(new Operacion());
		return subOperacion;
	}

	private ArrayList<Expresion> subSubExpresion(ArrayList<Expresion> subExpresion, int start, int end) {
		var subList = new ArrayList<Expresion>();
		for(int i=start; i<end; i++){
			subList.add(subExpresion.get(i));
		}
		return subList;
	}

	@Override
	public void compilar(Compilador compilador) {
		if(this.operando != null) {
			if(this.izquierda.valor != null) {
				this.izquierda.compilar(compilador);
				compilador.addLine("subu $sp, $sp, 4");
				compilador.addLine("sw $t0, 0($sp)");
			}
			this.derecha.compilar(compilador);
			// Si es una operación unaria
			compilador.addLine("# " + this.operando.tipo);
			if(this.operando.prioridad() == 4) {
				if(this.operando.tipo == Operandos.INCREMENTO) {
					compilador.addLine("addi $t0, $t0, 1");
				}
				if(this.operando.tipo == Operandos.DECREMENTO) {
					compilador.addLine("addi $t0, $t0, -1");
				}
				if(this.operando.tipo == Operandos.DECREMENTO) {
					compilador.addLine("addi $t0, $t0, -1");
				}
				if(this.operando.tipo == Operandos.NEGATIVO) {
					compilador.addLine("li $t1, -1");
					compilador.addLine("mul $t0, $t0, $t1");
				}
			} else {
				// Sacamos el valor de izquierda de la pila
				compilador.addLine("lw $t1, 0($sp)");
				compilador.addLine("addiu $sp, $sp, 4");
				if(this.operando.tipo == Operandos.SUMA) {
					compilador.addLine("add $t0, $t0, $t1");
				}
				if(this.operando.tipo == Operandos.RESTA) {
					compilador.addLine("sub $t0, $t0, $t1");
				}
				if(this.operando.tipo == Operandos.MULTIPLICACION) {
					compilador.addLine("mul $t0, $t0, $t1");
				}
				if(this.operando.tipo == Operandos.DIVISION) {
					compilador.addLine("div $t1, $t0");
					compilador.addLine("mflo $t0");
				}
				if(this.operando.tipo == Operandos.POTENCIA) {
					compilador.addLine("jal potencia");
				}
				if(this.operando.tipo == Operandos.MODULO) {
					compilador.addLine("div $t1, $t0");
					compilador.addLine("mfhi $t0");
				}
				if(this.operando.tipo == Operandos.DISTINTO) {
					this.compilarComparacion(compilador, "distinto", "bne");
				}
				if(this.operando.tipo == Operandos.IGUAL) {
					this.compilarComparacion(compilador, "igual", "beq");
				}
				if(this.operando.tipo == Operandos.MENOR) {
					compilador.addLine("slt $t0, $t1, $t0");
				}
				if(this.operando.tipo == Operandos.MAYOR) {
					compilador.addLine("slt $t0, $t0, $t1");
				}
				if(this.operando.tipo == Operandos.MENOR_IGUAL) {
					compilador.addLine("slt $t0, $t0, $t1");
					compilador.addLine("li $t1, 0");
					this.compilarComparacion(compilador, "menor_igual", "beq");
				}
				if(this.operando.tipo == Operandos.MAYOR_IGUAL) {
					compilador.addLine("slt $t0, $t1, $t0");
					compilador.addLine("li $t1, 0");
					this.compilarComparacion(compilador, "mayor_igual", "beq");
				}
				if(this.operando.tipo == Operandos.AND) {
					compilador.addLine("and $t0, $t0, $t1");
				}
				if(this.operando.tipo == Operandos.OR) {
					compilador.addLine("or $t0, $t0, $t1");
				}
			}
			return;
		}
		if(this.valor != null) valor.compilar(compilador);
	}

	private void compilarComparacion(Compilador compilador, String comparacion, String instruccion) {
		String idEtiqueta = compilador.randomString();
		compilador.addLine(instruccion + " $t0, $t1, " + comparacion + "_" + idEtiqueta);
		compilador.addLine("li $t0, 0");
		compilador.addLine("j no_" + comparacion + "_" + idEtiqueta);
		compilador.addLine(comparacion + "_" + idEtiqueta + ": li $t0, 1");
		compilador.addLine("no_" + comparacion + "_" + idEtiqueta + ":");
	}

	@Override
	public Tipo getTipo() {
		if(this.valor != null) return this.valor.getTipo();
		if(this.operando != null) {
			if(this.operando.tipo == Operandos.NOT || this.operando.prioridad() < 2) {
				return new Tipo(Tipos.BOOLEAN);
			} else {
				var tipoIzquierdo = this.izquierda.getTipo();
				var tipoDerecho = this.derecha.getTipo();
				if(tipoIzquierdo.nombre == Tipos.FLOAT || tipoDerecho.nombre == Tipos.FLOAT) {
					return new Tipo(Tipos.FLOAT);
				}
				return new Tipo(Tipos.INT);
			}
		}
		return new Tipo(Tipos.NULL);
	}
}

enum Operandos {
	OR,
	AND,
	DISTINTO,
	IGUAL,
	MENOR,
	MAYOR,
	MENOR_IGUAL,
	MAYOR_IGUAL,
	SUMA,
	RESTA,
	MULTIPLICACION,
	DIVISION,
	MODULO,
	POTENCIA,
	INCREMENTO,
	DECREMENTO,
	NEGATIVO,
	NOT,
	PARENTESIS_ABIERTO,
	PARENTESIS_CERRADO
}

class Operando extends Expresion {
	Operandos tipo;

	Operando(String simbolo) {
		this.tipo = Operandos.valueOf(simbolo);
	}

	@Override
	public String toString() {
		return tipo.toString();
	}

	int prioridad() {
		if(this.tipo == Operandos.OR) return 0;
		if(this.tipo == Operandos.AND) return 0;

		if(this.tipo == Operandos.DISTINTO) return 1;
		if(this.tipo == Operandos.IGUAL) return 1;
		if(this.tipo == Operandos.MENOR) return 1;
		if(this.tipo == Operandos.MAYOR) return 1;
		if(this.tipo == Operandos.MENOR_IGUAL) return 1;
		if(this.tipo == Operandos.MAYOR_IGUAL) return 1;

		if(this.tipo == Operandos.SUMA) return 2;
		if(this.tipo == Operandos.RESTA) return 2;

		if(this.tipo == Operandos.MULTIPLICACION) return 3;
		if(this.tipo == Operandos.DIVISION) return 3;
		if(this.tipo == Operandos.MODULO) return 3;
		if(this.tipo == Operandos.POTENCIA) return 3;

		if(this.tipo == Operandos.INCREMENTO) return 4;
		if(this.tipo == Operandos.DECREMENTO) return 4;
		if(this.tipo == Operandos.NEGATIVO) return 4;
		if(this.tipo == Operandos.NOT) return 4;

		if(this.tipo == Operandos.PARENTESIS_ABIERTO) return 5;
		if(this.tipo == Operandos.PARENTESIS_CERRADO) return 5;

		return -1;
	}
}
