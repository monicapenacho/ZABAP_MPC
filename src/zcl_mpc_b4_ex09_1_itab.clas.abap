CLASS zcl_mpc_b4_ex09_1_itab DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

      INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_b4_ex09_1_itab IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

  " TABLAS INTERNAS
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  " 1.1 CONCEPTOS
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " uso para procesamiento y ejecución de datos
  " SOLO EXISTE cuando el PROGRAMA SE ESTA EJECUTANDO
  " se comportan de la misma manera que estructura o area de trabajo
  " la estructura solo cuenta con un registro
  " la tabla puede contar con n lineas o registros
  " tabla interna = flexibles (pueden ser creadas usando otras estructuras definidas)
   " EN ABAP TODAS SUS entradas tienen que tener la misma estructura, ES DECIR
   " cada estructura debe tener el mismo número de campos o columnas
   " se puede acceder a través de una clave o índice
   " memoria dinámica (se crean en la memoria ram asignada a este propoósito y
   " desaparecen una vez ejecutado el bloque por el que se había creado
   " propiedades de los elementos excepto el uso o consumo de memoria puede estar determinado por el tip ode datos que asignemos



  " BBDD guarda la información en disco duro

  " ejemplo acceder a /dmo/flight ctrl may A y luego para acceder a los datos con fn f8

   " lo que más se tarda en una app son los accesos a las bbdd. para solucionarlo sap ha creado las TI que hacen las funciones
   " de arrays bidimensionales de otros lenguajes

   " el uso  más frecuente de una TI es almacenar en memoria los datos de una bbdd en tiempo de ejecución de una clase o código abap
   " cada valor ocupa una fila de una ti (fila = registro). No lim de filas La única limitación es la memoria disponible o config del sistema
   " también se usa además de guardar los datos, hacer cálculos etc. Se acceso el acceso 1 vez a bbdd y se guardan los registros en ti, para consultas
   " modificaciones etc -> ofrece rapidez y así disminuimos los accesos a bbdd y la baja rendimiento de app

   " 1.2 TIPO DE TABLAS INTERNAS
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   " PROPIEDADES BASICAS DE TI
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

   " 1.- tipo de linea O LINE TYPES
   "     definimos las columnas que tendrá la tabla
   "     se puede usar un tipo de datos elemental, complejo o tipo de referencia
   "     se indica en el momento de la declaración de la TI

   " 2.- CATEGORIA DE TABLA O TABLE CATEGORY
   "     como se administra y almacenan las tablas internas
   "     y como accedemos a los registros
   "     importante para mejorar el rendimiento

   "     EXISTEN DOS TIPOS DE ACCESO A LA TABLAS INTERNAS

   "     A) INDICE de la tabla
   "     se accede a los registros  = LÍNEAS usando un índice numérico,
   "     ejemplo Registro #4
   "     acceso más rápido si la TI no es muy grande

   "     B) CLAVE de la tabla
   "     se accede los registros mediante los valores específicos en una alguna columna en concreto


   " 3.- TAMANO DE TABLA O TABLE SIZE
   "     el tamaño de la tabla interna es el número de registros que contiene
   "     se puede calcularlo usando la función DB_TABLE_SIZE_GET

   "     TIPO DE TABLA INTERNA
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*   " 1.- STANDARD TABLE
*         Se crea por defecto si no se indica el tipo
*         Lineas organizadas según un índice ( que es interno )
*         Busqueda con indica ( principalmente) o con clave ( NO UNICA )
*         Acceso lineal ( va registro por registro )
*         Ocupa menos memoria y se puede añadir muchos registros
*         Poco eficiente si buscamos registros con frecuencia
*         Tiempo de búsqueda se incrementa con el nº de registro
*         ¿util? por ejemplo en tablas pequeñas y que el orden no importa
*         p ej si no necesitamos tener organizada los registros por una clave
*
*   " 2.- SORTED TABLE o TABLAS ORDENADAS
*         Lineas tienen asignada un índice interno
*         Lineas ordenadas de acuerdo con la clave de la tabla ( UNICA O NO UNICA)
*         Acceso a través de la clave principalmente
*         El algoritmo de búsqueda es binario
*         Tiempo de búsqueda se incrementa con el nº de registros de forma logarítmica
*         Tablas ordenadas mejoran la eficiencia global dentro de nuestro código
*
*   "  3.- HASHED TABLE
*          No se puede acceder a través del índice
*          El orden de los registros que se añaden a dicha tabla se realiza
*          a través de un algoritmo numérico llamado hash function el cual
*          calcula la posición de un registro partiendo de determinada CLAVE que es UNICA
*          Tiempo de acceso constante independientemente del nº de entradas del sistema
*          Es menor que el de las otras TI . Depende del algoritmo y rapidez del sistema
*          Es el más adecuado si es búsqueda recurrente ( acceso linea por clave )
*          o si se desa procesar grandes cantidades de datos.
*          No vale la pena para TI pequeñas

   " 1.3 DECLARACION DE TABLAS INTERNAS
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*   " Son estructuras bidimensionales que se declaran con DATA
*   " TIPOS DEPENDIENDO DE LA VISIBLIDAD
*   "    gt_nombre - global
*   "    lt_nombre - local
*   " despues de TABLE OF le damos el objeto de referencia por ej bbdd /dmo/flight.
*   " nuestra ti tomará de la bbdd como referencia los campos y las columnas
*   " ctrl_click para acceder a bbdd y visualizar Registros, campos y columnas
*   " DATA asignamos espacio en la memoria
*   " SORTED requiere especificar explicitamente la CLAVE ( ejemplo WITH UNIQUE OR NON-UNIQUE KEY) y el campo que queremos que sea la clave
*       "UNIQUE: No es posible tener más de un registro con la misma clave del campo 'carrier id'
*       "NON-UNIQUE: Es posible tener más de un registro con la misma clave de un solo campo
*    " HASHED TABLE - requiere especificar explicitamente la CLAVE UNICA - WITH UNIQUE KEY + nombre de la clave
*
*    "Standard table
*    DATA: lt_flight_stand  TYPE STANDARD TABLE OF /dmo/flight,
*          lt_flight_stand2 TYPE TABLE OF /dmo/flight.
*
*    "Sorted table
*    DATA lt_flight_sort TYPE SORTED TABLE OF /dmo/flight WITH NON-UNIQUE KEY carrier_id .
*
*    "Hashed table
*    DATA lt_flight_hash TYPE HASHED TABLE OF /dmo/flight WITH UNIQUE KEY carrier_id.
*
*    " declaración para su uso posterior

   " 1.4 CLAVES
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    " DEF = Proporcionan acceso optimizado aL contenido de las TI
*    " TIPOS
*        UNICA O NO UNICA      - ¿PUEDE haber más de un registro con la misma clave o no?
*        PRIMARIA O SECUNDARIA
*
*    " CLAVE PRIMARIA PRIMARY KEY:
*        " depende del tipo de la tabla interna
*        " TI standar se puede definir vacía -> acceso con claves secundarias
*        " Todas las TI tienen una clave primaria
*        " No es necesaria indicarla en la declaracion dentro de la TI stardandar ya que esta clave se toma automaticamente como una clave estandar no unica
*        " para las demás TI tenemos que colocar explicitamente en la declaración la definicón de la clave uínica (hashed o sorted o no única (esta última sólo en sorted)
*
*        " CLAVE ESTANDAR
*        " CLAVE primaria especial que puede declararse de forma explicita o implicita
*        " TI con linea estructurada la clave estandar principal corresponde a todos los campos con los tipos de datos similares a caracteres o bytes
*        " TI no estructurado y elemental - la tabla completa es la clave
*        " si no especificamos la clave de forma explicita se pondrá de forma implicita la clave estandar como clave principal
*
*        " CLAVE HASHED
*
*        " EMPTY KEY O CLAVE VACIA
*        " este tipo de clave solo se puede tener en las tablas de tipo estándar
*        " con vacía es que no contiene ningúna clave.
*        " WITH EMPTY KEY
*        "Standard table
*            DATA lt_flight_stand  TYPE STANDARD TABLE OF /dmo/flight WITH EMPTY KEY.
*
*    " CLAVE SECUNDARIA
*        " depende del tipo de clave

   " 1.5 AÑADIR REGISTROS - VALUE
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*   " Operador VALUE
*   " menor consumo de memoria - ahorrar tener que crear antes la estructura
*
*   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*   " tenemos declarada una tabla interna lt y luego una estructura ls  y un tipo declarado lty que tomará como referencia el tipo de la ti lt
*
*   " Ej NOMBRE DE LA TI DECLARADA = VALUE #( ). SE PUEDEN AGREGAR OPERACIONES COMO POR EJE FOR=
*   " CADA () RESPRESENTA UN REGISTRO DE LA TI
*   " CON CTRL ESPECIO LOS VAMOS AÑADIENDO
*   " se puede colocar en cualquier orden
*   " no es necesario incluir todos.
*   " imprimir
*
*   " hacemos autoreferencia # porque el tipo de tabla interna ya se encuentra de forma explicita en la declaración
*   " recordar que los registros sólo disponibles en tipo de ejecución (no en bbdd permanentes)
*
*
*    DATA: lt_employees TYPE STANDARD TABLE OF zemploy_table,
*          ls_employee  TYPE zemploy_table.
*
*    TYPES lty_employee LIKE lt_employees.
*
*    " EJ 1 VALUE CON AUTOREFERENCIA
*
*    lt_employees = VALUE #( ( id            = 0000
*                              first_name    = 'Mario'
*                              last_name     = 'Martinez'
*                              email         = 'mariom@logali.com'
*                              phone_number  = '1234567'
*                              salary        = '2000.3'
*                              currency_code = 'EUR' ) ).
*
*   out->write( lt_employees ).
*
*   " ej 2 VALUE de forma EXPLICITA
*   " si quiero hacer una declaración en linea de LA ti ¿DE dónde toma el tipo de dato=
*   "Si hacemos una declaración en linea y usamos la autoreferencia # sin haber determinado el tipo previamente sale un error
*   " en ninguna parte del código estamos diciendo al compilador el tipo de dato que vamos a recibir
*
*      DATA(lt_employees2) = VALUE #( ). " error
*
*   "entonces antes de los paréntesis tenemos que colocar el tipo de los datos = estructura de la ti
*   " por ejemplo quiero que sea el tipo lty_ ya existente (un tipo local declarado previamente)
*
*       DATA(lt_employees2) = VALUE lty_employee(
*      ( id            = 0000
*        first_name    = 'Mario'
*        last_name     = 'Martinez'
*        email         = 'mariom@logali.com'
*        phone_number  = '1234567'
*        salary        = '2000.3'
*        currency_code = 'EUR' )
*
*      ( id            = 0001
*        first_name    = 'Laura'
*        last_name     = 'Garcia'
*        email         = 'lgarcia@logali.com'
*        phone_number  = '2364568'
*        salary        = '2000.3'
*        currency_code = 'EUR' )
*    ).
*
*    out->write( lt_employees ).
*    out->write( lt_employees2 ).

  " 1.6 INSERTAR REGISTROS - INSERT ls_n INTO TABLE lt_t
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*   " Podemos especificar el indice o posición donde queremos insertar
*   " APPEND añadimos un registro (sólo para standard)
*   " INSERT (única opción para SORT O HASH TI)
*       " paso 1 NOMBRE_ESTRUCTURA - NOMBRE_COMPONENTE = ASIGNAMOS VALOR
*       " paso 2 INSERTAR EL VALOR EN LA TABLA INSERT ls_n INTO TABLE lt_t
*   " INSERT VALUE
*       " no hace falta colocar la estructura por lo que nos ahoramos el espacio
*       " COPIAR DE MANERA COLECTIVA ALT -SHIFTH A PARA ACTIVAR Y DESACTIVAR
*   " INSERT INITIAL LINE INTO
*        " insertar una linea en blanco sin info a nuestra TI
*   "INSERT VALUE #() INTO lt_n INDEX nº
*        " Insertar un registro en un índice muy específico
*        " si no indicamos el ínidce se inserta en la última posición de la TI
*        " si especificamos una posición x que ya tiene info entonces
*        " los registros de esa posición y ss se desplazan hacia abajo
*
*    " recordar operación exitosa devuelve valor de cero y no exitosa devuelve valor de 4
*
"   " INSERT LINES OF lt_tabla1 INTO TABLE lt_tabla_destino.
*        " rellenar una tabla a partir del contenido de otra tabla
*        " ej declarar otra tabla interna ls_employees2 y la referenciamos con LIKE
*        " `para darle un tipo de otra variable ya existente
*
"   " INSERT LINES OF lt_tabla1 to n INTO TABLE lt_tabla_destino.
***      " toma los registros hasta el indice indicado detras de to
*
*****"" FROM TO
*         " TOMA desde el índicce x hasta el indice y
*
*   *****INSERT
*
*DATA: lt_employees TYPE STANDARD TABLE OF zemploy_table,
*      ls_employee  TYPE zemploy_table.
*
*ls_employee-id            = 0001.
*ls_employee-first_name    = 'Laura'.
*ls_employee-last_name     = 'Martinez'.
*ls_employee-email         = 'lauram@logali.com'.
*ls_employee-phone_number  = '38512369'.
*ls_employee-salary        = '2000.3'.
*ls_employee-currency_code = 'EUR'.
*
*INSERT ls_employee INTO TABLE lt_employees.
*
*out->write( lt_employees ).
*
*
*"INSERT VALUE
*
*INSERT VALUE #( id            = 0002
*                first_name    = 'Laura2'
*                last_name     = 'Martinez2'
*                email         = 'lauram2@logali.com'
*                phone_number  = '385123692'
*                salary        = '2000.3'
*                currency_code = 'EUR' )
*       INTO TABLE lt_employees.
*
*INSERT INITIAL LINE INTO TABLE lt_employees.
*
*out->write( lt_employees ).
*
*INSERT VALUE #( id            = 0003
*                first_name    = 'Daniela'
*                last_name     = 'Linares'
*                email         = 'daniela1@logali.com'
*                phone_number  = '456789'
*                salary        = '3000'
*                currency_code = 'EUR' )
*       INTO lt_employees INDEX 2.
*
*out->write( lt_employees ).
*
*DATA lt_employees2 LIKE lt_employees.
*
*INSERT LINES OF lt_employees INTO TABLE lt_employees2.
*
*out->write( data = lt_employees  name = 'Employee Table' ).
*out->write( |\n| ).
*out->write( data = lt_employees2 name = 'Employee Table 2' ).
*
*DATA lt_employees2 LIKE lt_employees.
*
*INSERT LINES OF lt_employees TO 1 INTO TABLE lt_employees2.
*
*out->write( data = lt_employees  name = 'Employee Table' ).
*out->write( |\n| ).
*out->write( data = lt_employees2 name = 'Employee Table 2' ).
*
*INSERT LINES OF lt_employees FROM 2 TO 3 INTO TABLE lt_employees2.
*
*out->write( data = lt_employees  name = 'Employee Table' ).
*out->write( |\n| ).
*out->write( data = lt_employees2 name = 'Employee Table 2' ).

