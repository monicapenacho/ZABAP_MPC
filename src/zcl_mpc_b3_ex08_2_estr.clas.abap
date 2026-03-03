CLASS zcl_mpc_b3_ex08_2_estr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_b3_ex08_2_estr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " 2 ESTRUCTURAS Y TIPOS LOCALES
  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  " 2.1 DEFINICION
  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*  " OBJETOS de DATOS compuestos por tipos de datos complejos
*  " PLANTILLA compuesta por campos o columnas y cada una de ellas representa tipo de dato que puede ser
*        " objeto elemental
*        " Estructura
*        " TI
*        " rEFERENCIAS
*
*   "se puedeusar tanto en programas abap, clases globales, interfaces globales en la sección publica
*
*   " ej empleado nombre, id, profesión etc
*   " asignar a TI los tipos de linea
*
*   " 2 formas para crearlo
*   " 1 ls ->local sólo visible o diponible dentro del contexto en el que se está trabajando (se ha creado)
*   " 2 gs -> global desde diccionario de datos para que todos los desarrolladores tengan acceso a la plantilla
*   " nombre representativo
*
*   " las estructuras dentro del tiempo de ejecución solo almacenan un registro
*
*   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*   " type se puede asignar el tipo de linea de la tabla estándar /dmo/flight
*   " las vistas cd no se pueden usar en el diccionario abap (vistas de dicionario solo disponibles en abap standar)
*
**     DATA ls_flight TYPE /dmo/flight.  "Declara una estructura basada en la tabla DDIC /dmo/flight

  " 2.2 DECLARACION DE ESTRUCTURA
  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    "A)  declaración de TIPO ESTRUCTURADO LOCAL
