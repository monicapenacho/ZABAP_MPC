CLASS zcl_mpc_b6_ex11_2_pdin DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_b6_ex11_2_pdin IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " PROGRAMACION DINAMICA
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " 2.1 CONCEPTOS
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  "Escribir código fuente que puede adaptarse en tiempo de ejecución
  "en lugar de ser completamente definido dentro de código
  " incluye creación, modificación y ejecución de objetos y estructuras en tiempo real
  " Código más flexible y adaptativo

  "e j se pueden crear ti y estructuras cuyos tipos se determinen en tiempo de ejecución

  " También se puede hacer la invocación dinámica de los métodos
  " en lugar de tenerlo definido estáticamente dentro del código fuente

  " útil cuando el programa depende de condiciones que s´lo se conocen en tiempo de ejecución

  " También se puede hacer la creación dinámica de objetos
  " permite instanciar objetos de clases que se determinan en tiempo de ejecución
  " util cuando el tipo de objeto a crear no se conoce hasta que se ejecuta el código

  "También se puede ejecutar código dinámico

  " Los programas abap pueden incluir parte dinámica y parte estática

  "ejemplo CODIGO ESTATICO
  " DATA lt_data TYPE TABLE OF z01_address WITH EMPTY KEY.

  "EJEMPLO CODIGO DINAMICO
  "DATA(lt_database) = 'Z01_ADDRESS'.

    "SELECT *
  "FROM (lt_database)
  "INTO TABLE @DATA(lt_dyndata).

    "ventajas
    " 1 flexibilidad - adaptarse a cambios
    " 2 reutilización de código -adaptarse a múltiples escenarios

    "inconvenientes
    " 3. rendimiento más costoso
    "4.- puede ser más dificil de mantener y depurar
    " por su naturaleza menos predecible


 " 2.2. Usos de field Symbols
 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


 " FIELD-SYMBOLS: ASSIGN asignación específica a un área de datos
 " No se pueden declrar en la parte de declaración de fases e interfases


 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " BLOQUE 1 DECLARACION APUNTADOR GENERICO
* "Ej incluimos apuntadores dinámicos <>. El tipo se adaptará a los que asignemos al apuntador
* " operador value para agregar un registro sobre una estructura
* "evaluar si el apuntador está asignado, si no no realizar la operación. si si aputnar a estructura
* "to apuntar a componente para cambiar el nombre - > la programación dinámica y luego
* "quitamos la asignación al apuntador gs_data. P
* "para quitárselo el apuntador a la estructura hay que hacerlo fuera de el if
*
* " Este bloque demuestra la creación de una estructura tipada basada en zemploy_table
*" mediante la expresión VALUE,
*" seguida de la asignación dinámica a un field-symbol
*" de tipo genérico (TYPE any), ilustrando el uso de referencias dinámicas y tipado flexible
*" en ABAP moderno.
*
*FIELD-SYMBOLS: <gt_employees> TYPE ANY TABLE,
*               <gs_employee>  TYPE any,
*               <gs_data>      TYPE any.
*
*DATA(gs_employee) = VALUE zemploy_table(
*                      mandt         = 100
*                      id            = '10004'
*                      first_name    = 'Camila'
*                      last_name     = 'Pérez'
*                      email         = 'emont@logali.com'
*                      phone_number  = 31896523
*                      salary        = '4000'
*                      currency_code = 'EUR' ).
*
*ASSIGN gs_employee TO <gs_employee>.
*
*
*" Este bloque demuestra programación dinámica con field-symbols:
*" se valida la asignación de una estructura genérica, se accede dinámicamente
*" a un componente específico mediante ASSIGN COMPONENT,
*" se modifica su valor en tiempo de ejecución y
*"e liberan las asignaciones, evidenciando control
*" seguro de memoria y tipado dinámico en ABAP avanzado.
*
*IF <gs_employee> IS ASSIGNED.
*
*  ASSIGN COMPONENT 'FIRST_NAME' OF STRUCTURE <gs_employee> TO <gs_data>.
*
*  IF <gs_data> IS ASSIGNED.
*    <gs_data> = 'Maria'.
*    UNASSIGN <gs_data>.
*  ENDIF.
*
*  UNASSIGN <gs_employee>.
*
*ENDIF.
*
*out->write( data = gs_employee name = 'Dynamic Programming' ).

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BLOQUE 2 DECLARACION EN LINEA DE APUNTADORES - YA NO GENERICO

