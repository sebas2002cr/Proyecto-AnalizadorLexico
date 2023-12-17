import LexerParser.LexerParser;

public class App {
    public static void main(String[] args) {
        try {
            // Verifica si se proporcionó el argumento "-g" para generar el analizador
            // léxico.
            if (args.length > 0 && args[0].equals("-g")) {
                LexerParser.generate(); // Genera el analizador léxico.
            } else {
                // Realiza el análisis léxico del archivo de código fuente.
                LexerParser.analyze("/test/codigo.txt", "/test/lexemas.txt");
            }
        } catch (Exception e) {
            // Captura y maneja cualquier excepción que pueda ocurrir durante la ejecución.
            e.printStackTrace(); // Imprime la traza de la excepción (para fines de depuración).
        }
    }
}
