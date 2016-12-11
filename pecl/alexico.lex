/* --------------------------Codigo de Usuario----------------------- */
package analizadorLex;

import java_cup.runtime.*;
      
%% //inicio de opciones
   
/* ------ Seccion de opciones y declaraciones de JFlex -------------- */  

%class AnalizadorLexico

/*  Activar el contador de lineas, variable yyline
    Activar el contador de columna, variable yycolumn */
%line
%column
    
/* Activamos la compatibilidad con Java CUP para analizadores
   sintacticos(parser) */
%cup
   
/*	Declaraciones

    El codigo entre %{  y %} sera copiado integramente en el 
    analizador generado.	*/
%{
    /*  Generamos un java_cup.Symbol para guardar el tipo de token encontrado */
    private Symbol Symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    
    /* Generamos un Symbol para el tipo de token encontrado junto con su valor */
    private Symbol Symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
    
    /* Generamos una lista de Simbolos utilizados */
    
    private TablaSimbolos st = new TablaSimbolos(); 
    
%}
%eof{
	System.out.println(st.imprimirListaSimbolos());
	st.imprimirListaErroresLexicos();
%eof} 

/*	Declaramos expresiones regulares que despues usaremos en las reglas lexicas.	*/

SALTO = \r|\n|\r\n   		//Caracteres especiales: nueva línea, retorno, tabulación.
ESPACIO     = {SALTO} | [ \t\f]
EXP_ALPHA=[A-Za-z] 			//letra Mayuscula o Minuscula.
EXP_DIGITO=[0-9] 			//digito del 0 al 9.
EXP_ALPHANUMERIC={EXP_ALPHA}|{EXP_DIGITO} //expresion de un digito o una letra
ENTERO=({EXP_DIGITO})+ 					  //numero de uno una digitos.
IDENTIFICADOR={EXP_ALPHA}({EXP_ALPHANUMERIC})* //cadena de digitos y letras que comienza por una letra

%% //fin de opciones
/* -------------------- Seccion de reglas lexicas ------------------ */
   
