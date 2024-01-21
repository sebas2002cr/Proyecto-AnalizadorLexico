package compilation;

import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

import semantic.AnalisisSemantico;
import semantic.ArbolSintactico;
import semantic.Funcion;
import semantic.Tipo;
import syntaxis.Syntax;

public class Compilador {
	public HashMap<String, String> stringGlobales = new HashMap<String, String>();
	public ArrayList<Funcion> funciones;
	public HashMap<String, Tipo> tiposVariables = new HashMap<String, Tipo>();
	private FileWriter fileWriter;
	private int nextStackOffset = 0;
	private HashMap<String, Integer> variableStackOffsets = new HashMap<String, Integer>();
	private ArrayList<String> finalLabelLoops = new ArrayList<String>();

	public void compilar(String source, String destination) throws Exception {
		ArbolSintactico arbolSintactico = Syntax.parse(source);
		this.funciones = arbolSintactico.funciones;
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

	public void addLine() {
		this.addLine("");
	}

	// public Variable getVariable(String nombre) {
	// 	for (Map.Entry<Variable, Integer> entry : variableStackOffsets.entrySet()) {
	// 		Variable variable = entry.getKey();
	// 		if (variable.toString().equals(nombre)) {
	// 			return variable;
	// 		}
	// 	}
	// 	return null; // Variable no encontrada
	// }

	public int getNextStackOffset() {
		return nextStackOffset;
	}

	public int getStackOffsetForVariable(String nombreVariable) {
		return -(variableStackOffsets.get(nombreVariable) + 4);
		// return variableStackOffsets.getOrDefault(variable, 0);
	}

	private int reserveStackSpace(int bytes) {
		int currentOffset = nextStackOffset;
		nextStackOffset += bytes;
		return currentOffset;
	}

	public void assignStackOffsetForVariable(String nombreVariable) {
		int offset = this.reserveStackSpace(4); // Ajusta según el tamaño deseado en bytes
		this.variableStackOffsets.put(nombreVariable, offset);
	}

	public void clearStackOffset() {
		this.variableStackOffsets.clear();
		this.nextStackOffset = 0;
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
