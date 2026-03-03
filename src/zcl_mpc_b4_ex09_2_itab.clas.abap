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
 "COLLECT
 " iNSERTA el contenido de una estructura (ej 1 fila) en una TI O AÑADIENDO
 " los valores de sus componentes numéricos a los valores correspondientes
 " de las filas existentes con la mismas claves primarias
 " así evitamos registro duplicados
 " OBSOLETO PARA TABLAS ESTANDAR
 " uso para tablas hash y sort (con clave primaria única)

 "requisito previo: estructura SEA compatible con el tipo de fila de la TI


 "Este bloque demuestra la definición de una estructura auxiliar para agregación de datos (COLLECT), junto con la declaración de una tabla interna de tipo HASHED con clave única compuesta (carrid, connid), optimizada para búsquedas por clave y consolidac
"ión automática de valores numéricos mediante la sentencia COLLECT.

DATA: BEGIN OF ls_seats,
        carrid TYPE /dmo/flight-carrier_id,
        connid TYPE /dmo/flight-connection_id,
        seats  TYPE /dmo/flight-seats_max,
        price  TYPE /dmo/flight-price,
      END OF ls_seats.

DATA gt_seats LIKE HASHED TABLE OF ls_seats WITH UNIQUE KEY carrid connid.
"con el LIKE hacemos referencia a una variable existente en el conteto de nuestro programa

 "Este bloque demuestra la lectura de registros desde la tabla de base de datos /dmo/flight
 " seleccionando campos específicos (carrier_id, connection_id, seats_max y price)
 "y cargándolos directamente en una estructura de trabajo,
 " preparando los datos para su posterior procesamiento o agregación en memoria.

    SELECT carrier_id, connection_id, seats_max, price
      FROM /dmo/flight
      INTO @ls_seats.

      "Este bloque demuestra el uso de la sentencia COLLECT para insertar registros en
      "una tabla interna HASHED con clave única, permitiendo que,
      "si ya existe una entrada con la misma clave (carrid, connid),
      "los campos numéricos se acumulen automáticamente en lugar de generar un nuevo registro.
      " si no existe una entrada con la misma clave primeria se inserta con el contenido de la estructura
      " (sort = en el mismo orden que la tabla y en
      " hash = el algoritmo inserta la nueva fila de acuerdo a sus valores clave)

        COLLECT ls_seats INTO gt_seats.

  ENDSELECT.



  ENDMETHOD.
ENDCLASS.
