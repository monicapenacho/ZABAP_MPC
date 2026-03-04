CLASS zcl_mpc_b5_ex10_1_expcons_new DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.



    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_b5_ex10_1_expcons_new IMPLEMENTATION.




  METHOD if_oo_adt_classrun~main.

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
*" creado el objeto le asignamos NEW (dentro de lo paréntesisi podemos especificar un tipo de dato
" no genéricos
*" ->* = selector de componente de objeto (apuntar a un atributo de una clase,
" introducir un método independiente
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
*      "new 1 en dEFINITION
* *    "new 1
*    "Este bloque demuestra la definición de una clase final pública con atributos de instancia
*lv_name y lv_age,
*    "así como la declaración explícita de un constructor con parámetros IMPORTING tipados,
*    "estableciendo el contrato de inicialización del objeto en el momento de su creación.
*    DATA: lv_name TYPE string,
*          lv_age  TYPE i.
*
*    METHODS: constructor IMPORTING iv_name TYPE string
*                                    iv_age  TYPE i.

*  METHOD constructor.

*      "NEW 2 EN IMPLANTACION
**     "Este bloque demuestra la implementación del método constructor de una clase,
** "donde se realiza la asignación de los parámetros de entrada (iv_age, iv_name)
** "a los atributos de instancia (lv_age, lv_name),
** "estableciendo el estado inicial del objeto en el momento de su creación.
**
**"new 2
**
**    lv_age  = iv_age.
**    lv_name = iv_name.
*
*  ENDMETHOD.

*"NEW 3
*" Ej COMO en este ejemplo vamos a hacer una instanciación de una clase tenemos que
" pasar detrás de NEW el tipo de la clase
*" lo_employee almacena la referencia al nuevo objeto
*" en el mismo programa damos valor al parámetro de importación y luego lo traemos
" con el nombre de la variable haciendo
*" referencia al objeto que hemos creado
*
*"Este bloque demuestra la instanciación de un objeto mediante la
*"expresión constructora NEW invocando el constructor parametrizado de la clase zcl_12_expcons,
*"utilizando asignación nombrada de parámetros (iv_age, iv_name) y accediendo posteriormente a lo
*"s atributos públicos del objeto a través del operador de referencia (->)
" para mostrar su estado en consola.
*
*    DATA(lo_employee) = NEW zcl_mpc_b5_ex10_1_expcons_new( iv_age  = 22
*                                                          iv_name = 'Laura' ).
*
*    out->write( lo_employee->lv_age ).
*    out->write( lo_employee->lv_name ).

  ENDMETHOD.

ENDCLASS.
