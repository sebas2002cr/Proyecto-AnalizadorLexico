package semantic;

import java.util.ArrayList;

import compilation.Compilador;

public class Condicional extends LineaCodigo {
	Condicional sino;

	public void siNoAcierta(Condicional sino) {
		if (this.sino == null) this.sino = sino;
		else this.sino.siNoAcierta(sino);
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

	@Override
	public String toString() {
		return "if" + condicion + (sino != null ? sino.toString() : "");
	}

	@Override
	public void compilar(Compilador compilador) {
		compilador.addLine("# If ");
		this.condicion.compilar(compilador);
		String idEtiqueta = compilador.randomString();
		compilador.addLine("beq $t0, $zero, sino_if_" + idEtiqueta);
		compilador.addLine("if_" + idEtiqueta + ":");
		this.bloqueCodigo.compilar(compilador);
		compilador.addLine("j fin_if_" + idEtiqueta);
		compilador.addLine("sino_if_" + idEtiqueta + ":");
		if(this.sino != null) this.sino.compilar(compilador);
		compilador.addLine("fin_if_" + idEtiqueta + ":");
	}
}

class Elif extends Condicional {
	Expresion condicion;
	BloqueCodigo bloqueCodigo;

	Elif(Expresion condicion, BloqueCodigo bloqueCodigo) {
		this.condicion = condicion;
		this.bloqueCodigo = bloqueCodigo;
	}

	@Override
	public String toString() {
		return "elif" + condicion + (sino != null ? sino.toString() : "");
	}

	@Override
	public void compilar(Compilador compilador) {
		compilador.addLine("# Elif ");
		this.condicion.compilar(compilador);
		String idEtiqueta = compilador.randomString();
		compilador.addLine("beq $t0, $zero, sino_elif_" + idEtiqueta);
		compilador.addLine("elif_" + idEtiqueta + ":");
		this.bloqueCodigo.compilar(compilador);
		compilador.addLine("j fin_elif_" + idEtiqueta);
		compilador.addLine("sino_elif_" + idEtiqueta + ":");
		if(this.sino != null) this.sino.compilar(compilador);
		compilador.addLine("fin_elif_" + idEtiqueta + ":");
	}
}

class Else extends Condicional {
	BloqueCodigo bloqueCodigo;

	Else(BloqueCodigo bloqueCodigo) {
		this.bloqueCodigo = bloqueCodigo;
	}

	@Override
	public String toString() {
		return "else" + (sino != null ? sino.toString() : "");
	}

	@Override
	public void compilar(Compilador compilador) {
		compilador.addLine("# Else");
		String idEtiqueta = compilador.randomString();
		compilador.addLine("else" + idEtiqueta + ":");
		this.bloqueCodigo.compilar(compilador);
		compilador.addLine("fin_else_" + idEtiqueta + ":");
	}
}