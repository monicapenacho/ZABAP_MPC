CLASS zcl_mpc_b6_ex11_3_2_accesoitab DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  "-----------------------------------------------------------------------
" EXPLICACIÓN
"
" Este programa ABAP demuestra dos formas de recorrer y modificar
" registros de una tabla interna:
"
" 1) Usando FIELD-SYMBOLS (ASSIGNING) → modificación directa en memoria
"    sin necesidad de usar MODIFY.
"
" 2) Usando una estructura de trabajo (INTO DATA(...)) → se modifica la
"    estructura y luego se actualiza la tabla con MODIFY.
"
" Se leen registros de la tabla /DMO/AIRPORT y se almacenan en una
" tabla interna. Después se procesan mediante dos métodos diferentes
" para comparar ambos enfoques de programación.
"-----------------------------------------------------------------------

    INTERFACES if_oo_adt_classrun .
    METHODS structure.                "Método que procesa la tabla usando una estructura de trabajo
    METHODS field_symbol.             "Método que procesa la tabla usando field-symbols

  PROTECTED SECTION.
  PRIVATE SECTION.


    TYPES lty_flights TYPE STANDARD TABLE OF /dmo/airport WITH NON-UNIQUE KEY airport_id name.
                                      "Definición de tipo de tabla interna basada en /DMO/AIRPORT

    METHODS loop_fs CHANGING c_flights TYPE lty_flights.
                                      "Método que recorre la tabla usando field-symbols

    METHODS loop_struct CHANGING c_flights TYPE lty_flights.
                                      "Método que recorre la tabla usando estructura de trabajo

ENDCLASS.

CLASS zcl_mpc_b6_ex11_3_2_accesoitab IMPLEMENTATION.

  METHOD field_symbol.

    DATA lt_flights TYPE lty_flights.     "Declaración de tabla interna para almacenar aeropuertos

    SELECT FROM /dmo/airport              "Lectura de datos desde la tabla de base de datos
    FIELDS *
    INTO TABLE @lt_flights.               "Los registros se guardan en la tabla interna

    loop_fs( CHANGING c_flights = lt_flights ).
                                         "Llamada al método que recorre la tabla con field-symbols

  ENDMETHOD.



  METHOD structure.

    DATA lt_flights TYPE lty_flights.     "Declaración de tabla interna

    SELECT FROM /dmo/airport              "Lectura de todos los registros de aeropuertos
    FIELDS *
    INTO TABLE @lt_flights.

    loop_struct( CHANGING c_flights = lt_flights ).
                                         "Llamada al método que procesa la tabla con estructura

  ENDMETHOD.



  METHOD loop_fs.

    LOOP AT c_flights ASSIGNING FIELD-SYMBOL(<lfs_flight>).
                                         "Recorre la tabla asignando cada fila a un field-symbol

      <lfs_flight>-country = 'CO'.        "Modifica directamente el campo COUNTRY del registro

    ENDLOOP.

  ENDMETHOD.



  METHOD loop_struct.

    LOOP AT c_flights INTO DATA(ls_flight).
                                         "Recorre la tabla copiando cada registro en una estructura

      ls_flight-country = 'CO'.           "Modifica el campo COUNTRY en la estructura de trabajo

      MODIFY c_flights FROM ls_flight.    "Actualiza la tabla interna con la estructura modificada

    ENDLOOP.

  ENDMETHOD.



  METHOD if_oo_adt_classrun~main.

    DATA(lo_flights) = NEW zcl_mpc_b6_ex11_3_2_accesoitab( ).
                                         "Creación de una instancia de la clase

    lo_flights->structure( ).             "Ejecuta el método que usa estructura de trabajo

    lo_flights->field_symbol( ).          "Ejecuta el método que usa field-symbols

    out->write( 'OK' ).                   "Mensaje de confirmación en la salida



  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  "3. PERFORMANCE
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"3.4. Acceso a tablas internas
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"3.5. Análisis y comparación
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"herramienta abap profiling

" profile as - ABAP APPLICATION CONSOLE quitar el check de sql
" habilitar una perspectiva -> abap PROFILE
" abajo nombre zcl - clase ejecutada
" pestaña de hit list
" navegar a dmo/airport para ver qué solo tiene 47 registros - es pequeña
" nos fijamos en loop - iteración y vemos que tarda menos fieald symbol
" se reduce el tiempo en el uso de apuntadores
" para tablas grandes puede ahorar entre un 25% y un 40% de tiempo de ejecución
" cuando usamos una itab con un f-s en lugar de usar una estructura

"3.6. Rendimiento de tablas Sort y hash
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  ENDMETHOD.
ENDCLASS.
