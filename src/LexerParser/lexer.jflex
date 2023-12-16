package LexerParser;
import java_cup.runtime.*;

%%

%class CodeLexer
%public
%unicode
%cup
%line
%column

%{
	StringBuffer string = new StringBuffer();

	private Symbol symbol(int type) {
		return new Symbol(type, yyline, yycolumn);
	}
	private Symbol symbol(int type, Object value) {
		return new Symbol(type, yyline, yycolumn, value);
	}
%}

// LENGUAGE: Jojojo
LETER = [a-zA-Z_]
DIGIT = [0-9]
SPACE = [ \t \r \n \f \r\n]
SYMBOL = [#!$%&?¡_]
ACCENT = [ñÑáéíóúÁÉÍÓÚ]

/* comments */
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}

TraditionalComment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
// Comment can be the last line of the file, without line terminator.
EndOfLineComment     = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent       = ( [^*] | \*+ [^/*] )*

Identifier = [:jletter:] [:jletterdigit:]*

DecIntegerLiteral = 0 | [1-9][0-9]*

%state STRING

%%



	
{SPACE} {/*No se procesa*/} // espacio en blanco
"@".* {/*No se procesa*/} // dos slash de comentario
//("\(\*" ~"\*\)" | "\(\*" "\*"+ "\)") {/*No se procesa*/} // comentario multilínea 
("/" ~"/" | "/" "/") {/*No se procesa*/} // comentario multilínea


// OPERADORES ARITMETICOS BINARIOS (RENOS)
"+" {return new Symbol(sym.RUDOLPH, yyline, yycolumn, yytext());}
"-" {return new Symbol(sym.DASHER, yyline, yycolumn, yytext());}
"*" {return new Symbol(sym.COMET, yyline, yycolumn, yytext());}
"/" {return new Symbol(sym.VIXEN, yyline, yycolumn, yytext());}
"~" {return new Symbol(sym.TOTIN, yyline, yycolumn, yytext());} 
"**" {return new Symbol(sym.RENILLO, yyline, yycolumn, yytext());} //CAMBIAR NOMBRE DE RENO

// OPERADORES ARITMETICOS UNARIOS (GRINCH, QUIEN) duda sobre "quien"
"++" {return new Symbol(sym.GRINCH, yyline, yycolumn, yytext());}
"--" {return new Symbol(sym.QUIEN, yyline, yycolumn, yytext());}

// OPERADORES RELACIONALES (ELFOS) 
">=" {return new Symbol(sym.KNECHT_RUPRECHT, yyline, yycolumn, yytext());}
">" {return new Symbol(sym.KRAMPUS, yyline, yycolumn, yytext());}
"<=" {return new Symbol(sym.BELSNICKEL, yyline, yycolumn, yytext());}
"<" {return new Symbol(sym.ZWARTE_PIET, yyline, yycolumn, yytext());}
"<>" {return new Symbol(sym.SNOWBALL_ALABASTRO, yyline, yycolumn, yytext());}
"=" {return new Symbol(sym.PEPPER_MINSTIX, yyline, yycolumn, yytext());}

// OPERADORES LOGICOS (REYES MAGOS)
"^" {return new Symbol(sym.MELCHOR, yyline, yycolumn, yytext());} //CONJUNCION
"#" {return new Symbol(sym.GASPAR, yyline, yycolumn, yytext());} // DISYUNCION
"!" {return new Symbol(sym.BALTASAR, yyline, yycolumn, yytext());} //NEGACION


// IDENTIFICADORES 
{LETER}(({LETER}|{DIGIT}){0, 126})? {return new Symbol(sym.PERSONA, yyline, yycolumn, yytext());}


// TIPOS
"INT" {return new Symbol(sym.PAPA_NOEL, yyline, yycolumn, yytext());}
"BOOLEAN" {return new Symbol(sym.SANTA_CLAUS, yyline, yycolumn, yytext());}
"STRING" {return new Symbol(sym.SAN_NICOLAS, yyline, yycolumn, yytext());}
"CHAR" {return new Symbol(sym.NINO_JESUS, yyline, yycolumn, yytext());}
"FLOAT" {return new Symbol(sym.COLACHO, yyline, yycolumn, yytext());}
"ARRAY" {return new Symbol(sym.SANTA, yyline, yycolumn, yytext());}


//LITERALES
// Flotantes
(({DIGIT}+"."{DIGIT}+)) |
    (({DIGIT}"."{DIGIT}+)([eE][-]?{DIGIT}+)) {return new Symbol(sym.L_COLACHO, yyline, yycolumn, yytext());}

// Literales
((\"[^\"] ~\")|(\"\")) {return new Symbol(sym.L_SAN_NICOLAS, yyline, yycolumn, yytext());}
//\"({LETRA}|{DIGIT}|{ESPACIO}|{SIMBOLO})*+\" | ("#"{DIGIT}{DIGIT}) {lexeme=yytext(); line=yyline; return LITERAL_STRING;}
("#"{DIGIT}+) {return new Symbol(sym.L_SAN_NICOLAS, yyline, yycolumn, yytext());}
("(-"{DIGIT}+")")|{DIGIT}+ {return new Symbol(sym.L_PAPA_NOEL, yyline, yycolumn, yytext());} // Un numero entero


//PARENTESIS
"(" {return new Symbol(sym.ABRECUENTO, yyline, yycolumn, yytext());}
")" {return new Symbol(sym.CIERRECUENTO, yyline, yycolumn, yytext());}
"[" {return new Symbol(sym.ABREEMPAQUE, yyline, yycolumn, yytext());}
"]" {return new Symbol(sym.CIERRAEMPAQUE, yyline, yycolumn, yytext());}
"{" {return new Symbol(sym.ABREREGALO, yyline, yycolumn, yytext());}
"}" {return new Symbol(sym.CIERRAREGALO, yyline, yycolumn, yytext());}



// LEXEMAS DE ESTRUCTURAS DE CONTROL
"IF" {return new Symbol(sym.ELFO, yyline, yycolumn, yytext());}
"ELIF" {return new Symbol(sym.HADA, yyline, yycolumn, yytext());}
"ELSE" {return new Symbol(sym.DUENDE, yyline, yycolumn, yytext());}
"FOR" {return new Symbol(sym.ENVUELVE, yyline, yycolumn, yytext());}
"DO" {return new Symbol(sym.HACE, yyline, yycolumn, yytext());}
"UNTIL" {return new Symbol(sym.REVISA, yyline, yycolumn, yytext());}
"RETURN" {return new Symbol(sym.ENVIA, yyline, yycolumn, yytext());}
"BREAK" {return new Symbol(sym.CORTA, yyline, yycolumn, yytext());}


//PRINT - READ
"PRINT" {return new Symbol(sym.NARRA, yyline, yycolumn, yytext());}
"READ" {return new Symbol(sym.ESCUCHA, yyline, yycolumn, yytext());}


// LEXEME FINAL DE EXPRESION
"END" {return new Symbol(sym.FINREGALO, yyline, yycolumn, yytext());}

//LEXEMA DE ADSIGNACION
":=" {return new Symbol(sym.ENTREGA, yyline, yycolumn, yytext());}

//LEXEMA SEPARADOR
"," {return new Symbol(sym.COMA, yyline, yycolumn, yytext());}



// FUNCIONES 
"FUNCTION" {return new Symbol(sym.FUNCTION, yyline, yycolumn, yytext());}
"BEGIN" {return new Symbol(sym.BEGIN, yyline, yycolumn, yytext());}
"PROCEDURE" {return new Symbol(sym.PROCEDURE, yyline, yycolumn, yytext());}
"MAIN" {return new Symbol(sym.PROGRAM, yyline, yycolumn, yytext());}




<STRING> {
	\"                             { yybegin(YYINITIAL);
                                       return symbol(sym.STRING_LITERAL,
                                       string.toString()); }
	[^\n\r\"\\]+                   { string.append( yytext() ); }
	\\t                            { string.append('\t'); }
	\\n                            { string.append('\n'); }

	\\r                            { string.append('\r'); }
	\\\"                           { string.append('\"'); }
	\\                             { string.append('\\'); }
}


// --------------- GRAMATICA PARA CONTROL DE ERRORES --------------- //

//identificador mayor a 127 caracteres
{LETER}(({LETER}|{DIGIT}){127})({LETER}|{DIGIT})* {return new Symbol(sym.ERROR_IDENTIFICADOR, yyline, yycolumn, yytext());}
//identificador no comienza con DIGIT
(({DIGIT}+)({LETER}|{ACCENT}))(({LETER}|{DIGIT}|{SYMBOL}|{ACCENT}))* {return new Symbol(sym.ERROR_IDENTIFICADOR, yyline, yycolumn, yytext());}
//identificador no lleva simbolos
({LETER}|{ACCENT}|{SYMBOL})(({LETER}|{DIGIT}|{SYMBOL}|{ACCENT}))+ {return new Symbol(sym.ERROR_IDENTIFICADOR, yyline, yycolumn, yytext());}


// Errores en Flotantes
{DIGIT}+"."{DIGIT}+("."{DIGIT}*)+ {
    // Patrón: D+.D+D* (Error en formato de flotante)
    return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());
}

("."{DIGIT}+([eE][-]?{DIGIT}*)?) | ({DIGIT}+"."{DIGIT}+([eE][-]?)({DIGIT}*"."{DIGIT}*))* {
    // Patrón: .D+eD* / D+.D+eD* / D+.D* . D+D*
    // Error en formato de notación científica o en formato de punto flotante
    return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());
}

({DIGIT}+"."{DIGIT}+{LETER}+) | ({DIGIT}+"."{LETER}+{DIGIT}+) {
    // Patrón: D+.D+L+ / D+.L+D+
    // Error: Carácter no numérico después del punto en el flotante
    return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());
}

