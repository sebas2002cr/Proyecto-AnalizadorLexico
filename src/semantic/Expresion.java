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

	public static Read read(Object tipo) {
		return new Read(Tipo.fromString(tipo.toString()));
	}

	public static LlamadaFuncion llamadaFuncion(Object nombre, ArrayList<Expresion> argumentos) {
		return new LlamadaFuncion(nombre.toString(), argumentos);
	}

	public static Separador separador() {
		return new Separador();
	}

	public void compilar(Compilador compilador) {
	}

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
		if (this.tipo.nombre == Tipos.INT) {
			compilador.addLine("li $t0, " + this.valor);
		}
		if (this.tipo.nombre == Tipos.STRING) {
			compilador.addLine("la $t0, " + compilador.variables.get(this.valor));
		}
		if (this.tipo.nombre == Tipos.BOOLEAN) {
			compilador.addLine("li $t0, " + (valor.equals("true") ? 1 : 0));
		}
		if (this.tipo.nombre == Tipos.CHAR) {
			compilador.addLine("li $t0, " + (int) this.valor.charAt(1));
		}
		if (this.tipo.nombre == Tipos.FLOAT) {
			compilador.addLine("li.s $f0, " + this.valor);

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

class Read extends Expresion {
	Tipo tipo;

	Read(Tipo tipo) {
		this.tipo = tipo;
	}
}

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

	@Override
	public void compilar(Compilador compilador) {
		compilador.addLine("# Guardar el antiguo valor de $fp");
		compilador.addLine("subu $sp, $sp, 4");
		compilador.addLine("sw $fp, 0($sp)");

		compilador.addLine("# Establecer $fp igual a $sp");
		compilador.addLine("move $fp, $sp");

		int offset = 0;
		for (Expresion argumento : argumentos) {
			argumento.compilar(compilador);
			compilador.addLine("# Reservar espacio para argumento en la pila");
			if (argumento.getTipo() != null && argumento.getTipo().nombre == Tipos.FLOAT) {
				compilador.addLine("subu $sp, $sp, 8");
				compilador.addLine("swc1 $f0, " + offset + "($fp)");
				offset += 4;
			} else {
				compilador.addLine("subu $sp, $sp, 4");
				compilador.addLine("sw $t0, " + offset + "($fp)");
				offset += 4;
			}
		}

		compilador.addLine("# Llamada a la función");
		compilador.addLine("jal " + nombre);

		compilador.addLine("# Limpiar la pila después de la llamada");
		compilador.addLine("addu $sp, $fp, " + offset);

		compilador.addLine("# Restaurar el valor antiguo de $fp");
		compilador.addLine("lw $fp, 0($sp)");
		compilador.addLine("addu $sp, $sp, 4");

		if (this.getTipo() != null && this.getTipo().nombre != Tipos.NULL) {
			compilador.addLine("# Guardar el resultado de la función");
			if (this.getTipo().nombre == Tipos.FLOAT) {
				compilador.addLine("subu $sp, $sp, 4");
				compilador.addLine("swc1 $f0, 0($sp)");
			} else {
				compilador.addLine("subu $sp, $sp, 4");
				compilador.addLine("sw $v0, 0($sp)");
			}
		}
	}

}

class Separador extends Expresion {
	@Override
	public String toString() {
		return "SEPARADOR";
	}
}