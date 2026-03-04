CLASS zcl_mpc_b4_ex09_2_itab DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_b4_ex09_2_itab IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " BLOQUE IV TABLAS INTERNAS II
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " 2.1 FOR
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

*  " OPERADOR ITERACION - para tablas de gran tamaño. También se puede rellenar una TI a partir de otra
*  " columnas diferentes, limitir
*  " CONDICIONES DE ITERACION
*      " UNTIL
*      " WHILE
*  " IN - tomar los registros de otra tabla interna GT
*
*  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*  " EJ 1 TABLA = value # ( for conteo se detiene cuando el contador sea mayor que 30 y después de registringir
*  " colocamos los campos que queremos rellenar ALT + SHIFT + A
*  " ID USUARIO VA incrmeentando al sumarle i en cada iteración
*  "while LA iteración se haga mientras que el contador sea mnor o igual a un valor
*
*  " rellenar con otra tabla
*
*  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*  "Este bloque define un tipo estructurado lty_flights con los campos necesarios para almacenar información de vuelos, y posteriormente declara dos tablas internas basadas en dicho tipo para gestionar conjuntos de datos en memoria.
*
*TYPES: BEGIN OF lty_flights,
*         iduser     TYPE /dmo/customer_id,
*         aircode    TYPE /dmo/carrier_id,
*         flightnum  TYPE /dmo/connection_id,
*         key        TYPE land1,
*         seat       TYPE /dmo/plane_seats_occupied,
*         flightdate TYPE /dmo/flight_date,
*       END OF lty_flights.
*
*DATA: gt_flights_info TYPE TABLE OF lty_flights,
*      gt_my_flights   TYPE TABLE OF lty_flights.
*
* "Este bloque demuestra el uso de la expresión FOR dentro de VALUE para construir dinámicamente una tabla interna en una sola sentencia, generando múltiples registros de forma automática mediante un contador y asignando valores calculados a cada campo.
*
*gt_my_flights = VALUE #( FOR i = 1 UNTIL i > 30
*  ( iduser     = |{ 123456 + i }|
*    aircode    = 'LH'
*    flightnum  = 0001 + i
*    key        = 'US'
*    seat       = 0 + i
*    flightdate = cl_abap_context_info=>get_system_date( ) + i ) ). "fecha actual + i
*
*out->write( data = gt_my_flights name = 'gt_my_flights' ).
*
*"Este bloque demuestra el uso de la expresión FOR dentro de VALUE para generar dinámicamente la tabla interna gt_flights_info mediante un bucle controlado por contador, y posteriormente muestra por consola ambas tablas internas para comparar sus conteni
"d
*"os.
*
**gt_flights_info = VALUE #( FOR i = 1 WHILE i <= 20
**  ( iduser     = |{ 123456 + i }|
**    aircode    = 'LH'
**    flightnum  = 0001 + i
**    key        = 'US'
**    seat       = 0 + i
**    flightdate = cl_abap_context_info=>get_system_date( ) + i ) ).
**
**out->write( data = gt_my_flights name = 'gt_my_flights' ).
**out->write( |\n| ).
**out->write( data = gt_flights_info name = 'gt_flights_info' ).
*
*"Este bloque demuestra el uso de la expresión FOR ... IN para construir una nueva tabla interna (gt_flights_info) recorriendo otra tabla interna (gt_my_flights), copiando explícitamente cada componente campo a campo mediante expresiones modernas de VALU
"E.
*
*gt_flights_info = VALUE #(
*  FOR gs_my_flight IN gt_my_flights
*    ( iduser     = gs_my_flight-iduser
*      aircode    = gs_my_flight-aircode
*      flightnum  = gs_my_flight-flightnum
*      key        = gs_my_flight-key
*      seat       = gs_my_flight-seat
*      flightdate = gs_my_flight-flightdate ) ).
*
*out->write( data = gt_my_flights name = 'gt_my_flights' ).
*out->write( |\n| ).
*out->write( data = gt_flights_info name = 'gt_flights_info_relleno_de_otra_tabla' ).
*
*"Este bloque demuestra el uso de la expresión FOR ... IN con cláusula WHERE para filtrar registros durante la construcción de una nueva tabla interna, copiando únicamente aquellos vuelos cuyo aircode sea 'LH' y cuyo flightnum sea mayor que 001.
*
*gt_flights_info = VALUE #(
*  FOR gs_my_flight IN gt_my_flights
*  WHERE ( aircode = 'LH' AND flightnum GT 0012 )
*    ( iduser     = gs_my_flight-iduser
*      aircode    = gs_my_flight-aircode
*      flightnum  = gs_my_flight-flightnum
*      key        = gs_my_flight-key
*      seat       = gs_my_flight-seat
*      flightdate = gs_my_flight-flightdate ) ).
*
*out->write( data = gt_my_flights name = 'gt_my_flights' ).
*out->write( |\n| ).
*out->write( data = gt_flights_info name = 'gt_flights_info_relleno_de_otra_tabla_con_filtro' ).

  " 2.2 FOR ANIDADO - CURSOR PARALELO
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" FOR + filtro con where no es eficiente cuando las TI tienen gran tamaño
*" usar MULTIPLES BUCLES ANIDADOS - WHERE para encontrar las entradas coincidentes
*" UP TO reducir numero de registros
*
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" gt_final tabla final donde guardaremos la info del for anidado
*" vamos a iterar dos ti
*" ¿cómo anidamos o vinculamos los resultados? que sean iguales por un campo por ej campo = gs_anterior-campo
*" traemos los campos primero de una estructura y debajo de otra estructura
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*"Este bloque define una estructura local lty_flights, realiza dos selecciones a base de datos (vuelos y reservas limitadas), y declara una tabla interna ordenada por precio de vuelo para posteriores operaciones sobre los datos.
*
*TYPES: BEGIN OF lty_flights,
*         aircode     TYPE /dmo/carrier_id,
*         flightnum   TYPE /dmo/connection_id,
*         flightdate  TYPE /dmo/flight_date,
*         flightprice TYPE /dmo/flight_price,
*         currency    TYPE /dmo/currency_code,
*       END OF lty_flights.
*
*SELECT FROM /dmo/flight
*  FIELDS *
*  INTO TABLE @DATA(gt_flights_type).
*
*SELECT FROM /dmo/booking_m
*  FIELDS carrier_id, connection_id, flight_price, currency_code
*  INTO TABLE @DATA(gt_airline)
*  UP TO 20 ROWS.
*
*DATA gt_final TYPE SORTED TABLE OF lty_flights
*              WITH NON-UNIQUE KEY flightprice.