" 1.7. Añadir registros con APPEND
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" añade registro en la parte inferior de la tabla interna
*" NO APTO PARA TIPO HASH Y TIPO SOUR - para estos usar INSERT
*" RECOMENDACION SIEMPRE INSERT porque cubre todos los tipos de ti
*" append LS_de donde traemos la info to lt_a donde queremos volcarla
*" se puede añadir una linea o registro en blanco
*" APPEND VALUE #() Ahora el tema de estrctura ls y sólo hay  que pasarle lt y los nombres de los campos y su valor
*" APPEND LINES OF
*
*
*"APPEND
*
*DATA: lt_employees TYPE STANDARD TABLE OF zemploy_table,
*      ls_employee  TYPE zemploy_table.
*
*
*ls_employee-id            = 0001.
*ls_employee-first_name    = 'Laura'.
*ls_employee-last_name     = 'Martinez'.
*ls_employee-email         = 'lauram@logali.com'.
*ls_employee-phone_number  = '38512369'.
*ls_employee-salary        = '2000.3'.
*ls_employee-currency_code = 'EUR'.
*
*APPEND ls_employee TO lt_employees.
*
*APPEND INITIAL LINE TO lt_employees.
*
*APPEND VALUE #( id            = 0002
*                first_name    = 'Mario'
*                last_name     = 'Martinez'
*                email         = 'mariom@logali.com'
*                phone_number  = '38512369'
*                salary        = '2000'
*                currency_code = 'EUR' ) TO lt_employees.
*
*out->write( data = lt_employees name = 'Employee Table' ).

