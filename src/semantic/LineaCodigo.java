package semantic;

import java.util.ArrayList;
import compilation.Compilable;
import compilation.Compilador;

public class LineaCodigo implements Compilable {
	public static BloqueCodigo bloqueCodigo() {
		return new BloqueCodigo();
	}

	public static LineaExpresion expresion(ArrayList<Expresion> expresion) {
		return new LineaExpresion(expresion.get(0));
	}

	public static DeclaracionesVariables declaracionesVariables(ArrayList<Variable> declaraciones) {
		return new DeclaracionesVariables(declaraciones);
	}

	public static AsignacionVariable asignacionVariable(Object nombreVariable, ArrayList<Expresion> expresiones) {
		return new AsignacionVariable(nombreVariable.toString(), expresiones.get(0));
	}

	public static DeclaracionAsignacionVariable declaracionAsignacionVariable(
			ArrayList<Variable> variables, ArrayList<Expresion> expresiones) {
		return new DeclaracionAsignacionVariable(variables.get(0), expresiones.get(0));
	}

	public static Return returnLine(ArrayList<Expresion> expresiones) {
		return new Return(expresiones.get(0));
	}

	public static Break breakLine() {
		return new Break();
	}

	public static For forLine(
			Object asignacion,
			ArbolSintactico arbol,
			ArrayList<Expresion> expresiones,
			BloqueCodigo bloqueCodigo) {
		String asigString = asignacion.toString();
		int separador = asigString.indexOf("|");
		String tipoAsignacion = asigString.substring(0, separador);
		if (tipoAsignacion.equals("asignar_variable_declarada")) {
			return new For(
					new AsignacionVariable(asigString.substring(separador + 1), expresiones.get(0)),
					expresiones.get(1),
					expresiones.get(2),
					bloqueCodigo);
		}
		return new For(
				new DeclaracionAsignacionVariable(arbol.variables(true).get(0), expresiones.get(0)),
				expresiones.get(1),
				expresiones.get(2),
				bloqueCodigo);
	}

	public static DoUntil doUntil(BloqueCodigo bloqueCodigo, ArrayList<Expresion> expresiones) {
		return new DoUntil(bloqueCodigo, expresiones.get(0));
	}

	public static Print print(ArrayList<Expresion> expresiones) {
		return new Print(expresiones.get(0));
	}

	public void compilar(Compilador compilador) {
	}
}

class BloqueCodigo implements Compilable {
	ArrayList<LineaCodigo> lineasCodigo = new ArrayList<LineaCodigo>();

	public void agregar(LineaCodigo lineaCodigo) {
		lineasCodigo.add(lineaCodigo);
	}

	public void compilar(Compilador compilador) {
		for (LineaCodigo lineaCodigo : lineasCodigo) {
			compilador.addLine();
			lineaCodigo.compilar(compilador);
		}
	}
}

class LineaExpresion extends LineaCodigo {
	Expresion expresion;

	LineaExpresion(Expresion expresion) {
		this.expresion = expresion;
	}

	@Override
	public void compilar(Compilador compilador) {
		compilador.addLine(
				"# LineaExpresion: " +
						expresion.getClass().getSimpleName() + " -> " +
						expresion.toString());
		expresion.compilar(compilador);
	}
}

class DeclaracionesVariables extends LineaCodigo {
	ArrayList<Variable> declaraciones = new ArrayList<Variable>();

	DeclaracionesVariables(ArrayList<Variable> declaraciones) {
		this.declaraciones = declaraciones;
	}

	@Override
	public void compilar(Compilador compilador) {
		for (Variable variable : declaraciones) {
			// Utilizar el compilador para asignar la dirección en la pila
			compilador.assignStackOffsetForVariable(variable);
			compilador.addLine("# Declaración de variable: " + variable.nombre + ", Tipo: " + variable.tipo.nombre);

			// Verificar si es una variable de tipo FLOAT
			if (variable.tipo.nombre == Tipos.FLOAT) {
				// Reservar espacio en la pila para almacenar el valor (4 bytes para FLOAT)
				compilador.addLine("subu $sp, $sp, 4");
				compilador.addLine("s.s $f0, 0($sp)");
			} else {
				// Reservar espacio en la pila para almacenar el valor (4 bytes para otros
				// tipos)
				compilador.addLine("subu $sp, $sp, 4");
				compilador.addLine("sw $t0, 0($sp)");
			}
		}
	}
}

class DeclaracionAsignacionVariable extends LineaCodigo {
	Variable declaracion;
	Expresion asignacion;

	DeclaracionAsignacionVariable(Variable declaracion, Expresion asignacion) {
		this.declaracion = declaracion;
		this.asignacion = asignacion;
	}

