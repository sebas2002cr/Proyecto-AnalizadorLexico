package compilation;

import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import semantic.AnalisisSemantico;
import semantic.ArbolSintactico;
import semantic.Variable;
import syntaxis.Syntax;

public class Compilador {
	public HashMap<String, String> variables = new HashMap<String, String>();
	private FileWriter fileWriter;
	private int nextStackOffset = 0;
	private Map<Variable, Integer> variableStackOffsets = new HashMap<>();
	private ArrayList<String> finalLabelLoops = new ArrayList<String>();

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
		} catch (Exception e) {
		}
	}

	public int getNextStackOffset() {
		return nextStackOffset;
	}

	public int getStackOffsetForVariable(Variable variable) {
		return variableStackOffsets.getOrDefault(variable, 0);
	}

	public int reserveStackSpace(int bytes) {
		int currentOffset = nextStackOffset;
		nextStackOffset += bytes;
		return currentOffset;
	}

	public void assignStackOffsetForVariable(Variable variable) {
		int offset = reserveStackSpace(4); // Ajusta según el tamaño deseado en bytes
		variableStackOffsets.put(variable, offset);
	}

	public void addLine() {
		this.addLine("");
	}

	public void addFinalLabelLoop(String finalLabelLoop) {
		finalLabelLoops.add(finalLabelLoop);
	}

	public String lastFinalLabelLoop() {
		return this.finalLabelLoops.get(this.finalLabelLoops.size() - 1);
	}

	public String randomString() {
		int leftLimit = 97; // letter 'a'
		int rightLimit = 122; // letter 'z'
		int targetStringLength = 10;
		Random random = new Random();
		StringBuilder buffer = new StringBuilder(targetStringLength);
		for (int i = 0; i < targetStringLength; i++) {
			int randomLimitedInt = leftLimit + (int) (random.nextFloat() * (rightLimit - leftLimit + 1));
			buffer.append((char) randomLimitedInt);
		}
		String generatedString = buffer.toString();
		return generatedString;
	}
}
