Perfecto. Aquí tienes un **README completo y listo para GitHub**, optimizado para tu proyecto de analizador léxico de números complejos, listo para copiar en la sección CODE del README:

```markdown
# Analizador Léxico de Números Complejos

Este proyecto implementa un **analizador léxico** en **Flex** que reconoce números complejos en varias formas:

- Parte real + parte imaginaria: `a + bi`, `a - bi`  
- Solo parte real: `a`  
- Solo parte imaginaria: `bi`, incluyendo `i`, `-i`, `j`, `-j`  

El programa lee las entradas desde un archivo `Entrada.txt` y clasifica cada línea como **Acepta** o **No acepta** según cumpla la estructura de número complejo.

---

## Estructura del proyecto

```

ProyectoComplejos/
│
├─ complejo.l        # Archivo fuente Flex
├─ Entrada.txt       # Archivo con los números a evaluar
├─ lex.yy.c          # Código C generado por Flex
└─ complejo          # Ejecutable compilado

````

---

## Requisitos

- macOS
- Flex instalado
- GCC (compilador de C)

Verificar instalación de Flex:

```bash
flex --version
````

Si no está instalado:

```bash
brew install flex
```

---

## Uso

1. Crear el archivo `Entrada.txt` con los números complejos a evaluar, por ejemplo:

```
3.5 + 2i
3.5 e -10
4+I
-2.3-5j
3y-2
10.8 + 8.9j
```

2. Generar el código C desde el archivo Lex:

```bash
flex complejo.l
```

3. Compilar el código generado:

```bash
gcc lex.yy.c -o complejo
```

4. Ejecutar el programa:

```bash
./complejo
```

5. Salida esperada para la entrada de ejemplo:

```
Acepta
No acepta
Acepta
Acepta
No acepta
Acepta
```

---

## Explicación del Código

### Definición de patrones

```c
DIGITO      [0-9]
ENTERO      {DIGITO}+
DECIMAL     {DIGITO}"."{DIGITO}+
REAL        [+-]?({DECIMAL}|{ENTERO})
IMAG        [iIjJ]
```

* `DIGITO` → 0 a 9
* `ENTERO` → uno o más dígitos
* `DECIMAL` → números con punto decimal
* `REAL` → números enteros o decimales, con signo opcional
* `IMAG` → unidades imaginarias `i`, `I`, `j`, `J`

### Reglas del analizador

```c
^[ ]*{REAL}[ ]*[\+|-][ ]*{REAL}{IMAG}[ ]*$   → Acepta (a ± bi)
^[ ]*{REAL}[ ]*$                              → Acepta (solo real)
^[ ]*[+-]?{REAL}?{IMAG}[ ]*$                  → Acepta (solo imaginaria)
^[^\n]+$                                      → No acepta
\n                                            → Ignorar líneas vacías
```

### Flujo de ejecución

1. Se abre `Entrada.txt` para lectura.
2. `yyin` se asigna al archivo.
3. `yylex()` procesa línea por línea.
4. Cada línea se evalúa y se imprime `Acepta` o `No acepta`.
5. Al finalizar, `yywrap()` devuelve 1 y termina el scanner.

---

## Notas

* Espacios antes o después del operador `+` o `-` son opcionales.
* Se aceptan números complejos con parte real y/o imaginaria.
* Líneas que no correspondan a un número complejo válido se clasifican como `No acepta`.

