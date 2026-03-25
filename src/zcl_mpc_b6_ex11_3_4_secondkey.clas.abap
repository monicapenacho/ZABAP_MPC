CLASS zcl_mpc_b6_ex11_3_4_secondkey DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

"-----------------------------------------------------------------------
" 3.7. Uso claves secundarias
" EXPLICACIÓN
"
" Esta clase ABAP demuestra el uso de claves primarias y claves
" secundarias (SECONDARY KEY) en tablas internas tipo SORTED TABLE.
"
" Se definen dos tablas internas basadas en /DMO/BOOKING_M:
"
" 1) LT_SORT
"    Tabla ordenada con una clave primaria compuesta por:
"    TRAVEL_ID, BOOKING_ID y BOOKING_DATE.
"
" 2) LT_SORT_WITH_SK
"    Tabla ordenada con la misma clave primaria pero además con una
"    clave secundaria llamada SK_CARRIER basada en el campo CARRIER_ID.
"
" Las claves secundarias permiten realizar búsquedas más eficientes
" usando otros campos distintos a la clave primaria.
"
" Los métodos definidos en la clase permitirán comparar diferentes
" tipos de acceso a la tabla:
"
" - READ_PRIMARY       → lectura por clave primaria
" - READ_NON_KEY       → lectura sin clave
" - READ_SECONDARY_1/2/3 → lectura usando la clave secundaria
"
" Esto permite analizar el comportamiento y rendimiento de las
" búsquedas en tablas internas con y sin claves secundarias.
"-----------------------------------------------------------------------

  INTERFACES if_oo_adt_classrun.     "Interfaz para ejecutar la clase desde ADT

  METHODS constructor.               "Constructor que cargará los datos
  METHODS read_primary.              "Lectura usando la clave primaria
  METHODS read_non_key.              "Lectura sin utilizar clave
  METHODS read_secondary_1.          "Lectura usando la clave secundaria (variante 1)
  METHODS read_secondary_2.          "Lectura usando la clave secundaria (variante 2)
  METHODS read_secondary_3.          "Lectura usando la clave secundaria (variante 3)

  PROTECTED SECTION.
  PRIVATE SECTION.

  DATA: lt_sort TYPE SORTED TABLE OF /dmo/booking_m                "itab ordenada
        WITH NON-UNIQUE KEY travel_id booking_id booking_date,     "tabla con clave primaria

        lt_sort_with_sk TYPE SORTED TABLE OF /dmo/booking_m         "itab ordenada
        WITH NON-UNIQUE KEY travel_id booking_id booking_date       "tabla con clave primaria
        WITH NON-UNIQUE SORTED KEY sk_carrier COMPONENTS carrier_id.
        "tabla con clave secundaria basada en carrier_id

ENDCLASS.



CLASS zcl_mpc_b6_ex11_3_4_secondkey IMPLEMENTATION.

  METHOD constructor.

  "-----------------------------------------------------------------------
" 3.7. Uso claves secundarias
  "Mejora rendimiento por uso de secondary key en itab



" Este método es el CONSTRUCTOR de la clase y se ejecuta automáticamente
" cuando se crea una instancia del objeto.
"
" Su función es cargar los mismos datos de la tabla de base de datos
" /DMO/BOOKING_M en dos tablas internas:
"
" 1) LT_SORT
"    Tabla SORTED con clave primaria.
"
" 2) LT_SORT_WITH_SK
"    Tabla SORTED que además tiene definida una clave secundaria
"    (SECONDARY KEY) basada en el campo CARRIER_ID.
"
" Esto permite posteriormente comparar diferentes formas de lectura
" utilizando la clave primaria o la clave secundaria.

  SELECT FROM /dmo/booking_m
  FIELDS *
  INTO TABLE @lt_sort.

  SELECT FROM /dmo/booking_m
  FIELDS *
  INTO TABLE @lt_sort_with_sk.

  ENDMETHOD.

  METHOD read_non_key.

  "-----------------------------------------------------------------------
" EXPLICACIÓN
"
" Este método muestra un ejemplo de lectura en una tabla interna
" sin usar la clave primaria de la tabla.
"
" La tabla LT_SORT está definida con una clave basada en:
" TRAVEL_ID, BOOKING_ID y BOOKING_DATE.
"
" Sin embargo, aquí se intenta acceder utilizando el campo
" FLIGHT_DATE, que no forma parte de la clave primaria.
"
" El código comentado muestra una forma tradicional usando
" LOOP AT ... WHERE.
"
" La línea activa utiliza la sintaxis moderna de ABAP:
"
"     itab[ field = value ]
"
" para recuperar directamente un registro que cumpla la condición.
"-----------------------------------------------------------------------