	@Override
	public void compilar(Compilador compilador) {
		compilador.addLine("# Declaración y asignación de variable: " + declaracion.nombre +
				", Tipo: " + declaracion.tipo.nombre);

		// Compilar la asignación de la variable
		asignacion.compilar(compilador);

		// Utilizar el compilador para almacenar el valor en la dirección de la variable
		// en la pila
		// Verificar si es una variable de tipo FLOAT
		if (declaracion.tipo.nombre == Tipos.FLOAT) {
			compilador.addLine("s.s $f0, " + compilador.getStackOffsetForVariable(declaracion) + "($sp)");
		} else {
			compilador.addLine("lw $t0, 0($sp)"); // Cargar el valor desde la pila al registro $t0
			compilador.addLine("sw $t0, " + compilador.getStackOffsetForVariable(declaracion) + "($sp)");
		}

		// Ajustar el puntero de la pila después de almacenar el valor
		compilador.addLine("addu $sp, $sp, 4");
	}
}

class AsignacionVariable extends LineaCodigo {
	String nombreVariable;
	Expresion asignacion;

	AsignacionVariable(String nombreVariable, Expresion asignacion) {
		this.nombreVariable = nombreVariable;
		this.asignacion = asignacion;
	}

	@Override
	public void compilar(Compilador compilador) {
		compilador.addLine("# Asignación de variable: " + nombreVariable);

		// Compilar la asignación de la variable
		asignacion.compilar(compilador);

		// Utilizar el compilador para almacenar el valor en la dirección de la variable
		// en la pila
		compilador.addLine(
				"sw $t0, " + compilador.getStackOffsetForVariable(new Variable(nombreVariable, null)) + "($sp)");
	}
}

class Return extends LineaCodigo {
	Expresion valor;

	Return(Expresion valor) {
		this.valor = valor;
	}

	@Override
	public void compilar(Compilador compilador) {
		if (valor != null) {
			valor.compilar(compilador);

			// Empujar el resultado a la pila
			if (valor.getTipo().nombre == Tipos.FLOAT) {
				compilador.addLine("subu $sp, $sp, 4");
				compilador.addLine("swc1 $f0, 0($sp)");
			} else {
				compilador.addLine("subu $sp, $sp, 4");
				compilador.addLine("sw $v0, 0($sp)");
			}
		}

		// Limpiar la pila después de la llamada
		compilador.addLine("addu $sp, $sp, " + (valor.getTipo().nombre == Tipos.FLOAT ? 4 : 8));
	}
}

class Break extends LineaCodigo {
}

class For extends LineaCodigo {
	DeclaracionAsignacionVariable decAsiVariable;
	AsignacionVariable asigVariable;
	Expresion finalizacion;
	Expresion continuacion;
	BloqueCodigo bloqueCodigo;

	For(DeclaracionAsignacionVariable decAsiVariable, Expresion finalizacion, Expresion continuacion,
			BloqueCodigo bloqueCodigo) {
		this.decAsiVariable = decAsiVariable;
		this.finalizacion = finalizacion;
		this.continuacion = continuacion;
		this.bloqueCodigo = bloqueCodigo;
	}

	For(AsignacionVariable asigVariable, Expresion finalizacion, Expresion continuacion, BloqueCodigo bloqueCodigo) {
		this.asigVariable = asigVariable;
		this.finalizacion = finalizacion;
		this.continuacion = continuacion;
		this.bloqueCodigo = bloqueCodigo;
	}
}

class DoUntil extends LineaCodigo {
	BloqueCodigo bloqueCodigo;
	Expresion condicion;

	DoUntil(BloqueCodigo bloqueCodigo, Expresion condicion) {
		this.bloqueCodigo = bloqueCodigo;
		this.condicion = condicion;
	}
}

class Print extends LineaCodigo {
	Expresion expresion;

	Print(Expresion expresion) {
		this.expresion = expresion;
	}

	@Override
	public void compilar(Compilador compilador) {
		compilador.addLine("# Print " + this.expresion);
		this.expresion.compilar(compilador);
		if (expresion.getTipo().nombre == Tipos.STRING) {
			compilador.addLine("move $a0, $t0");
			compilador.addLine("li $v0, 4");
		} else if (expresion.getTipo().nombre == Tipos.CHAR) {
			compilador.addLine("move $a0, $t0");
			compilador.addLine("li $v0, 11");
		} else if (expresion.getTipo().nombre == Tipos.FLOAT) {
			compilador.addLine("mov.s $f12, $f0");
			compilador.addLine("li $v0, 2");
		} else {
			compilador.addLine("move $a0, $t0");
			compilador.addLine("li $v0, 1");
		}
		compilador.addLine("syscall");
		compilador.addLine("jal imprimir_salto_linea");
	}
}