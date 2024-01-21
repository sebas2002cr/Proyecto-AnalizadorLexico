package semantic;

public class Tipo {
	Tipos nombre;

	Tipo(Tipos nombre) {
		this.nombre = nombre;
	}

	static Tipo fromString(String tipoString) {
		try {
			return new Tipo(Tipos.valueOf(tipoString.toUpperCase()));
		} catch (Exception e) {
			int index = tipoString.indexOf("[");
			Tipos tipoLista = Tipos.valueOf(tipoString.substring(0, index).toUpperCase());
			return new Lista(
				tipoLista == Tipos.CHAR ? Tipos.LIST_CHAR : tipoLista == Tipos.INT ? Tipos.LIST_INT : Tipos.NULL,
				Integer.parseInt(tipoString.substring(index + 1, tipoString.length() - 1).toUpperCase())
			);
		}
	}
}

enum Tipos {
	INT,
	FLOAT,
	STRING,
	CHAR,
	LIST_INT,
	LIST_CHAR,
	BOOLEAN,
	NULL
}

class Lista extends Tipo {
	int tamanno;

	Lista(Tipos nombre, int tamanno) {
		super(nombre);
		this.tamanno = tamanno;
	}
}