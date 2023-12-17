package LexerParser;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.Reader;
import java.nio.file.Files;
import java.nio.file.Paths;
import java_cup.runtime.Symbol;

public class LexerParser {
    // Ruta base del proyecto
    private static String basePath = System.getProperty("user.dir");

    // Método para generar el Lexer y Parser utilizando JFlex y Cup
    public static void generate() throws Exception {
        // Archivos Lexer y Parser
        String[] lexerPath = { basePath + "/src/LexerParser/lexer.jflex" };
        String[] parserPath = { basePath + "/src/LexerParser/parser.cup" };

        // Generar Lexer y Parser
        jflex.Main.generate(lexerPath);
        java_cup.Main.main(parserPath);

        // Mover archivos generados a ubicaciones específicas
        Files.deleteIfExists(Paths.get(basePath + "/src/LexerParser/sym.java"));
        Files.deleteIfExists(Paths.get(basePath + "/src/LexerParser/parser.java"));
        Files.move(Paths.get(basePath + "/sym.java"), Paths.get(basePath + "/src/LexerParser/sym.java"));
        Files.move(Paths.get(basePath + "/parser.java"), Paths.get(basePath + "/src/LexerParser/parser.java"));
    }

    // Método para realizar el análisis léxico
    public static void analyze(String sourcePath, String targetPath) throws Exception {
        // Crear archivo de salida
        new File(basePath + targetPath).createNewFile();

        // Crear FileWriter para archivos de salida
        FileWriter targetWriter = new FileWriter(basePath + targetPath);
        FileWriter errorWriter = new FileWriter(basePath + "/test/errores.txt");

        // Crear lector para el archivo fuente
        Reader reader = new BufferedReader(new FileReader(basePath + sourcePath));
        reader.read();

        // Crear instancia del Lexer
        CodeLexer lexer = new CodeLexer(reader);
        Symbol token;

        // Bucle para analizar tokens
        while (true) {
            token = lexer.next_token();
            if (token.sym != 0) {
                // Escribir en el archivo de salida
                targetWriter.write("ID: " + token.sym + ", " +
                        "Token: " + sym.terminalNames[token.sym] + ", " +
                        "Linea: " + (token.left + 1) + ", " +
                        "Columna: " + token.right + ", " +
                        "Valor: " + (token.value == null ? lexer.yytext() : token.value.toString()) +
                        "\n");

                // Si el token.sym es igual a 1, también escribir en el archivo de errores
                if (token.sym == 1) {
                    errorWriter.write("Token no reconocido: "
                            + (token.value == null ? lexer.yytext() : token.value.toString()) + ", en la linea: "
                            + (token.left + 1) + ", columna " + token.right + "\n");
                }
            } else {
                break;
            }
        }

        // Cierre de FileWriter y mensajes de salida
        targetWriter.close();
        errorWriter.close();
        System.out.println("\nSe leyó el archivo llamado \"codigo.txt\", para hacer el análisis léxico ");
        System.out.println("Análisis léxico escrito en \"lexemas.txt\" ");
        System.out.println("Análisis de Errores léxicos escrito en \"errores.txt\" ");
    }
}
