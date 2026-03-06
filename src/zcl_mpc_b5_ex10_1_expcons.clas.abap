CLASS zcl_mpc_b5_ex10_1_expcons DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_b5_ex10_1_expcons IMPLEMENTATION.



  METHOD if_oo_adt_classrun~main.

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " BLOQUE V - 1 CONSTRUCTOR
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  "1.1 CONCEPTO CONSTRUCTOR
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  "Es una función que permite crear instancias de objetos, estructuras,
  "y otros valores de manera más concisa y directa en el código.
  "Estas expresiones se utilizan para inicializar datos de forma clara y compacta.
  " Se usan para inicializar estructuras, TI, objetos y referencias de una form amás concisa
  " AYUDAN A SIMPLIFICAR Y ESCRIBIR CODIGO MAS LIMPIO Y EFICIENTE


  "Conceptos Expresiones Constructor

"VALUE

"Inicialización de Estructuras y Tablas
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"DATA(ls_person) = VALUE ty_person( name = 'John Doe' age = 30 ).

"creamos la estructura con declaración en linea. La inizializamos con valores. con value
" hay que pasarle la autoreferencia = # (si se ha declarado previamente)
" o el tipo explícito (si estamos haciendo una declaración en linea)
" en los () colocamos los valores de los componentes o parámetros para poderlos inicializar en este proceso
" si no colocamos nada en los parámetros el valor de retorno será un valor inicial dependiendo del tipo
"que tengamos asignado

" "Manipulación de Datos
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"ls_person = VALUE #( BASE ls_person name = 'Jane Doe' ).

"modificar estructyuras complejos o crear valores nuevos basados en datos ya existentes en nuestro código en el mismo contexto


"Conceptos Expresiones Constructor

"CORRESPONDING

"Asignación entre Estructuras y Tablas Internas

"DATA(ls_person_copy) = CORRESPONDING #( ls_person ).

"facilita la transferencia de valores entre estructuras con campos similares
" eliminando la necesidad de copiar campo por campo
" se basa en la correspondencia de los nombres de campos
" Muy util para copiar datos entre TI o estructuras cuando los nombres coinciden o se requieren mapear campos específicos

"Conceptos Expresiones Constructor

"NEW

"Creación de Objetos

"DATA(lo_person) = NEW cl_person( name = 'John Doe' age = 30 ).

" usamos new para instanciar objetos de clases ABAP de forma directa pasando los valores iniciales en el constructor
" usamos un tipo de clase que existe en el sistema cl_person para poder inicializar los valores


"Conceptos Expresiones Constructor

"REF

" referencias

" Permite crear referencias a estructuras, objetos o tablas sin necesidad de multiples pasos

"Ejemplo 1: Referencia a una estructura

*DATA(ls_person) = VALUE string( 'John Doe' ).
*DATA(lr_person) = REF #( ls_person ).
*
*out->write( lr_person->* ).
*
*
*"Ejemplo 2: Referencia a una estructura compleja
*
*TYPES: BEGIN OF ty_person,
*         name TYPE string,
*         age  TYPE i,
*       END OF ty_person.
*
*DATA(ls_person2) = VALUE ty_person( name = 'Jane Doe' age = 30 ).
*DATA(lr_person2) = REF #( ls_person2 ).
*
*out->write( lr_person2->name ).
*
*
*"Ejemplo 3: Referencia a una tabla interna
*
*DATA(lt_numbers) = VALUE TABLE OF i( ( 1 ) ( 2 ) ( 3 ) ).
*DATA(lr_table)   = REF #( lt_numbers ).
*
*out->write( lines( lr_table->* ) ).

"Conceptos Expresiones Constructor

"BENEFICIOS

"Legibilidad: Al hacer el código más directo y fácil de entender, se reduce la complejidad de las operaciones de inicialización y transformación de datos, facilitando su mantenimiento.

"Concisión: Reducen la cantidad de líneas de código necesarias, lo que elimina la redundancia y hace que el código sea más limpio y claro.

"Eficiencia: Al combinar varias operaciones en una sola expresión, se mejora el rendimiento del código y se disminuye el riesgo de errores, ya que se realiza menos manipulación manual de datos.


