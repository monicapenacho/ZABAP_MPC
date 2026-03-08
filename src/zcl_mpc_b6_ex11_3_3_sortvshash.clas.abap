CLASS zcl_mpc_b6_ex11_3_3_sortvshash DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

 "-----------------------------------------------------------------------
    " EXPLICACIÓN
    "
    " Esta clase ABAP muestra el uso de tres tipos de tablas internas:
    "
    " 1) STANDARD TABLE  → tabla estándar que permite duplicados y no
    "    mantiene orden automáticamente. Acceso secuencial (depende del índice)
    "    útiles cuando se manejan tablas con pocos registros
    "    en caso de tablas grandes mejor usar TABLAS SORT O HASH (mejor rendimiento

    " 2) SORTED TABLE    → tabla ordenada automáticamente por su clave. PUede tener clave única o no única
    "
    " 3) HASHED TABLE    → tabla optimizada para búsquedas rápidas por
    "    clave única usando hashing.
    "
    " Las tablas almacenan datos de reservas (/DMO/BOOKING_M). También se
    " definen variables que representan los campos de la clave y un método
    " auxiliar que permitirá preparar la lectura de registros.
    "-----------------------------------------------------------------------

    INTERFACES if_oo_adt_classrun .

    METHODS constructor.                "Constructor de la clase
    METHODS standard.                   "Método para trabajar con tabla STANDARD
    METHODS sort.                       "Método para trabajar con tabla SORTED
    METHODS hash.                       "Método para trabajar con tabla HASHED

  PROTECTED SECTION.
  PRIVATE SECTION.

  "Declaración de tablas internas
  DATA: lt_standard TYPE STANDARD TABLE OF /dmo/booking_m WITH NON-UNIQUE KEY travel_id booking_id booking_date,
                                      "Tabla interna estándar (sin orden automático y permite duplicados)

        lt_sort     TYPE SORTED TABLE OF /dmo/booking_m WITH NON-UNIQUE KEY travel_id booking_id booking_date,
                                      "Tabla interna ordenada automáticamente por la clave definida

        lt_hash     TYPE HASHED TABLE OF /dmo/booking_m WITH UNIQUE KEY travel_id booking_id booking_date.
                                      "Tabla interna tipo hash con clave única optimizada para búsqueda

 "Definimos tres variables para poder asignar la clave
  DATA: key_travel_id TYPE /dmo/travel_id,      "Variable para almacenar el travel_id usado en búsquedas
        key_booking_id TYPE /dmo/booking_id,    "Variable para almacenar el booking_id
        key_date TYPE /dmo/booking_date.        "Variable para almacenar la fecha de reserva

 " Método para seleccionar la linea Que queremos lear
  METHODS set_line_to_read.                    "Método auxiliar para preparar la clave de lectura

ENDCLASS.



