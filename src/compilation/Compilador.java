package compilation;

import java.io.File;
import java.io.FileWriter;
import java.util.HashMap;
import java.util.Random;

import semantic.AnalisisSemantico;
import semantic.ArbolSintactico;
import syntaxis.Syntax;

public class Compilador {
	public HashMap<String, String> variables = new HashMap<String, String>();
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

	public String randomString() {
		int leftLimit = 97; // letter 'a'
		int rightLimit = 122; // letter 'z'
		int targetStringLength = 10;
		Random random = new Random();
		StringBuilder buffer = new StringBuilder(targetStringLength);
		for (int i = 0; i < targetStringLength; i++) {
			int randomLimitedInt = leftLimit + (int)
			(random.nextFloat() * (rightLimit - leftLimit + 1));
			buffer.append((char) randomLimitedInt);
		}
		String generatedString = buffer.toString();
		return generatedString;
	}
}