" 1.8 CORRESPONDING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

*"CORRESPONDING
*"Se utiliza para asignar automáticamente valores entre estructuras o tablas con campos de igual nombre y tipo.
*
*" gt_flights ti lectura bbdd
*" gt_my_flifhts ti donde vamos a traspasar la información
*
*" MOVE CORRESPONDING TI ORIGEN TO TI DESTINO
*" CORRESPONDING (ABAP VERSION 7.4) - TI DESTION CORRESPONDING #(TI ORIGEN)
*" KEEPING TARGET LINES // BASE
*"    COPIAR CONSERVNADO LOS REGISTROS QUE YA EXISTEN EN LA TI DESTION (EN NUESTRO EJ DUPLICAMOS DATOS PUES EL ORIGEN ES EL MISMO)
*
*" SI EL nombre no coincide no vuelca info
*
*"CORRESPONDING
*
*TYPES: BEGIN OF lty_flights,
*         carrier_id    TYPE /dmo/carrier_id,
*         connection_id TYPE /dmo/connection_id,
*         flight_date   TYPE /dmo/flight_date,
*       END OF lty_flights.
*
*DATA: gt_my_flights TYPE STANDARD TABLE OF lty_flights,
*      gs_my_flight  TYPE lty_flights.
*
*SELECT FROM /dmo/flight
*  FIELDS *
*  WHERE currency_code EQ 'EUR'
*  INTO TABLE @DATA(gt_flights).
*
*MOVE-CORRESPONDING gt_flights TO gt_my_flights.
*out->write( data = gt_flights name = 'gt_flights' ).
*out->write( |\n| ).
*out->write( data = gt_my_flights name = 'gt_my_flights' ).
*
*gt_my_flights = CORRESPONDING #( gt_flights ).
*
*out->write( data = gt_flights name = 'gt_flights' ).
*out->write( |\n| ).
*out->write( data = gt_my_flights name = 'gt_my_flights' ).
*
*MOVE-CORRESPONDING gt_flights TO gt_my_flights KEEPING TARGET LINES.
*
*out->write( data = gt_flights name = 'gt_flights' ).
*out->write( |\n| ).
*out->write( data = gt_my_flights name = 'gt_my_flights' ).
*
*gt_my_flights = CORRESPONDING #( BASE ( gt_my_flights ) gt_flights ).
*
*out->write( data = gt_flights name = 'gt_flights' ).
*out->write( |\n| ).
*out->write( data = gt_my_flights name = 'gt_my_flights' ).
*
*
*TYPES: BEGIN OF lty_flights,
*         carrier       TYPE /dmo/carrier_id,
*         connection_id TYPE /dmo/connection_id,
*         flight_date   TYPE /dmo/flight_date,
*       END OF lty_flights.
*
*
*gt_my_flights = CORRESPONDING #( BASE ( gt_my_flights ) gt_flights ).
*
* out->write( data = gt_flights name = 'gt_flights' ).
*out->write( |\n| ).
*out->write( data = gt_my_flights name = 'gt_my_flights' ).
*
*gt_my_flights = CORRESPONDING #(
*  gt_flights
*  MAPPING carrier    = carrier_id
*          connection = connection_id
*).
*
* out->write( data = gt_flights name = 'gt_flights' ).
*out->write( |\n| ).
*out->write( data = gt_my_flights name = 'gt_my_flights' ).