"Conceptos Expresiones Constructor

"¿Qué es la inicialización compacta?

"Consiste en asignar valores a una variable u objeto de forma directa y concisa en el momento de su declaración o utilización, en lugar de hacerlo en múltiples pasos. Esto se logra utilizando expresiones de constructor.

"Son útiles cuando se necesita organizar datos de forma jerárquica o compleja. Con las expresiones de constructor, se pueden inicializar estas estructuras anidadas en una única instrucción,
" lo que facilita la manipulación de datos complejos y mejora la claridad del código.


"1.2. VALUE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*"Conceptos Expresiones Constructor
*
*"VALUE
*
*"Inicialización de Estructuras y Tablas
*
*"VALUE some_type( ... ) ...
*
*"Manipulación de Datos
*
*"VALUE #( ... ) ...
*
*"VALUE
*
*"Se utiliza principalmente para inicializar estructuras, tablas o variables
*" con valores específicos de manera compacta y eficiente.
*
*"SIMPLifica la asignación de valores e inicialización de las variables en una sola linea
*"reduce la legibilidad y código repetitivo
*
*"también es útil con estructuras profundas
*"Una estructura profunda es una estructura que contiene, además de campos simples (como enteros o caracteres),
*"otros campos que pueden ser tablas internas o estructuras anidadas.
*"Esto permite crear estructuras jerárquicas y complejas.
*
*" ej1 declaración en linea de una ti - le pasamos un tipo elemental equivale a tabla estándar (como es string incluir valores literales, variables etc)
*" cadena de caracteres ...
*" OJO COMILLAS especiales
*
*"Este bloque demuestra la inicialización compacta de una tabla interna de tipo string_table utilizando la expresión constructora VALUE, creando múltiples entradas en una sola instrucción y mostrando posteriormente su contenido en consola.
*
*DATA(lt_msg) = VALUE string_table( ( `Welcome` ) ( `Student` ) ).
*
*out->write( data = lt_msg name = 'lt_msg' ).
*
*" ej 2 pasamos el VALUE vacío (con autoreferencia ya que el tipo se había definido anteriormente ver declaración en linea
*" vacía el contenido de la TI o de la estructura
*
*"Este bloque demuestra la reinicialización compacta de la tabla interna lt_msg utilizando la expresión constructora VALUE con inferencia de tipo (#), dejando la tabla vacía (sin registros) y mostrando posteriormente su estado en consola.
*
*lt_msg = VALUE #( ).
*
*out->write( data = lt_msg name = 'lt_msg' ).
*
*
*"ej 3 estructura anidada
*
*"nested structure
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*"Este bloque demuestra la declaración de una estructura profunda (nested structure) con una subestructura anidada y
*"su posterior inicialización compacta mediante la expresión constructora VALUE,
*"asignando valores tanto al campo simple emp_name como a los
*" componentes internos de address en una única instrucción, y mostrando el resultado en consola.
*
*DATA: BEGIN OF ls_emp_data,
*        emp_name TYPE /dmo/first_name,
*        BEGIN OF address,
*          street TYPE /dmo/street,
*          number TYPE i,
*        END OF address,
*      END OF ls_emp_data.
*
*ls_emp_data = VALUE #( emp_name = 'Laura'
*                       address = VALUE #( street = 'Street CA' number = 22 ) ).
*
*out->write( data = ls_emp_data name = 'ls_emp_data' ).


