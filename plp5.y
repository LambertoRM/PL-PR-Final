%token algoritmo dospto id falgoritmo
%token var fvar pyc coma entero real logico
%token tabla nentero de escribe lee si entonces
%token sino mientras hacer repetir hasta opasig
%token blq fblq obool ybool oprel opas opmd
%token nreal pari pard nobool cierto falso cori cord

%{

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <iostream>


using namespace std;

#include "comun.h"
#include "TablaTipos.h"

// variables y funciones del A. Léxico
extern int ncol,nlin,findefichero;


extern int yylex();
extern char *yytext;
extern FILE *yyin;


int yyerror(char *s);


const int ENTERO = 1;
const int REAL = 2;

string operador, s1, s2;  // string auxiliares

%}

//Errores semánticos
void errorSemantico(int nerror,int nlin,int ncol,const char *s)
{
   fprintf(stderr,"Error semantico (%d,%d): ", nlin,ncol);
   switch(nerror) {
         case ERR_YADECL: fprintf(stderr,"variable '%s' ya declarada\n",s);
            break;
         case ERR_NODECL: fprintf(stderr,"variable '%s' no declarada\n",s);
            break;
         case ERR_DIM: fprintf(stderr,"la dimension debe ser mayor que cero\n");
            break;
         case ERR_FALTAN: fprintf(stderr,"faltan indices\n");
            break;
         case ERR_SOBRAN: fprintf(stderr,"sobran indices\n");
            break;
         case ERR_INDICE_ENTERO: fprintf(stderr,"la expresion entre corchetes debe ser de tipo entero\n");
            break;
         case ERR_EXP_LOG: fprintf(stderr,"la expresion debe ser de tipo logico\n");
            break;
         case ERR_EXDER_LOG: fprintf(stderr,"la expresion a la derecha de '%s' debe ser de tipo logico\n",s);
            break;
         case ERR_EXDER_ENT: fprintf(stderr,"la expresion a la derecha de '%s' debe ser de tipo entero\n",s);
            break;
         case ERR_EXDER_RE:fprintf(stderr,"la expresion a la derecha de '%s' debe ser de tipo real o entero\n",s);
            break;        
         case ERR_EXIZQ_LOG:fprintf(stderr,"la expresion a la izquierda de '%s' debe ser de tipo logico\n",s);
            break;       
         case ERR_EXIZQ_RE:fprintf(stderr,"la expresion a la izquierda de '%s' debe ser de tipo real o entero\n",s);
            break;       
         case ERR_NOCABE:fprintf(stderr,"la variable '%s' ya no cabe en memoria\n",s);
            break;
         case ERR_MAXTMP:fprintf(stderr,"no hay espacio para variables temporales\n");
            break;
   }
   exit(-1);
}

//Errores léxicos y sintácticos
void msgError(int nerror,int nlin,int ncol,const char *s)
{
    switch (nerror) {
         case ERRLEXICO: fprintf(stderr,"Error lexico (%d,%d): caracter '%s' incorrecto\n",nlin,ncol,s);
            break;
         case ERRSINT: fprintf(stderr,"Error sintactico (%d,%d): en '%s'\n",nlin,ncol,s);
            break;
         case ERREOF: fprintf(stderr,"Error sintactico: fin de fichero inesperado\n");
            break;
     }

     exit(1);
}