" 1.9 READ TABLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
* " COMANDO para leer una linea específica de una TI en tiempo de ejecución
* " sirve para buscar y recuperar datos de una tabla
* " 3 formas
* " indice
* " claves
* " clave libre
*
* " TRANSPORTING si solo queremos leer algunos campos
*
* " DECLARACION EN LINEA DE UN APUNTADOR en lugar de una ls (estructura)
*
* " EXPRESIONES DE TABLA - almacenarlo en una VARIABLE
*
* " OPTIONAL EXCEPCION Por leer un registro inexistente - optional  linea en blanco con LAS COLUMNAS - evitar excepción
*
* " DEFAULT mostrar información por defecto si  no existe el registro - indicar el registro que queremos mostrar
*
* """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
* " ej 1 INDICE
* " TABLA estandar
* " READ TABLE lt_nombre INTO  DATA(ls_volcamos la info en una estructura) INDEX N.
* " SE PUede imprimir la TI completa lt o la estructura ls
*  " ej 2
*  " READ TABLE lt_taBLA que leemos INTO DATA (LS_estructura donde volcamos) indes n TRANSPORTING campos que quiero volcar
*  " ej 3
*  " READ TABLE Lt_TABLA ASSINGNING FIELD-SYMBOL
*  " EJ 4
*  " nueva sintaxis de abap
*  " DATA(ls estructura donde guardamos) = lt_tabla interna que q   çueremos leer`[  nº indice que queremos buscar   ]
*  " nº indice que no existe - no devuelve valor
*  " OPTIONA
*  " default
*
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*"Este bloque realiza una selección de aeropuertos del país 'DE', almacena los registros en una tabla interna y demuestra dos formas distintas de lectura: READ TABLE con INDEX y READ TABLE con INDEX TRANSPORTING para leer campos específicos.
*
*"READ TABLE with INDEX
*SELECT FROM /dmo/airport
*  FIELDS *
*  WHERE country EQ 'DE'
*  INTO TABLE @DATA(lt_flights).
*
*IF sy-subrc EQ 0.
*
*  "Lectura completa del primer registro por índice
*  READ TABLE lt_flights INTO DATA(ls_flight) INDEX 1.
*  out->write( data = lt_flights name = 'lt_flights' ).
*  out->write( data = ls_flight name = 'ls_flight' ).
*
*  "Lectura del segundo registro por índice transportando solo campos específicos
*  READ TABLE lt_flights INTO DATA(ls_flight2) INDEX 2 TRANSPORTING airport_id city.
*  out->write( data = ls_flight2 name = 'ls_flight2' ).
*
*    "Este bloque demuestra la lectura de una línea específica de la tabla interna utilizando READ TABLE con INDEX y asignación mediante FIELD-SYMBOL para acceder directamente al registro sin copia de datos.
*
*    READ TABLE lt_flights ASSIGNING FIELD-SYMBOL(<ls_flight>) INDEX 3.
*    out->write( data = <ls_flight> name = '<ls_flight>' ).
*
*    "Este bloque demuestra el acceso directo a una posición específica de la tabla interna mediante expresión de índice, asignando el registro a una variable inline y mostrando el resultado.
*    "NUEVA SINTAXIS
*
*    DATA(ls_data) = lt_flights[ 2 ].
*    out->write( data = ls_data name = 'ls_data' ).
*
*    "Este bloque demuestra el acceso seguro a una posición específica de la tabla interna utilizando VALUE #( ) con expresión de índice y mostrando el resultado en la salida.
*    " ESTE indice no existe por lo que no trae nada
*
*    DATA(ls_data2) = VALUE #( lt_flights[ 20 ] ).
*    out->write( data = ls_data2 name = 'ls_data' ).
*
*    "Este bloque demuestra el acceso seguro a una posición específica de la tabla interna utilizando VALUE #( ) con OPTIONAL, evitando error en tiempo de ejecución cuando el índice no existe.
*
*DATA(ls_data2) = VALUE #( lt_flights[ 20 ] OPTIONAL ).
*out->write( data = ls_data2 name = 'ls_data2' ).
*
*"Este bloque demuestra el acceso seguro a una posición específica de la tabla interna utilizando VALUE #( ) con DEFAULT, devolviendo un registro alternativo cuando el índice solicitado no existe.
*
*DATA(ls_data3) = VALUE #( lt_flights[ 20 ] DEFAULT lt_flights[ 1 ] ).
*out->write( data = ls_data3 name = 'ls_data3' ).
*
*
*
*ENDIF.



" 1.10 READ TABLE con CLAVE - campos librs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" Leer registro con clave
*" devuelve la primera que encuentre ( = fila con el índice más bajo)
*
*
*" READ TABLE lt tabla a leer INTO DATA(declaración en linea de la estructura ls para guardar info) WITH KEY campos o filtros para busqueda (ej ciudad de Berlin)
*
*" NUEVA SINTAXIS DE ABAP - EXPRESIONES DE TABLA EN VEZ DE READ TABLE
*
*" SOLO TRAER UN CAMPO ESPECIFICO - AÑADIR -campo especifico  => devuelve el valor en una variable unidimensional
*
*
*"Este bloque demuestra la lectura de una tabla interna utilizando READ TABLE con WITH KEY, buscando un registro por el campo CITY y mostrando el resultado encontrado.
*
*"READ TABLE WITH KEY
*
*SELECT FROM /dmo/airport
*  FIELDS *
*  WHERE country EQ 'DE'
*        or airport_id = 'JFK'
*  INTO TABLE @DATA(lt_flights).
*
*READ TABLE lt_flights INTO DATA(ls_flight) WITH KEY city = 'Berlin'.
*
*out->write( data = lt_flights name = 'lt_flights' ).
*out->write( data = ls_flight name = 'ls_flight' ).
*
*"Este bloque demuestra el acceso directo a una tabla interna mediante expresión de clave utilizando sintaxis de tabla interna con condición, asignando el resultado a una variable inline.
*
*DATA(ls_flight2) = lt_flights[ airport_id = 'JFK' ].
*out->write( data = lt_flights name = 'lt_flights' ).
*
*
*"Este bloque demuestra el acceso directo a un campo específico de un registro de la tabla interna utilizando expresión de clave y accediendo directamente al componente NAME.
*
*DATA(lv_flight) = lt_flights[ airport_id = 'JFK' ]-name.
*out->write( data = lv_flight name = 'lv_flight' ).
*
*" 1.10 READ TABLE con CLAVE - campos DE CLAVE PRIMARIA (PRIMARY KEY)
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" WITH TABLE KEY - filtro por primary key (especificar campo clave y darle un valor)
*" TABLA SORTED organizado de forma ascendente
*
*" MEDIANTE EXPERSIONES DE TABLAS (nuevo ABAP)
*
*"Este bloque demuestra la definición de una tabla interna SORTED con clave NON-UNIQUE y la carga de datos desde la base de datos, preparando la tabla para lecturas eficientes mediante PRIMARY KEY.
*
*"READ TABLE with PRIMARY KEY
*
*DATA gt_flights_sort TYPE SORTED TABLE OF /dmo/airport
*                     WITH NON-UNIQUE KEY airport_id.
*
*SELECT FROM /dmo/airport
*  FIELDS *
*  INTO TABLE @gt_flights_sort.
*
*"Este bloque demuestra la lectura de una tabla interna SORTED utilizando READ TABLE con TABLE KEY (PRIMARY KEY), realizando una búsqueda optimizada por la clave definida airport_id.
*
*READ TABLE gt_flights_sort INTO DATA(ls_flight3)
*     WITH TABLE KEY airport_id = 'LAS'.
*
*out->write( data = gt_flights_sort name = 'gt_flights_sort' ).
*out->write( data = ls_flight3      name = 'ls_flight3' ).
*
*"Este bloque demuestra el acceso directo a una tabla interna SORTED mediante expresión de tabla utilizando explícitamente la PRIMARY KEY definida (TABLE KEY primary_key) para realizar una búsqueda optimizada.
*
*DATA(ls_flight4) = gt_flights_sort[ KEY primary_key airport_id = 'LAS' ].
*out->write( data = ls_flight3 name = 'ls_flight3' ).
*
*"ACCESO A INDICE MAS RAPIDO QUE CON CLAVE

" 1.11 CHEQUEO DE REGISTROS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*" VERIFICIAR que un registro exista -
*
*" LINE EXITS - > devuelve si el registro existe o no
*" con la condicidencia de inide o clave  - nuevo ABAP
*" ej if line_exists (tabla ( campo = valor) texto
*
*" READ TABLE  + TRANSPORTING NO FIELDS - antiguo ABAP
*" si encuentra registro sy_subrc = 0
*
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"LINE_EXISTS
*"Este bloque demuestra cómo realizar el chequeo de existencia de registros en una tabla interna después de una selección desde base de datos.
*
*DATA: gt_flights TYPE STANDARD TABLE OF /dmo/flight.
*
*SELECT FROM /dmo/flight
*  FIELDS *
*  WHERE carrier_id EQ 'LH'
*  INTO TABLE @gt_flights.
*
*IF sy-subrc EQ 0.
*
*"Este bloque demuestra cómo verificar la existencia de un registro en una tabla interna utilizando READ TABLE con TRANSPORTING NO FIELDS para evitar copiar datos y solo comprobar si la línea existe.
*
*    READ TABLE gt_flights WITH KEY connection_id = '0403' TRANSPORTING NO FIELDS.
*
*    IF sy-subrc EQ 0.
*      out->write( 'The flight exists in the database' ).
*    ELSE.
*      out->write( 'The flight doesn´t exist in the database' ).
*    ENDIF.
*
*"Este bloque demuestra el chequeo moderno de existencia de un registro en una tabla interna utilizando la función line_exists( ), evitando el uso de sy-subrc y sin riesgo de excepción.
*
*    IF line_exists( gt_flights[ connection_id = '0403' ] ).
*      out->write( 'The flight exists in the database' ).
*    ELSE.
*      out->write( 'The flight does´nt exists in the database' ).
*    ENDIF.
*
*ENDIF.

" 1.12 IDICE DE UN REGISTRO
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" posición exacta de un registro - sy-tabix
*
*" READ TYBLE WITH KEY TRANSPORTING FIELDS - declarar variable el sistema guarda el valor  lv_index (nº de indice d euna tabla interna)
*" LINE INDEX - nuevA SINTAXIS ABAP
*
*" LINES
*" cuántos registros hay en una tabla interna en tiempo de ejecución
*
*DATA: gt_flights TYPE STANDARD TABLE OF /dmo/flight.
*
*SELECT FROM /dmo/flight
*  FIELDS *
*  WHERE carrier_id EQ 'LH'
*  INTO TABLE @gt_flights.
*
*IF sy-subrc EQ 0.
*
*"LINE INDEX
*"Este bloque demuestra cómo obtener el índice de una línea encontrada en una tabla interna utilizando READ TABLE con TRANSPORTING NO FIELDS y recuperando la posición mediante sy-tabix.
*"resultado de la primera coincidencia
*
*    READ TABLE gt_flights WITH KEY connection_id = '0403' TRANSPORTING NO FIELDS.
*
*    DATA(lv_index) = sy-tabix.
*
*    out->write( data = gt_flights name = 'gt_flights' ).
*    out->write( lv_index ).
*
*"LINE_INDEX
*"Este bloque demuestra el uso de la función line_index( ) para obtener el índice de una línea mediante expresión de clave y mostrar el resultado en la salida.
*
*    DATA(lv_index_nuevo) = line_index( gt_flights[ connection_id = '0401' ] ).
*
*    out->write( data = gt_flights name = 'gt_flights' ).
*    out->write( data = lv_index_nuevo name = 'lv_index_nuevo' ).
*
*"LINES
*"Este bloque demuestra el uso de la función lines( ) para obtener el número total de registros contenidos en una tabla interna.
*
*    DATA(lv_num) = lines( gt_flights ).
*    out->write( data = lv_num name = 'lv_num' ).
*
*
*ENDIF.

" 1.13 LOOP AT
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" recorrer todos los registros de una TI
"LOOP AT
"Sirve para ejecutar un bloque de código repetidamente para cada entrada de una tabla interna, permitiendo leer y manipular los datos dentro de cada fila.

" WHERE incluir filtro

" ASSIGNING FIELD-SYMBOL En lugar de estructura - APUNTADOR (ventaja no reserva espacio en memoria. Simplemente apunta a la variable q asignamos en cada iteración

" FROM TO - Iterar un nº determinado de posiciones

" modificar un campo (ej moneda)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" loop at tabla INTO DATA(estructura donde se guarda la info)  o pasar el nombre de estructura si ya está craeda
" las tablas de indice se recorren por orden ascendente por el indice
" sy-tabix por cada iteración irá incrementando de valor

DATA: gt_flights TYPE STANDARD TABLE OF /dmo/flight.

SELECT FROM /dmo/flight
  FIELDS *
  WHERE carrier_id EQ 'LH'
  INTO TABLE @gt_flights.

IF sy-subrc EQ 0.

"Este bloque demuestra el uso de LOOP AT para recorrer una tabla interna, leer cada registro en una estructura de trabajo y procesar cada fila dentro del bucle.

DATA gs_flight TYPE /dmo/flight.

LOOP AT gt_flights INTO gs_flight. " establecer un breakpoint (punto de interrupción) para ver el comportamiento
                                   " escribir en la parte superior sy-tabix en variables y con f6 ver como cambia de valor

  out->write( data = gs_flight ).

ENDLOOP.

"Este bloque demuestra el uso de LOOP AT con declaración inline DATA( ), permitiendo crear automáticamente la estructura de trabajo dentro del bucle sin necesidad de declaración previa.

LOOP AT gt_flights INTO DATA(gs_flight2).

ENDLOOP.

"Este bloque demuestra el uso de LOOP AT con cláusula WHERE para recorrer únicamente las filas que cumplen una condición específica dentro de la tabla interna.

LOOP AT gt_flights INTO DATA(gs_flight3) WHERE connection_id = '0401'.

  out->write( data = gs_flight2 name = 'gs_flight2' ).

ENDLOOP.

" no existe valor
"Este bloque demuestra el uso de LOOP AT con ASSIGNING FIELD-SYMBOL para recorrer la tabla interna sin copiar datos, trabajando directamente sobre la referencia de cada fila y filtrando con la cláusula WHERE.

*LOOP AT gt_flights ASSIGNING FIELD-SYMBOL(<ls_flight>) WHERE carrier_id = 'AZ'.
*
*  out->write( data = <ls_flight> name = '<ls_flight>' ).
*
*ENDLOOP.

"Este bloque demuestra el uso de LOOP AT con ASSIGNING FIELD-SYMBOL utilizando rango de índices (FROM ... TO ...) para modificar directamente varias filas de la tabla interna sin copiar datos, actualizando el campo currency_code en las posiciones indicad
"as.

LOOP AT gt_flights ASSIGNING FIELD-SYMBOL(<ls_flight>) FROM 3 TO 8.

  <ls_flight>-currency_code = 'COP'.

ENDLOOP.

out->write( data = gt_flights name = 'gt_flights2' ).

ENDIF.


  ENDMETHOD.

ENDCLASS.