"OPCIÓN 1 ACCESO A ITAB CON LOOP Y CONDICION
*LOOP AT lt_sort INTO DATA(ls_sort) WHERE flight_date = '20240801'.
*
*ENDLOOP.

"OPCION 2 ACCESO A ITAB CON READ TABLE sobre un campo que no forma parte de la clave primaria
" la clave primaria  WITH NON-UNIQUE KEY travel_id booking_id booking_date,
  DATA(ls_flight_without_key) = lt_sort[ flight_date = '20250503' ].  "antes '20240801'

  ENDMETHOD.

  METHOD read_primary.

  "-----------------------------------------------------------------------
" EXPLICACIÓN
"
" Este método demuestra cómo leer un registro de una tabla interna
" usando la clave primaria de la tabla SORTED TABLE.
"
" La tabla LT_SORT está definida con la clave:
" TRAVEL_ID, BOOKING_ID y BOOKING_DATE.
"
" Usando la sintaxis moderna:
"
"     itab[ key = value ... ]
"
" ABAP accede directamente al registro que coincide con esos valores
" de clave, lo que hace la búsqueda más eficiente.
"
" El registro encontrado se guarda en la variable LS_FLIGHT.
"-----------------------------------------------------------------------

*  DATA(ls_flight) = lt_sort[ travel_id    = '00000013'
*                             booking_id   = '0003'
*                             booking_date = '20240402' ].

  DATA(ls_flight) = lt_sort[ travel_id    = '00000005'
                             booking_id   = '0001'
                             booking_date = '20250430' ].



  ENDMETHOD.

  METHOD read_secondary_1.

 "-----------------------------------------------------------------------
" EXPLICACIÓN
"
" Estos métodos muestran cómo leer registros de una tabla interna
" utilizando una clave secundaria (SECONDARY KEY).
"
" La tabla LT_SORT_WITH_SK tiene definida una clave secundaria llamada
" SK_CARRIER basada en el campo CARRIER_ID.
"
" Usando la sintaxis:
"
"     KEY sk_carrier
"
" se indica a ABAP que la búsqueda debe realizarse utilizando esa
" clave secundaria en lugar de la clave primaria de la tabla.
"
" Cada método realiza la misma lectura para demostrar el uso repetido
" de la clave secundaria al acceder a los registros.
"-----------------------------------------------------------------------

   DATA(ls_scnd_key1) = lt_sort_with_sk[ KEY sk_carrier carrier_id = 'AA' ]. "usando por primera vez la clave secundaria CARRIER_ID

  ENDMETHOD.

  METHOD read_secondary_2.

  DATA(ls_scnd_key2) = lt_sort_with_sk[ KEY sk_carrier carrier_id = 'AA' ]. "usando por primera vez la clave secundaria CARRIER_ID

  ENDMETHOD.

  METHOD read_secondary_3.

  DATA(ls_scnd_key3) = lt_sort_with_sk[ KEY sk_carrier carrier_id = 'AA' ]. "usando por primera vez la clave secundaria CARRIER_ID

  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

  "-----------------------------------------------------------------------
" EXPLICACIÓN
" Este es el método principal de ejecución de la clase cuando se
" ejecuta desde ADT utilizando la interfaz IF_OO_ADT_CLASSRUN.
"
" Primero se crea una instancia de la clase ZCL_16_SECONDKEY.
"
" Después se ejecutan varios métodos que demuestran diferentes
" formas de leer datos de una tabla interna:
"
" 1) READ_NON_KEY      → lectura sin usar clave
" 2) READ_PRIMARY      → lectura usando la clave primaria
" 3) READ_SECONDARY_1  → lectura usando clave secundaria
" 4) READ_SECONDARY_2  → lectura usando clave secundaria
" 5) READ_SECONDARY_3  → lectura usando clave secundaria
"
" Esto permite comparar cómo funcionan las lecturas con claves
" primarias, secundarias y sin clave en tablas internas ABAP.
"-----------------------------------------------------------------------

  DATA(object) = NEW zcl_mpc_b6_ex11_3_4_secondkey( ).

  object->read_non_key( ).
  object->read_primary( ).
  object->read_secondary_1( ).
  object->read_secondary_2( ).
  object->read_secondary_3( ).

  out->write(  'ok' ).

  " Activar
  " Cambiar a la perspectiva abap profile abap console
  " quitar el ckeck sql database access
  " Pinchar el icono de lupa con triángulo azul superior
  " desglosar en abap trace
  " doble clikc en la última ejecución
  " " visualizar hit list - analizar el tiempo de procesamiento por todos lo smétodos ejecutados
  "lento proesamiento con primera clave secundaria y el resto mejora rendimiento
  " si da error cambiar valores que nos aseguremos que existen en la tabla

  ENDMETHOD.

ENDCLASS.