*" Este bloque demuestra la creación de una estructura tipada mediante VALUE,
*" la asignación a un field-symbol, la validación con IS ASSIGNED y la modificación
*" directa de un componente de la estructura, ilustrando el uso práctico de
*" programación dinámica y control seguro de referencias en ABAP moderno.
*
*DATA(gs_employee) = VALUE zemploy_table(
*                      mandt         = 100
*                      id            = '10004'
*                      first_name    = 'Camila'
*                      last_name     = 'Pérez'
*                      email         = 'emont@logali.com'
*                      phone_number  = 31896523
*                      salary        = '4000'
*                      currency_code = 'EUR' ).
*
*ASSIGN gs_employee TO FIELD-SYMBOL(<gs_employee>).
*
*IF <gs_employee> IS ASSIGNED.
*
*  <gs_employee>-first_name = 'Maria'.
*
*  UNASSIGN <gs_employee>.
*
*ENDIF.
*
*out->write( data = gs_employee name = 'Dynamic Programming' ).

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BLOQUE 3 DECLARACION GENERICA DE APUNTADORES
" Este bloque demuestra la lectura de datos desde una tabla de base de datos,
" la validación de contenido mediante la función lines( ),
" y el uso de programación dinámica con field-symbols para recorrer la tabla
" y modificar en tiempo de ejecución el componente 'EMAIL' de cada registro,
" aplicando manipulación dinámica segura sobre estructuras internas.

" ej select llenar tabla interna
" if Si las lineas de la TI son mayores que 0 entonces asigna la ti al apuntador
" LOOP AT iteración asignándolo a otro apuntador que actuará como una estructura
" va a guardar un sólo registro
" IS ASSIGNED comprobación de nuestro apuntador
" ASSIGN COMPONENT apuntamos al componente del F-S de estructura
" para asignarlo a un segundo FS llamado gs_data
" finalmente imprimir el resultado de la ti


*FIELD-SYMBOLS: <gt_employees> TYPE ANY TABLE,
*               <gs_employee>  TYPE any,
*               <gs_data>      TYPE any.
*
*DATA(gs_employee) = VALUE zemploy_table(
*                      mandt         = 100
*                      id            = '10004'
*                      first_name    = 'Camila'
*                      last_name     = 'Pérez'
*                      email         = 'emont@logali.com'
*                      phone_number  = 31896523
*                      salary        = '4000'
*                      currency_code = 'EUR' ).
*
*
*SELECT FROM zemploy_table
*  FIELDS *
*  INTO TABLE @DATA(gt_employees).
*
*IF lines( gt_employees ) GT 0.
*
*  ASSIGN gt_employees TO <gt_employees>.
*
*  LOOP AT <gt_employees> ASSIGNING <gs_employee>.
*
*    IF <gs_employee> IS ASSIGNED.
*      ASSIGN COMPONENT 'EMAIL' OF STRUCTURE <gs_employee> TO <gs_data>.
*
*      IF <gs_data> IS ASSIGNED.
*        <gs_data> = |{ <gs_data> }.es|.
*        UNASSIGN <gs_data>.
*      ENDIF.
*
*    ENDIF.
*
*  ENDLOOP.
*
*ENDIF.
*
*" Este bloque muestra la salida en consola de la tabla interna gt_employees,
*" utilizando el método out->write para visualizar el resultado final tras
*" la manipulación dinámica de sus registros, evidenciando el estado actualizado
*" de los datos en memoria.
*
*out->write( data = gt_employees name = 'Dynamic Programming' ).


