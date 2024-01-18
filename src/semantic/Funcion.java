package semantic;

import java.util.ArrayList;
import compilation.Compilable;
import compilation.Compilador;

public class Funcion implements Compilable {
	String nombre;
	Tipo tipo;
	ArrayList<Variable> parametros;
	BloqueCodigo bloqueCodigo;

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

	public void compilar(Compilador compilador){
		if(this.nombre == "main") compilador.addLine("main:");
		else compilador.addLine("function_" + this.nombre + ":");
		compilador.addLine("# Registro de activacion\nmove $fp, $sp");
		this.bloqueCodigo.compilar(compilador);
		compilador.addLine("jr $ra");
		compilador.addLine();
	}
}