"1.3. CORRESPONDING / BASE / MAPPING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" CORRESPONDING  transferir valores entre estructuras o TI basándose en la correspondencia de los nombres de los campos
*" CORRESPONDING - MAPPING en caso de que no tuvieran los campos el mismo nombre, corresponding permite mapear los nombres de los campos
*" de una estructura o TI a otra con el añadido de MAPPING
*
*" EJ 1 copiar la info de lt_employee a lt_person
*" 2 TIPOS LOCALES Y DECLARAMOS 2 TI locales con dichos tipos
*" con value (incluimos los valores - si quieremos muchos podemos usar FOR por ej
*
*"Este bloque demuestra la definición de dos tipos de estructuras compatibles (lty_employee y lty_person),
*"la declaración de sus respectivas tablas internas tipadas y la inicialización compacta de lt_employee
*"mediante la expresión constructora VALUE, preparando el escenario para una posterior asignación estructural
*"mediante CORRESPONDING basada en nombres de campos.
*
*
*
*TYPES: BEGIN OF lty_employee,
*         emp_name TYPE string,
*         emp_age  TYPE i,
*       END OF lty_employee.
*
*TYPES: BEGIN OF lty_person,
*         name TYPE string,
*         age  TYPE i,
*       END OF lty_person.
*
*DATA: lt_employee TYPE TABLE OF lty_employee,
*      lt_person   TYPE TABLE OF lty_person,
*      lt_client   TYPE TABLE OF lty_person.
*
*lt_employee = VALUE #( ( emp_name = 'John King'
*                         emp_age  = 30 ) ).
*
*out->write( data = lt_employee name = 'lt_employee' ).
*
*"si coinciden los nombres de los campos
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
**
**"Este bloque demuestra el uso de la expresión constructora CORRESPONDING con inferencia de tipo (#)
*" para realizar una asignación estructural entre tablas internas compatibles,
*"copiando automáticamente los campos que coinciden por nombre desde lt_employee
*" hacia lt_person en una única instrucción compacta.
**
**lt_person = CORRESPONDING #( lt_employee ).
**out->write( data = lt_person name = 'lt_person' ).
*
* "con BASE no machacamos si no que añadimos los nuevos registros de la otra tabla a los existentes
* "Este bloque demuestra la combinación de las expresiones constructoras VALUE y CORRESPONDING con la cláusula BASE,
*"permitiendo inicializar una tabla interna con un registro propio y posteriormente ampliarla conservando
*"sus datos originales mientras se incorporan los registros de lt_person en una única operación declarativa y compacta.
*
*lt_client = VALUE #( ( name = 'María Lopez'
*                       age  = 52 ) ).
*
*lt_client = CORRESPONDING #( BASE ( lt_client ) lt_person ).
*
*out->write( data = lt_client name = 'lt_client' ).
*
*
*"si no coinciden los nombres de los campos
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" si no hacemos mapping no se produce la transferencia de los datos
*
*"Este bloque demuestra el uso avanzado de la expresión constructora CORRESPONDING con la cláusula MAPPING,
*" permitiendo realizar una asignación estructural entre tablas internas con nombres de campos diferentes,
*" mapeando explícitamente emp_name → name y emp_age → age en una única instrucción declarativa y compacta.
*
*lt_person = CORRESPONDING #( lt_employee MAPPING name = emp_name
*                                                     age  = emp_age ).
*
*out->write( data = lt_person name = 'lt_person' ).

" 1.4. EXCEPT / DUPLICATES (DISCARDING DUPLICATES)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" EXCEPT - EXCLUIR determinados campos en la copia de una TI a otra
*
*"Este bloque demuestra el uso avanzado de la expresión constructora CORRESPONDING con la cláusula EXCEPT, permitiendo realizar una asignación estructural entre tablas internas excluyendo explícitamente el campo age del mapeo automático, y mostrando post
"e
*"riormente el resultado en consola.
*
*lt_person = CORRESPONDING #( lt_client EXCEPT age ).
*
*out->write( data = lt_person name = 'lt_person' ).
*
*"DISCARDING DUPLICATES
*" descartar duplicados - control lineas duplicadas
*" WITH EMPTY KEY - puede tener registros repetidos
*" WITH UNIQUE KEY XXX - no puede tener registros repetidos
*
*"Este bloque demuestra la definición de dos tablas internas con distinto comportamiento de clave (una estándar con EMPTY KEY y otra SORTED con clave única por name), junto con la inicialización compacta de lt_itab1 mediante VALUE incluyendo registros du
"p
*"licados para preparar un escenario de eliminación automática de duplicados al insertarlos en una tabla con UNIQUE KEY.
*
*DATA: lt_itab1 TYPE TABLE OF lty_person WITH EMPTY KEY,
*      lt_itab2 TYPE SORTED TABLE OF lty_person WITH UNIQUE KEY name.
*
*lt_itab1 = VALUE #( ( name = 'Maria' age = 22 )
*                    ( name = 'Maria' age = 25 )
*                    ( name = 'Maria' age = 22 )
*                    ( name = 'Carmen' age = 45 ) ).
*
**"Este bloque demuestra el uso de la expresión constructora CORRESPONDING para transferir registros desde una tabla estándar
**" con posibles duplicados hacia una tabla SORTED con UNIQUE KEY, provocando la eliminación implícita de duplicados basada
**"en la clave name y mostrando posteriormente el resultado en consola.
**
**lt_itab2 = CORRESPONDING #( lt_itab1 ).
**
**out->write( data = lt_itab2 name = 'lt_itab2' ). " ERROR DUMP DE PROGRAMACION POR REGISTROS DUPLICADOS lt_itab2 tiene clave primaria unica
*
*"Este bloque demuestra el uso avanzado de la expresión constructora CORRESPONDING con la cláusula DISCARDING DUPLICATES,
*"permitiendo transferir registros desde una tabla interna origen hacia una tabla destino eliminando explícitamente los duplicados segú
*"n la clave definida en la tabla objetivo, y mostrando posteriormente el resultado en consola.
*
*lt_itab2 = CORRESPONDING #( lt_itab1 DISCARDING DUPLICATES ).
*
*out->write( data = lt_itab2 name = 'lt_itab2' ).
*
*" ojo pérdida de registros pues se eliminan para evitar duplicados por nombre

