CLASS zcl_mpc_b6_ex11_3_perf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_b6_ex11_3_perf IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  "3. PERFORMANCE
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  "3.1 PROCESAMIENTO TABLAS INTERNAS
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  "TIPOS ITAB : STANDARD , SORTED, HASHED
  " SORT -> organizar el contenido de una ITAB STANDARD
  " ITAB SORTED -> ya ordenadas por una clae

  "ej
  " tipo local de tipo standard de la tabla /dmo/flight (navegamos para ver campos clave)
  " declaramos una tabla interna del tipo anterior
  " Agregamos registros usando el operador VALUE #()

  "-----------------------------------------------------------------------
" EXPLICACIÓN PARA EL ALUMNO
"
" Este código ABAP muestra cómo trabajar con:
"   - Tipos de tablas internas
"   - Creación de datos en una tabla interna usando VALUE
"   - Carga manual de registros
"   - Visualización de los datos antes de aplicar un SORT
"
" PASOS QUE REALIZA EL CÓDIGO
"
" 1. Se define un tipo de tabla interna llamado LTY_FLIGHTS basado en
"    la estructura /DMO/FLIGHT.
"
" 2. Esta tabla tiene una clave NO ÚNICA formada por:
"       carrier_id
"       connection_id
"       flight_date
"
" 3. Se declara una tabla interna LT_FLIGHTS del tipo LTY_FLIGHTS.
"
" 4. Se rellenan registros manualmente utilizando la expresión moderna
"    VALUE #( ).
"
" 5. Se insertan varios vuelos con diferentes aerolíneas:
"       CO  (Colombia)
"       MX  (México)
"       QF  (Qantas)
"       SP  (Spain)
"       LX  (Swiss)
"
" 6. Se muestran los datos antes de aplicar cualquier ordenación
"    usando OUT->WRITE.
"
" 7. Después del comentario se prepararía el ejemplo para demostrar
"    cómo ordenar la tabla interna con SORT.
"
" Este ejemplo es típico para enseñar:
"   - Tablas internas
"   - Expresiones VALUE
"   - Uso de estructuras ABAP modernas
"-----------------------------------------------------------------------
 TYPES lty_flights TYPE STANDARD TABLE OF /dmo/flight
                  WITH NON-UNIQUE KEY carrier_id connection_id flight_date.

DATA lt_flights TYPE lty_flights.

lt_flights = VALUE #(
( client        = sy-mandt
  carrier_id    = 'CO'
  connection_id = '0500'
  flight_date   = '20250201'
  plane_type_id = '123-456'
  price         = '1000'
  currency_code = 'COP' )

( client        = sy-mandt
  carrier_id    = 'MX'
  connection_id = '0600'
  flight_date   = '20250120'
  plane_type_id = '747-400'
  price         = '800'
  currency_code = 'MXN' )

( client        = sy-mandt
  carrier_id    = 'QF'
  connection_id = '0006'
  flight_date   = '20230112'
  plane_type_id = 'A380'
  price         = '1600'
  currency_code = 'AUD' )

( client        = sy-mandt
  carrier_id    = 'CO'
  connection_id = '0500'
  flight_date   = '20250610'
  plane_type_id = '321-654'
  price         = '100'
  currency_code = 'EUR' )

( client        = sy-mandt
  carrier_id    = 'SP'
  connection_id = '0700'
  flight_date   = '20250610'
  plane_type_id = '321-654'
  price         = '100'
  currency_code = 'EUR' )

( client        = sy-mandt
  carrier_id    = 'LX'
  connection_id = '0900'
  flight_date   = '20250101'
  plane_type_id = '258-963'
  price         = '50'
  currency_code = 'COP' )
).

out->write( 'Before Sort' ).
out->write( lt_flights ).

*"SORT with primary key
*" cuando no indicamos explicitamente los campos por los que queremos organizar
*" toma por defecto los campos key de la clave primaria
*" en este ej son 3 WITH NON-UNIQUE KEY carrier_id connection_id flight_date.
*" si no se especifica nada empieza ascendente con el primer campo y luego con el 2º y finalmente con el 3º
*
*"SORT with any fields
*"También se puede organizar por cualquier otro campo (que no sea clave primaria)
*" que forme parte de nuestra tabla
*" Si no especificamos ordenación por defecto se ordena ASCENDENTE
*
*
*
*"SORT with any fields - ASCENDING AND DESCENDING
*" Especificamos un campo para ordenar ascendente y otro descendente
*
*"-----------------------------------------------------------------------
*" EXPLICACIÓN PARA EL ALUMNO
*"
*" Este bloque de código muestra diferentes formas de ordenar
*" una tabla interna en ABAP utilizando la sentencia SORT.
*"
*" En el ejemplo se utilizan tres tipos de ordenación:
*"
*" 1) SORT con la clave primaria de la tabla interna
*"    La tabla se ordena automáticamente por los campos definidos
*"    en la clave al momento de declarar el tipo de tabla.
*"
*" 2) SORT por campos específicos
*"    Permite ordenar por uno o más campos indicados explícitamente.
*"
*" 3) SORT combinando ASCENDING y DESCENDING
*"    Permite controlar el orden de cada campo individualmente.
*"
*" Después de cada ordenación se muestran los datos usando
*" out->write( ) para visualizar el resultado de la ordenación.
*"
*" Esto permite comparar cómo cambia el orden de los registros
*" dentro de la tabla interna lt_flights.
*"
*"-----------------------------------------------------------------------
*
*"SORT with primary key
*SORT lt_flights.
*out->write( 'Sort by primary key' ).
*out->write( lt_flights ).
*
*"SORT with any fields
*SORT lt_flights BY currency_code plane_type_id.
*out->write( 'Sort by 2 fields' ).
*out->write( lt_flights ).
*
*"SORT with any fields - ASCENDING and DESCENDING
*SORT lt_flights BY carrier_id ASCENDING flight_date DESCENDING .
*out->write( 'Sort by 2 fields' ).
*out->write( lt_flights ).

