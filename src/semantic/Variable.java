package semantic;

public class Variable {
	String nombre;
	Tipo tipo;
	int desplazamiento; // Nuevo campo para almacenar el desplazamiento

	public Variable(Object nombre, Object tipo) {
		this.nombre = nombre.toString();
		this.tipo = Tipo.fromString(tipo.toString());
	}

	public int getDesplazamiento() {
		return this.desplazamiento;
	}

	public void setDesplazamiento(int desplazamiento) {
		this.desplazamiento = desplazamiento;
	}

	@Override
	public String toString() {
		return this.nombre;
	}

	public Tipo getTipo() {
		return this.tipo;
	}
}
