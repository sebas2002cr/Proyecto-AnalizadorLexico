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

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]

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

<YYINITIAL> "abstract"           { return symbol(sym.ABSTRACT); }
<YYINITIAL> "boolean"            { return symbol(sym.BOOLEAN); }
<YYINITIAL> "break"              { return symbol(sym.BREAK); }
<YYINITIAL> "public"             { return symbol(sym.PUBLIC); }
<YYINITIAL> {
	
{ESPACIO} {/*No se procesa*/} // espacio en blanco
"//".* {/*No se procesa*/} // dos slash de comentario
("\(\*" ~"\*\)" | "\(\*" "\*"+ "\)") {/*No se procesa*/} // comentario multilínea
("{" ~"}" | "{" "}") {/*No se procesa*/} // comentario multilínea


// OPERADORES ARITMETICOS BINARIOS (RENOS)
"+" {return new Symbol(sym.RUDOLPH, yyline, yycolumn, yytext());}
"-" {return new Symbol(sym.DASHER, yyline, yycolumn, yytext());}
"*" {return new Symbol(sym.COMET, yyline, yycolumn, yytext());}
"/" {return new Symbol(sym.VIXEN, yyline, yycolumn, yytext());}

// OPERADORES ARITMETICOS UNARIOS (GRINCH, QUIEN) duda sobre "quien"
"++" {return new Symbol(sym.GRINCH, yyline, yycolumn, yytext());}
"--" {return new Symbol(sym.QUIEN, yyline, yycolumn, yytext());}

// OPERADORES RELACIONALES (ELFOS) Krampus. Belsnickel. Zwarte Piet Snowball Alabastro Pepper Minstix
">=" {return new Symbol(sym.KNECHT_RUPRECHT, yyline, yycolumn, yytext());}
">" {return new Symbol(sym.KRAMPUS, yyline, yycolumn, yytext());}
"<=" {return new Symbol(sym.BELSNICKEL, yyline, yycolumn, yytext());}
"<" {return new Symbol(sym.ZWARTE_PIET, yyline, yycolumn, yytext());}
"<>" {return new Symbol(sym.SNOWBALL_ALABASTRO, yyline, yycolumn, yytext());}
"=" {return new Symbol(sym.PEPPER_MINSTIX, yyline, yycolumn, yytext());}

// OPERADORES LOGICOS (REYES MAGOS)
"&&" {return new Symbol(sym.MELCHOR, yyline, yycolumn, yytext());}
"||" {return new Symbol(sym.GASPAR, yyline, yycolumn, yytext());}
"!" {return new Symbol(sym.BALTASAR, yyline, yycolumn, yytext());}


// IDENTIFICADORES 
{LETRA}(({LETRA}|{DIGITO}){0, 126})? {return new Symbol(sym.PERSONA, yyline, yycolumn, yytext());}


// TIPOS
"INT" {return new Symbol(sym.PAPA_NOEL, yyline, yycolumn, yytext());}
"BOOLEAN" {return new Symbol(sym.SANTA_CLAUS, yyline, yycolumn, yytext());}
"STRING" {return new Symbol(sym.SAN_NICOLAS, yyline, yycolumn, yytext());}
"CHAR" {return new Symbol(sym.NINO_JESUS, yyline, yycolumn, yytext());}
"FLOAT" {return new Symbol(sym.COLACHO, yyline, yycolumn, yytext());}
"ARRAY" {return new Symbol(sym.SANTA, yyline, yycolumn, yytext());}


//LITERALES
// Flotantes
(({DIGITO}+"."{DIGITO}+)) |
    (({DIGITO}"."{DIGITO}+)([eE][-]?{DIGITO}+)) {return new Symbol(sym.L_COLACHO, yyline, yycolumn, yytext());}

// Literales
((\"[^\"] ~\")|(\"\")) {return new Symbol(sym.L_SAN_NICOLAS, yyline, yycolumn, yytext());}
//\"({LETRA}|{DIGITO}|{ESPACIO}|{SIMBOLO})*+\" | ("#"{DIGITO}{DIGITO}) {lexeme=yytext(); line=yyline; return LITERAL_STRING;}
("#"{DIGITO}+) {return new Symbol(sym.L_SAN_NICOLAS, yyline, yycolumn, yytext());}
("(-"{DIGITO}+")")|{DIGITO}+ {return new Symbol(sym.L_PAPA_NOEL, yyline, yycolumn, yytext());} // Un numero entero


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
}

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

/* error fallback */
[^] {
	throw new Error("Illegal character <"+ yytext()+">");
}