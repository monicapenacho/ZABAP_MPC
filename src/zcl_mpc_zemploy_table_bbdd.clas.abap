CLASS zcl_mpc_zemploy_table_bbdd DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_zemploy_table_bbdd IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.



  DELETE FROM zemploy_table.
**
MODIFY zemploy_table FROM TABLE @(

    VALUE #( ( mandt = '100'
    id = '00000000000000000001'
    first_name = 'Laura'
    last_name = 'Martinez'
    email = 'laura@logali.com'
    phone_number = '38512369'
    salary = 2000
    Currency_code = 'EUR' )

  ( mandt = sy-mandt
    id = '00000000000000000002'
    first_name = 'Mario'
    last_name = 'Martinez'
    email = 'mario@logali.com'
    phone_number = '38512369'
    salary = 2000
    currency_code = 'EUR' )


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
)

    ).


  ENDMETHOD.
ENDCLASS.