" 1.5. NEW
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*"NEW
*
*"Se utiliza para crear instancias de clases y estructuras de manera más compacta y legible.
*"Con NEW, puedes instanciar un objeto o estructura directamente al asignarlo a una variable,
*"sin necesidad de declarar el tipo explícitamente si ya está implícito.
*" resultado = variable de referencia que apunta al objeto creado
*
*" en este ejercicio hacemos referencia a un tipo primitivo
*" creado el objeto le asignamos NEW (dentro de lo paréntesisi podemos especificar un tipo de dato no genéricos
*" ->* = selector de componente de objeto (apuntar a un atributo de una clase, introducir un método independiente
*" introducir método funcional)"
*
*"Este bloque demuestra el uso de la expresión constructora NEW para crear referencias tipadas de forma compacta,
*"tanto a un tipo elemental (TYPE REF TO i) mediante inferencia de tipo (#)
*"como a un objeto string directamente instanciado, evidenciando la creación inline de datos referenciados
*"y su posterior visualización en consola.
*
**DATA lo_data TYPE REF TO i.
**
**lo_data = NEW #( 12345 ).
**
**out->write( lo_data ).
**
**DATA(lo_data2) = NEW string( 'Logali' ).
**
**out->write( lo_data2 ).
*
*"ej 2
*"crear en la sección pública 2 variables y un método constructor
*" con dos parámetros de importación
*"implementamos el m´todo constructor (igualamos los parámetros a cada variable respectiva)
*
" VER zcl_mpc_b5_ex10_2_expcons_new

"1.5. NEW
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"new 3
    DATA(lo_employee) = NEW zcl_mpc_b5_ex10_2_expcons_new( iv_age  = 22
                                                          iv_name = 'Laura' ).

    out->write( lo_employee->lv_age ).
    out->write( lo_employee->lv_name ).