**"Este bloque demuestra el uso de una expresión FOR anidada para construir una tabla interna ordenada (gt_final), combinando datos de dos tablas internas (gt_flights_type y gt_airline) mediante filtrado por carrier_id, generando un resultado similar a u
"n INNER JOIN en memoria.

*gt_final = VALUE #(
*  FOR gs_flight_type IN gt_flights_type WHERE ( carrier_id EQ 'AA' )
*  FOR gs_airline IN gt_airline WHERE ( carrier_id = gs_flight_type-carrier_id )
*    ( aircode     = gs_flight_type-carrier_id
*      flightnum   = gs_flight_type-connection_id
*      flightdate  = gs_flight_type-flight_date
*      flightprice = gs_airline-flight_price
*      currency    = gs_airline-currency_code ) ).
*
*out->write( data = gt_final name = 'gt_final' ).



  " 2.2 AÑADIR MULTIPLES LINEAS (SELECT) - SELECT
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
**" SENTENCIA SELECT
**" podemos realizar lecturas con multiples propositos y también podemos aplicar para tablas internas
**" 1 tabla origen
**" 2 FIELDS campos que queremos tomar
**" 3 WHERE filtro (opcional)
**" 4 INTO TABLE @DATA (volcar la info por ejemplo en una tabla interna). Elimina a diferencia de APPENING las anteriores entradas
**
**" APPENing tenemos en cuenta las anteriores entradas que había antes de la ejecución del código y las agrega
*
**
**"Este bloque demuestra el uso de SELECT sobre base de datos para cargar vuelos del carrier 'LH' en una tabla interna, y posteriormente un SELECT adicional directamente sobre la tabla interna (@itab) para proyectar únicamente campos específicos en una n
"u
*"e
**"va tabla interna copia.
**
**SELECT FROM /dmo/flight
**  FIELDS *
**  WHERE carrier_id EQ 'LH'
**  INTO TABLE @DATA(gt_flights).
**
**SELECT carrier_id, connection_id, flight_date
**  FROM @gt_flights AS gt
**  INTO TABLE @DATA(gt_flights_copy).
**
**out->write( data = gt_flights_copy name = 'gt_flights_copy' ).
*
*  " 2.3 ORDENAR REGISTROS - SORT
*  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
**" NO aplica para tablas SORT porque ya vienen ordenado
**" Orden por clave primaria de la tabla o especificando explicitamente algún campo para ordenar ascendente o descendente
**" BY el campo por el cual queremos ordenar (por defecto se ordena ascendente por clave primaria), Se puede combinar
**
**""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
**
**"Este bloque demuestra la declaración explícita de una tabla interna tipada, la carga de datos desde base de datos filtrando por carrier 'LH', y posteriormente el uso de SELECT sobre tabla interna (@itab) para generar una copia proyectando únicamente d
"et
**"erminados campos.
**
**DATA: gt_flights TYPE STANDARD TABLE OF /dmo/flight.
**
**SELECT FROM /dmo/flight
**  FIELDS *
**  WHERE carrier_id EQ 'LH'
**  INTO TABLE @gt_flights.
**
**SELECT carrier_id, connection_id, flight_date
**  FROM @gt_flights AS gt
**  INTO TABLE @DATA(gt_flights_copy).
**
**out->write( data = gt_flights_copy name = 'gt_flights_copy' ).
**
**
**"Este bloque demuestra cómo ordenar una tabla interna STANDARD (sin clave primaria definida) utilizando la sentencia SORT, aplicando el ordenamiento explícitamente por los campos deseados.
**
**"SORT básico (ordena por todos los campos en orden ascendente)
**SORT gt_flights_copy.
**
**out->write( data = gt_flights_copy name = 'gt_flights_copy' ).
**
**
**"Ordenando explícitamente por campos concretos (recomendado cuando la clave primaria está vacía)
**SORT gt_flights_copy BY carrier_id connection_id flight_date.
**
**out->write( data = gt_flights_copy name = 'gt_flights_copy' ).
**
**
**"Orden descendente por un campo específico
**SORT gt_flights_copy BY flight_date DESCENDING.
**
**out->write( data = gt_flights_copy name = 'gt_flights_copy' ).
**
**"Este bloque es para la ordenación de una tabla interna STANDARD declarada de florma explicita. Ya no se toma como clave vacía
**" todos los componentes o campos que formen la clave primaria de la tabla principal
**" si no se indica de forma explicita el campo por el que queremos ordenar toma por defecto la clave primaria
**" por defecto es ordenación ascendente
**
**"Este bloque demuestra la ordenación de una tabla interna estándar (STANDARD TABLE) utilizando la sentencia SORT, reorganizando sus registros en memoria según la clave estándar de la tabla antes de mostrarlos por consola.
**
**SORT gt_flights.
**out->write( data = gt_flights name = 'gt_flights' ).
**
**"Este bloque demuestra la ordenación descendente de una tabla interna estándar (STANDARD TABLE) utilizando la sentencia SORT
**"con la adición DESCENDING, reorganizando los registros en memoria en orden inverso según la clave estándar antes de mostrarlos por consola.
**
**SORT gt_flights DESCENDING.
**out->write( data = gt_flights name = 'gt_flights_descendente' ).
**
**"Este bloque demuestra la ordenación explícita de una tabla interna estándar utilizando la cláusula BY para definir el criterio de ordenación por el campo flight_date en orden ascendente, mostrando posteriormente el resultado en consola.
**
**SORT gt_flights_copy BY flight_date.
**out->write( data = gt_flights_copy name = 'gt_flights_copy' ).
**
**"Este bloque demuestra la ordenación explícita de una tabla interna estándar utilizando la cláusula BY junto con DESCENDING para ordenar los registros por el campo flight_date en orden descendente, mostrando posteriormente el resultado en consola.
**
**SORT gt_flights_copy BY flight_date DESCENDING.
**out->write( data = gt_flights_copy name = 'gt_flights_copy' ).
**
**"Este bloque demuestra la ordenación múltiple de una tabla interna estándar utilizando la cláusula BY con diferentes criterios de orden, aplicando primero un orden descendente por flight_date y, en caso de igualdad, un orden ascendente por connection_i
"d,
**" mostrando posteriormente el resultado en consola.
**
**SORT gt_flights_copy BY flight_date DESCENDING connection_id ASCENDING.
**out->write( data = gt_flights_copy name = 'gt_flights_copy' ).
*
*  " 2.4 MODIFICAR REGISTROS - MODIFY
*  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" SE pueden modificar los registros de una TI: read table, look at ?? loop at??? , modify
*
*" MODIFY tabla VALUE #( CAMPOS A MODIFICAR). Modifica los registros que cumple la condición del IF y el resto de filas las deja en blanco
*" VALUE #() solo funciona a partir de ABAP 7.54 / 7.55 en adelante
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" SI el componente (delante la estructura a la que pertenence el componente) es mayor que n
*" asignamos fecha actual (estándar) - asignamos el valor que queremos poner
*" MODIFY tabla interna FROM traemos los valores de la estructura INDEX posición 2 queremos modificar
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"Este bloque demuestra la declaración explícita de una tabla interna estándar tipada con la estructura de base de datos /dmo/flight, la carga de registros filtrados por carrier 'LH' desde la base de datos y su posterior ordenación descendente en memoria
*"antes de mostrarlos por consola.
*
*DATA: gt_flights TYPE STANDARD TABLE OF /dmo/flight.
*
*SELECT FROM /dmo/flight
*  FIELDS *
*  WHERE carrier_id EQ 'LH'
*  INTO TABLE @gt_flights.
*
*SORT gt_flights DESCENDING.
*
*" MODIFY
*
*"Este bloque demuestra el uso de LOOP AT para recorrer una tabla interna antes y después de una posible modificación (contexto MODIFY), mostrando el estado inicial y final de la tabla para comparar los cambios realizados en memoria.
*
*out->write( data = gt_flights name = 'BEFORE / gt_flights' ).
*
*DATA(lv_index) = sy-tabix. "X
*
*LOOP AT gt_flights INTO DATA(gs_flight).
*
***"Este bloque demuestra la modificación condicional de un registro de una tabla interna utilizando MODIFY con acceso por índice,
***"actualizando previamente el campo flight_date cuando cumple la condición establecida.
*
*    out->write( lv_index ). "X
*        IF gs_flight-flight_date GT '20250101'.
*    out->write( |dentro  { lv_index } | ). "X
*          gs_flight-flight_date = cl_abap_context_info=>get_system_date( ).
*
**          MODIFY gt_flights FROM gs_flight INDEX 2.
*          MODIFY gt_flights FROM gs_flight INDEX sy-tabix.
*
*        ENDIF.
*
**"Este bloque demuestra el uso de la sentencia MODIFY con la cláusula TRANSPORTING,
**"permitiendo actualizar únicamente el campo flight_date del registro correspondiente en la tabla interna sin afectar al resto de componentes de la estructura.
**" solo realiza el cambio en las fechas que cumplen la condición En todos las filas (no tenemos limitación de indice
***
**    IF gs_flight-flight_date GT '20250101'.
**
**      gs_flight-flight_date = cl_abap_context_info=>get_system_date( ).
**
**      MODIFY gt_flights FROM gs_flight TRANSPORTING flight_date.
**
**    ENDIF.
*
**
**"Este bloque demuestra el uso de MODIFY con una expresión VALUE para actualizar directamente un registro de la tabla interna mediante construcción inline de una estructura con los campos que se desean modificar.
**
**    IF gs_flight-flight_date GT '20260101'.
**
**      gs_flight-flight_date = cl_abap_context_info=>get_system_date( ).
**
**      MODIFY gt_flights from VALUE #(
**                                  connection_id = '111'
**                                  carrier_id    = 'XX'
**                                  plane_type_id = 'YY'
**                                 ).
**
**    ENDIF.
**
**
**
**
**
**    IF gs_flight-flight_date GT '20250101'.
**
**      gs_flight-flight_date = cl_abap_context_info=>get_system_date( ).
**
**        MODIFY gt_flights FROM VALUE #(
**                                        connection_id = '111'
**                                        carrier_id    = 'XX'
**                                        plane_type_id = 'YY'
**                                      )
**                                      TRANSPORTING connection_id
**                                                   carrier_id
**                                                   plane_type_id.
**
**    ENDIF.
**
*ENDLOOP.
*
*out->write( |\n| ).
*out->write( data = gt_flights name = 'AFTER gt_flights_VALUE#' ).


  " 2.6 ELIMINAR REGISTROS -DELETE
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*  " DELETE
*  " ELIMINAR registros en tiempo de ejecución de las TI
*        "1.- toda la estructura
*        "2.- un registro o indice o posición
*        "3.- un rango de índices
*        "4.- borrado si algún campo está vacío
*
*  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*  " DELETE TABLE tabala con la que queremos trabajar de dónde se van a traer los valores que se van a
*  "borrar
*
*  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*  "Este bloque demuestra la declaración de una tabla interna estándar y una estructura de trabajo tipadas con la tabla de base de datos /dmo/airport, la selección de registros filtrados por país 'US', su carga en memoria y la preparación para su procesa
"m
*"iento mediante LOOP, mostrando previamente el estado inicial de la tabla interna en consola.
*
*DATA: gt_flights_struc TYPE STANDARD TABLE OF /dmo/airport,
*      gs_flights_struc TYPE /dmo/airport.
*
*SELECT FROM /dmo/airport
*  FIELDS *
*  WHERE country EQ 'US'
*  INTO TABLE @gt_flights_struc.
*
*IF sy-subrc EQ 0.
*
*  out->write( data = gt_flights_struc name = 'BEFORE gt_flights_struc' ).
*
*  LOOP AT gt_flights_struc INTO gs_flights_struc.
*
*  "BLOQUE 1
*  "Este bloque demuestra la eliminación condicional de registros de una tabla interna mediante DELETE TABLE FROM
*   "dentro de un LOOP, evaluando múltiples valores del campo airport_id y
*   "suprimiendo en memoria aquellas filas que cumplen la condición lógica establecida.
*
*    IF gs_flights_struc-airport_id = 'JFK' OR
*       gs_flights_struc-airport_id = 'BNA' OR
*       gs_flights_struc-airport_id = 'BOS'.
*
*      DELETE TABLE gt_flights_struc FROM gs_flights_struc.
*
*    ENDIF.
*
*  ENDLOOP.
*
*     "BLOQUE 2
*    "borrar posición: indicar con el índice
*    "Este bloque demuestra la eliminación directa de una fila específica de una tabla interna estándar
*    "mediante acceso posicional utilizando INDEX, suprimiendo el registro ubicado en la segunda posición física de la tabla en memoria.
*
*    DELETE gt_flights_struc INDEX 2.
*
*    "BLOQUE 3
*    "Este bloque demuestra la eliminación de un rango consecutivo de registros dentro de una tabla interna
*    " estándar utilizando acceso posicional, suprimiendo las filas comprendidas entre los índices 5 y 8 inclusive en memoria.
*
*    DELETE gt_flights_struc FROM 5 TO 8.
*
*    "BLOQUE 4
*    "Este bloque demuestra la eliminación condicional de registros en una tabla interna mediante la
*    " cláusula WHERE,
*    "suprimiendo en memoria todas aquellas filas cuyo campo CITY se encuentre en estado inicial (vacío o no informado).
*
*    DELETE gt_flights_struc WHERE city IS INITIAL.
*
*    "Este bloque demuestra la eliminación de registros duplicados consecutivos en una tabla interna
*    "utilizando DELETE ADJACENT DUPLICATES, comparando específicamente el campo COUNTRY, por lo que solo se conservará
*    " la primera ocurrencia de cada valor repetido contiguo en memoria.
*
*    DELETE ADJACENT DUPLICATES FROM gt_flights_struc COMPARING country.
*
*ENDIF.
*
*  "Este bloque demuestra la visualización del estado final de la tabla interna tras la ejecución de
*  "operaciones de eliminación (DELETE), permitiendo comparar el contenido posterior en memoria con el
*  "estado inicial previamente mostrado en consola.
*
*    out->write( |\n| ).
*    out->write( data = gt_flights_struc name = 'AFTER gt_flights_struc' ).