" 2.3. Usos de Referencias de Datos DATA REFERENCE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" punteros
*"Apuntar a un área de memoria donde se almacenan datos.
*"Asignar a cualquier tipo de dato
*" El tipo puede ser conocido o desconocido en tiempo de ejecución
*"Útiles para manipulación de los datos dinámicos
*" pARA asignación de referencia de datos se usa NEW para agregar datos de forma dinámica
*" desreferenciar la referencia de datos - > *
*" una vez desreferenciada se puede acceder al contenido
*
*"DIFERENCIA PRINCIPAL DE PUNTEROS
*" puntero fyeld symbol - > uso para acceso temporal a área de datos existente
*" puntero DATA reference -> uso creación y gestión de datos en escenarios dinámicos
*
*" BLOQUE 1 ANTES
*
**DATA lr_data TYPE REF TO i.
**
**CREATE DATA lr_data.
*
*" BLOQUE 2 AHORA USAMOS EL OPERADOR NEW
*
*" Este bloque demuestra la creación dinámica de datos mediante NEW,
*" la desreferenciación con ->* para asignar el valor a un field-symbol,
*" y la instanciación de un objeto de clase, ilustrando manejo avanzado
*" de referencias a datos y referencias a objetos en ABAP moderno.
*
*DATA(lr_data) = NEW i( ).
*
*ASSIGN lr_data->* TO FIELD-SYMBOL(<lfs_value>).
*
*<lfs_value> = 30.
*
*DATA(lr_class) = NEW zcl_11_expcons( ).

