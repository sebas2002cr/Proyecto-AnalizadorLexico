package semantic;

import java.util.ArrayList;
import compilation.Compilable;
import compilation.Compilador;

public class Expresion implements Compilable {
	public static Literal literal(String tipo, Object valor) {
		return new Literal(Tipo.fromString(tipo), valor.toString());
	}

	public static Identificador identificador(Object token) {
		return new Identificador(token.toString());
	}

	public static Read read() {
		return new Read();
	}

	public static LlamadaFuncion llamadaFuncion(Object nombre, ArrayList<Expresion> argumentos) {
		return new LlamadaFuncion(nombre.toString(), argumentos);
	}

	public static Separador separador(){
		return new Separador();
	}

	public void compilar(Compilador compilador) {}

	public Tipo getTipo() {
		return null;
	}
}

class Literal extends Expresion {
	Tipo tipo;
	String valor;

	public Literal(Tipo tipo, String valor) {
		this.tipo = tipo;
		this.valor = valor;
	}

	@Override
	public Tipo getTipo() {
		return this.tipo;
	}

	@Override
	public String toString() {
		return this.valor;
	}

	@Override
	public void compilar(Compilador compilador) {
		if(this.tipo.nombre == Tipos.INT) {
			compilador.addLine("li $t0, " + this.valor);
			// "subu $sp, $sp, 4\n" +
			// "li $t0, " + this.valor + "\n" +
			// "sw $t0, 0($sp)\n";
		}
	}
}

class Identificador extends Expresion {
	String identificador;

	public Identificador(Object identificador) {
		this.identificador = identificador.toString();
	}

	@Override
	public String toString() {
		return this.identificador;
	}
}

class Read extends Expresion {}

class LlamadaFuncion extends Expresion {
	String nombre;
	ArrayList<Expresion> argumentos;

	public LlamadaFuncion(String nombre, ArrayList<Expresion> argumentos) {
		this.nombre = nombre;
		this.argumentos = argumentos;
	}

	@Override
	public String toString() {
		return nombre;
	}
}

class Separador extends Expresion {
	@Override
	public String toString() {
		return "SEPARADOR";
	}
}