"2.7. CLEAR / FREE / VALUE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" GESTIONAR memoria de las tablas internas
*
*    " clear inicializar o borrar el contenido de una ti o variable
*    " pero no libera la memoria
*    " planeamos reutilizar la ti en un futuro
*
*    " free vacíar y liberar completamente la memoria de la TI
*    " ti estará vacía después del free y la memoria será devuelta al sistema
*
*    "VALUE #() eliminar los registros de tabla intera
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*    DATA: gt_flights_struc TYPE STANDARD TABLE OF /dmo/airport,
*          gs_flights_struc TYPE /dmo/airport.
*
*    SELECT FROM /dmo/airport
*      FIELDS *
*      WHERE country EQ 'US'
*      INTO TABLE @gt_flights_struc.
*
*    IF sy-subrc EQ 0.
*
**    "BLOQUE 1
**    "Este bloque demuestra el uso de la sentencia CLEAR aplicada a una tabla interna estándar, eliminando todos los registros cargados en memoria (reinicializando su contenido lógico), permitiendo posteriormente visualizar que la tabla ha quedado vacía
" e
**"n la salida por consola.
**
**    CLEAR gt_flights_struc.
*
*    "BLOQUE 2
*    "Este bloque demuestra el uso de la sentencia FREE aplicada a una tabla interna estándar, liberando completamente la memoria reservada para la misma (no solo vaciando su contenido lógico como CLEAR), permitiendo observar posteriormente que la tabla
*    "queda inicializada y sin consumo de memoria en el heap.
*
*    FREE gt_flights_struc.
*
*    "BLOQUE 3
*    "Este bloque demuestra la reinicialización de una tabla interna estándar utilizando una expresión VALUE vacía, lo que provoca la creación de una nueva instancia inicial de la tabla en memoria, dejando su contenido completamente vacío de forma equiva
"lente a CLEAR, pero utilizando sintaxis moderna ABAP 7.4+.
*
*    gt_flights_struc = VALUE #( ).
*
*
*      out->write( data = gt_flights_struc name = 'BEFORE gt_flights_struc' ).
*
*    ENDIF.
*
*
*        out->write( |\n| ).
*        out->write( data = gt_flights_struc name = 'AFTER gt_flights_struc' ).

 "2.8  Instrucción COLLECT
 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