" 2.4. Objetos de datos ANONIMOS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" objetos sin nombre
*" se pueden acceder mediante variables desreferenciadas o field symbols
*" se almacenan en HY (distinto de stack)
*
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"datos previons
*
*
*" Este bloque demuestra la definición de una estructura tipada (lty_data),
*" la creación de una estructura y una tabla interna asociada,
*" la inicialización mediante VALUE, la inserción con APPEND,
*" y la creación dinámica de un objeto anónimo de datos con NEW,
*" ilustrando manejo combinado de datos estáticos y dinámicos en ABAP moderno.
*
*TYPES: BEGIN OF lty_data,
*         field1 TYPE i,
*         field2 TYPE string,
*         field3 TYPE string,
*       END OF lty_data.
*
**DATA ls_data TYPE lty_data.
**
**DATA lt_data TYPE TABLE OF lty_data WITH EMPTY KEY.
**
**ls_data = VALUE #( field1 = 1
**                   field2 = 'aaa'
**                   field3 = 'Z' ).
**
**APPEND ls_data TO lt_data.
**
**DATA(lr_data) = NEW lty_data( field1 = 2
**                              field2 = 'b'
**                              field3 = 'Y' ).
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*
*
*
*" Este bloque demuestra especificaciones dinámicas en tablas internas,
*" definición de claves primarias y secundarias (UNIQUE y NON-UNIQUE),
*" tipado derivado con LIKE, manejo de tablas de referencias a datos,
*" e inicialización declarativa mediante VALUE, ilustrando modelado
*" avanzado de estructuras internas en ABAP moderno.
*
*"Dynamic Specifications in itab
*
*DATA lt_data_dyn TYPE TABLE OF lty_data WITH EMPTY KEY.
*
*"Standard table and specification of primary and secondary table key
*
*DATA lt_data_dyn2 TYPE TABLE OF lty_data
*     WITH NON-UNIQUE KEY field1                             " clave primaria
*     WITH UNIQUE SORTED KEY sortk COMPONENTS field2.        " clave secundaria sortk con el componente field2
*
*TYPES lt_type LIKE lt_data_dyn2.
*
*DATA lt_ref TYPE TABLE OF REF TO lty_data WITH EMPTY KEY.
*
*lt_data_dyn = VALUE #(
*  ( field1 = 1 field2 = 'aaa' field3 = 'zzz' )
*  ( field1 = 2 field2 = 'bbb' field3 = 'yyy' )
*  ( field1 = 3 field2 = 'ccc' field3 = 'xxx' )
*).
*
*lt_data_dyn2 = lt_data_dyn.
*
*"Anonymous data objects -  CREAR OBJETOS ANONIMOS
*"Anonymous data objects - forma antigua create data - creación con tipo IMPLICITO
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" Declaración de una variable de referencia llamada lr_data01
*" TYPE REF TO string significa que la variable no contiene el string directamente
*" sino una referencia (puntero) a un objeto de tipo string en memoria
*DATA lr_data01 TYPE REF TO string.
*
*" CREATE DATA crea dinámicamente en memoria un objeto del tipo indicado
*" En este caso crea un objeto de tipo string en el heap (memoria dinámica)
*" y la referencia lr_data01 pasa a apuntar a ese nuevo objeto
*CREATE DATA lr_data01.
*
*
*"Anonymous data objects - forma antigua create data - creación con tipo EXPLICITO
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" Declaración de una variable de referencia llamada lr_data02
*" TYPE REF TO data significa que es una referencia genérica
*" No se especifica el tipo del objeto al que apuntará todavía
*DATA lr_data02 TYPE REF TO data.
*
*" CREATE DATA crea dinámicamente un objeto en memoria
*" TYPE p LENGTH 10 DECIMALS 4 define el tipo del objeto creado:
*" - TYPE p  → número decimal empaquetado (packed number)
*" - LENGTH 10 → longitud total del campo
*" - DECIMALS 4 → número de decimales
*" La referencia lr_data02 pasa a apuntar a ese objeto recién creado
*CREATE DATA lr_data02 TYPE p LENGTH 10 DECIMALS 4.
*
*"Anonymous data objects - forma antigua create data - creación con tipo EXPLICITO de la tabla
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" LIKE que sea del tipo de la tabla que estaos creando. Generamos otro tipo para esa variable de referencia
*" Pasamos de dato genérico a tipo tabla estándar
*
*" Declaración de una tabla interna llamada lt_data
*" La tabla interna es estándar TYPE STANDARD TABLE OF or TYPE TABLE OF
*" TYPE TABLE OF zemplpy_table indica que la tabla interna tendrá
*" la misma estructura de línea que la tabla/estructura zemplpy_table
*DATA lt_data TYPE TABLE OF zemploy_table.
*
*" CREATE DATA crea dinámicamente un objeto de datos en memoria
*" LIKE lt_data significa que el objeto creado tendrá exactamente
*" el mismo tipo que la variable lt_data (es decir, una tabla interna
*" con la misma estructura que zemplpy_table)
*" La referencia lr_data02 pasa a apuntar a esa tabla creada dinámicamente
*CREATE DATA lr_data02 LIKE lt_data.
*
*
*
*" pasamos a tipo tabla interna hashed (requiere clave única)
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*" CREATE DATA crea dinámicamente un objeto de datos en memoria (heap)
*" lr_data02 es una variable de referencia que apuntará al objeto creado
*" TYPE HASHED TABLE OF zemplpy_table define que el objeto será una tabla interna
*" de tipo HASHED (tabla hash) cuya estructura de línea es zemplpy_table
*" WITH UNIQUE KEY id indica que la clave de la tabla es el campo id
*" y que no puede haber valores duplicados en esa clave
*CREATE DATA lr_data02 TYPE HASHED TABLE OF zemploy_table WITH UNIQUE KEY id.
*
*
*"Anonymous structures -  CREAR ESTRUCTURAS ANONIMOS
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" antes era una table ahora le decimos LIKE LINE OF que tenga una sóla linea
*" por tanto la convertimos en una estructura
*" OTRA forma de crear una estructura es con TYPE (porque no le incluimos la coletilla de TYPE STANDARD TABLE OF...)
*" LIKE ESTÁ MAS OBSOLETO QUE type
*
*" Anonymous structures
*" Este bloque muestra cómo crear estructuras anónimas (objetos de datos
*" creados dinámicamente en memoria sin declarar una variable estructurada previamente)
*
*" CREATE DATA crea dinámicamente un objeto de datos en memoria
*" lr_data02 es una variable de referencia que apuntará al objeto creado
*" LIKE LINE OF lt_data indica que el objeto creado tendrá el mismo tipo
*" que una línea (estructura) de la tabla interna lt_data
*CREATE DATA lr_data02 LIKE LINE OF lt_data.
*
*" CREATE DATA crea nuevamente un objeto de datos dinámico
*" TYPE zemplpy_table indica que el objeto será una estructura
*" con el mismo tipo que zemplpy_table
*" lr_data02 pasará a apuntar a esta nueva estructura creada
*CREATE DATA lr_data02 TYPE zemploy_table.
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" OBSOLETO - CREATE DATA
*" NUEVO - NEW
*
*" Declaración en linea
*" le pasamos con new el tipo de forma explictia y entre los paréntesis los valores
*
*" NEW
*" Este bloque muestra cómo crear objetos de datos anónimos usando el operador NEW
*
*" DATA(...) es una declaración inline (la variable se declara en el mismo momento)
*" lr_data03 será una variable de referencia
*" NEW i(123) crea dinámicamente un objeto de tipo entero (type i)
*" y lo inicializa con el valor 123
*DATA(lr_data03) = NEW i( 123 ).
*
*" DATA(...) vuelve a declarar otra referencia de forma inline
*" NEW zemplpy_table(...) crea una estructura dinámica del tipo zemplpy_table
*" Dentro de los paréntesis se inicializan los campos de la estructura
*" id se inicializa con el valor 10005
*" first_name se inicializa con el valor 'Sofia'
*DATA(lr_data04) = NEW zemploy_table( id = 10005 first_name = 'Sofia' ).
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" SELECT + NEW
*
*" SELECT
*" Ejemplo de uso de SELECT con creación de datos anónimos usando NEW y DATA inline
*
*SELECT *
*  FROM zemploy_table
*  " INTO TABLE NEW crea dinámicamente una tabla interna
*  " @DATA(lr_data05) declara la variable inline
*  " lr_data05 será una referencia a una tabla interna con el resultado del SELECT
*  INTO TABLE NEW @DATA(lr_data05).   " ITAB
*
*" Escribe el contenido de la tabla interna en la consola de ABAP
*" out es el objeto de salida proporcionado por IF_OO_ADT_CLASSRUN
*out->write( lr_data05 ).
*
*
*" SELECT SINGLE obtiene solo un registro de la tabla
*SELECT SINGLE *
*  FROM zemploy_table
*  " NEW @DATA(lr_data06) crea dinámicamente una estructura
*  " lr_data06 contendrá una única fila de la tabla
*  INTO NEW @DATA(lr_data06).        "structure
*
*" Muestra el registro obtenido en la consola
*out->write( lr_data06 ).
*
*"->* operador de acceso

