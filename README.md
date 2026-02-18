# Analizador Léxico de Números Complejos

Este proyecto implementa un **analizador léxico** en **Flex** para reconocer números complejos en varias formas:

- Parte real + parte imaginaria: `a + bi`, `a - bi`
- Solo parte real: `a`
- Solo parte imaginaria: `bi`, incluyendo `i` o `-i`

El programa lee las entradas desde un archivo `Entrada.txt` y clasifica cada línea como **Acepta** o **No acepta** según cumpla la estructura de número complejo.

---

## Estructura del proyecto

ProyectoComplejos/
│
├─ complejo.l # Archivo fuente Lex
├─ Entrada.txt # Archivo de prueba con números complejos
├─ lex.yy.c # Código C generado por Flex
└─ complejo # Ejecutable compilado

---

## Instalación y Requisitos

- macOS
- Flex (Lex) instalado
- GCC (compilador de C)

Verifica Flex:

```bash
flex --version
Si no está instalado:
brew install flex
Uso
Crear el archivo de entrada Entrada.txt con los números complejos a evaluar:
3.5 + 2i
3.5 e -10
4+I
-2.3-5j
3y-2
10.8 + 8.9j

Generar el código C con Flex:
flex complejo.l
Compilar el código:
gcc lex.yy.c -o complejo
Ejecutar el programa:
./complejo
Salida esperada:
Acepta
No acepta
No acepta
Acepta
No acepta
Acepta
Explicación del Código
Macros y patrones:
DIGITO      [0-9]
ENTERO      {DIGITO}+
DECIMAL     {DIGITO}"."{DIGITO}+
REAL        [+-]?({DECIMAL}|{ENTERO})
IMAG        [iIjJ]
Reglas del analizador:
^[ ]*{REAL}[ ]*[\+|-][ ]*{REAL}{IMAG}[ ]*$   → Acepta (a ± bi)
^[ ]*{REAL}[ ]*$                               → Acepta (solo real)
^[ ]*[+-]?{REAL}?{IMAG}[ ]*$                   → Acepta (solo imaginaria)
^[^\n]+$                                       → No acepta
\n                                             → Ignorar línea vacía
Flujo de ejecución:
El archivo Entrada.txt se abre para lectura.
yyin se asigna al archivo.
yylex() procesa línea por línea.
Cada línea se evalúa y se imprime Acepta o No acepta.
Fin de archivo: yywrap() devuelve 1 para terminar el scanner.
Notas
El analizador reconoce tanto i como I, j o J como unidad imaginaria.
Se permite signo + o - en la parte real o imaginaria.
Espacios antes o después de operadores son opcionales.
Líneas que no corresponden a un número complejo válido se clasifican como No acepta.