* "COLLECT
* " iNSERTA el contenido de una estructura (ej 1 fila) en una TI O AÑADIENDO
* " los valores de sus componentes numéricos a los valores correspondientes
* " de las filas existentes con la mismas claves primarias
* " así evitamos registro duplicados
* " OBSOLETO PARA TABLAS ESTANDAR
* " uso para tablas hash y sort (con clave primaria única)
*
* "requisito previo: estructura SEA compatible con el tipo de fila de la TI
*
*
* "Este bloque demuestra la definición de una estructura auxiliar para agregación de datos (COLLECT), junto con la declaración de una tabla interna de tipo HASHED con clave única compuesta (carrid, connid), optimizada para búsquedas por clave y consolida
"c
*"ión automática de valores numéricos mediante la sentencia COLLECT.
*
*DATA: BEGIN OF ls_seats,
*        carrid TYPE /dmo/flight-carrier_id,
*        connid TYPE /dmo/flight-connection_id,
*        seats  TYPE /dmo/flight-seats_max,
*        price  TYPE /dmo/flight-price,
*      END OF ls_seats.
*
*DATA gt_seats LIKE HASHED TABLE OF ls_seats WITH UNIQUE KEY carrid connid.
*"con el LIKE hacemos referencia a una variable existente en el conteto de nuestro programa
*
* "Este bloque demuestra la lectura de registros desde la tabla de base de datos /dmo/flight
* " seleccionando campos específicos (carrier_id, connection_id, seats_max y price)
* "y cargándolos directamente en una estructura de trabajo,
* " preparando los datos para su posterior procesamiento o agregación en memoria.
*
*    SELECT carrier_id, connection_id, seats_max, price
*      FROM /dmo/flight
*      INTO @ls_seats.
*
*      "Este bloque demuestra el uso de la sentencia COLLECT para insertar registros en
*      "una tabla interna HASHED con clave única, permitiendo que,
*      "si ya existe una entrada con la misma clave (carrid, connid),
*      "los campos numéricos se acumulen automáticamente en lugar de generar un nuevo registro.
*      " si no existe una entrada con la misma clave primeria se inserta con el contenido de la estructura
*      " (sort = en el mismo orden que la tabla y en
*      " hash = el algoritmo inserta la nueva fila de acuerdo a sus valores clave)
*
*        COLLECT ls_seats INTO gt_seats.
*
*  ENDSELECT.

 "2.9  Instrucción LET
 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
