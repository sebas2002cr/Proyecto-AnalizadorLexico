import lexical.Lexer;
import syntaxis.Syntax;

public class App {
    public static void main(String[] args) {
        try {
            // Verifica si se proporcionó el argumento "-g" para generar el analizador léxico.
            if (args.length > 0) {
                if (args[0].equals("-lg")) Lexer.generate();
                if (args[0].equals("-la")) {
                    Lexer.analyze("/test/codigo.txt", "/test/lexemas.txt", "/test/errores.txt");
                    System.out.println("\nSe leyó el archivo llamado \"codigo.txt\", para hacer el análisis léxico ");
                    System.out.println("Análisis léxico escrito en \"lexemas.txt\" ");
                    System.out.println("Análisis de Errores léxicos escrito en \"errores.txt\" ");
                }
            } else {
                Syntax.parse("/test/prueba-gramatica.txt");
            }
        } catch (Exception e) {
            // Captura y maneja cualquier excepción que pueda ocurrir durante la ejecución.
            e.printStackTrace(); // Imprime la traza de la excepción (para fines de depuración).
        }
    }
}
