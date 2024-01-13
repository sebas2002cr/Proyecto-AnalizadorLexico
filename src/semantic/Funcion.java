package semantic;

import java.util.ArrayList;

public class Funcion {
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
		this.bloqueCodigo = bloqueCodigo;
	}
}