*    "lty = tipo local
*    "Cuando construimos nuestra porpia estructura
*    "TYPES: BEGIN OF lty_nombre
*    "incluir componentes con tipos por lo general elementales o primitivos como string o
*    "elementos del diccionario por ejemplo /dmo/ctrlespacio
*    "o tabla interna, elemento de diccionario de datos, referencia etc
*    " No reserva memoria
*    " es una plantilla que puede ser usada posteriormente para declarar variables
*
*    "B) declaración de ESTRUCTURA
*    " Se puede incluir además del componente también el valor del campo  o  componente con VALUE dentro de la propia declaración
*    " DATA también se utiliza para declarar variables y tablas internas.
*    " DATA define el tipo y Reserva memoria (y se lo comunicamos al compilador) para usar al variable o la TI
*
*    "C) declaración de TABLA INTERNA ASIGNADO CON TIPO LOCAL ESTRUCTURADO
*
*    "D) declaración de estructura que le asignamos el tipo local estructurado creado anteriormente
*
*    "E) crear variable y tomar el tipo de estructura ya existente con LIKE
*
*
*    " TYPE se usa cuando el tipo es conocido y definido explicitamente en el sistema ( bien porque es del diccionario o porque lo hemos definido previamente)
*    " se puede usar cuando declaramos en linea una variable y le asignamos un valor innidcando el tipo local estructurado definido previamente (con ctrl espacio tenemos los campos)
*    " LIKE definimos una variable basándonos en una variable existente. Asegurar que una variable tenga el tipo de otra ya conocida.
*    "util cuando no se onoce el tipo exacto o se quiere mantener la consistencia entre variables
*
*
*    " 0)
*
*    DATA ls_flight TYPE /dmo/flight.  "Declara una estructura basada en la tabla DDIC /dmo/flight
*
*
*    "A)
*    TYPES: BEGIN OF lty_employee,     "Definición de un tipo de estructura propio
*             name  TYPE string,       "Campo texto dinámico
*             id    TYPE i,            "Campo entero
*             email TYPE /dmo/email_address. "Campo basado en elemento de datos DDIC
*           TYPES: END OF lty_employee.
*
*    "B)
*    DATA: BEGIN OF ls_employee,       "Declaración inline de una estructura (work area)
*            name  TYPE string VALUE 'Laura',  "Inicializa el campo name
*            id    TYPE i,                    "Campo entero sin valor inicial explícito (0)
*            email TYPE /dmo/email_address,   "Campo basado en elemento de datos DDIC
*          END OF ls_employee.
*
*    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*    DATA lt_employees TYPE TABLE OF lty_employee.  "Tabla interna basada en el tipo estructurado lty_employee
*    DATA ls_emp TYPE lty_employee.                 "Work area (estructura) del mismo tipo que la tabla
*
*    DATA ls_emp2 LIKE ls_employee.                 "Crea estructura con el mismo tipo que la variable ls_employee (referencia por LIKE)
*
*    DATA(ls_emp3) = ls_employee.                   "Declaración inline con inferencia de tipo (copia completa de estructura)
*
*    DATA(ls_emp4) = VALUE lty_employee( name = 'Maria' id = 1234 email = 'm@logali.com' ).
*    "Inicialización moderna usando constructor VALUE del tipo estructurado

  " 2.3. Estructuras anidadas (NESTED)
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    "A) Estrucutra PLANA O FLAT
*        "CAMPOS DE TIPOS ELEMENTALES - > cuando declaramos una estructura y cada campo le asignamos un tipo elemental (i, string, c....)
*
*    "B) Estructura ANIDADA (NESTED)
*        "- > cuando declaramos una estructura y al menos un de los componentes contiene una subestructura
*
*    "C) Estructura PROFUNDA (DEEP)
*
*    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*    "EJ A
*    "DATA BEGIN OF ls_nombre estructura,
*                    "campo1 TYPE i,
*                "END OF ls_nombre estructura.
*
*    "EJ B Tenemos anidadas 2 estructuras bajo la estructura principal
*    "DATA BEGIN OF ls_nombre estructura,
*                 "BEGIN OF info,
*                    "campo1 TYPE i,
*                 "END OF INFO,
*
*                 "BEGIN OF ...,
*                    "componentes
*                 "END OF ....,
*
*                "END OF ls_nombre estructura.
*
*      "SE muestra en pantalla la estructura anidada
*      "out->write(data = ls_empl_info name = 'nombre_encabezado')
*
*    """""NESTED STRUCTURE
*
     DATA: BEGIN OF ls_empl_info,   "Estructura principal que contiene subestructuras anidadas

        BEGIN OF info,         "Subestructura: datos personales
          id         TYPE i VALUE 12345,              "Identificador del empleado
          first_name TYPE string VALUE 'Laura',       "Nombre
          last_name  TYPE string VALUE 'Martinez',    "Apellido
        END OF info,

        BEGIN OF address,      "Subestructura: datos de dirección
          city    TYPE string VALUE 'Frankfurt',      "Ciudad
          street  TYPE string VALUE '123 Main street',"Calle
          country TYPE string VALUE 'Germany',        "País
        END OF address,

        BEGIN OF position,     "Subestructura: datos laborales
          department TYPE string VALUE 'IT',          "Departamento
          salary     TYPE p DECIMALS 2 VALUE '2000.23',"Salario con 2 decimales
        END OF position,

      END OF ls_empl_info.
*
*      out->write( DATA = ls_empl_info name = 'Employee info').
*
*
*       " tres estructuras anidadas una al lado de otra

  " 2.4. Estructuras complejas o profundas (DEEP)
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    " Estructuras en el que en algunos de sus campos o componentes contiene un campo de tipo complejo (tabla interna, cadena, referencia....)
*
*    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    " ej a)tipo de estructura local que consta de tres campos
*    " navegar sobre BD o tabla transparente con ctrl + click sobre nombre
*    " vemos todos sus campos y el elemento de dato correspondiente
*    " elemento de dato = dato que se va a manejar (ctrl click y vemos que /dmo/flight_date es tipo date con longitud 8 => es el tipo que asignará a nuestro
*    " componente flight_date
*    " por tanto hacemos referencia a un tipo de dato haciendo una referencia a una tabla /dmo/flight y su campo -flight-date
*    " y así para los demás componentes
*    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    "ej b) declarar estructura (asignar un nombre que no exista en nuestro código para evitar errores)
*    " seguimos unando la misma tabla estándar. Se puede asignar el tipo de dato complejo (de la tabla estándar ) y un valor
*    " La convertimos en una estructura profunda pues el últipo campo es una tabla del typo tabla interna al cual le asignamos el tipo que creamos en el bloque anterior
*    " se puede asignar una caracterísitica de una ti por ejemplo que la clave interna sea vacía
*    " END OF nombre estructura
*    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    "ej c) acceder a la tabla
*    " SELECT * Tomar todos los campos
*    " FROM tabla estándar
*    " WHERE filtro: ej cuando el campo xxxx sea igual a yy (igual = EQ)
*    " INTO CORRESPONDING FIELDS OF tomar de la tabla de la estructura profunda @ls_nombre_estrucutra profunda-campo DONDE está la tabla interna
*    " UP TO 4 ROWS -> extraoer 4 registros
*
*
*    TYPES: BEGIN OF lty_flights,                      "Define estructura línea para tabla interna
*             flight_date   TYPE /dmo/flight-flight_date,   "Campo fecha desde DDIC
*             price         TYPE /dmo/flight-price,         "Campo precio desde DDIC
*             currency_code TYPE /dmo/flight-currency_code, "Moneda desde DDIC
*           END OF lty_flights.
*
*    DATA: BEGIN OF ls_flight_info,                    "Estructura principal con cabecera + tabla anidada
*            carrier    TYPE /dmo/flight-carrier_id VALUE 'AA',     "Aerolínea
*            connid     TYPE /dmo/flight-connection_id VALUE '0018',"Conexión
*            lt_flights TYPE TABLE OF lty_flights WITH EMPTY KEY,   "Tabla interna anidada (componente deep)
*          END OF ls_flight_info.

*    SELECT *                                          "Selecciona registros de base de datos
*      FROM /dmo/flight
*      WHERE carrier_id EQ 'AA'                        "Filtro por compañía
*      INTO CORRESPONDING FIELDS OF TABLE @ls_flight_info-lt_flights
*      "Mapea campos por nombre hacia la tabla interna anidada
*      UP TO 4 rows. " mostrar sólo 4 registros
*
*    out->write( data = ls_flight_info name = 'ls_flight_info' ).
*    "Imprime estructura completa (cabecera + tabla interna)

  " 2.5. ACCESO - AÑADIR DATOS A ESTRUCTURAS
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    " tabla/bbdd-campos         -> /dmo/flight-price
*    " estructura(no tabla interna)-campos = valor -> no podemos asignar un valor que no sea compatible
*    " condición -> si un campo tiene valor xx entonces que se muestre en pantalla todo lo que hemos puesto bajo la estructura
*
*    "Ejemplo añadir valor a una estructura
*
*    TYPES: BEGIN OF lty_flights,                      "Define estructura línea para tabla interna
*             flight_date   TYPE /dmo/flight-flight_date,   "Campo fecha desde DDIC
*             price         TYPE /dmo/flight-price,         "Campo precio desde DDIC
*             currency_code TYPE /dmo/flight-currency_code, "Moneda desde DDIC
*           END OF lty_flights.
**
*    DATA: BEGIN OF ls_flight_info,                    "Estructura principal con cabecera + tabla anidada
*            carrier    TYPE /dmo/flight-carrier_id VALUE 'AA',     "Aerolínea
*            connid     TYPE /dmo/flight-connection_id VALUE '0018',"Conexión
*            ls_flights TYPE lty_flights,   "IMPORTANTE NO ES Tabla interna anidada ES ESTRUCTURA PARA poner como VALOR la fecha actual del sistema (ver abajo)
*          END OF ls_flight_info.
*
*    "Nota ls_flights al no tratarse de tabla interna (porque lo hemos modificado) guardará sólo un registro
*
*
*    ls_flight_info-carrier = 'XX'.
*    ls_flight_info-connid  = '0022'.
*
*    ls_flight_info-ls_flights-flight_date   = cl_abap_context_info=>get_system_date( ).
*    ls_flight_info-ls_flights-currency_code = 'USD'.
*    ls_flight_info-ls_flights-price         = '200'.
*
*    IF ls_flight_info-carrier EQ 'XX'.
*      out->write(
*        data = ls_flight_info
*        name = 'ls_flight_info'
*      ).
*    ENDIF.

  " 2.6. AÑADIR DATOS - A LAS ESTRUCTURAS EN TIEMPO DE EJECUCION - VALUE()
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    " VALUE - versión 7.4
*    " ahorra tiempo
*
*    "NESTD STRUCTURE ls_empl_info = VALUE #( ).
*    " EJ estructura anidada (activar 2.3 ls_empl_info): HAY QUe rellenar los componentes de cada una de sus 3 estructuras que la componen
*    " ctrl ESP accedemos a los componentes y los incluimos en los paréntesis - ojo a la compatiblidad de los tipos
*    " no se cierra con punto porque no hemos terminado ya que hay que rellenar el resto de subestructuras
*    " sólo rellenar las subestructuras que necesitamos
*    " al imprimir agregar el nombre
*
*    "NESTED Structure
*    ls_empl_info = VALUE #(
*      info    = VALUE #( id = 123456 first_name = 'Juan' last_name = 'Martinez' )
*      address = VALUE #( city = 'Madrid' street = 'Gran Vía' country = 'Spain' )
*      position = VALUE #( department = 'Finance' salary = '2550' )
*    ).
*
*    out->write( data = ls_empl_info name = 'ls_empl_info' ).
*
*
*    "DEEP STRUCTURE ls_flight_info = VALUE #( ).
*    "Estructura profunda
*    " ej el tercer componente ls_flights es una tabla interna (tipo complejo). nota ACTIVAR la estructura
*
*    TYPES: BEGIN OF lty_flights,                      "Define estructura línea para tabla interna
*             flight_date   TYPE /dmo/flight-flight_date,   "Campo fecha desde DDIC
*             price         TYPE /dmo/flight-price,         "Campo precio desde DDIC
*             currency_code TYPE /dmo/flight-currency_code, "Moneda desde DDIC
*           END OF lty_flights.
*
*    DATA: BEGIN OF ls_flight_info,                    "Estructura principal con cabecera + tabla anidada
*            carrier    TYPE /dmo/flight-carrier_id VALUE 'AA',     "Aerolínea
*            connid     TYPE /dmo/flight-connection_id VALUE '0018',"Conexión
*            ls_flights TYPE lty_flights,   "IMPORTANTE LA CONVERTIMOS EN ESTRUCTURA ANTES ERA Tabla interna anidada (componente deep)
*          END OF ls_flight_info.
*
*    " SALTO DE linea out->write( |\n| ).
*
*    out->write( |\n| ).
*
*    "DEEP Structure
*    ls_flight_info = VALUE #(
*      carrier    = 'SP'
*      connid     = '0035'
*      ls_flights = VALUE #(
*                    flight_date   = '20250101'
*                    currency_code = 'EUR'
*                    price         = '200'
*                  )
*    ).
*
*    out->write( data = ls_flight_info name = 'ls_flight_info' ).
*
*    " SOLO RELLENAR UN CAMPO. El resto de componentes los muestra en cero
*
*    DATA(ls_flight2) = VALUE lty_flights( currency_code = 'USD' ).
*
*    out->write( data = ls_flight2 name = 'ls_flight2' ).

  " 2.7. ELIMINAR DATOS - DE LOS COMPONENTES DE UNA ESTRUCTURA EN TIEMPO DE EJECUCION - CLEAR
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    " CLEAR
*    " clear se puede usar para un componente de forma individual o para la estructura complet
*
*    " ej lectura bbdd SELECT SINGLE ES SINGLE significa que sólo recibimos un registro
*    " para llenar de información la estructura
*    " where condición
*    " traemos un registro y lo guardamos en la estructura ls_flight2
*
*    " clear borrado de la información de un campo connection_id
*
*    " clear sobre toda la estructura si queremos limpiarla
*
*    "Delete
*
*    SELECT SINGLE FROM /dmo/flight
*      FIELDS *
*      WHERE carrier_id EQ 'LH'
*      INTO @DATA(ls_flight2).
*
*    out->write( data = ls_flight2 name = 'ls_flight2' ).
*
*    clear ls_flight2-connection_id.
*    out->write( data = ls_flight2 name = 'ls_flight2' ).
*
*    clear ls_flight2.
*    out->write( data = ls_flight2 name = 'ls_flight2' ).

  " 2.8. ESTRUCTURA INCLUDE - INCLUDE TYPE / INCLUDE STRUCTURE
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    " Incluir componentes de otra estructura a una estructura prinicpal
*
*    "INCLUDE TYPE
*    "Se utiliza para incluir definiciones de tipos de datos estándar o definidos por el usuario en programas ABAP.
*    " Esto permite reutilizar definiciones de tipos en diferentes programas ABAP, mejorando la modularidad y la consistencia del código.
*
*    "INCLUDE STRUCTURE
*    "Se utiliza en ABAP para incorporar una estructura completa dentro de otra.
*    " Esto permite reutilizar y extender estructuras de datos sin necesidad de redefinir todos sus campos, lo que facilita la gestión y la consistencia de los datos en diferentes partes del sistema.
*
**    TYPES BEGIN OF NOMBRE_type.
**    incluimos los campos que va a incluir
**    con el alias AS purchase podemos llamar a los compoenntes
**    tenemos dos tipos que tienen un componente con el mismo nombre - > solución con REMAINING WITH SUFFIX
*"    vamos a añadir un sufijo para poder diferenciar el campo. ejemplo _supplier . Importante poner delante un alias AS supplier
**    TYPES END OF nombre_type.
**    con esto le decimos al compilador que vamos a realizar una estructura de tipo include
*
**    ¿qué hacemos con esto ? declarar una estructura ya que no podemos definir datos a los tipos locales definidos
**    el tipo de la estructura es el tipo local que hemos definido
*
**     Empezamos a rellenar campos para ello se puede crear otra estructura por ejemplo LS_purchase para rellenarlo de forma individual
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*        "NESTED Structure
*        TYPES: BEGIN OF purchase_order_type,
*                 order_id   TYPE i,
*                 order_date TYPE d,
*               END OF purchase_order_type,
*
*               BEGIN OF supplier_type,
*                 supplier_id TYPE i,
*                 name        TYPE string,
*               END OF supplier_type,
*
*               BEGIN OF material_type,
*                 material_id TYPE i,
*                 name        TYPE string,
*               END OF material_type.
*
*        DATA ls_mat TYPE material_type.
*
*
*        TYPES BEGIN OF invoice_type.
*
*          INCLUDE TYPE purchase_order_type AS purchase.
*          INCLUDE TYPE supplier_type AS supplier renaming with suffix _supplier.
*          INCLUDE STRUCTURE ls_mat AS mat renaming with suffix _mat.
*
*        TYPES END OF invoice_type.
*
*
*        DATA: ls_invoice  TYPE invoice_type,
*              ls_purchase TYPE purchase_order_type.
*
*        ls_purchase = VALUE #( order_date = '20250101' order_id = 1234 ).
*
*        ls_invoice = VALUE #(
*          purchase            = ls_purchase
*          supplier-supplier_id = 123
*          supplier-name        = 'XX'
*          material_id_mat      = 123
*          name_mat             = 'MAT1'
*        ).
*
*        out->write( data = ls_invoice name = 'ls_invoice' ).







  ENDMETHOD.
ENDCLASS.