<YYINITIAL> {
	//EspLex 7. Los valores de tipo entero
	{ENTERO}    {
		st.getListaSimpolos().add(new Simbolo(yytext(),"num("+yytext()+")",yyline,yycolumn)); 
		return Symbol(sym.ENTERO, new Integer(yytext()));
	}

	//EspLex 1. El conjunto de las palabras reservadas del lenguaje
	"program"   {
		st.getListaSimpolos().add(new Simbolo(yytext(),"program",yyline,yycolumn)); 
		return Symbol(sym.PROGRAM);
	}

	"is"   {
		st.getListaSimpolos().add(new Simbolo(yytext(),"is",yyline,yycolumn)); 
		return Symbol(sym.IS);
	}

	"begin"   {
		st.getListaSimpolos().add(new Simbolo(yytext(),"begin",yyline,yycolumn)); 
		return Symbol(sym.BEGIN);
	}

	"end"   {
		st.getListaSimpolos().add(new Simbolo(yytext(),"end",yyline,yycolumn)); 
		return Symbol(sym.END);
	}

	"var"   {
		st.getListaSimpolos().add(new Simbolo(yytext(),"var",yyline,yycolumn)); 
		return Symbol(sym.VAR);
	}

	"integer"   {
		st.getListaSimpolos().add(new Simbolo(yytext(),"integer",yyline,yycolumn)); 
		return Symbol(sym.INTEGER);
	}

	"boolean"   {
		st.getListaSimpolos().add(new Simbolo(yytext(),"boolean",yyline,yycolumn)); 
		return Symbol(sym.BOOLEAN);
	}

	"read"   {
		st.getListaSimpolos().add(new Simbolo(yytext(),"read",yyline,yycolumn)); 
		return Symbol(sym.READ);
	}

	"write"   {
		st.getListaSimpolos().add(new Simbolo(yytext(),"write",yyline,yycolumn)); 
		return Symbol(sym.WRITE);
	}

	"skip"   {
		st.getListaSimpolos().add(new Simbolo(yytext(),"skip",yyline,yycolumn)); 
		return Symbol(sym.SKIP);
	}

	"while"   {
		st.getListaSimpolos().add(new Simbolo(yytext(),"while",yyline,yycolumn)); 
		return Symbol(sym.WHILE);
	}

	"do"   {
		st.getListaSimpolos().add(new Simbolo(yytext(),"do",yyline,yycolumn)); 
		return Symbol(sym.DO);
	}

	"if"   {
		st.getListaSimpolos().add(new Simbolo(yytext(),"if",yyline,yycolumn)); 
		return Symbol(sym.IF);
	}

	"then"   {
		st.getListaSimpolos().add(new Simbolo(yytext(),"then",yyline,yycolumn)); 
		return Symbol(sym.THEN);
	}

	"else"   {
		st.getListaSimpolos().add(new Simbolo(yytext(),"else",yyline,yycolumn)); 
		return Symbol(sym.ELSE);
	}

	"and"   {
		st.getListaSimpolos().add(new Simbolo(yytext(),"and",yyline,yycolumn)); 
		return Symbol(sym.AND);
	}

	"or"   {
		st.getListaSimpolos().add(new Simbolo(yytext(),"or",yyline,yycolumn)); 
		return Symbol(sym.OR);
	}

	"true"   {
		st.getListaSimpolos().add(new Simbolo(yytext(),"true",yyline,yycolumn)); 
		return Symbol(sym.TRUE);
	}

	"false"   {
		st.getListaSimpolos().add(new Simbolo(yytext(),"false",yyline,yycolumn)); 
		return Symbol(sym.FALSE);
	}

	"not"   {
		st.getListaSimpolos().add(new Simbolo(yytext(),"not",yyline,yycolumn)); 
		return Symbol(sym.NOT);
	}


	//EspLex 6. Identificadores
	{IDENTIFICADOR}   {
		st.getListaSimpolos().add(new Simbolo("ide("+yytext()+")","ide",yyline,yycolumn)); 
		return Symbol(sym.IDE, new String("ide("+yytext()+")"));
	}

	//EspLex 2. Operador de asignación
	":="  {
		st.getListaSimpolos().add(new Simbolo(yytext(),"asignacion",yyline,yycolumn)); 
		return Symbol(sym.ASIGNACION);
	}


	//EspLex 3. Operadores de relación
	"<="  {
		st.getListaSimpolos().add(new Simbolo(yytext(),"menor_igual",yyline,yycolumn)); 
		return Symbol(sym.MENOR_IGUAL);
	}

	"<"  {
		st.getListaSimpolos().add(new Simbolo(yytext(),"menor",yyline,yycolumn)); 
		return Symbol(sym.MENOR);
	}

	"="  {
		st.getListaSimpolos().add(new Simbolo(yytext(),"igual",yyline,yycolumn)); 
		return Symbol(sym.IGUAL);
	}

	">"  {
		st.getListaSimpolos().add(new Simbolo(yytext(),"mayor",yyline,yycolumn)); 
		return Symbol(sym.MAYOR);
	}

	">="  {
		st.getListaSimpolos().add(new Simbolo(yytext(),"mayor_igual",yyline,yycolumn)); 
		return Symbol(sym.MAYOR_IGUAL);
	}

	"<>"  {
		st.getListaSimpolos().add(new Simbolo(yytext(),"distinto",yyline,yycolumn)); 
		return Symbol(sym.DISTINTO);
	}


	// EspLex 4. Operadores matemáticos
	"+"  {
		st.getListaSimpolos().add(new Simbolo(yytext(),"suma",yyline,yycolumn)); 
		return Symbol(sym.SUMA);
	}

	"-"  {
		st.getListaSimpolos().add(new Simbolo(yytext(),"resta",yyline,yycolumn)); 
		return Symbol(sym.RESTA);
	}

	"*"  {
		st.getListaSimpolos().add(new Simbolo(yytext(),"multiplicacion",yyline,yycolumn)); 
		return Symbol(sym.MULTIPLICACION);
	}

	"/"  {
		st.getListaSimpolos().add(new Simbolo(yytext(),"division",yyline,yycolumn)); 
		return Symbol(sym.DIVISION);
	}


	//EspLex 5. Signos de puntuación
	"("  {
		st.getListaSimpolos().add(new Simbolo(yytext(),"parentesis_abierto",yyline,yycolumn)); 
		return Symbol(sym.PARENTESIS_ABIERTO);
	}

	")"  {
		st.getListaSimpolos().add(new Simbolo(yytext(),"parentesis_cerrado",yyline,yycolumn)); 
		return Symbol(sym.PARENTESIS_CERRADO);
	}

	","  {
		st.getListaSimpolos().add(new Simbolo(yytext(),"coma",yyline,yycolumn)); 
		return Symbol(sym.COMA);
	}

	";"  {
		st.getListaSimpolos().add(new Simbolo(yytext(),"punto_coma",yyline,yycolumn)); 
		return Symbol(sym.PUNTO_COMA);
	}

	":"  {
		st.getListaSimpolos().add(new Simbolo(yytext(),"dos_puntos",yyline,yycolumn)); 
		return Symbol(sym.DOS_PUNTOS);
	}


	//EspLex 8. Puede haber espacios y/o tabuladores en cualquier parte del fichero a analizar.
	{ESPACIO} {}
	
	{SALTO} {}
}

//EspLex 9. Se considera un error léxicos la detección de un carácter no definido

[^] { st.getListaErroresLexicos().add("Caracter ilegal en la linea "+(yyline+1)+" y columna "+(yycolumn+1)+": <"+yytext()+">"); }