CLASS zcl_mpc_b6_ex11_3_3_sortvshash IMPLEMENTATION.



  METHOD hash.
    DATA(result) = lt_hash[ travel_id    = me->key_travel_id
                            booking_id   = me->key_booking_id
                            booking_date = me->key_date ].
  ENDMETHOD.


  METHOD sort.
    DATA(result) = lt_sort[ travel_id    = me->key_travel_id
                            booking_id   = me->key_booking_id
                            booking_date = me->key_date ].
  ENDMETHOD.

  METHOD constructor.

    SELECT FROM /dmo/booking_m
    FIELDS *
    INTO TABLE @lt_standard.

    SELECT FROM /dmo/booking_m
    FIELDS *
    INTO TABLE @lt_sort.

    SELECT FROM /dmo/booking_m
    FIELDS *
    INTO TABLE @lt_hash.

    set_line_to_read( ).

  ENDMETHOD.

  METHOD standard.

    DATA(result) = lt_standard[ travel_id    = me->key_travel_id
                                booking_id   = me->key_booking_id
                                booking_date = me->key_date ].

  ENDMETHOD.

  METHOD set_line_to_read.

    DATA(lv_data) = lt_standard[ CONV i( lines( lt_standard ) * '0.65' ) ].
    me->key_travel_id = lv_data-travel_id .
    me->key_booking_id = lv_data-booking_id.
    me->key_date = lv_data-booking_date.

  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

  DATA(lo_flights) = NEW zcl_mpc_b6_ex11_3_3_sortvshash( ).

  lo_flights->standard( ).
  lo_flights->sort( ).
  lo_flights->hash( ).

  out->write( me->key_travel_id ).
  out->write( me->key_booking_id ).
  out->write( me->key_date ).

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  "3. PERFORMANCE
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"3.6. Rendimiento de tablas Sort y hash
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"-----------------------------------------------------------------------
" EXPLICACIÓN RESUMIDA PARA EL ALUMNO
"
" Este fragmento de código implementa dos métodos que muestran cómo
" leer registros de dos tipos diferentes de tablas internas:
"
" 1) HASHED TABLE
"    Permite acceder directamente a un registro mediante su clave
"    completa usando una búsqueda muy rápida (acceso tipo hash).
"
" 2) SORTED TABLE
"    Permite acceder a registros usando su clave porque la tabla está
"    ordenada automáticamente por los campos definidos en la clave.
"
" En ambos casos se usa la sintaxis moderna de ABAP:
"
"     itab[ key = value ... ]
"
" que devuelve directamente la fila encontrada en la tabla interna.
"
" Las variables ME->KEY_TRAVEL_ID, ME->KEY_BOOKING_ID y ME->KEY_DATE
" contienen los valores de la clave que se usarán para buscar el
" registro correspondiente en cada tabla.
"-----------------------------------------------------------------------
"-----------------------------------------------------------------------
" EXPLICACIÓN method constructor
"
" Este método es el CONSTRUCTOR de la clase y se ejecuta automáticamente
" cuando se crea una instancia de la clase.
"
" Su objetivo es cargar los datos de la tabla de base de datos
" /DMO/BOOKING_M en tres tipos diferentes de tablas internas:
"
" 1) LT_STANDARD → STANDARD TABLE
" 2) LT_SORT     → SORTED TABLE
" 3) LT_HASH     → HASHED TABLE
"
" De esta forma, los mismos datos se almacenan en diferentes
" estructuras para poder comparar posteriormente el comportamiento
" y el rendimiento de lectura entre los distintos tipos de tablas.
"
" Finalmente se llama al método SET_LINE_TO_READ(), que prepara
" los valores de clave que se utilizarán para buscar registros
" dentro de estas tablas internas.
"-----------------------------------------------------------------------
"-----------------------------------------------------------------------
" EXPLICACIÓN method standard
"
" Este método muestra cómo leer un registro desde una STANDARD TABLE
" usando la sintaxis moderna de acceso por clave:
"
"      itab[ key = value ... ]
"
" La tabla LT_STANDARD se busca usando los campos clave:
" TRAVEL_ID, BOOKING_ID y BOOKING_DATE.
"
" El registro encontrado se guarda en la variable RESULT.
" A diferencia de HASHED o SORTED TABLE, en una STANDARD TABLE la
" búsqueda no está optimizada y normalmente implica un recorrido
" secuencial de la tabla.
"-----------------------------------------------------------------------
"-----------------------------------------------------------------------
" EXPLICACIÓN METHOD set_line_to_read.
" Hacemos alguna operación
" Este método selecciona una fila específica de la tabla interna
" LT_STANDARD para utilizarla posteriormente como clave de lectura.
"
" Primero calcula una posición dentro de la tabla usando:
"      LINES( lt_standard ) * 0.65
" es decir, aproximadamente el 65% del tamaño de la tabla.
"
" La función CONV i convierte ese resultado a un número entero
" para poder usarlo como índice de acceso a la tabla interna.
"
" Luego se lee esa fila de LT_STANDARD y se guardan sus campos
" TRAVEL_ID, BOOKING_ID y BOOKING_DATE en variables de la clase.
"
" Estas variables se utilizarán después como clave para realizar
" búsquedas en las tablas STANDARD, SORTED y HASHED.
"-----------------------------------------------------------------------
"-----------------------------------------------------------------------
" EXPLICACIÓN METHOD if_oo_adt_classrun~main.
"
" Este es el método principal de ejecución de la clase cuando se
" ejecuta desde ADT (ABAP Development Tools) usando la interfaz
" IF_OO_ADT_CLASSRUN.
"
" Primero se crea una instancia de la clase ZCL_16_SORTVSHASH.
"
" Después se ejecutan tres métodos que realizan lecturas en tres
" tipos diferentes de tablas internas:
"
" 1) STANDARD TABLE
" 2) SORTED TABLE
" 3) HASHED TABLE
"
" Finalmente se muestran en la salida los valores de clave utilizados
" para realizar las búsquedas: TRAVEL_ID, BOOKING_ID y BOOKING_DATE.
"-----------------------------------------------------------------------






  ENDMETHOD.
ENDCLASS.
