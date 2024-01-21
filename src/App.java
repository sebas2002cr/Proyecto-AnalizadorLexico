import compilation.Compilador;
import lexical.Lexer;
import syntaxis.Syntax;

public class App {
    public static void main(String[] args) {
        try {
            // Verifica si se proporcionó el argumento "-g" para generar el analizador
            // léxico.
            if (args.length > 0) {
                if(args[0].equals("-g"))
                    Lexer.generate();
                if(args[0].equals("-a")) {
                    Lexer.analyze("/test/lexico/codigo.txt", "/test/lexico/lexemas.txt", "/test/lexico/errores.txt");
                    System.out.println("\nSe leyó el archivo llamado \"codigo.txt\", para hacer el análisis léxico ");
                    System.out.println("Análisis léxico escrito en \"lexemas.txt\" ");
                    System.out.println("Análisis de Errores léxicos escrito en \"errores.txt\" ");
                }
                if(args[0].equals("-p")) {
                    Syntax.parse("/test/semantica/semantica.txt");
                }
            } else {
                new Compilador().compilar("/test/pila.txt", "/test/compilado.asm");
            }
        } catch (Exception e) {
            // Captura y maneja cualquier excepción que pueda ocurrir durante la ejecución.
            e.printStackTrace(); // Imprime la traza de la excepción (para fines de depuración).
        }
    }
}
