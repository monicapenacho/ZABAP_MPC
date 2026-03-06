CLASS zcl_mpc_b6_ex11_1_debug DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_b6_ex11_1_debug IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " DEPURACION
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " 1.1. Debug en SAP
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"1.2. Perspectiva del debug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" icono insecto - click para cambio perspectiva
" Habilitar en código fuente un punto de interrupción = BREAKPOINT
" EJECUTAR




    " Tipo de tabla basado en /dmo/flight
    TYPES lty_flights TYPE STANDARD TABLE OF /dmo/flight
      WITH NON-UNIQUE KEY carrier_id connection_id.

    " Declaración de tabla interna
    DATA lt_flights TYPE lty_flights.

    " Carga de datos en memoria
    lt_flights = VALUE #(

      ( client         = sy-mandt
        carrier_id     = 'CO'
        connection_id  = '0400'
        flight_date    = cl_abap_context_info=>get_system_date( )
        price          = 200
        currency_code  = 'EUR'
        plane_type_id  = 'A340-600'
        seats_max      = 300
        seats_occupied = 120 )

      ( client         = sy-mandt
        carrier_id     = 'AA'
        connection_id  = '0500'
        flight_date    = cl_abap_context_info=>get_system_date( )
        price          = 350
        currency_code  = 'USD'
        plane_type_id  = 'A380'
        seats_max      = 400
        seats_occupied = 220 )

      ( client         = sy-mandt
        carrier_id     = 'LH'
        connection_id  = '0600'
        flight_date    = cl_abap_context_info=>get_system_date( )
        price          = 500
        currency_code  = 'EUR'
        plane_type_id  = 'B747-400'
        seats_max      = 350
        seats_occupied = 280 )

    ).

    " Mostrar resultado
    out->write( lt_flights ).

" Este bloque demuestra el uso avanzado de la expresión REDUCE para realizar
" una agregación estructurada sobre una tabla interna, acumulando múltiples
" componentes (precio y asientos ocupados) en una única variable de resultado,
" evitando bucles explícitos y aplicando programación funcional en ABAP moderno.

    TYPES: BEGIN OF lty_total,
             price    TYPE /dmo/flight-price,
             seatsocc TYPE /dmo/flight-seats_occupied,
           END OF lty_total.

    DATA(ls_data) = REDUCE lty_total(
                      INIT ls_totals TYPE lty_total
                      FOR ls_flight IN lt_flights
                      NEXT ls_totals-price    += ls_flight-price
                           ls_totals-seatsocc += ls_flight-seats_occupied ).

    out->write( 'Sum of flights price and seats occ' ).
    out->write( ls_data ).
    out->write( ' ' ).

* VISTAS PERSPECTIVAS DEBUG

*“VISTA DE JERARQUIA DE DEPURACION
*“servidor sap , usuario depura y metadatos de código que se depura

*“VISTA DE CODIGO FUENTE
*“ muestra código escrito – diferencia con SAP GUI el código se puede editar y actualizar
*" incluye breakpoint

*VISTA VARIABLES
*Se verifican las variables, incluidas estructuras y tablas internas,  en tiempo de ejecución (se pueden editar)

*después de realizar todas las operaciones el depurador para en el breakpoint
*se puede ingresar en la parte superior el nombre de una variable
*para analizarla en tiempo de ejución
*ver contenido , tipos etc
*ver registros de tablas internas

*VISTA BREAKPOINTS

*VISTA CONSOLA_PROBLEMAS_DEBUGshell_ABAPInternalTable

*MENU SUPERIOR (f6 f8 etc)

" 1.3. Funciones de navegación
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PARAR
" F5, F6, F7 , SHIFT F8 SHIFT F12

" 1.4. tipos de BREAKPOINT
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ESTATICOS
" DINAMICOS
    " Breakpoint at Statement
    " Se detiene cuando se ejecuta una instrucción ABAP específica (ej: SELECT, LOOP, CALL METHOD).

    " Breakpoint at Method
    " Se detiene al entrar en un método determinado, sin necesidad de modificar el código.

    " Breakpoint at Function Module
    " Se detiene cuando se llama a un módulo de función específico.

"1.5. Identificar errores en modo depuración en tiempo de ejecución
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"1.6. Watchpoints
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

*" Este bloque demuestra la definición de una estructura tipada (lty_flights),
*" la lectura de datos desde tablas CDS (/dmo/flight y /dmo/a_booking_d),
*" y la construcción declarativa de una tabla interna final mediante
*" una expresión VALUE con doble FOR anidado, aplicando filtros y
*" combinando datos (join en memoria) usando programación funcional moderna.
*
*TYPES: BEGIN OF lty_flights,
*         aircode    TYPE /dmo/carrier_id,
*         flightnum  TYPE /dmo/connection_id,
*         key        TYPE /dmo/currency_code,
*         seat       TYPE /dmo/plane_seats_occupied,
*         flightdate TYPE /dmo/flight_date,
*       END OF lty_flights.
*
*SELECT FROM /dmo/flight
*  FIELDS *
*  INTO TABLE @DATA(gt_flights).
*
*SELECT FROM /dmo/a_booking_d
*  FIELDS carrier_id, connection_id, customer_id
*  WHERE booking_status EQ 'N'
*  INTO TABLE @DATA(gt_airline).
*
*DATA: gt_final TYPE SORTED TABLE OF lty_flights WITH NON-UNIQUE KEY flightnum.
*
*gt_final = VALUE #(             "establecer un breakpoint
*  FOR gs_flight IN gt_flights WHERE ( carrier_id = 'SQ' )
*
*    FOR gs_airline IN gt_airline WHERE ( connection_id = gs_flight-connection_id )
*
*      ( aircode    = gs_flight-carrier_id
*        flightnum  = gs_airline-connection_id
*        key        = gs_airline-customer_id
*        seat       = gs_flight-seats_occupied " establecer un whatchpoint
*        flightdate = gs_flight-flight_date )
*).
*
*out->write( gt_final ).


"1.7. Guardar sesiones
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

















  ENDMETHOD.
ENDCLASS.