({DIGIT}+{LETER}+"."{DIGIT}+) | ({LETER}+{DIGIT}+"."{DIGIT}+) {
    // Patrón: D+L+.D+ / L+D+.D+
    // Error: Carácter no numérico antes del punto en el flotante
    return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());
}

({LETER}+"."{DIGIT}+{LETER}+) | ({LETER}+"."{LETER}+{DIGIT}+) {
    // Patrón: L+.D+L+ / L+.L+D+
    // Error: Carácter no numérico antes y después del punto en el flotante
    return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());
}

({DIGIT}+{LETER}*".") {
    // Patrón: D+L*.
    // Error: Carácter no numérico después del punto en el flotante
    return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());
}

{DIGIT}+","{DIGIT}+ {
    // Patrón: D+,D+
    // Error: Uso de coma como separador decimal en lugar de punto
    return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());
}

// Errores en Literales
"#" {LETER}+ {
    // Patrón: #L+
    // Error: Literal inválido, comienza con '#' seguido de caracteres no válidos
    return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());
}

'[^'] ~' {
    // Patrón: 'C' ~'
    // Error: Literal de cadena inválido, comienza y termina con comillas simples
    return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());
}

// Errores en Comentarios
\"[^\"]* {
    // Patrón: "C*
    // Error: Comentario inválido, comienza con comillas dobles y no termina
    return new Symbol(sym.error, yyline, yycolumn, yytext());
}

\(\*[^\)\*]* {
    // Patrón: (*C*
    // Error: Comentario inválido, comienza con paréntesis y asterisco y no termina
    return new Symbol(sym.error, yyline, yycolumn, yytext());
}

\{[^\}]* {
    // Patrón: {C*
    // Error: Comentario inválido, comienza con llave y no termina
    return new Symbol(sym.error, yyline, yycolumn, yytext());
}

. {
    // Cualquier otro carácter no reconocido
    return new Symbol(sym.error, yyline, yycolumn, yytext());
}