* "LET
* " DEF  esta expresión nos ayuda a def var o simbolos de campos
* "como campos auxiliares locales en una expresión y a estos les asigna los valores
* " para evitar declaraciones no deseadas de variables auxiliares
* " en la variables se puede guardar: texto , valor númérico , otros
* " Ahorra código
*
*
* """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
* "Este bloque demuestra la selección de registros desde la tabla /dmo/flight filtrando por moneda 'USD'
* "y su carga en una tabla interna inline, junto con una segunda selección limitada de registros
* "desde /dmo/booking_m, preparando los datos para su posterior procesamiento mediante
* "LOOP sobre la tabla de vuelos en memoria. LOOP volcará la información en la estructura ls_flight_let
* " La variable donde se guarda la información lv_flights se declara en línea (ahí guardaremos el resultado
* " de la operación LET
* " Detrás de LET se inclyen las variables auxiliares [ incluir filtro ] en las que guardamos un valor no una estructura
* " Las variables auxiliares las concatenamos y la guardamos en la variable lv_flights.
*
*
*SELECT FROM /dmo/flight
*  FIELDS *
*  WHERE currency_code EQ 'USD'
*  INTO TABLE @DATA(lt_flights).
*
*SELECT FROM /dmo/booking_m
*  FIELDS *
*  INTO TABLE @DATA(lt_airline)
*  UP TO 50 ROWS. "Limitado a 50 registros
*
*LOOP AT lt_flights INTO DATA(ls_flight_let).
*
*    "BLOQUE 1 LET
*
*    "Este bloque demuestra el uso avanzado de la expresión LET dentro de una conversión a string
*    "mediante CONV, permitiendo definir variables auxiliares inline a partir de lecturas por clave
*    "en tablas internas, para posteriormente construir dinámicamente un texto formateado
*    "utilizando plantillas de cadena (string templates) con los valores recuperados.
*
*    DATA(lv_flights) = CONV string(
*      LET lv_airline      = lt_airline[ carrier_id = ls_flight_let-carrier_id ]-travel_id
*          lv_flight_price = lt_flights[ carrier_id = ls_flight_let-carrier_id
*                                         connection_id = ls_flight_let-connection_id ]-price
*          lv_carrid       = lt_airline[ carrier_id = ls_flight_let-carrier_id ]-carrier_id
*      IN | { lv_carrid } / Airline name: { lv_airline } / Flight price: { lv_flight_price } |
*    ).
*
*    out->write( data = lv_flights ).
*
*
*ENDLOOP.

" 2.10. Instrucción BASE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" se puede usar dentro de otro operador para tomar en cuenta
*" los registros de otra tabla interna o de la misma ti en tiempo de ejecución
*" El tipo de TI debe ser convertible al tipo de fila del valor de retorno
*" Indicarlo implicito o explicito el tipo de TI si con # no se puede determinar el tipo del valor de retorno???
*" Uso con estructuras o TI Y en expresiones como corresponding, NEW o value
*
*" VALUE
*
*" LINES OF agregar lines para tener en cuenta más TI
*
*" CORRESPONDING
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*" Ej VALUE agregamos los registros a una TI
*" BASE (NOMBRE tabla interna de donde tomamos los registros y luego (AGREGAMOS los nuevos registros dentro del paréntesis)),.
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*SELECT FROM /dmo/flight
*  FIELDS *
*  WHERE currency_code EQ 'USD'
*  INTO TABLE @DATA(lt_flights).
*
*SELECT FROM /dmo/booking_m
*  FIELDS *
*  INTO TABLE @DATA(lt_airline)
*  UP TO 50 ROWS. "Limitado a 50 registros
*
*"Este bloque demuestra la visualización del estado inicial de una tabla interna mediante salida por consola y la posterior declaración explícita de una nueva tabla interna tipada con la estructura de base de datos /dmo/flight, preparando el entorno para
*"trabajar con la instrucción BASE en construcciones modernas de tablas.
*
*out->write( data = lt_flights name = 'INITIAL lt_flights' ).
*
*DATA lt_seats TYPE TABLE OF /dmo/flight.
*
*"BLOQUE 1
*"Este bloque demuestra el uso de la expresión VALUE con la cláusula BASE para crear una nueva tabla interna partiendo del contenido existente de lt_flights y añadiendo un nuevo registro construido inline, utilizando sintaxis moderna ABAP 7.4+ para exten
"d
*"er tablas de forma declarativa en memoria.
*
*lt_seats = VALUE #( BASE lt_flights
*                    ( carrier_id    = 'CO'
*                      connection_id = '000123'
*                      flight_date   = cl_abap_context_info=>get_system_date( )
*                      price         = '2000'
*                      currency_code = 'COP'
*                      plane_type_id = 'B213-58'
*                      seats_max     = 120
*                      seats_occupied = 100 ) ).
*
*out->write( data = lt_seats name = 'lt_seats_BASE' ).
*
*"BLOQUE 2
*"LINES OF
*"Este bloque demuestra el uso avanzado de la expresión VALUE combinada con BASE y LINES OF para reconstruir una tabla interna tomando como base su contenido actual, incorporando además todas las líneas de otra tabla (lt_flight) y añadiendo finalmente un
*"nuevo registro construido inline mediante sintaxis moderna ABAP.
*
*lt_seats = VALUE #( BASE lt_seats ( LINES OF lt_flights )
*                    ( carrier_id     = 'CO'
*                      connection_id  = '000123'
*                      flight_date    = cl_abap_context_info=>get_system_date( )
*                      price          = '2000'
*                      currency_code  = 'COP'
*                      plane_type_id  = 'B213-58'
*                      seats_max      = 120
*                      seats_occupied = 100 ) ).
*
*out->write( data = lt_seats name = 'lt_seats_BASE_LINES_OF' ).
*
*"BLOQUE 3
*"CORRESPONDING
*"Este bloque demuestra el uso de la expresión CORRESPONDING combinada con la cláusula BASE para reconstruir la tabla interna lt_seats a partir de su contenido previo, incorporando además los registros de lt_flights mediante asignación automática de camp
"o
*"s con el mismo nombre y tipo, utilizando sintaxis moderna declarativa de ABAP 7.4+.
*
*lt_seats = CORRESPONDING #( BASE ( lt_seats ) lt_flights ).
*
*out->write( data = lt_seats name = 'lt_seats' ).

" 2.11. AGRUPACION DE REGISTROS - GROUP BY
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"GROUP BY
*" AGRUPA las filas de una TI y ejecuta en bucle estos grupos
*" variante de LOOP AT
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" ej ETAPA 1 primer LOOP AT
*" Para cada fila leida con LOOP AT se construye una clave de grupo
*" la que se haya especificado después de la sentencia group by
*" cada clave de grupo representa un grupo y cada fila se asigna a ese grupo
*" si coincide el contenido y se identifica como un miembro de grupo
*" sÓLO muestra el primer registro que encuentre para cada grupo
*" no se muestra todos los miembros de cada agrupación
*" sirve por ej para saber cuántos tipos de carrier_id tenemos en el contenido de TI
*
*" EJ ETAPA 2 segundo LOOP AT
*" FIN ver en la TI todos los miembros de cada grupo (carrier_id)
*" Declarar una variable gt_members que va a alojar los miembros del grupo
*" LIKE para que tenga el mismo tipo que gt_dmo_fligth
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"GROUP BY
*"Este bloque demuestra la carga completa de la tabla /dmo/flight en una tabla interna y su posterior recorrido mediante LOOP ASSIGNING con FIELD-SYMBOL, permitiendo el acceso directo a cada registro en memoria para su procesamiento eficiente sin copias d
*"e estructura.
*
*SELECT FROM /dmo/flight
*  FIELDS *
*  INTO TABLE @DATA(gt_dmo_flight).
*
*"Este bloque demuestra el uso completo de LOOP AT ... GROUP BY en ABAP moderno,
*"donde los registros se agrupan dinámicamente por carrier_id, se
*"reinicializa una tabla auxiliar para cada grupo y se reconstruye mediante VALUE con BASE
*"iterando sobre los miembros del grupo con LOOP AT GROUP, mostrando finalmente cada agrupación en consola.
*
*DATA gt_members LIKE gt_dmo_flight.
*
*
*"Grouping by column
*LOOP AT gt_dmo_flight ASSIGNING FIELD-SYMBOL(<lfs_dmo_flight>)
*
*
*
*" ETAPA 1
*"Este bloque demuestra el uso de LOOP AT ... GROUP BY en programación moderna ABAP,
*"agrupando dinámicamente los registros de la tabla interna por el campo carrier_id y
*" permitiendo procesar cada grupo lógico en memoria antes de mostrar el contenido
*" mediante salida por consola.
*" ETAPA 1.1 AGRUPAR POR UNA COLUMNA = AEROLINEA
*
*    "Grouping by 1 column of groups
**    GROUP BY <lfs_dmo_flight>-carrier_id. " AGRUPAR POR UNA COLUMNA
**
**    out->write( data = <lfs_dmo_flight> name = '<lfs_dmo_flight>' ).
*
* "ETAPA 1.2 AGRUPAR POR EL CODIGO DE AEROLINEA Y TIPO DE AVION (comentar etapa 1.1.?
*"Este bloque demuestra el uso avanzado de GROUP BY con agrupación estructurada en ABAP moderno, permitiendo definir una clave compuesta mediante alias (airline y plane) para agrupar dinámicamente los registros por carrier_id y plane_type_id dentro de un
*"LOOP AT ... GROUP BY.
****
*   "Grouping by more than one column of groups
*    GROUP BY ( airline = <lfs_dmo_flight>-carrier_id
*               plane   = <lfs_dmo_flight>-plane_type_id ).
*
* " ETAPA 2 - DECLARAR VARIABLE GT_MEMBERS
* "Este bloque demuestra el procesamiento de los miembros de cada grupo generado mediante LOOP AT GROUP,
* "insertando cada registro agrupado en una tabla interna auxiliar utilizando la expresión VALUE con BASE
* " para extender progresivamente la colección, y mostrando posteriormente el resultado consolidado en consola.
*
*     CLEAR gt_members.
*
*    LOOP AT GROUP <lfs_dmo_flight> INTO DATA(gs_member).
*
*      gt_members = VALUE #( BASE gt_members ( gs_member ) ).
*
*    ENDLOOP.
*
*    out->write( data = gt_members name = 'gt_members' ).
*
*ENDLOOP.


" 2.12. Agrupar por clave
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" ver cómo realizar las agrupaciones por clave
*" se puede declarar en linea en una sentencia de group by una clave en grupo sin
*" usar el apuntador
*" usar una clave de grupo explícita (gs_key) en lugar de apuntador
*" witouth members - no se puede usar LOOP. Vemos info adicional ¿cuántos miembros y posición de cada grupo
*" es otra forma de visualizarlo
*
*SELECT FROM /dmo/flight
*  FIELDS *
*  INTO TABLE @DATA(gt_dmo_flight).
*
*DATA gt_members LIKE gt_dmo_flight.
*
*"BLOQUE 1
**
**"Grouping by column
**LOOP AT gt_dmo_flight ASSIGNING FIELD-SYMBOL(<lfs_dmo_flight>)
**
**    "Grouping by more than one column of groups
**    ""Este bloque demuestra la agrupación estructurada por múltiples columnas
**    "utilizando una clave de grupo explícita (gs_key) mediante INTO DATA,
**    "sustituyendo el uso directo del apuntador del LOOP por una estructura de clave que representa el grupo actual.
**
**    GROUP BY ( airline = <lfs_dmo_flight>-carrier_id
**               plane   = <lfs_dmo_flight>-plane_type_id ) INTO DATA(gs_key). "declaramos clave de grupo
**
**     CLEAR gt_members.
**
***    LOOP AT GROUP <lfs_dmo_flight> INTO DATA(gs_member). " sustituir el apuntador por clave de grupo
**     LOOP AT GROUP gs_key INTO DATA(gs_member). " sustituir el apuntador por clave de grupo
**
**      gt_members = VALUE #( BASE gt_members ( gs_member ) ).
**
**    ENDLOOP.
**
**    out->write( data = gt_members name = 'gt_members' ).
**
**    "Este bloque demuestra la visualización de la clave de grupo (gs_key) generada en la sentencia GROUP BY, permitiendo inspeccionar en consola los valores que identifican cada agrupación lógica creada durante la iteración.
**
**    out->write( data = gs_key name = 'gs_key' ).
**
**ENDLOOP.
*
*"BLOQUE 2 without members
*
*"Grouping by column
*LOOP AT gt_dmo_flight ASSIGNING FIELD-SYMBOL(<lfs_dmo_flight>)
*
*    "Grouping by more than one column of groups
*    "Este bloque demuestra el uso avanzado de GROUP BY con múltiples columnas,
*    "incluyendo la definición explícita de alias de grupo (airline, plane),
*    "así como el uso de GROUP INDEX y GROUP SIZE para obtener metadatos del grupo.
*    "La cláusula WITHOUT MEMBERS evita cargar las filas individuales,
*    "trabajando únicamente con la clave y atributos del grupo.
*
*    GROUP BY ( airline = <lfs_dmo_flight>-carrier_id
*               plane   = <lfs_dmo_flight>-plane_type_id
*               index   = GROUP INDEX
*               size    = GROUP SIZE ) WITHOUT MEMBERS INTO DATA(gs_key). "no mostramos miembros , si info sobre agrupaciones
*
*
*    out->write( data = gs_key name = 'gs_key' ).
*
*ENDLOOP.

" 2.13. FOR GROUPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" evalúa una tabla interna igual que loop con la adición group by
*"
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" ej 1 tabla vacía
*" No muestra miembros. Sólo los campos por los que se han hecho agrupaciones
*
*"Este bloque demuestra el uso de la expresión FOR GROUPS para construir
*"una tabla interna derivada que contiene únicamente las claves de agrupación
*"(carrier_id) a partir de una tabla fuente, aplicando orden descendente
*"y utilizando WITHOUT MEMBERS para trabajar solo con las claves de grupo
*"sin materializar los registros individuales.
*
*SELECT FROM /dmo/flight
*  FIELDS *
*  INTO TABLE @DATA(gt_dmo_flight).
*
*TYPES lty_group_keys TYPE STANDARD TABLE OF /dmo/flight-carrier_id WITH EMPTY KEY.
*
*out->write( VALUE lty_group_keys( FOR GROUPS gv_group OF gs_group IN gt_dmo_flight
*                                   GROUP BY gs_group-carrier_id
*                                   DESCENDING
*                                   WITHOUT MEMBERS ( gv_group ) ) ).

"2.14. Tablas de rangos o RANGE TABLE - TYPE RANGE OF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" TI q contiene las columnas de sign option low y hight
*" se usan como deposito interno de una condición de rangos
*" es posible evaluarlas en una expresión de comparación con IN o en consultas where
*" 4 COLUMNAS
*        " 1. SIGN - manejamos valores de tipo C LONG 1
*                " I INCLUYO E EXCLUSO
*        " 2. OPTION - tipo C long 2
*                " Condición de selección EQ GE ....
*        " 3. LOW " 4. HIGH
*                " Establecer valores minimos y maximos (between BT or not between NB
*
*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"RANGE OF
*
*" EJ
*" lty TIPO de tabla con el añadido de TYPE range of para definir el rango local -> tabla de rangos
*" declaramos en linea de una tabla lt con VALUE hay que pasar el tipo de forma explicita VLUE lty_
*" ( configuramos TI de tipo de rango )
*" realizar tabla de rangos para realizar una lectura de BBDD
*" SELECT * todos los coampos
*" WHERE queremos filtrar un rango de precios IN especificar la tabla de rango
*" INTO tabla en la que vuelca la info
*" SIRT organizar precios de forma ascendente
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*"Este bloque demuestra el uso de un tipo RANGE para filtrar registros por intervalo de precios,
*"construyendo dinámicamente una tabla de rangos mediante VALUE,
*"aplicándola en un SELECT con condición IN,
*"ordenando posteriormente el resultado y mostrando tanto el rango aplicado como los datos filtrados.
*
*TYPES lty_price TYPE RANGE OF /dmo/flight-price.
*
*DATA(lt_price_range) = VALUE lty_price( ( sign   = 'I'
*                                          option = 'BT'
*                                          low    = '600'
*                                          high   = '1000' ) ).
*
*SELECT *
*  FROM /dmo/flight
*  WHERE price IN @lt_price_range
*  INTO TABLE @DATA(ltr_price).
*
*SORT ltr_price BY price.
*
*out->write( data = lt_price_range name = 'lt_price_range' ).
*out->write( data = ltr_price name = 'ltr_price' ).

" 2.15. Enumeraciones " BEGIN OF ENUM - END OF ENUM
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEGIN OF ENUM - END OF ENUM
" definimos las enumeraciones con un tipo de valor y constantes ABAP
" MEZCLAS de tipos y constantes (constantes de enumeración y type funciona como la instrucción constance)
" SOLO los valores enumerados permitidos se pueden asignar a los objetos enumerados
" DATA lv_ Crear una variable enumerada

" ESTRUCTURA Cuando usas STRUCTURE ls_type, los literales del ENUM ya no están en el espacio global,
" sino que quedan encapsulados dentro de la estructura generada.

"CASE ENDCASE
" definimos el mensaje a mostrar en función del valor que toma la variable
" SI no se toma ninguna de las constantes indicadas dentro del case saldría que el valor no existe

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"BLOQUE 1
*"Este bloque demuestra la definición de un tipo ENUM en ABAP moderno,
*"permitiendo crear un conjunto cerrado de valores constantes tipados (colores),
*"asignar un valor inicial mediante VALUE, mostrarlo por consola
*"y posteriormente cambiar su valor manteniendo control de tipos estricto.
*" Un objeto de valor de tipo enumerado SOLO SE PUEDE ASIGNAR AL conjunto de valores definido en GTY_colors
*
*TYPES: BEGIN OF ENUM gty_colors,
*         c_white,
*         c_black,
*         c_purple,
*         c_red,
*         c_blue,
*       END OF ENUM gty_colors.
*
*DATA lv_color TYPE gty_colors VALUE c_purple.
*
*out->write( lv_color ). " Establecer un punto de interrupción para ver el valor que toma lv_color . tipo ENUM
*
*lv_color = c_black.     " Un objeto de valor de tipo enumerado SOLO SE PUEDE ASIGNAR AL conjunto de valores definido en GTY_colors
**lv_color = c_rosa.      " error
*
*out->write( lv_color ).

" BLOQUE 2
"Este bloque demuestra la definición de un ENUM con la adición de STRUCTURE,
"permitiendo que los literales del enumerado se utilicen como componentes
"de una estructura tipada (ls_type). Posteriormente se declara una variable
"del tipo enumerado, se muestra su valor inicial y se reasigna
"uno de los valores definidos dentro del conjunto cerrado del ENUM.

TYPES: BEGIN OF ENUM gty_colors STRUCTURE ls_type,
         c_white,
         c_black,
         c_purple,
         c_red,
         c_blue,
       END OF ENUM gty_colors STRUCTURE ls_type.

DATA lv_color TYPE gty_colors. " punto de control para ver como varía el valor de lv_color

out->write( lv_color ).

*lv_color = c_white.  " ERRor VER ESTRUCTURA Cuando usas STRUCTURE ls_type, los literales del ENUM ya no están en el espacio global, sino que quedan encapsulados dentro de la estructura generada.
lv_color = ls_type-c_purple.

out->write( lv_color ).


"BLOQUE 4
"Este bloque demuestra el uso de la sentencia CASE sobre un tipo ENUM definido con STRUCTURE,
"evaluando cada literal del enumerado mediante su calificación con la estructura (ls_type-),
"permitiendo ejecutar lógica específica según el valor tipado del ENUM y garantizando
"control estricto de valores dentro del conjunto cerrado definido.

CASE lv_color.
  WHEN ls_type-c_white.
    out->write( 'The color is WHITE' ).
  WHEN ls_type-c_black.
    out->write( 'The color is BLACK' ).
  WHEN ls_type-c_purple.
    out->write( 'The color is PURPLE' ).
  WHEN ls_type-c_red.
    out->write( 'The color is RED' ).
  WHEN OTHERS.
    out->write( 'The value doesn´t exist' ).
ENDCASE.


  ENDMETHOD.
ENDCLASS.
