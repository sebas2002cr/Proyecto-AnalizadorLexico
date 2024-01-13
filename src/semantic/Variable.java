package semantic;

public class Variable {
	String nombre;
	Tipo tipo;

	public Variable(Object nombre, Object tipo) {
		this.nombre = nombre.toString();
		this.tipo = Tipo.fromString(tipo.toString());
	}

	@Override
	public String toString() {
		return this.nombre;
	}
}