"1.6. CONV
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
**La expresión CONV se utiliza para realizar conversiones explícitas entre
**tipos de datos. Es útil cuando es necesario convertir valores entre tipos no
**compatibles de manera directa. Conversión tiene que ser controlada
*
**Sintaxis Básica de CONV
**CONV <tipo_destino>( valor ).
**• <tipo_destino>: El tipo de dato al que se quiere convertir el valor.
**• valor: El valor que se va a convertir.
*
**DATA: text TYPE string,
**      num  TYPE i.
**num = 100.
**text = CONV string( num ).
**out->write( text ).
*
*" ej convertimos de un número entero a una cadena de caracteres
*"Este bloque demuestra el uso de la expresión constructora CONV para realizar una conversión explícita de tipo en ABAP moderno, transformando un valor entero (i) a tipo string de forma segura y declarativa, y mostrando posteriormente el resultado en con
"s
*"ola.
*
*DATA: lv_int    TYPE i VALUE 123,
*      lv_string TYPE string.
*
*lv_string = CONV string( lv_int ). "poner un breakpoint para ver que lv_string sige siendo string
*
*out->write( lv_string ).
*
*" ej conversión de datos aplicado a TI
*" 1.- DECLARAMOS TIPO
*" 2.- DECLARAMOS VAR DE TI - OCUPA MEMORIA
*" 3.- LE DAMOS VALOR
*" 4.- NUEVA TABLA CON CONV le pasamos el tipo de lt_type
*
*"Este bloque demuestra el uso de la expresión constructora CONV para convertir
*"una tabla interna de tipo SORTED TABLE con clave por defecto a
*"un tipo de tabla estándar definido explícitamente (lt_type),
*"realizando una conversión estructural completa de
*"la tabla origen y mostrando posteriormente el resultado en consola.
*
*TYPES lt_type TYPE TABLE OF i WITH EMPTY KEY.
*
*DATA lt_itab TYPE SORTED TABLE OF i WITH NON-UNIQUE DEFAULT KEY.
*
*lt_itab = VALUE #( ( 1 ) ( 2 ) ( 3 ) ).
*
*DATA(lt_conv) = CONV lt_type( lt_itab ).
*
*out->write( lt_conv ).
*
*"Poner breakpoint. hemos pasado de una tabla sort a una tabla stardard con CONV lt_type

"1.7. EXACT
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"EXACT

"Verifica que un valor coincida exactamente con un tipo de datos,
"sin permitir conversiones implícitas y lanzando una excepción si no coincide.
" capturar  la excepción con TRY CATCH CX_SY_conversion_error ENDTRY en una variable (por ej lv_error)

"asegura que la conversión sea 100% precisa y no haya pérdida de datos
"(ej convertir int7 en int2 -> excepción)

" ej convertir un nº entero a un entero de 2 digitos
"var a la que asignamos el nuevo valor = EXACT tipo al que convertimos(variable a la que vamos a convertir)


"Este bloque demuestra el uso de la expresión EXACT para realizar una
"conversión estricta entre tipos numéricos, forzando que el valor entero
"coincida exactamente con el tipo destino (int2), encapsulando la operación
"dentro de un bloque TRY-CATCH para capturar la excepción cx_sy_conversion_error
"en caso de desbordamiento o incompatibilidad de rango.

"CONVERSION OK

*DATA: lv_int_value  TYPE i VALUE 32767,
*      lv_int2_value TYPE int2.
*
*TRY.
*
*    lv_int2_value = EXACT int2( lv_int_value ).
*
*    out->write( data = lv_int2_value name = 'Converted value:' ). "punto de interrupción
*
*  CATCH cx_sy_conversion_error INTO DATA(lx_error).
*
*    out->write( data = lx_error->get_longtext( ) name = 'Error' ).
*
*ENDTRY.

"EXCEPCION
*DATA: lv_int_value  TYPE i VALUE 327674154,
*      lv_int2_value TYPE int2.
*
*TRY.
*
*    lv_int2_value = EXACT int2( lv_int_value ).
*
*    out->write( data = lv_int2_value name = 'Converted value:' ).
*
*  CATCH cx_sy_conversion_error INTO DATA(lx_error).
*
*    out->write( data = lx_error->get_longtext( ) name = 'Error' ).
*
*ENDTRY.

"EXACT CARACTER A NUMERO

"Este bloque demuestra el uso de la expresión EXACT para convertir un valor de tipo string a entero (TYPE i),
"validando estrictamente que el contenido textual sea numéricamente compatible con el tipo destino,
"y gestionando mediante TRY-CATCH la posible excepción cx_sy_conversion_error
" en caso de formato inválido o conversión no permitida.

*DATA: lv_text_value TYPE string VALUE '123.45',
*      lv_int_value3 TYPE i.
*
*TRY.
*
*    lv_int_value3 = EXACT i( lv_text_value ).
*
*    out->write( data = lv_int_value3 name = 'Converted value:' ).
*
*  CATCH cx_sy_conversion_error INTO DATA(lx_error2).
*
*    out->write( data = lx_error2->get_text( ) name = 'Error' ).
*
*ENDTRY.

"QUITAMOS DECIMALES .45 porque es CONVERSION A NUMERO ENTERO Y POR TANTO 123.45 DA ERROR

