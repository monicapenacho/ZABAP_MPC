CLASS zcl_mpc_b1_ex01_types DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  INTERFACES if_oo_adt_classrun.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_b1_ex01_types IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


**********************************************************************
* TIPOS DATOS

**********************************************************************
* DATA declaracion de variable. Si es local lv. TYPE para definir tipo

*  DATA lv_string TYPE string. "Variable de tipo string (cadena de caracteres)
*
*  lv_string = '20250110'.      "Asignar valor a la variable
*
*  out->write( lv_string ).     "Imprimir en pantalla (nombre variable).

* DATA: declarar varias variables separadas por ,

  DATA: lv_string TYPE string,           "Variable de tipo string (cadena de caracteres)
        lv_int    TYPE i VALUE 20250110, "Variable de tipo número entero
        lv_date   TYPE d,                 "Variable de tipo fecha
        lv_dec TYPE p LENGTH 8 DECIMALS 2 VALUE '202501.10',           "Variable TIPO INCOMPLETO de tipo decimal.
                                            "Usamos la de empaquetado hay que pasarle la longitud Y DECIMALES
                                            " ENTRE comillas por el problema del punto al final del comando
        lv_car TYPE c LENGTH 10 VALUE 'profesor'.            "Variable TIPO INCOMPLETO de tipo caracter,
                                            "Como es incompleto hay que pasarle la longitud de manera explictia
                                            "No podemos pasarnos de esa longitud o nos arroja un error de compilación

  lv_string = '20250110'.     "Asignar valor a la variable. También se puede hacer en la misma posición de la declaración de la variable con VALUE
  lv_date = '20250110'.      "Asignar valor a la variable. También se puede hacer en la misma posición de la declaración de la variable con VALUE

  out->write( lv_string ).  "Imprimir en pantalla (nombre variable).
  out->write( lv_int ).     "Imprimir en pantalla (nombre variable).
  out->write( lv_date ).     "Imprimir en pantalla (nombre variable).

                             " Borrar consola
                             "Activar y ejecutar en consola
                             "Se imprime en consola en la 3ª posición
                             "poner en fila 45 un punto de interrupción
                             "pulsar debug (bicho) y ver a derecha en variables los tipos
                             "si no funcona Run As → ABAP Application (Console)

  out->write( lv_dec ).     "Imprimir en pantalla (nombre variable).
                               "quitar punto de interrupción y ejecutar
                               "quita un decimal porque el cero a la dercha no vale nada
  out->write( lv_car ).     "Imprimir en pantalla (nombre variable).

  ENDMETHOD.

ENDCLASS.
