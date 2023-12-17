package LexerParser;
import java_cup.runtime.*;

%%

%class CodeLexer
%public
%unicode
%cup
%line
%column
%ignorecase

%{
	StringBuffer string = new StringBuffer();

	private Symbol symbol(int type) {
		return new Symbol(type, yyline, yycolumn);
	}
	private Symbol symbol(int type, Object value) {
		return new Symbol(type, yyline, yycolumn, value);
	}
%}

// ------------------

LETER = [a-zA-Z_]
DIGIT = [0-9]
SPACE = [ \t \r \n \f \r\n]
SYMBOL = [#!$%&?¡_]
ACCENT = [ñÑáéíóúÁÉÍÓÚ]

// ------------------

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



DecIntegerLiteral = 0 | [1-9][0-9]*

%state STRING

%%

// TIPOS
<YYINITIAL> "INT" {return new Symbol(sym.PAPA_NOEL, yyline, yycolumn, yytext());}
<YYINITIAL> "BOOLEAN" {return new Symbol(sym.SANTA_CLAUS, yyline, yycolumn, yytext());}
<YYINITIAL> "STRING" {return new Symbol(sym.SAN_NICOLAS, yyline, yycolumn, yytext());}
<YYINITIAL> "CHAR" {return new Symbol(sym.NINO_JESUS, yyline, yycolumn, yytext());}
<YYINITIAL> "FLOAT" {return new Symbol(sym.COLACHO, yyline, yycolumn, yytext());}
<YYINITIAL> "ARRAY" {return new Symbol(sym.SANTA, yyline, yycolumn, yytext());}
// LEXEMAS DE ESTRUCTURAS DE CONTROL
<YYINITIAL> "IF" {return new Symbol(sym.ELFO, yyline, yycolumn, yytext());}
<YYINITIAL> "ELIF" {return new Symbol(sym.HADA, yyline, yycolumn, yytext());}
<YYINITIAL> "ELSE" {return new Symbol(sym.DUENDE, yyline, yycolumn, yytext());}
<YYINITIAL> "FOR" {return new Symbol(sym.ENVUELVE, yyline, yycolumn, yytext());}
<YYINITIAL> "DO" {return new Symbol(sym.HACE, yyline, yycolumn, yytext());}
<YYINITIAL> "UNTIL" {return new Symbol(sym.REVISA, yyline, yycolumn, yytext());}
<YYINITIAL> "RETURN" {return new Symbol(sym.ENVIA, yyline, yycolumn, yytext());}
<YYINITIAL> "BREAK" {return new Symbol(sym.CORTA, yyline, yycolumn, yytext());}
<YYINITIAL> "PRINT" {return new Symbol(sym.NARRA, yyline, yycolumn, yytext());}
<YYINITIAL> "READ" {return new Symbol(sym.ESCUCHA, yyline, yycolumn, yytext());}
<YYINITIAL> "END" {return new Symbol(sym.FINREGALO, yyline, yycolumn, yytext());}

<YYINITIAL> {

// IDENTIFICADORES 
{LETER}(({LETER}|{DIGIT}){0, 126})? {return new Symbol(sym.PERSONA, yyline, yycolumn, yytext());}


	
	/* operators */
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



//LEXEMA DE ADSIGNACION
":=" {return new Symbol(sym.ENTREGA, yyline, yycolumn, yytext());}

//LEXEMA SEPARADOR
"," {return new Symbol(sym.COMA, yyline, yycolumn, yytext());}


	/* comments */
	{Comment}                      { /* ignore */ }

	/* whitespace */
	{WhiteSpace}                   { /* ignore */ }
}

/* error fallback */
[^] {return new Symbol(sym.error, yyline, yycolumn, yytext());}