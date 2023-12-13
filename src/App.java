import LexerParser.LexerParser;

public class App {
    public static void main(String[] args) {
        try {
            if(args.length > 0 && args[0].equals("-g")){
                LexerParser.generate();
            } else {
                LexerParser.analyze("\\src\\codigo.txt");
            }
        } catch (Exception e) {}
    }
}