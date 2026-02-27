CLASS zcl_mpc_b2_ex06_2_conv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_b2_ex06_2_conv IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
      " CONVERSIONES DE TIPOS
      """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
      " LAS VAIABLES TIENEN QUE ESTAR DECLARADAS
      " SE ASIGNA UN VALOR DE 1 VAR A OTRA DE DISTINTO TIPO ->
      " el compliador intenta convertir del origen al destino
      " para tener exito los valores tienen que ser compativles

*  " DECLARACION VARIABLES
*  " Primer bloque DATA (String e Integer)
*  DATA: lv_string TYPE string VALUE '12345',    " Hemos asignado un valor con una cadena de caracteres ''
*      lv_int    TYPE i.
*
*  "Segundo bloque DATA (Fecha y Decimal)
*  DATA: lv_date    TYPE d,
*      lv_decimal TYPE p LENGTH 3 DECIMALS 2.
*
*   "ASIGNACIO DE 1 VAR PASANDO EL VALOR DE OTRA VAR
*
*   lv_int = lv_string.
*
*   out->write( lv_int ).
*
*   """"
*
*   lv_string = '20250101'.
*   lv_date = lv_string.
*
*   out->write( lv_date ).
*
*   """"
*
*   lv_string = '123.45'.
*   lv_date = lv_string.
*
*   out->write( lv_string ).
*   out->write( | Date { lv_date DATE = USER } | ). " Realizamos un formateo mediante DATE = USER
*
*   """
*    " Si los valores son incompatibles - > error (tiempo de ejecución)
*
*
*  DATA: lv_string2 TYPE string VALUE 'MONI',    " Hemos asignado un valor con una cadena de caracteres ''
*      lv_int2    TYPE i.
*
*   lv_int2 = lv_string2.
*
*   out->write( lv_int2 ).
*
*   "error abajo a derecha CONVT_NO_NUMBER Este string contiene letras y no numeros como cadena de caracteres
*   " son tipos incompatibles
*   " PULSAR SHOW para profundizar en el error (arriba del todo tipo de error y abajo sombreado en emarillo la linea

      """

      " INCOMPATIBILIDAD 2


*      DATA: lv_string TYPE string VALUE 'MONICA',
*      lv_int    TYPE i.
*
*      DATA: lv_date    TYPE d,
*      lv_decimal TYPE p LENGTH 3 DECIMALS 2.
*
*      lv_string = '12345678'.
*      lv_decimal = lv_string.

      "nOS hemos excedido de la longitud 6 vs 8 "

      """
      " CONVERSION DE FECHA A NUMERO - CONTENIO TENIENDO EN CUENTA 01010001

      DATA: lv_string TYPE string VALUE 'MONICA',
            lv_int    TYPE i,
            lv_num    TYPE n LENGTH 6.

      DATA: lv_date    TYPE d,
            lv_decimal TYPE p LENGTH 3 DECIMALS 2.

      lv_date = cl_abap_context_info=>get_system_date( ). " fecha actual del servidor del sistema
      out->write( lv_date ).

      lv_int = lv_date.             "conversión conteo del nº de días desde 01010001
      out->write( lv_int ).

      "concersión 2
      lv_string = 'A1B2C3'.
      lv_num = lv_string.           "elimina letras y deja sólo numeros y rellena con ceros a la izquierda
      out->write( lv_num ).

  ENDMETHOD.
ENDCLASS.
