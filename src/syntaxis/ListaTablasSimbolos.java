package syntaxis;

import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;

public class ListaTablasSimbolos {
	private TablaSimbolos ultimo;
	private ArrayList<TablaSimbolos> tablas = new ArrayList<TablaSimbolos>();
	private ArrayList<Parametro> parametros = new ArrayList<Parametro>();

	public void tabla(Funcion funcion) {
		TablaSimbolos tabla = new TablaSimbolos();
		tabla.agregar(funcion);
		tabla.nombre = funcion.nombre;
		this.ultimo = tabla;
		tablas.add(tabla);
	}

	public void simbolo(Simbolo simbolo) {
		this.ultimo.agregar(simbolo);
	}

	public void simbolo(Parametro parametro){
		this.parametros.add(parametro);
	}

	public void parametro(String lexema){
		for (Parametro parametro : this.parametros) {
			parametro.setLexema(lexema);
			this.ultimo.agregar(parametro);
		}
		this.parametros.clear();
	}

	public void guardar(String path) throws Exception {
		String filePath = System.getProperty("user.dir") + "/" + path;
		System.out.println(filePath);
		new File(filePath).createNewFile();
		FileWriter writer = new FileWriter(filePath);
		for (TablaSimbolos tabla : tablas) {
			writer.write("TABLA: " + tabla.nombre + "\n");
			writer.write(tabla.toString() + "\n");
		}
		writer.close();
	}
}

class TablaSimbolos {
	public String nombre;
	private ArrayList<Simbolo> simbolos = new ArrayList<Simbolo>();

	public void agregar(Simbolo simbolo) {
		simbolos.add(simbolo);
	}

	@Override
	public String toString() {
		String texto = "";
		for (Simbolo simbolo : simbolos) {
			texto += simbolo.toString() + "\n";
		}
		return texto;
	}
}

abstract class Simbolo {}

class Funcion extends Simbolo {
	String nombre, tipo;

	Funcion(Object nombre, Object tipo){
		this.nombre = nombre.toString();
		this.tipo = tipo.toString();
	}

	Funcion() { this.nombre = "main"; }

	@Override
	public String toString() {
		return "funcion, NOMBRE: " + this.nombre + ", TIPO: " + this.tipo;
	}
}

class Lexema extends Simbolo {
	protected String lexema;

	Lexema(Object lexema) {
		this.lexema = lexema.toString();
	}

	@Override
	public String toString() {
		return this.lexema;
	}
}

class Parametro extends Simbolo {
	private String lexema, nombre, tipo;

	public Parametro(String lexema, Object tupla){
		System.out.println(tupla.getClass().getName());
		this.setLexema(lexema);
	}

	public Parametro(Object nombre, Object tipo){
		this.nombre = nombre.toString();
		this.tipo = tipo.toString();
	}

	public void setLexema(String lexema){
		this.lexema = lexema;
	}

	@Override
	public String toString() {
		return this.lexema + ", NOMBRE: " + this.nombre + ", TIPO: " + this.tipo;
	}
}

class LexemaNombre extends Lexema {
	private String nombre;

	LexemaNombre(String lexema, Object nombre){
		super(lexema);
		this.nombre = nombre.toString();
	}

	@Override
	public String toString() {
		return super.lexema + ", NOMBRE: " + nombre;
	}
}