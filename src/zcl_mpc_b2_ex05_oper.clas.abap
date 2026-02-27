CLASS zcl_mpc_b2_ex05_oper DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

      INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_b2_ex05_oper IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  "Declaración tres variables 2 enteros y una decimal incompleta que le he pasado longitud y posiciones decimales

  DATA: lv_num_a TYPE i VALUE 20, " 10 Y PARA DIV 20
        lv_num_b TYPE i VALUE 8,  " 15 Y PARA MULT 4 Y DIV 8
        lv_total TYPE p LENGTH 8 DECIMALS 2. "En esta variable guardaremos el resultado

**********************************************************************
*  " 1.- Operación SUMA
*
*  "1.1 +
*
*  lv_total = lv_num_a + lv_num_b. " OJO dejar los espacios entre el operador
*
*  "Muestro el resultado por pantalla: Impresión de las variables en pantalla
*
*  out->write( | Number a { lv_num_a } Number b { lv_num_b } Total: { lv_total } | ).
*
*  "1.2 ADD
*
*  ADD 5 to lv_total. " OBSOLETA No usar ADD en la nueva versión de abap
*
*
*  "Muestro el resultado por pantalla: Impresión de las variables en pantalla
*
*  out->write( | Total (ADD): { lv_total } | ).
*
*  "1.3 ACUMULADORES +=
*
*  lv_total += 5. " se puede poner una variable definida o el número 5
*
*   "Muestro el resultado por pantalla: Impresión de las variables en pantalla
*
*  out->write( | Total (+=): { lv_total } | ).
*
*   "1.4 Sumatoria múltiple
*
*  lv_total = lv_num_a + lv_num_b + lv_total.
*
*  out->write( | Total : { lv_total } | ).
*
*  " Limpiar la variable total
*
*  clear lv_total.
*
*  out->write( | Total (limpio) : { lv_total } | ).


**********************************************************************
*  " 2.- Operación RESTA
*
*  "2.1 -
*
*  lv_total = lv_num_a - lv_num_b. " OJO dejar los espacios entre el operador
*
*  "Muestro el resultado por pantalla: Impresión de las variables en pantalla
*
*  out->write( | Number a: { lv_num_a } Number b: { lv_num_b } Total: { lv_total } | ).
*
*  " 2.2 SUBTRACT
*
*  SUBTRACT 2 FROM lv_total.           "OBSOLETA (aprender por mantenimiento de codigo antiguo) (6-2 = 4)
*
*  out->write( | Total : { lv_total } | ).
*
*  "2.3 variable - nº entero
*
*  lv_total = lv_num_a - 1.
*
*   out->write( | Total : { lv_total } | ).


**********************************************************************
**  " 3.- Operación MULTIPLICACION
*
*    " 3.1 *
*
*
*    lv_total = lv_num_a * lv_num_b. "multiplicación de dos variables previamente declaradas
*
*    out->write( | Number a: { lv_num_a } Number b: { lv_num_b } Total: { lv_total } | ).
*
*    " 3.2 MULTIPLY
*
*    MULTIPLY lv_total BY 5. "OBSOLETA
*
*    out->write( | Total : { lv_total } | ).
*
*    MULTIPLY lv_total BY lv_num_a.  "OBSOLETA Multiplicar por una variable previamente declarada
*
*    out->write( | Total : { lv_total } | ).
*
*    " 3.3 multiplicar por un número entero
*
*    lv_total = lv_total * 2.
*
*    out->write( | Total : { lv_total } | ).

**********************************************************************
**  " 4.- Operación DIVISION
*
*   "4.1 /
*
*   lv_total = lv_num_a / lv_num_b. "división de dos variables previamente declaradas
*
*   out->write( | Number a: { lv_num_a } Number b: { lv_num_b } Total: { lv_total } | ).
*

*   "4.2 DIVIDE
*
*   DIVIDE lv_total BY 2.            " OBSOLETA
*
*   out->write( | Total : { lv_total } | ).
*
*    "4.3  lIMPIAR variable resultado y decir que suma a + b y lo / 3
*
*    CLEAR lv_total.
*
*   lv_total = ( lv_num_a + lv_num_b ) / 3.
*
*   out->write( | Total : { lv_total } | ).

**********************************************************************
**  " 5.- Operación DIVISION SIN RESTO

*   "5.1. Resultado de división sin resto
*
*
*     CLEAR lv_total.
*
*   lv_num_a = 9.
*   lv_num_b = 4.
*
*   lv_total = lv_num_a / lv_num_b.
*
*    out->write( | Number a: { lv_num_a } Number b: { lv_num_b } Total: { lv_total } | ).
*
*   lv_total = lv_num_a DIV lv_num_b. "división de dos variables previamente declaradas
*
*   out->write( | Number a: { lv_num_a } Number b: { lv_num_b } Total: { lv_total } | ).
*
*   out->write( | Total : { lv_total } | ). " se siguen mostrando los decimales .00 por la tipología definida para esta variable

**********************************************************************

***  " 6.- Operación MODULO
*
*   "6.1. MOD Saber el resto o residuo de una división
*
*   lv_num_a = 9.
*   lv_num_b = 4.
*
*    lv_total = lv_num_a / lv_num_b.
*
*    out->write( | Number a: { lv_num_a } Number b: { lv_num_b } Total: { lv_total } | ).
*
*   lv_total = lv_num_a MOD lv_num_b.
*
*    out->write( | Number a: { lv_num_a } Number b: { lv_num_b } Total (con MOD): { lv_total } | ).

**********************************************************************

**  " 7.- Operación EXPONENCIACION
*
*    ".7.1 EXP **
*
*    lv_num_a = 3.
*
*    out->write( | Number a: { lv_num_a } | ).
*
*    lv_num_a = lv_num_a ** 2.
*
*    out->write( | Number a: { lv_num_a } | ).
*
*    "7.1.2 Limpiar variable. Declaración en linea para guardar nº exploente
*
*    CLEAR lv_num_a.
*
*    lv_num_a = 3.
*
*    DATA(lv_exp) = 3.
*
*    lv_num_a = lv_num_a ** lv_exp.
*
*     out->write( | Number a: { lv_num_a } | ).
*
*    " 7.2 ipow
*
*     DATA(result) = ipow( base = 2 exp = 3 ).
*
*     out->write( result ).

**********************************************************************

***  " 8.- Operación RAIZ CUADRADA

    "8.1 SQRT

    "8.1.1 con valor previo de la variable

    lv_num_a = 9.

    out->write( | Number a: { lv_num_a } | ).

    lv_num_a = SQRT( lv_num_a ).

    out->write(  | Total SQRT: { lv_num_a }| ).

    "8.1.2

    CLEAR lv_num_a.

    lv_num_a = SQRT( 25 ).

    out->write(  | Total SQRT: { lv_num_a }| ).


    ENDMETHOD.

ENDCLASS.