" 2.5. Sentencias dinámicas ASSIGN
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
**" uso: queremos asignar el valor a un campo cuyo nombre no se conoce hasta el tiempo de ejecución
**" (ej cuando trabajamos con estructuras o ti couyos campos pueden estar variando en tiempo de ejecución
**
**
**" ASSIGN
**" Definición de un tipo de estructura local
**
**TYPES: BEGIN OF lty_data,
**         field1 TYPE i,        " Campo entero
**         field2 TYPE string,   " Campo de texto tipo string
**         field3 TYPE string,   " Otro campo de texto
**       END OF lty_data.
**
**" Declaración de una estructura basada en el tipo definido
**DATA ls_data TYPE lty_data.
**
**" Declaración de una tabla interna basada en la estructura lty_data
**" EMPTY KEY indica que la tabla no tiene clave primaria definida
**DATA lt_data TYPE TABLE OF lty_data WITH EMPTY KEY.
**
**" Inicialización de la estructura usando el operador VALUE
**" VALUE permite rellenar estructuras de forma moderna
**ls_data = VALUE #( field1 = 1
**                   field2 = 'aaa'
**                   field3 = 'Z' ).
**
**" Inserta la estructura ls_data como una nueva línea en la tabla interna lt_data
**APPEND ls_data TO lt_data.
**
**" Declaración inline de una referencia de datos llamada lr_data
**" NEW crea dinámicamente una instancia del tipo lty_data
**" y se inicializan sus campos
**DATA(lr_data) = NEW lty_data(
**                     field1 = 2
**                     field2 = 'b'
**                     field3 = 'Y' ).
**
**" Declaración de un field-symbol genérico
**" TYPE data significa que puede apuntar a cualquier tipo de dato
**FIELD-SYMBOLS <fs_generic> TYPE data.
*
*
*" ASSIGN
*" Definición de un tipo de estructura local
*
*TYPES: BEGIN OF lty_data,
*         field1 TYPE i,        " Campo entero
*         field2 TYPE string,   " Campo de texto tipo string
*         field3 TYPE string,   " Otro campo de texto
*       END OF lty_data.
*
*" Declaración de una estructura basada en el tipo definido
*DATA ls_data TYPE lty_data.
*
*" Declaración de una tabla interna basada en la estructura lty_data
*" EMPTY KEY indica que la tabla no tiene clave primaria definida
*DATA lt_data TYPE TABLE OF lty_data WITH EMPTY KEY.
*
*" Inicialización de la estructura usando el operador VALUE
*" VALUE permite rellenar estructuras de forma moderna
*ls_data = VALUE #( field1 = 1
*                   field2 = 'aaa'
*                   field3 = 'Z' ).
*
*" Inserta la estructura ls_data como una nueva línea en la tabla interna lt_data
*APPEND ls_data TO lt_data.
*
*" Declaración inline de una referencia de datos llamada lr_data
*" NEW crea dinámicamente una instancia del tipo lty_data
*" y se inicializan sus campos
*DATA(lr_data) = NEW lty_data(
*                     field1 = 2
*                     field2 = 'b'
*                     field3 = 'Y' ).
*
*" Declaración de un field-symbol genérico
*" TYPE data significa que puede apuntar a cualquier tipo de dato
*FIELD-SYMBOLS <fs_generic> TYPE data.
*
*
*" ASIGNACION DINAMICA DE COMPONENTES
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" ASSIGN dinámico de un componente de una estructura
*
*ASSIGN ls_data-('FIELD1') TO <fs_generic>.
*" ASSIGN asigna dinámicamente el campo FIELD1 de la estructura ls_data
*" ('FIELD1') es acceso dinámico al componente de la estructura
*" <fs_generic> pasa a apuntar al contenido de ese campo
*
*out->write( <fs_generic> ).
*" Escribe en la consola el valor al que apunta el field-symbol
*" En este caso mostrará el contenido de ls_data-field1
*
*
*" ASSIGN dinámico de un campo dentro de una tabla interna
*
*ASSIGN lt_data[ 1 ]-('FIELD1') TO <fs_generic>.
*" lt_data[1] accede a la primera fila de la tabla interna
*" ('FIELD1') accede dinámicamente al componente FIELD1 de esa fila
*" <fs_generic> apuntará ahora a ese valor
*
*out->write( <fs_generic> ).
*" Muestra el valor del campo FIELD1 de la primera fila de la tabla
*
*
*" ASSIGN dinámico usando una referencia de datos
*
*ASSIGN lr_data->('FIELD2') TO <fs_generic>.
*" lr_data es una referencia a una estructura lty_data creada con NEW
*" -> accede al objeto al que apunta la referencia
*" ('FIELD2') accede dinámicamente al componente FIELD2
*
*out->write( <fs_generic> ).
*" Muestra el valor del campo FIELD2 de la estructura referenciada
*
*" ASSIGN dinámico usando referencia de datos con desreferenciación explícita
*
*ASSIGN lr_data->*-('FIELD3') TO <fs_generic>.
*" lr_data es una referencia a una estructura del tipo lty_data
*" ->* desreferencia el objeto (accede a la estructura real a la que apunta la referencia)
*" ('FIELD3') accede dinámicamente al componente FIELD3 de esa estructura
*" <fs_generic> pasa a apuntar al contenido del campo FIELD3
*
*"AQUÍ USAMOS el operador de desreferenciación seguido del selector de componente
*
*out->write( <fs_generic> ).
*" Muestra en la consola el valor del campo FIELD3
*" En este ejemplo mostrará: 'Y'
*
*
*DATA lv_field TYPE string VALUE 'FIELD2'.
*" Declaración de una variable llamada lv_field
*" TYPE string indica que almacenará texto
*" VALUE 'FIELD2' inicializa la variable con el nombre del campo que queremos acceder dinámicamente
*
*ASSIGN ls_data-(lv_field) TO <fs_generic>.
*" ASSIGN dinámico de un componente de la estructura ls_data
*" (lv_field) indica que el nombre del campo se toma del contenido de la variable lv_field
*" En este caso lv_field contiene 'FIELD2'
*" Por lo tanto el sistema accede dinámicamente a ls_data-field2
*" <fs_generic> pasa a apuntar al contenido de ese campo
*
*out->write( <fs_generic> ).
*
*
*ASSIGN ('LS_DATA-FIELD1') TO <fs_generic>.
*" ASSIGN dinámico usando una cadena literal
*" 'LS_DATA-FIELD1' es el nombre completo del objeto y del campo
*" El sistema interpreta la cadena y asigna ese campo al field-symbol
*" <fs_generic> ahora apunta a ls_data-field1
*
*
*out->write( <fs_generic> ).
*" Muestra el contenido del campo ls_data-field1 en la consola
*
*"Navegar a posición 3
*
*ASSIGN ls_data-(3) TO <fs_generic>.
*" ASSIGN dinámico usando la posición del campo dentro de la estructura
*" (3) indica que se accede al tercer componente de la estructura ls_data
*" En la definición de la estructura lty_data:
*" 1 -> field1
*" 2 -> field2
*" 3 -> field3
*" Por lo tanto aquí se está accediendo a ls_data-field3
*" <fs_generic> pasa a apuntar al contenido de ese campo
*
*out->write( <fs_generic> ).
*" Muestra en la consola el valor del campo al que apunta el field-symbol
*" En este caso imprimirá el contenido de ls_data-field3
*" Según el ejemplo mostrado: 'Z'
*
*" Instancia de una clase y asignar los atributos de esa instancia mediante una variable de referencia de objeto
*
*DATA(lo_ref) = NEW ZCL_MPC_B5_EX10_2_EXPCONS_NEW( iv_age = 22 iv_name = 'Lorena' ).
*
*lo_ref->lv_age = 30.
*" lo_ref es una referencia a un objeto o estructura
*" -> accede al objeto al que apunta la referencia
*" lv_age es un atributo o campo del objeto
*" Aquí se asigna el valor 30 al campo lv_age
*
*
*ASSIGN lo_ref->('LV_AGE') TO <fs_generic>.
*" ASSIGN dinámico sobre una referencia de objeto
*" -> accede al objeto al que apunta lo_ref
*" ('LV_AGE') indica acceso dinámico al atributo cuyo nombre es LV_AGE
*" <fs_generic> pasa a apuntar al contenido de ese atributo
*
*
*out->write( <fs_generic> ).
*" Escribe en la consola el valor al que apunta el field-symbol
*" En este caso mostrará: 30

