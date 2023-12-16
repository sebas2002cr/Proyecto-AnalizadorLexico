package LexerParser;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
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

    public static void analyze(String codePath) throws Exception {
        // Construye la ruta del archivo de manera que sea independiente del sistema
        // operativo
        File file = new File(basePath, codePath);
        String absolutePath = file.getAbsolutePath();
        System.out.println("Ruta del archivo: " + basePath + codePath);
        Reader reader = new BufferedReader(new FileReader(absolutePath));
        reader.read();
        CodeLexer lex = new CodeLexer(reader);
        int i = 0;
        Symbol token;
        while (true) {
            token = lex.next_token();
            if (token.sym != 0) {
                System.out.println(
                        "Token: " +
                                token.sym +
                                ", Valor: " +
                                (token.value == null ? lex.yytext() : token.value.toString()));
            } else {
                System.out.println("Cantidad de lexemas encontrados: " + i);
                return;
            }
            i++;
        }
    }
}