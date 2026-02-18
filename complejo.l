%{
#include <stdio.h>
#include <stdlib.h>
%}

DIGITO      [0-9]
ENTERO      {DIGITO}+
DECIMAL     {DIGITO}"."{DIGITO}+
REAL        [+-]?({DECIMAL}|{ENTERO})
IMAG        [iIjJ]

%%
^[ ]*{REAL}[ ]*[\+|-][ ]*{REAL}{IMAG}[ ]*$      { printf("Acepta\n"); }
^[ ]*{REAL}[ ]*$                                { printf("Acepta\n"); }   /* solo parte real */
^[ ]*[+-]?{REAL}?{IMAG}[ ]*$                    { printf("Acepta\n"); }   /* solo parte imaginaria */
^[^\n]+$                                        { printf("No acepta\n"); }
\n                                              { /* Ignorar línea vacía */ }
%%

int main() {
    FILE *archivo = fopen("Entrada.txt", "r");
    if (!archivo) {
        printf("No se pudo abrir Entrada.txt\n");
        return 1;
    }
    yyin = archivo;
    yylex();
    fclose(archivo);
    return 0;
}

int yywrap() { return 1; }