*DATA: lv_text_value TYPE string VALUE '123',
*      lv_int_value3 TYPE i.
*
*TRY.
*
*    lv_int_value3 = EXACT i( lv_text_value ).
*
*    out->write( data = lv_int_value3 name = 'Converted value:' ).
*
*  CATCH cx_sy_conversion_error INTO DATA(lx_error2).
*
*    out->write( data = lx_error2->get_text( ) name = 'Error' ).
*
*ENDTRY.


"1.8. Expresión REF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"La expresión REF permite crear una referencia a un valor o un objeto de
"datos. Devuelve una referencia que puede ser utilizada para acceder a los
"datos de forma indirecta.

"Sintaxis Básica de REF
"REF #( <valor> ).


"Ejemplo de Uso

*DATA: num   TYPE i,
*      ref_num TYPE REF TO i.
*num = 100.
*ref_num = REF #( num ). " Crear una referencia al valor de num
*WRITE: / ref_num->*. " Acceder al valor referenciado ¡OJO VERSION!

"En este ejemplo, REF crea una referencia a la variable num, y se accede a su
*"valor a través del puntero.

"REF

"Crea referencias a objetos o estructuras,
"evitando la copia de datos y mejorando la eficiencia en memoria y rendimiento.
" Permite manipular datos sin necesidad de copiarlos (ahorro memoria y mejora rendimiento)

" ESTRUCTURA
" DATA(ref_name) = REF TO data_type object_type( data_or_object ).

" REF_NAME nombre de la variable que almacena la referencia
" oBJEC_TYPE tipo de objeto o datos al que la ref apuntará
" DATA_OR_OBJECT área de datos o el objeto al que se va a referenciar

"Características:

"Creación de Referencias: Permite crear una referencia a un objeto existente, sin duplicarlo.

"Tipos de Datos: Funciona tanto con tipos de datos básicos como complejos (estructuras, tablas internas).

"Uso en Asignaciones: Se utiliza comúnmente para asignar referencias en variables y
"pasar datos por referencia a funciones o métodos.

"Memoria Compartida: Al trabajar con referencias, se accede directamente al mismo bloque de memoria,
"lo que evita copias innecesarias.


" diferencia con GET REFERENCE
" evita la declaración de variables auxiliares


" REF REFERENCIA A UNA (VARIABLE). USAMOS TIPOS PRIMITIVOS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*"Este bloque demuestra el uso de la expresión constructora REF para crear una referencia tipada (TYPE REF TO i)
*"a una variable existente, evidenciando que no se realiza copia del dato sino que ambas expresiones
*"comparten la misma dirección de memoria, accediendo al valor mediante el operador de desreferenciación (->*).
*
*DATA: lv_int_value TYPE i VALUE 100,
*      lv_ref_int   TYPE REF TO i.
*
*lv_ref_int = REF #( lv_int_value ). "obtenemos una referencia a la variable que está dentro del ()
*
*"uSAMOS autoreferencia # porque ya hemos indicado el tipo anteriormente
*
*out->write( data = lv_int_value name = 'Original value' ).
*out->write( data = lv_ref_int->* name = 'Value through reference' ). "(*)
*
*"(*) accedemos al valor de lv_int_value a través de la refeferenia


