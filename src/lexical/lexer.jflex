package lexical;

import syntaxis.sym;
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
		return new Symbol(type, yyline, yycolumn, yytext());
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
Comment = {MultilineComment} | {OneLineComment}

MultilineComment   = "/_" [^*] ~"_/" | "/_" "_"+ "/"
CommentContent     = ( [^*] | \*+ [^/*] )*
OneLineComment     = "@@".*

DecIntegerLiteral = 0 | [1-9][0-9]*

%state STRING

%%

// TIPOS
<YYINITIAL> "INT" {return symbol(sym.PAPA_NOEL);}
<YYINITIAL> "BOOLEAN" {return symbol(sym.SANTA_CLAUS);}
<YYINITIAL> "STRING" {return symbol(sym.SAN_NICOLAS);}
<YYINITIAL> "CHAR" {return symbol(sym.NINO_JESUS);}
<YYINITIAL> "FLOAT" {return symbol(sym.COLACHO);}

// LEXEMAS DE ESTRUCTURAS DE CONTROL
<YYINITIAL> "IF" {return symbol(sym.ELFO);}
<YYINITIAL> "ELIF" {return symbol(sym.HADA);}
<YYINITIAL> "ELSE" {return symbol(sym.DUENDE);}
<YYINITIAL> "FOR" {return symbol(sym.ENVUELVE);}
<YYINITIAL> "DO" {return symbol(sym.HACE);}
<YYINITIAL> "UNTIL" {return symbol(sym.REVISA);}
<YYINITIAL> "RETURN" {return symbol(sym.ENVIA);}
<YYINITIAL> "BREAK" {return symbol(sym.CORTA);}
<YYINITIAL> "PRINT" {return symbol(sym.NARRA);}
<YYINITIAL> "READ" {return symbol(sym.ESCUCHA);}

<YYINITIAL> "FUNCTION" {return symbol(sym.FUNCTION);}
<YYINITIAL> "MAIN" {return symbol(sym.MAIN);}
<YYINITIAL> "LOCAL" {return symbol(sym.LOCAL);}
<YYINITIAL> "TRUE" {return symbol(sym.L_SANTA_CLAUS);}
<YYINITIAL> "FALSE" {return symbol(sym.L_SANTA_CLAUS);}

<YYINITIAL> {
	// IDENTIFICADORES
	{LETER}(({LETER}|{DIGIT}){0, 126})? {return new Symbol(sym.PERSONA, yyline, yycolumn, yytext());}

	/* operators */
	// OPERADORES ARITMETICOS BINARIOS (RENOS)
	"+" {return symbol(sym.RUDOLPH);}
	"-" {return symbol(sym.DASHER);}
	"*" {return symbol(sym.COMET);}
	"/" {return symbol(sym.VIXEN);}
	"~" {return symbol(sym.TOTIN);}
	"**" {return symbol(sym.RENILLO);} //CAMBIAR NOMBRE DE RENO
	// OPERADORES ARITMETICOS UNARIOS (GRINCH, QUIEN) duda sobre "quien"
	"++" {return symbol(sym.GRINCH);}
	"--" {return symbol(sym.QUIEN);}

	// OPERADORES RELACIONALES (ELFOS)
	">=" {return symbol(sym.KNECHT_RUPRECHT);}
	">" {return symbol(sym.KRAMPUS);}
	"<=" {return symbol(sym.BELSNICKEL);}
	"<" {return symbol(sym.ZWARTE_PIET);}
	"<>" {return symbol(sym.SNOWBALL_ALABASTRO);}
	"=" {return symbol(sym.PEPPER_MINSTIX);}

	// OPERADORES LOGICOS (REYES MAGOS)
	"^" {return symbol(sym.MELCHOR);} //CONJUNCION
	"#" {return symbol(sym.GASPAR);} // DISYUNCION
	"!" {return symbol(sym.BALTASAR);} //NEGACION

	//LITERALES
	// Flotantes
	(({DIGIT}+"."{DIGIT}+)) |
		(({DIGIT}"."{DIGIT}+)([eE][-]?{DIGIT}+)) {return symbol(sym.L_COLACHO);}

	// Literales
	((\"[^\"] ~\")|(\"\")) {return symbol(sym.L_SAN_NICOLAS);}
	("#"{DIGIT}+) {return symbol(sym.L_SAN_NICOLAS);}
	("-"?)("(-"{DIGIT}+")")|("-"?){DIGIT}+ {return symbol(sym.L_PAPA_NOEL);} // Un numero entero
	"'".?"'" {return symbol(sym.L_NINO_JESUS);}

	//PARENTESIS
	"(" {return symbol(sym.ABRECUENTO);}
	")" {return symbol(sym.CIERRECUENTO);}
	"[" {return symbol(sym.ABREEMPAQUE);}
	"]" {return symbol(sym.CIERRAEMPAQUE);}
	"{" {return symbol(sym.ABREREGALO);}
	"}" {return symbol(sym.CIERRAREGALO);}

	//LEXEMA DE ASIGNACION
	":=" {return symbol(sym.ENTREGA);}

	//LEXEMA SEPARADOR
	"," {return symbol(sym.COMA);}
	":" {return symbol(sym.DOS_PUNTOS);}
	"|" {return symbol(sym.FIN_REGALO);}

	{Comment}                      { /* ignore */ }
	{WhiteSpace}                   { /* ignore */ }
}

// |-------------------- RECONOCER ERRORES --------------------| //
// Identificadores
//identificador mayor a 127 caracteres
{LETER}(({LETER}|{DIGIT}){127})({LETER}|{DIGIT})* {return new Symbol(sym.ERROR_IDENTIFICADOR, yyline, yycolumn, yytext());}
//identificador no comienza con DIGIT
(({DIGIT}+)({LETER}|{ACCENT}))(({LETER}|{DIGIT}|{SYMBOL}|{ACCENT}))* {return new Symbol(sym.ERROR_IDENTIFICADOR, yyline, yycolumn, yytext());}
//identificador no lleva SYMBOLs
({LETER}|{ACCENT}|{SYMBOL})(({LETER}|{DIGIT}|{SYMBOL}|{ACCENT}))+ {return new Symbol(sym.ERROR_IDENTIFICADOR, yyline, yycolumn, yytext());}

// Flotantes
// 12.12.12...
{DIGIT}+"."{DIGIT}+("."{DIGIT}*)+ {return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());}
// .12e12 / .12e / .12  | 12.23e-23.12
("."{DIGIT}+([eE][-]?{DIGIT}*)?) | ({DIGIT}+"."{DIGIT}+([eE][-]?)({DIGIT}*"."{DIGIT}*))* {return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());}
// 12ab.12 | ab12.12
({DIGIT}+{LETER}+"."{DIGIT}+) | ({LETER}+{DIGIT}+"."{DIGIT}+) {return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());}
// 12.12ab | 12.ab12
({DIGIT}+"."{DIGIT}+{LETER}+) | ({DIGIT}+"."{LETER}+{DIGIT}+) {return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());}
// ab.12ab | ab.ab12
({LETER}+"."{DIGIT}+{LETER}+) | ({LETER}+"."{LETER}+{DIGIT}+) {return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());}
// 12. | 12e.
({DIGIT}+{LETER}*".") {return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());}
// 3,14
{DIGIT}+","{DIGIT}+ {return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());}

// Literales
"#"{LETER}+ {return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());}
'[^'] ~' {return new Symbol(sym.ERROR_LITERAL, yyline, yycolumn, yytext());}

// Comentarios
@[^@]* {return new Symbol(sym.error, yyline, yycolumn, yytext());}
// /_[^]*_/{ return new Symbol(sym.error, yyline, yycolumn, yytext()); }

/* error fallback */
[^] {return symbol(sym.error);}