"3.2 Eliminación de registros duplicados
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" DELETE ADJACENT DUPLICATES - sólo se eliminan los registros que están seguidos
*"(uno tras de otro)
*
*" ej 1 no están eliminados los reg duplicados porque no están seguidos (1º y 4º
*
*"-----------------------------------------------------------------------
*" EXPLICACIÓN PARA EL ALUMNO
*"
*" Este bloque de código muestra cómo eliminar registros duplicados
*" consecutivos en una tabla interna utilizando la sentencia:
*"
*"        DELETE ADJACENT DUPLICATES
*"
*" Concepto clave:
*" Esta sentencia solo elimina duplicados que estén uno junto a otro
*" (adyacentes) dentro de la tabla interna.
*"
*" Por esta razón, en la práctica profesional siempre se recomienda
*" ordenar primero la tabla interna usando SORT con los campos clave
*" que definen el duplicado.
*"
*" Flujo lógico típico en ABAP:
*"
*"   1) SORT itab BY campos_clave.
*"   2) DELETE ADJACENT DUPLICATES FROM itab COMPARING campos_clave.
*"
*" En este ejemplo se eliminan duplicados de la tabla interna
*" LT_FLIGHTS.
*"
*" Finalmente, se muestra el contenido de la tabla después de
*" eliminar los duplicados usando:
*"
*"   out->write( lt_flights ).
*"
*"-----------------------------------------------------------------------
*
*"DELETE ADJACENT DUPLICATES
*"CASO 1 no consecutivo
*DELETE ADJACENT DUPLICATES FROM lt_flights.
*
*out->write( lt_flights ).
*
*"CASO 2 consecutivo
*"-----------------------------------------------------------------------
*" EXPLICACIÓN RESUMIDA PARA EL ALUMNO
*"
*" Este código demuestra cómo eliminar registros duplicados en una
*" tabla interna en ABAP.
*"
*" Primero se ordena la tabla interna LT_FLIGHTS por los campos
*" CARRIER_ID y CONNECTION_ID usando la sentencia SORT.
*"
*" Después se utiliza DELETE ADJACENT DUPLICATES para eliminar los
*" registros duplicados que estén consecutivos (adyacentes) en la
*" tabla interna después de la ordenación.
*"
*" Finalmente se muestran los datos resultantes con OUT->WRITE para
*" visualizar el contenido de la tabla después de aplicar el proceso.
*"-----------------------------------------------------------------------
*
*"DELETE ADJACENT DUPLICATES
*" Hizo la comparación por los 3 campos claves y en el tercero no coinciden
*
*SORT lt_flights BY carrier_id connection_id.
*DELETE ADJACENT DUPLICATES FROM lt_flights.
*
*out->write( 'AFTER Sort' ).
*out->write( lt_flights ).
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"CASO3
*" COMPARING especificar por qué campo queremos realizar la comparación
*"-----------------------------------------------------------------------
*
*" Este código muestra cómo eliminar registros duplicados en una tabla
*" interna utilizando DELETE ADJACENT DUPLICATES con la cláusula
*" COMPARING.
*"
*" Primero se ordena la tabla interna LT_FLIGHTS por los campos
*" CARRIER_ID y CONNECTION_ID mediante la sentencia SORT.
*"
*" Luego se eliminan los registros duplicados consecutivos comparando
*" únicamente esos dos campos. Si dos registros tienen el mismo
*" CARRIER_ID y CONNECTION_ID, solo se conserva el primero.
*"
*" Finalmente se muestran los datos resultantes con OUT->WRITE para
*" visualizar el contenido de la tabla después del proceso.
*"-----------------------------------------------------------------------
*
*"DELETE ADJACENT DUPLICATES
*SORT lt_flights BY carrier_id connection_id.
*DELETE ADJACENT DUPLICATES FROM lt_flights COMPARING carrier_id connection_id.
*
*out->write( 'AFTER Sort' ).
*out->write( lt_flights ).
*
*"COMPARING ALL FIELDS todas las columnas de al menos dos líneas tienen que ser =
*" para considerarse duplicadas

