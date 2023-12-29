package syntaxis;

import java.io.FileReader;
import java.io.Reader;
import lexical.CodeLexer;

public class Syntax {
	private static String basePath = System.getProperty("user.dir");

	public static void parse(String parsePath) throws Exception{
        Reader inputLexer = new FileReader(basePath + parsePath);
        CodeLexer lexer = new CodeLexer(inputLexer);
        new parser(lexer).parse();
    }
}
