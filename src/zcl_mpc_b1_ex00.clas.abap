CLASS zcl_mpc_b1_ex00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  INTERFACES if_oo_adt_classrun. "agregar interfaz para ejectuar y ver en consola-definición PODER VISUALIZAR LAS IMPRESIONES DENTRO DE LA EJECUCIÓN DE NUESTRO CODIGO

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_mpc_b1_ex00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main. "agregar interfaz para ejectuar y ver en consola-implementación

    out->write( 'This is my first class' ).

  ENDMETHOD. "cierre

ENDCLASS.