"2.6. Especificaciones dinámicas itab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Dynamic Specifications in itab
" Definición de una estructura que se usará como línea de una tabla interna

TYPES: BEGIN OF lty_data,
         field1 TYPE i,        " Campo entero
         field2 TYPE string,   " Campo de texto
         field3 TYPE string,   " Campo de texto
       END OF lty_data.


DATA lt_data_dyn TYPE TABLE OF lty_data WITH EMPTY KEY.
" Declaración de una tabla interna basada en la estructura lty_data
" EMPTY KEY indica que la tabla no tiene clave primaria definida


" Standard table and specification of primary and secondary table key
" Definición de una tabla estándar con clave primaria y clave secundaria

DATA lt_data_dyn2 TYPE TABLE OF lty_data
                  WITH NON-UNIQUE KEY field1
                  WITH UNIQUE SORTED KEY sortk COMPONENTS field2.
" Tabla interna estándar
" Clave primaria no única basada en field1
" Clave secundaria ordenada (sorted key) llamada sortk basada en field2
" UNIQUE indica que field2 no puede repetirse en esta clave secundaria


TYPES lt_type LIKE lt_data_dyn2.
" Definición de un tipo nuevo basado en la estructura de la tabla lt_data_dyn2
" Esto permite reutilizar la misma definición en otras variables


