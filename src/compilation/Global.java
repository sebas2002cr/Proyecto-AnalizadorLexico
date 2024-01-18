package compilation;

import semantic.ArbolSintactico;

public class Global {
	public static Global global = new Global();
	public ArbolSintactico arbol;

	public void setArbol(ArbolSintactico arbol) {
		this.arbol = arbol;
	}
}
