CLASS zcl_mpc_b2_ex06_3_red DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_b2_ex06_3_red IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  "TRUNCAMIENTO - perdida de datos
  "REDONDEO - aproximacion

        DATA: lv_string TYPE string VALUE 'MONICA',
              lv_char   TYPE c LENGTH 2,
              lv_int    TYPE i,
              lv_num    TYPE n LENGTH 6.

        DATA: lv_date    TYPE d,
              lv_decimal TYPE p LENGTH 3 DECIMALS 2,
              lv_decimal2 TYPE p LENGTH 3 DECIMALS 4.

    "truncation and rounding

    "truncation

      lv_char = lv_string.  " long de char 2 y de string tiene un valor de 7
      out->write( lv_char ). "MONICA -> MO  Se pierden carteres

      "Rounding"

      lv_decimal = 1 / 6.   "ojo solo 2 decimales
      out->write( lv_decimal ). "0.16666666666666666666666666666666666666666666666666666666666666666666666666666666666666666

      "Rounding"

      lv_decimal2 = 1 / 6.  "amplio a 4 decimales
      out->write( lv_decimal2 ). "0.16666666666666666666666666666666666666666666666666666666666666666666666666666666666666666

     "Rounding"

      lv_decimal2 = 1 / 12.  "amplio a 4 decimales
      out->write( | 1/12 is rounded to  { lv_decimal2  } | ). "concatenación para indicar más información ej el valor de la operacion

  ENDMETHOD.
ENDCLASS.