DATA lt_ref TYPE TABLE OF REF TO lty_data WITH EMPTY KEY.
" Declaración de una tabla interna que contiene referencias a estructuras lty_data
" Cada línea de la tabla almacenará un puntero a una estructura lty_data


lt_data_dyn = VALUE #(
  ( field1 = 1 field2 = 'aaa' field3 = 'zzz' )
  ( field1 = 2 field2 = 'bbb' field3 = 'yyy' )
  ( field1 = 3 field2 = 'ccc' field3 = 'xxx' )
).
" Inicialización de la tabla interna lt_data_dyn usando VALUE
" Se crean tres registros con valores para field1, field2 y field3


lt_data_dyn2 = lt_data_dyn.
" Copia el contenido de la tabla lt_data_dyn en la tabla lt_data_dyn2
" Las dos tablas tienen la misma estructura, por lo que la asignación es directa

"ITAB
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*" No borrar lo de asingación"
*
*
*" SORT
*
*" Este bloque demuestra ordenación dinámica de tablas internas,
*" utilizando un nombre de campo almacenado en variable para el SORT descendente,
*" y posteriormente un SORT dinámico directo con literal de campo,
*" evidenciando manipulación flexible de criterios de ordenación en tiempo de ejecución.
*
*DATA(lv_field_name) = 'FIELD1'.
*
*SORT lt_data_dyn BY (lv_field_name) DESCENDING.
*out->write( lt_data_dyn ).
*
*SORT lt_data_dyn BY ('FIELD2'). " por defecto la ordenación es ASCENDENTE
*out->write( lt_data_dyn ).
*
*
*


