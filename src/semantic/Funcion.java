package semantic;

import java.util.ArrayList;
import compilation.Compilable;
import compilation.Compilador;

public class Funcion implements Compilable {
	String nombre;
	Tipo tipo;
	BloqueCodigo bloqueCodigo;
	public ArrayList<Variable> parametros;

	public Funcion(
		Object nombre,
		Object tipo,
		ArrayList<Variable> parametros,
		BloqueCodigo bloqueCodigo
	) {
		this.nombre = nombre.toString();
		this.tipo = Tipo.fromString(tipo.toString());
		this.parametros = parametros;
		this.bloqueCodigo = bloqueCodigo;
	}

	// constructor de main
	public Funcion(BloqueCodigo bloqueCodigo) {
		this.nombre = "main";
		this.parametros = new ArrayList<Variable>();
		this.bloqueCodigo = bloqueCodigo;
	}

	public void compilar(Compilador compilador) {
		compilador.ultimaFuncion = this;
		if (this.nombre == "main") {
			compilador.addLine("main:");
			compilador.addLine("move $fp, $sp");
		} else
			compilador.addLine("function_" + this.nombre + ":");

		for (Variable parametro : this.parametros) {
			compilador.assignStackOffsetForVariable(parametro.nombre);
			compilador.tiposVariables.put(parametro.nombre, parametro.tipo);
		}

		this.bloqueCodigo.compilar(compilador);

		compilador.addLine();
		if (this.nombre == "main") {
			compilador.addLine("""
			# Terminar el programa
			li $v0, 10
			syscall
			""");
		} else {
			compilador.addLine("# Salir funcion " + this.nombre);
			compilador.addLine(
				"addu $sp, $sp, " +
				compilador.getNextStackOffset() +
				" # Libera las variables de la pila"
			);
			compilador.addLine("jr $ra");
		}

		compilador.clearStackOffset();
		compilador.tiposVariables.clear();
	}
}