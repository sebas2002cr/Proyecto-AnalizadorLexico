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
    private static String basePath = System.getProperty("user.dir");

    public static void generate() throws Exception {
        // archivos lexer y parser
        String[] lexerPath = { basePath + "/src/LexerParser/lexer.jflex" };
        String[] parserPath = { basePath + "/src/LexerParser/parser.cup" };

        // generamos lexer y parser
        jflex.Main.generate(lexerPath);
        java_cup.Main.main(parserPath);

        // mover archivos
        Files.deleteIfExists(Paths.get(basePath + "/src/LexerParser/sym.java"));
        Files.deleteIfExists(Paths.get(basePath + "/src/LexerParser/parser.java"));
        Files.move(Paths.get(basePath + "/sym.java"), Paths.get(basePath + "/src/LexerParser/sym.java"));
        Files.move(Paths.get(basePath + "/parser.java"), Paths.get(basePath + "/src/LexerParser/parser.java"));
    }

    public static void analyze(String sourcePath, String targetPath) throws Exception {
        new File(basePath + targetPath).createNewFile();
        FileWriter targetWritter = new FileWriter(basePath + targetPath);
        Reader reader = new BufferedReader(new FileReader(basePath + sourcePath));
        reader.read();
        CodeLexer lexer = new CodeLexer(reader);
        Symbol token;
        while(true){
            token = lexer.next_token();
            if(token.sym != 0) {
                targetWritter.write(
                    "ID: " + token.sym + ", " +
                    "Token: " + sym.terminalNames[token.sym] + ", " +
                    "Linea: " + token.left + ", " +
                    "Columna: " + token.right + ", " +
                    "Valor: " + (token.value == null ? lexer.yytext() : token.value.toString()) +
                    "\n"
                );
            } else break;
        }
        targetWritter.close();
    }
}