" ITAB REFERENCIA A TABLAS INTERNAS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"Este bloque demuestra la inicialización compacta de una tabla interna tipada con /dmo/flight
*"mediante la expresión constructora VALUE,
*"creando múltiples registros en una sola instrucción, y posteriormente el uso de la expresión
*" REF para obtener una referencia
*"a una línea específica por índice (posición 2),
*"accediendo a su contenido mediante desreferenciación (->*) para mostrarlo en consola.
*
*    DATA lt_flight TYPE TABLE OF /dmo/flight WITH EMPTY KEY.
*
*    lt_flight = VALUE #(
*      ( client         = 100
*        carrier_id     = 'CO'
*        connection_id  = 1101
*        currency_code  = 'COP'
*        flight_date    = cl_abap_context_info=>get_system_date( )
*        plane_type_id  = 'AF-1234'
*        price          = 200
*        seats_max      = 100
*        seats_occupied = 20 )
*
*      ( client         = 100
*        carrier_id     = 'MX'
*        connection_id  = 1102
*        currency_code  = 'MXN'
*        flight_date    = cl_abap_context_info=>get_system_date( )
*        plane_type_id  = 'XX-1234'
*        price          = 400
*        seats_max      = 60
*        seats_occupied = 50 )
*
*      ( client         = 100
*        carrier_id     = 'PE'
*        connection_id  = 1103
*        currency_code  = 'USD'
*        flight_date    = cl_abap_context_info=>get_system_date( )
*        plane_type_id  = 'PE-1234'
*        price          = 150
*        seats_max      = 80
*        seats_occupied = 20 )
*       ).
*
*    DATA(lr_flight) = REF #( lt_flight[ 2 ] ).
*
*    out->write( data = lr_flight name = 'Reference Index 2 of ITAB lt_flight sin operador de navegación' ).
*    out->write( data = lr_flight->* name = 'Reference Index 2 of ITAB lt_flight' ). " no es necesario operador de navegación
*
*"Apuntar a un registro que no exista - incluir OPTIONAL (evitar DUMP o error de programación) y apuntar a un registro vacío
*
*    DATA(lr_flight2) = REF #( lt_flight[ 6 ] OPTIONAL ).
*
*    out->write( data = lr_flight2 name = 'Reference Index 6 of ITAB lt_flight sin operador de navegaciñon' ).

" REF Referencias a objeto (apuntamos a ese espacio de memoria)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*"Este bloque demuestra la creación de una instancia de clase mediante la expresión constructora NEW,
*"almacenando la referencia del objeto en lor_emp1, y posteriormente el uso de la expresión REF
*"para crear una segunda referencia (lor_emp2) que apunta al mismo objeto en memoria,
*"evidenciando el concepto de referencias compartidas y visualizando el contenido del objeto en consola.
*
*DATA(lor_emp1) = NEW zcl_mpc_b5_ex10_2_expcons_new( iv_age = 22 iv_name = 'Sol' ).
*
*DATA(lor_emp2) = REF #( lor_emp1 ).
*
*out->write( data = lor_emp2 name = 'Object Reference' ).


"1.9. CAST
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Convierte tipos de datos de forma explícita, garantizando una conversión correcta
" según las reglas del lenguaje.

"Down Casting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Convierte una referencia de un tipo general (clase base)
"a un tipo más específico (subclase) para acceder a métodos y atributos específicos de la subclase.

"sintaxis
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DATA(new_ref) = CAST target_type( source ).

" new_ref = donde guardamos la operación con CAST
" source = objeto o valor que estamos convirtiendo
" es posible encadenamiento de métodos

"Este bloque demuestra el uso de la expresión CAST para realizar un down casting desde una referencia genérica (TYPE REF TO data)
"a un tipo estructurado concreto (t_struc), permitiendo acceder tanto al contenido completo mediante desreferenciación (->*)
"como a sus componentes individuales (col1, col2), evidenciando conversión explícita de tipo en tiempo de ejecución.

TYPES: BEGIN OF t_struc,
         col1 TYPE i,
         col2 TYPE i,
       END OF t_struc.

DATA lr_data TYPE REF TO data.
DATA ls_int  TYPE t_struc.

lr_data = NEW t_struc( ).

ls_int = CAST t_struc( lr_data )->*.
ls_int-col1 = CAST t_struc( lr_data )->col1.
ls_int-col2 = CAST t_struc( lr_data )->col2.

out->write( data = ls_int name = 'ls_int' ).
out->write( data = ls_int-col1 name = 'ls_int-col1' ).
out->write( data = ls_int-col2 name = 'ls_int-col2' ).

"otra forma de asignar

"Este bloque demuestra una asignación directa mediante down casting,
"utilizando la expresión CAST para convertir una referencia genérica (lr_data)
"al tipo estructurado concreto t_struc y desreferenciando inmediatamente (->*)
"para transferir el contenido completo a la estructura ls_int en una sola instrucción.

CAST t_struc( lr_data )->* = ls_int.

out->write( data = ls_int name = 'ls_int' ).



 ENDMETHOD.

ENDCLASS.
