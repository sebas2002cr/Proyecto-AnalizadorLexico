package syntaxis;

import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;

// Clase principal que representa una lista de tablas de símbolos
public class ListaTablasSimbolos {
	private TablaSimbolos ultimo; // Última tabla de símbolos agregada
	private ArrayList<TablaSimbolos> tablas = new ArrayList<TablaSimbolos>(); // Lista de tablas de símbolos
	private ArrayList<Parametro> parametros = new ArrayList<Parametro>(); // Lista de parámetros

	// Método para agregar una nueva tabla de símbolos correspondiente a una función
	public void tabla(Funcion funcion) {
		TablaSimbolos tabla = new TablaSimbolos(); // Crear una nueva tabla de símbolos
		tabla.agregar(funcion); // Agregar la función a la tabla
		tabla.nombre = funcion.nombre; // Establecer el nombre de la tabla como el nombre de la función
		this.ultimo = tabla; // Establecer la última tabla como la recién creada
		tablas.add(tabla); // Agregar la tabla a la lista de tablas
	}

	// Método para agregar un símbolo a la última tabla de símbolos
	public void simbolo(Simbolo simbolo) {
		this.ultimo.agregar(simbolo);
	}

	// Método para agregar un parámetro a la lista de parámetros
	public void simbolo(Parametro parametro) {
		this.parametros.add(parametro);
	}

	// Método para asignar un lexema a todos los parámetros y agregarlos a la última
	// tabla
	public void parametro(String lexema) {
		for (Parametro parametro : this.parametros) {
			parametro.setLexema(lexema);
			this.ultimo.agregar(parametro);
		}
		this.parametros.clear(); // Limpiar la lista de parámetros después de agregarlos a la tabla
	}

	// Método para guardar las tablas de símbolos en un archivo
	public void guardar(String path) throws Exception {
		String filePath = System.getProperty("user.dir") + "/" + path; // Ruta del archivo
		System.out.println(filePath);
		new File(filePath).createNewFile(); // Crear el archivo
		FileWriter writer = new FileWriter(filePath); // Inicializar un escritor de archivos
		for (TablaSimbolos tabla : tablas) {
			writer.write("TABLA: " + tabla.nombre + "\n"); // Escribir el nombre de la tabla
			writer.write(tabla.toString() + "\n"); // Escribir los símbolos en la tabla
		}
		writer.close(); // Cerrar el escritor de archivos
	}
}

// Clase que representa una tabla de símbolos
class TablaSimbolos {
	public String nombre; // Nombre de la tabla
	private ArrayList<Simbolo> simbolos = new ArrayList<Simbolo>(); // Lista de símbolos en la tabla

	// Método para agregar un símbolo a la tabla
	public void agregar(Simbolo simbolo) {
		simbolos.add(simbolo);
	}

	@Override
	public String toString() {
		String texto = "";
		for (Simbolo simbolo : simbolos) {
			texto += simbolo.toString() + "\n"; // Convertir cada símbolo a una cadena y agregarlo al texto
		}
		return texto;
	}
}

// Clase abstracta que representa un símbolo
abstract class Simbolo {
}

// Clase que representa una función (tipo de símbolo)
class Funcion extends Simbolo {
	String nombre, tipo; // Nombre y tipo de la función

	// Constructores
	Funcion(Object nombre, Object tipo) {
		this.nombre = nombre.toString();
		this.tipo = tipo.toString();
	}

	Funcion() {
		this.nombre = "main";
	}

	@Override
	public String toString() {
		return "funcion, NOMBRE: " + this.nombre + ", TIPO: " + this.tipo;
	}
}

// Clase que representa un lexema (tipo de símbolo)
class Lexema extends Simbolo {
	protected String lexema; // El lexema

	// Constructor
	Lexema(Object lexema) {
		this.lexema = lexema.toString();
	}

	@Override
	public String toString() {
		return this.lexema;
	}
}

// Clase que representa un parámetro (tipo de símbolo)
class Parametro extends Simbolo {
	private String lexema, nombre, tipo; // Lexema, nombre y tipo del parámetro

	// Constructores
	public Parametro(String lexema, Object tupla) {
		System.out.println(tupla.getClass().getName());
		this.setLexema(lexema);
	}

	public Parametro(Object nombre, Object tipo) {
		this.nombre = nombre.toString();
		this.tipo = tipo.toString();
	}

	// Método para establecer el lexema del parámetro
	public void setLexema(String lexema) {
		this.lexema = lexema;
	}

	@Override
	public String toString() {
		return this.lexema + ", NOMBRE: " + this.nombre + ", TIPO: " + this.tipo;
	}
}

// Clase que representa un lexema con un nombre adicional (tipo de símbolo)
class LexemaNombre extends Lexema {
	private String nombre; // Nombre adicional

	// Constructor
	LexemaNombre(String lexema, Object nombre) {
		super(lexema);
		this.nombre = nombre.toString();
	}

	@Override
	public String toString() {
		return super.lexema + ", NOMBRE: " + nombre;
	}
}
