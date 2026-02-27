CLASS zcl_mpc_b1_ex04_objt DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

      INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_mpc_b1_ex04_objt IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

**********************************************************************
* OBJETO DE DATOS
* representa una sección reservada en la memoria de dicho programa
* SE DECLARA CON SENTENCIA DATA
* TIPOS DE OBJETOS DE DATOS: variables, constantes y literales

**********************************************************************

* 1 VARIABLE
* Contenedor nombrado que almacena un valor que puede cambiar durante la ejecución del programa
* o del objeto donde estemos trabajando
* Esos valores pueden ser numéricos, caracteres, cadenas de texto, estructuras de datos
* tablas internas  etc
* SE TIENEN QUE DECLARAR ANTES DE SU USO
* Pueden tener diferentes tipos de datos STRING, INT, INT4, FLOAT , DECIMAL
**********************************************************************

DATA lv_variable TYPE string. "DECLARACION DE VARIABLE TIPO STRING


**********************************************************************

* 2. CONSTANTES

* vALOR que se asigna una sola vez y no cambia durante la ejecución del programa
* Es un valor fijo que se usa para representar datos que no deben modificarse nunca

**********************************************************************

CONSTANTS lc_constante TYPE i VALUE 10.

**********************************************************************

* 3. LITERALES

* Representación directa de un valor en el código fuente del programa
* PUede ser número, cadena de caracteres, fecha etc
* Se escribe directamente en el programa sin necesidad de una variable o constante
* PUeden ser fijos o variables = cambiantes = q se pueden modificar durante la ejecución del programa

**********************************************************************

* Ejemplo número entero: 10.

    out->write(  'ABAP Class - Literal' ).
    out->write( |Student 1| ).

  ENDMETHOD.

ENDCLASS.
