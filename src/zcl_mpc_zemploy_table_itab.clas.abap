CLASS zcl_mpc_zemploy_table_itab DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

      " 👇 Tipo reutilizable
    TYPES: BEGIN OF zemp_struc,
             mandt         TYPE mandt,
             id            TYPE c LENGTH 20,
             first_name    TYPE c LENGTH 40,
             last_name     TYPE c LENGTH 40,
             email         TYPE c LENGTH 50,
             phone_number  TYPE c LENGTH 20,
             salary        TYPE p LENGTH 15 DECIMALS 2,
             currency_code TYPE c LENGTH 5,
           END OF zemp_struc.

    TYPES zemp_itab TYPE STANDARD TABLE OF zemp_struc WITH EMPTY KEY.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_zemploy_table_itab IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*      " Declaramos tipo estructura local
*    TYPES: BEGIN OF zemp_struc,
*         mandt         TYPE mandt,
*         id            TYPE c LENGTH 20,
*         first_name    TYPE c LENGTH 40,
*         last_name     TYPE c LENGTH 40,
*         email         TYPE c LENGTH 50,
*         phone_number  TYPE c LENGTH 20,
*         salary        TYPE p LENGTH 15 DECIMALS 2,
*         currency_code TYPE c LENGTH 5,
*       END OF zemp_struc.

    " Declaramos tabla interna
    DATA zemp_itab TYPE STANDARD TABLE OF zemp_struc WITH EMPTY KEY.

    " Cargamos datos en memoria (inicialización compacta)
    zemp_itab = VALUE #(
      ( mandt = sy-mandt
        id = '00000000000000000001'
        first_name = 'Laura'
        last_name = 'Martinez'
        email = 'laura@logali.com'
        phone_number = '38512369'
        salary = 2000
        currency_code = 'EUR' )

      ( mandt = sy-mandt
        id = '00000000000000000002'
        first_name = 'Mario'
        last_name = 'Martinez'
        email = 'mario@logali.com'
        phone_number = '38512369'
        salary = 2000
        currency_code = 'EUR' )

      ( mandt = sy-mandt
        id = '00000000000000000003'
        first_name = 'Daniela'
        last_name = 'Linares'
        email = 'daniela@logali.com'
        phone_number = '38512369'
        salary = 2000
        currency_code = 'EUR' )

      ( mandt = sy-mandt
        id = '00000000000000000004'
        first_name = 'Karol'
        last_name = 'Pérez'
        email = 'kperez@logali.com'
        phone_number = '546987'
        salary = 5000
        currency_code = 'USD' )
    ).

    " Mostramos resultado
    out->write( zemp_itab ).

  ENDMETHOD.
ENDCLASS.
