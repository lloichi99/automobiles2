import compilerTools.Token;

%%
%class Lexer
%type Token
%line
%column
%{
    private Token token(String lexeme, String lexicalComp, int line, int column){
        return new Token(lexeme, lexicalComp, line+1, column+1);
    }
%}
/* Variables básicas de comentarios y espacios */
TerminadorDeLinea = \r|\n|\r\n
EntradaDeCaracter = [^\r\n]
EspacioEnBlanco = {TerminadorDeLinea} | [ \t\f]
ComentarioTradicional = "/*" [^*] ~"*/" | "/*" "*"+ "/"
FinDeLineaComentario = "//" {EntradaDeCaracter}* {TerminadorDeLinea}?
ContenidoComentario = ( [^*] | \*+ [^/*] )*
ComentarioDeDocumentacion = "/**" {ContenidoComentario} "*"+ "/"

//------------------------------------------



/* Comentario */
Comentario = {ComentarioTradicional} | {FinDeLineaComentario} | {ComentarioDeDocumentacion}

/* Identificador */
Letra = [A-Za-zÑñ_ÁÉÍÓÚáéíóúÜü]
Digito = [0-9]
Identificador = {Letra}({Letra}|{Digito})*

/* Número */
Entero = -?[0-9]+
//Fraccion
Real = -?([0-9]+\.?[0-9]*|[0-9]*\.?[0-9]+)
/* Constante string*/
Cadena = \"[^\"]*\"
/*id string*/
%%

/* EXPRESIONES REGULARES PARA Comentarios o espacios en blanco */
{Comentario}|{EspacioEnBlanco} { /*Ignorar*/ }


//--------------------------Palabras reservadas por orden------------------------//
if {return token(yytext(), "-1", yyline, yycolumn);}
else {return token(yytext(), "-2", yyline, yycolumn);}
for {return token(yytext(), "-3", yyline, yycolumn);}
print {return token(yytext(), "-4", yyline, yycolumn);}
println {return token(yytext(), "-5", yyline, yycolumn);}
int {return token(yytext(),"-64",yyline,yycolumn);}
String {return token(yytext(),"-66",yyline,yycolumn);}
double {return token(yytext(),"-65",yyline,yycolumn);}


//----------------------------------------------OPERADORES ARITMETICOS
"*" {return token(yytext(), "-21", yyline, yycolumn);}
"/" {return token(yytext(), "-22", yyline, yycolumn);}
"%" {return token(yytext(), "-23", yyline, yycolumn);}
"+" {return token(yytext(), "-24", yyline, yycolumn);}
"-" {return token(yytext(), "-25", yyline, yycolumn);}
"=" {return token(yytext(), "-26", yyline, yycolumn);}
//----------------------------------------------OPERADORES RELACIONALESs
"<" {return token(yytext(), "-31", yyline, yycolumn);}
"<=" {return token(yytext(), "-32", yyline, yycolumn);}
">" {return token(yytext(), "-33", yyline, yycolumn);}
">=" {return token(yytext(), "-34", yyline, yycolumn);}
"==" {return token(yytext(), "-35", yyline, yycolumn);}
"!=" {return token(yytext(), "-36", yyline, yycolumn);}
//----------------------------------------------OPERADORES LOGICOS
"&&" {return token(yytext(), "-41", yyline, yycolumn);}
"||" {return token(yytext(), "-42", yyline, yycolumn);}
"!" {return token(yytext(), "-43", yyline, yycolumn);}





//----------------------------------------------CONTANTE REAL
{Entero} {return token(yytext(), "-61", yyline, yycolumn);}
//----------------------------------------------CONTANTE ENTERA
{Real} {return token(yytext(), "-62", yyline, yycolumn);}
//----------------------------------------------CONTANTE STRING
{Cadena} {return token(yytext(), "-63", yyline, yycolumn);}


------------------------------------------------TIPO DE DATO




//----------------------------------------------CARACTERES ESPECIALES
"[" {return token(yytext(), "-71", yyline, yycolumn);}
"]" {return token(yytext(), "-72", yyline, yycolumn);}
"(" {return token(yytext(), "-73", yyline, yycolumn);}
")" {return token(yytext(), "-74", yyline, yycolumn);}
";" {return token(yytext(), "-75", yyline, yycolumn);}
"," {return token(yytext(), "-76", yyline, yycolumn);}
"{" {return token(yytext(), "-77", yyline, yycolumn);}
"}" {return token(yytext(), "-78", yyline, yycolumn);}


//IDENTIFICADORES
{Identificador}\$ {return token(yytext(), "-79", yyline, yycolumn);}
{Identificador}\% {return token(yytext(), "-80", yyline, yycolumn);}
{Identificador}\& {return token(yytext(), "-81", yyline, yycolumn);}
{Identificador}[a-zA-Z0-9]* {return token(yytext(), "-82", yyline, yycolumn);}




/* Regla para la declaración de variables */
DeclaracionVariable = TIPO_DATO Identificador '=' VALOR ';'

    
//Errores   GENERALES
. { return token(yytext(), "ERROR", yyline, yycolumn); }






  