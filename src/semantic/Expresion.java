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
			compilador.addLine("la $t0, " + compilador.stringGlobales.get(this.valor));
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
	Tipo tipo;

	public Identificador(Object identificador) {
		this.identificador = identificador.toString();
	}

	@Override
	public String toString() {
		return identificador;
	}

	@Override
	public Tipo getTipo() {
		return this.tipo;
	}

	@Override
	public void compilar(Compilador compilador) {
		// Obtener el desplazamiento para la variable
		int desplazamiento = compilador.getStackOffsetForVariable(this.identificador);
		Tipo tipoVariable = compilador.tiposVariables.get(this.identificador);
		this.tipo = tipoVariable;
		// Cargar el valor desde la memoria a $t0 (o $f0 para variables de punto flotante)
		if (tipoVariable.nombre == Tipos.FLOAT) {
			compilador.addLine("l.s $f0, " + desplazamiento + "($fp)");
		} else {
			compilador.addLine("lw $t0, " + desplazamiento + "($fp)");
		}
	}

	// private int getDesplazamiento(Compilador compilador) {
	// 	return compilador.getStackOffsetForVariable(this.identificador);
	// 	// Utilizar el nuevo método getVariable
	// 	Variable variable = compilador.getVariable(identificador);
	// 	if (variable != null) {
	// 		return compilador.getStackOffsetForVariable(variable);
	// 	} else {
	// 		// Manejar el caso en que la variable no se encuentra
	// 		throw new RuntimeException("Variable no encontrada: " + identificador);
	// 	}
	// }
}

class Read extends Expresion {
	Tipo tipo;

	Read(Tipo tipo) {
		this.tipo = tipo;
	}

	@Override
	public String toString() {
		return "Read";
	}

	@Override
	public Tipo getTipo() {
		return this.tipo;
	}

	@Override
	public void compilar(Compilador compilador) {
		compilador.addLine("# Read " + tipo.nombre);
		if (tipo.nombre == Tipos.INT) {
			compilador.addLine("li $v0, 5");
			compilador.addLine("syscall");
			compilador.addLine("move $t0, $v0");
		} else if (tipo.nombre == Tipos.FLOAT) {
			compilador.addLine("li $v0, 6");
			compilador.addLine("syscall");
		} else if (tipo.nombre == Tipos.STRING) {
			compilador.addLine("li $v0, 8");
			compilador.addLine("la $a0, resultado_read");
			compilador.addLine("la $a1, 100");
			compilador.addLine("syscall");
			compilador.addLine("la $t0, resultado_read");
		}
	}
}

class LlamadaFuncion extends Expresion {
	String nombre;
	ArrayList<Expresion> argumentos;
	Tipo tipo;

	public LlamadaFuncion(String nombre, ArrayList<Expresion> argumentos) {
		this.nombre = nombre;
		this.argumentos = argumentos;
	}

	@Override
	public String toString() {
		return nombre;
	}

	@Override
	public Tipo getTipo() {
		return this.tipo;
	}

	@Override
	public void compilar(Compilador compilador) {
		// Buscamos la función
		Funcion funcionActual = null;
		for (Funcion funcion : compilador.funciones) {
			if(funcion.nombre.equals(this.nombre)){
				funcionActual = funcion;
				break;
			}
		}
		this.tipo = funcionActual.tipo;

		// Guardamos el registro de activación
		compilador.addLine("subu $sp, $sp, 4 # Aparta campo en la pila para el $fp");
		compilador.addLine("sw $fp, 0($sp) # Guarda el $fp");

		// Mover fp a la posición actual de la pila
		compilador.addLine("move $fp, $sp # Nuevo registro de activación para la función actual");

		// Reservar espacio en la pila para los argumentos
		int offset = 0;
		for (int i=0; i<argumentos.size(); i++) {
			Expresion argumento = this.argumentos.get(i);
			argumento.compilar(compilador);
			compilador.addLine("subu $sp, $sp, 4");
			if (argumento.getTipo().nombre == Tipos.FLOAT) {
				compilador.addLine("swc1 $f0, 0($sp)");
			} else {
				compilador.addLine("sw $t0, 0($sp)");
			}
			offset += 4;
		}

		// Llamada a la función
		compilador.addLine("jal function_" + nombre);

		// Limpiar la pila después de la llamada
		compilador.addLine("addu $sp, $sp, " + offset + " # Libera los parámetros de la pila");
		compilador.addLine("lw $fp, 0($sp) # Restaura el $fp anterior");
		compilador.addLine("addu $sp, $sp, 4 # Libera el fp de la pila");
	}

}

class Separador extends Expresion {
	@Override
	public String toString() {
		return "SEPARADOR";
	}
}