"1.3 REDUCCIONES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Reducciones

"La expresión REDUCE en SAP permite realizar acumulaciones o agregaciones eficientes
"sobre elementos de una tabla interna,
"como sumas o concatenaciones, reduciendo datos a un único valor de forma concisa.


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"ej CASO 1
*" declaramos una itab del tipo estándar tomando como soporte dmo - navegamos
*" lectura -> rellenamos como resultado la tabla interna lt_flights_red
*"declaración de una variable
*" INIT definimos una variable que alojará el total y la inicializamos en cero
*" FOR estructura ls_ donde vamos a guardar la iteración de la tabla lt
*" next INCRMENTAMOS LA VARIABLE CON un acumulador += con el campo price de ls
*" luego lo guardaremos en una variable que se declara en LINEA lv_sum
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"Table reductions
*"Ejemplo de uso de la expresión REDUCE para realizar una agregación (suma)
*"sobre los precios de vuelos contenidos en una tabla interna.
*
*DATA lt_flights_red TYPE TABLE OF /dmo/flight.   "Declaración de una tabla interna basada en la estructura /DMO/FLIGHT
*
*SELECT FROM /dmo/flight                         "Lectura de datos desde la tabla de base de datos /DMO/FLIGHT
*FIELDS *                                         "Selección de todos los campos de la tabla
*INTO TABLE @lt_flights_red.                      "Los registros recuperados se guardan en la tabla interna LT_FLIGHTS_RED
*
*DATA(lv_sum) = REDUCE i(                         "Declaración de la variable LV_SUM calculada con la expresión REDUCE
*      INIT lv_result = 0                         "Inicializa la variable acumuladora LV_RESULT en 0
*      FOR ls_flight_red IN lt_flights_red        "Itera sobre cada registro LS_FLIGHT_RED de la tabla interna
*      NEXT lv_result += ls_flight_red-price ).   "En cada iteración suma el campo PRICE al acumulador LV_RESULT
*
*out->write( 'Sum of flights price' ).            "Muestra un texto descriptivo en la salida
*out->write( lv_sum ).                            "Muestra el resultado total de la suma de precios
*out->write( ' ' ).                               "Imprime una línea vacía para mejorar la visualización

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CASO 2 TABLE REDUCTION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tambión se apica a tipos estructurados (con varios campos)
" ej a un tipo tabla con dos columnas price y ASIENTOS ocupados seatsocc
" declaramos una variable estructura donde se va a almacenar el total de la operación
" con REDUCE YA NO pasamos un tipo primitivo i sino un tipo tabla
" NEXT como es una estructura tenemos que especificar con el guión el campo
" hay que acceder a dos campos

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Table reductions
"Este ejemplo muestra cómo usar la expresión REDUCE para calcular
"agregaciones múltiples (suma de precio y suma de asientos ocupados)
"de una tabla interna utilizando una estructura acumuladora.

TYPES: BEGIN OF lty_total,                         "Definición de una estructura para almacenar resultados acumulados
         price    TYPE /dmo/flight_price,          "Campo para acumular el total de precios de vuelos
         seatsocc TYPE /dmo/plane_seats_occupied,  "Campo para acumular el total de asientos ocupados
       END OF lty_total.                           "Fin de la definición de la estructura

DATA lt_flights_red TYPE TABLE OF /dmo/flight.     "Declaración de una tabla interna basada en la estructura /DMO/FLIGHT

SELECT FROM /dmo/flight                            "Lectura de datos desde la tabla de base de datos /DMO/FLIGHT
FIELDS *                                           "Selección de todos los campos de la tabla
INTO TABLE @lt_flights_red.                        "Los registros recuperados se almacenan en la tabla interna LT_FLIGHTS_RED

"STRUCTURE
"Uso de REDUCE con una estructura acumuladora para sumar varios campos.

DATA(ls_data) = REDUCE lty_total(                  "Creación del resultado LS_DATA usando REDUCE con tipo estructura
  INIT ls_totals TYPE lty_total                    "Inicialización de la estructura acumuladora LS_TOTALS
  FOR ls_flight_red2 IN lt_flights_red             "Iteración sobre cada registro de la tabla interna
  NEXT ls_totals-price    += ls_flight_red2-price  "Acumulación del campo PRICE en la estructura
       ls_totals-seatsocc += ls_flight_red2-seats_occupied ). "Acumulación del campo SEATS_OCCUPIED

out->write( 'Sum of flights price and seats occ' ). "Texto descriptivo del resultado mostrado
out->write( ls_data ).                              "Visualización de la estructura con los totales calculados
out->write( ' ' ).                                  "Línea vacía para mejorar la salida

" La operación se agrega en el parámetro de next y con reduce agrupamos




"3.4. Acceso a tablas internas
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" field-symbol -> no copian -> menos memoria y mas flexibles. Acceso + rápido
" preferidos en situación donde se requiere alto rendimiento y gran manipulación de datos
" work area o structur -> copian
" situaciones simples donde el código es más importante que la eficiencia

" comparar





  ENDMETHOD.
ENDCLASS.
