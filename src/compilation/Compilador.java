package compilation;

import java.io.File;
import java.io.FileWriter;

import semantic.AnalisisSemantico;
import semantic.ArbolSintactico;
import syntaxis.Syntax;

public class Compilador {
	private FileWriter fileWriter;

	public void compilar(String source, String destination) throws Exception {
		ArbolSintactico arbolSintactico = Syntax.parse(source);
		new AnalisisSemantico(arbolSintactico);
		String basePath = System.getProperty("user.dir");
		new File(basePath + destination).createNewFile();
		this.fileWriter = new FileWriter(basePath + destination);
		arbolSintactico.compilar(this);
		fileWriter.close();
		System.out.println("\nCompilación hecha en " + destination);
	}

	public void addLine(String linea) {
		try {
			fileWriter.write(linea + "\n");
		} catch (Exception e) {}
	}

	public void addLine() {
		this.addLine("");
	}
}
