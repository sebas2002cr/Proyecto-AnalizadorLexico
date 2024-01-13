package semantic;

public class AnalisisSemantico {
	public AnalisisSemantico(ArbolSintactico arbol) {
		System.out.println("Funciones: " + arbol.funciones.size());
		Funcion funcion1 = arbol.funciones.get(0);
		System.out.println("Tipo funcion1: " + funcion1.tipo.nombre);
		System.out.println("Params funcion1: " + funcion1.parametros.size());
		for (LineaCodigo linea : funcion1.bloqueCodigo.lineasCodigo) {
			System.out.println("Linea funcion1: " + linea.getClass().getName());
		}
	}
}
