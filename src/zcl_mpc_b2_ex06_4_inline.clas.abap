CLASS zcl_mpc_b2_ex06_4_inline DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

      INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_b2_ex06_4_inline IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   " Inline declaration

   " El compilador tomará de forma implicita (en tiempo de ejecución)
   " el tipo de dato dependiendo del valor que el usuario pase dentro
   " de esta variable en la asignación

   """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

*   DATA(lv_nombre_variable) = valor_variable.
*

    "DECLARACION EN LINEA

   data(lv_mult) = 8 * 16.
   out->write( lv_mult ).

   DATA(lv_div) = 8 / 16.  "SI QUEREMOS DECIMALES HAY QUE INDICARLO PORQUE POR DEFECTO AL DECLARARLO EN LINEA LO TOMA COMO ENTERO (VER ABAJO)
   out->write( lv_div ).

   DATA(lv_text) = 'ABAP I 2025'.
   out->write( lv_text ).  "PONER UN BREAKPOINT PARA VER CON DEBUG
                           " EL TIPO QUE HA TOMADO EL COMPILADOR POR LA OP REALIZADA EN ESA ASIGNACION
                           "RECIBE UN NUMERO ENTERO Y POR TANTO TOMA NUMERO ENTERO

   DATA(lv_dec) = '10.254'. "Los decimales para que identifique el punto decimal hay que colocarlo entre comillas
   out->write( lv_dec ).    "ahora al hacer el breakpoint en debug vemos que lo ha tomado como cadena de caracteres
                            "si queremos que sea decimal entonces debemos especificar el tipo. Por lo que cuidado con la declaración en linea



  ENDMETHOD.

ENDCLASS.
