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
			arbol.variables(true);
			return new For(
				new AsignacionVariable(asigString.substring(separador + 1),
				expresiones.get(0)),
				expresiones.get(1),
				expresiones.get(2),
				bloqueCodigo
			);
		}
		return new For(
			new DeclaracionAsignacionVariable(
				arbol.variables(true).get(0),
				expresiones.get(0)
			),
			expresiones.get(1),
			expresiones.get(2),
			bloqueCodigo
		);
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
			compilador.tiposVariables.put(variable.nombre, variable.tipo);
			// Asignar desplazamiento en la pila a la variable
			// int desplazamiento = compilador.reserveStackSpace(4); // Ajusta según el tamaño deseado en bytes
			// variable.setDesplazamiento(desplazamiento);

			// Agregar comentarios y código MIPS según el tipo de variable
			compilador.addLine("# Declaración de variable: " + variable.nombre + ", Tipo: " + variable.tipo.nombre);
			compilador.assignStackOffsetForVariable(variable.nombre);
			compilador.tiposVariables.put(variable.nombre, variable.tipo);

			if (variable.tipo.nombre == Tipos.FLOAT) {
				compilador.addLine("subu $sp, $sp, 4");
				compilador.addLine("s.s $f0, 0 ($sp)");
			} else {
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
		compilador.tiposVariables.put(this.declaracion.nombre, this.declaracion.tipo);

		compilador.addLine(
			"# Declaración y asignación de variable: " + declaracion.nombre +
			", Tipo: " + declaracion.tipo.nombre
		);

		// Compilar la asignación de la variable
		asignacion.compilar(compilador);

		// Obtener el desplazamiento de la pila para la variable
		// int desplazamiento = declaracion.getDesplazamiento();

		compilador.assignStackOffsetForVariable(declaracion.nombre);
		compilador.tiposVariables.put(declaracion.nombre, declaracion.tipo);

		// Utilizar el compilador para almacenar el valor en la dirección de la variable
		// en la pila
		compilador.addLine("subu $sp, $sp, 4");
		if (declaracion.tipo.nombre == Tipos.FLOAT) {
			// Almacenar el valor en la dirección de la variable en la pila
			compilador.addLine("s.s $f0, 0($sp)"); // Almacenar el valor flotante
		} else {
			// Tratar como otros tipos de variables (INT, CHAR, BOOLEAN, STRING, etc.)
			compilador.addLine("sw $t0, 0($sp)"); // Almacenar el valor en la pila
		}
		// Ajustar el puntero de la pila después de almacenar el valor
		// compilador.addLine("addu $sp, $sp, 4");
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

		// Utilizar el compilador para almacenar el valor en la dirección de la variable en la pila
		compilador.addLine(
			"sw $t0, " +
			compilador.getStackOffsetForVariable(nombreVariable) +
			"($fp)"
		);
	}
}

class Return extends LineaCodigo {
	Expresion valor;

	Return(Expresion valor) {
		this.valor = valor;
	}

	@Override
	public void compilar(Compilador compilador) {
		this.valor.compilar(compilador);
		compilador.addLine("# Return");
		compilador.addLine(
			"addu $sp, $sp, " +
			compilador.getNextStackOffset() +
			" # Libera las variables de la pila"
		);
		compilador.addLine("jr $ra");
		// if (valor != null) {
		// 	valor.compilar(compilador);

		// 	// Almacenar el resultado en $t0 o $f0
		// 	if (valor.getTipo().nombre == Tipos.FLOAT) {
		// 		compilador.addLine("mov.s $f0, $f0");
		// 	} else {
		// 		compilador.addLine("move $t0, $v0");
		// 	}
		// }

		// // Limpiar la pila después de la llamada
		// compilador.addLine("addu $sp, $sp, " + (valor.getTipo().nombre == Tipos.FLOAT ? 4 : 8));
	}
}

class Break extends LineaCodigo {
	@Override
	public void compilar(Compilador compilador) {
		String etiqueta = compilador.lastFinalLabelLoop();
		compilador.addLine("j " + etiqueta);
	}
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

	@Override
	public void compilar(Compilador compilador) {
		compilador.addLine("# For");

		// Compilar la declaración o asignación de la variable
		if (decAsiVariable != null) {
			decAsiVariable.compilar(compilador);
		} else if (asigVariable != null) {
			asigVariable.compilar(compilador);
		}

		String idInicioBucle = compilador.randomString();
		compilador.addFinalLabelLoop("for_fin_" + idInicioBucle);
		compilador.addLine("for_inicio_" + idInicioBucle + ":");
		finalizacion.compilar(compilador);
		compilador.addLine("beq $t0, $zero, for_fin_" + idInicioBucle);
		bloqueCodigo.compilar(compilador);
		continuacion.compilar(compilador);
		compilador.addLine("j for_inicio_" + idInicioBucle);
		compilador.addLine("for_fin_" + idInicioBucle + ":");
	}
}

class DoUntil extends LineaCodigo {
	BloqueCodigo bloqueCodigo;
	Expresion condicion;

	DoUntil(BloqueCodigo bloqueCodigo, Expresion condicion) {
		this.bloqueCodigo = bloqueCodigo;
		this.condicion = condicion;
	}

	@Override
	public void compilar(Compilador compilador) {
		String idEtiqueta = compilador.randomString();
		compilador.addFinalLabelLoop("final_do_until_" + idEtiqueta);
		compilador.addLine("# Do until");
		compilador.addLine("do_until_" + idEtiqueta + ":");
		this.bloqueCodigo.compilar(compilador);
		this.condicion.compilar(compilador);
		compilador.addLine("beq $t0, $zero, do_until_" + idEtiqueta);
		compilador.addLine("final_do_until_" + idEtiqueta + ":");
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
		compilador.addLine("# jal imprimir_salto_linea");
	}
}