"2.7. READ TABLE dinamico en itab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ej En la estructura ls_read tenemos la clave por la que vamos a filtrar
" reutilización de la tabla lt_data_dym2 creada arriba

" Este bloque demuestra la lectura eficiente de una tabla interna utilizando
" una clave secundaria (SORTK) mediante USING KEY, creando previamente una
" estructura de búsqueda con VALUE, y recuperando el resultado como referencia
" con REFERENCE INTO, aplicando acceso optimizado y desreferenciación (->*)
" en ABAP moderno orientado a rendimiento.


DATA(ls_read) = VALUE lty_data( field2 = 'aaa' ).

READ TABLE lt_data_dyn2 FROM ls_read USING KEY ('SORTK') REFERENCE INTO DATA(lr_read).

out->write( lr_read->* ).

"sólo trae los registros asociados al campo buscado field2 = 'aaaa'

" A continuación Pasamos los componentes de forma dinámica

" Este bloque demuestra la lectura optimizada de una tabla interna mediante
" la clave primaria explícita (PRIMARY_KEY), especificando dinámicamente el
" componente de búsqueda con COMPONENTS, y recuperando el resultado como
" referencia (REFERENCE INTO) para su posterior desreferenciación (->*),
" aplicando acceso eficiente basado en clave en ABAP moderno.

READ TABLE lt_data_dyn2 WITH KEY ('PRIMARY_KEY') COMPONENTS ('FIELD1') = 3 REFERENCE INTO lr_read.
out->write( lr_read->* ).


"a continuación con índice y de forma dinámica using key

" Este bloque demuestra la lectura de una tabla interna utilizando acceso por índice
" combinado con una clave secundaria (SORTK), recuperando el resultado como referencia
" mediante REFERENCE INTO y mostrando el contenido a través de desreferenciación (->*),
" aplicando técnicas de acceso eficiente y manejo de referencias en ABAP moderno.

READ TABLE lt_data_dyn2 INDEX 2 USING KEY ('SORTK') REFERENCE INTO lr_read.
out->write( lr_read->* ).


"2.7. READ TABLE dinamico en itab - expRESIONES DE TABLA
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Este bloque demuestra el uso de la expresión de acceso a tablas internas
" con clave secundaria (SORTK) y acceso por índice mediante la sintaxis
" moderna de tabla con corchetes [ ], recuperando directamente una línea
" tipada sin necesidad de READ TABLE explícito, aplicando acceso eficiente
" y expresivo en ABAP moderno.


DATA(ls_read2) = lt_data_dyn2[ KEY ('SORTK') INDEX 2 ].
out->write( ls_read2 ).

" obtenemos el mismo resultado pero es nuevo

" Ahora colocamos los campos de forma dinámica dentro de los corchetes

" Este bloque demuestra el acceso directo a una tabla interna mediante
" expresión de tabla con especificación dinámica de múltiples componentes
" como criterio de búsqueda, recuperando una línea tipada sin usar READ TABLE,
" aplicando sintaxis moderna y declarativa en ABAP.

DATA(ls_read3) = lt_data_dyn2[ ('FIELD2') = 'bbb' ('FIELD3') = 'yyy' ].
out->write( ls_read3 ).


" Ahora vamos a realizar una especificación explícita de la clave de tabla
" realizar lectura especificando de forma dinámica los nombres de los componentes y la clave secundaria


" Este bloque demuestra el acceso a una tabla interna utilizando una clave
" secundaria explícita (SORTK) junto con un componente específico como
" criterio de búsqueda, aplicando la expresión moderna de tabla con KEY,
" y recuperando directamente la línea tipada sin usar READ TABLE.

DATA(ls_read4) = lt_data_dyn2[ KEY ('SORTK') ('FIELD2') = 'ccc' ].
out->write( ls_read4 ).





  ENDMETHOD.
ENDCLASS.
