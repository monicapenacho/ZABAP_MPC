CLASS zcl_mpc_b5_ex10_2_expcons_new DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA: lv_name TYPE string,
          lv_age  TYPE i.

    METHODS: constructor IMPORTING iv_name TYPE string

                                   iv_age  TYPE i.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_mpc_b5_ex10_2_expcons_new IMPLEMENTATION.


  METHOD constructor.
   "Igualación variable a parámetro
    lv_age  = iv_age.
    lv_name = iv_name.

  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.



  ENDMETHOD.

ENDCLASS.
