package semantic;

import java.util.ArrayList;

public class Condicional extends LineaCodigo{
	Condicional sino;

	public void siNoAcierta(Condicional sino) {
		this.sino = sino;
	}

	public static If ifLine(ArrayList<Expresion> expresiones, BloqueCodigo bloqueCodigo){
		return new If(expresiones.get(0), bloqueCodigo);
	}

	public static Elif elif(ArrayList<Expresion> expresiones, BloqueCodigo bloqueCodigo){
		return new Elif(expresiones.get(0), bloqueCodigo);
	}

	public static Else elseCondition(BloqueCodigo bloqueCodigo) {
		return new Else(bloqueCodigo);
	}
}

class If extends Condicional {
	Expresion condicion;
	BloqueCodigo bloqueCodigo;

	If(Expresion condicion, BloqueCodigo bloqueCodigo) {
		this.condicion = condicion;
		this.bloqueCodigo = bloqueCodigo;
	}
}

class Elif extends Condicional {
	Expresion condicion;
	BloqueCodigo bloqueCodigo;

	Elif(Expresion condicion, BloqueCodigo bloqueCodigo) {
		this.condicion = condicion;
		this.bloqueCodigo = bloqueCodigo;
	}
}

class Else extends Condicional {
	BloqueCodigo bloqueCodigo;

	Else(BloqueCodigo bloqueCodigo) {
		this.bloqueCodigo = bloqueCodigo;
	}
}