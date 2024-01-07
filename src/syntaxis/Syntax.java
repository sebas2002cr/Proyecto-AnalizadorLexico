package syntaxis;

import java.io.FileReader;
import java.io.Reader;
import lexical.CodeLexer;

// Clase que representa la sintaxis del programa
public class Syntax {
    private static String basePath = System.getProperty("user.dir"); // Ruta base del proyecto

    // Método para realizar el análisis sintáctico
    public static void parse(String parsePath) throws Exception {
        Reader inputLexer = new FileReader(basePath + parsePath); // Crear un lector de archivos para el código fuente
        CodeLexer lexer = new CodeLexer(inputLexer); // Inicializar un lexer con el lector de archivos
        new parser(lexer).parse(); // Iniciar el análisis sintáctico utilizando el lexer
    }
}
