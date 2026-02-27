CLASS zcl_mpc_b1_ex04_con DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_mpc_b1_ex04_con IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

**********************************************************************
* OBJETO DE DATOS
* representa una sección reservada en la memoria de dicho programa
* SE DECLARA CON SENTENCIA DATA
* TIPOS DE OBJETOS DE DATOS: variables, constantes y literales

*********************************************************************

**********************************************************************

* 1 VARIABLE
* Contenedor nombrado que almacena un valor que puede cambiar durante la ejecución del programa
* o del objeto donde estemos trabajando
* Esos valores pueden ser numéricos, caracteres, cadenas de texto, estructuras de datos
* tablas internas  etc
* SE TIENEN QUE DECLARAR ANTES DE SU USO
* Pueden tener diferentes tipos de datos STRING, INT, INT4, FLOAT , DECIMAL
**********************************************************************
* 1.1 DECLARACION

*DATA lv_variable TYPE string. "DECLARACION DE VARIABLE TIPO STRING - local variable
*DATA gv_variable TYPE string. "DECLARACION DE VARIABLE TIPO STRING - global variable

*DATA: lv_num1 TYPE i,       " ver abajo asignación valor
    DATA: lv_num1 TYPE i VALUE 10,       " ver abajo asignación valor 1.2.1
          lv_num2 TYPE i,      "RECORDATORIO: no puede haber 2 elementos con el mismo nombre dentro de nuestro programa
          lv_num3 TYPE i.


**********************************************************************
* 1.2 ASIGNACION VALOR
* Dos formas
* 1.2.1 con value en la misma sentencia de la declaración
* 1.2.2 nombre variable = valor
* También se pueden usar para realizar diferentes operaciones

    lv_num2 = 15.  "1.2.2.

    lv_num3 = lv_num1 + lv_num2. " Asignamos una operación de suma a la variable lv_num3


**********************************************************************
* 1.3 IMPRIMIR VALOR de una variable

    out->write( | value 1 = { lv_num1 } value 2 = { lv_num2 } value 3 = { lv_num3 } | ).    "concatenación |CADEna de caracteres| {trarer valor variable}


**********************************************************************

* 2. CONSTANTES

* elementos declarados no modifiables
* vALOR que se asigna una sola vez y no cambia durante la ejecución del programa
* Es un valor fijo que se usa para representar datos que no deben modificarse nunca
* sE puede guardar cualquier tipo de valor: numero , string, fecha, hora, cadena de caracteres etc

**********************************************************************

    CONSTANTS lc_constante TYPE i VALUE 10.

**********************************************************************

    CONSTANTS: lc_num4   TYPE i VALUE 10,
               lc_num5   TYPE i VALUE 20,
               lc_string TYPE string VALUE 'ABAP'. " ej DNI de un cliente

*lc_num4 = 5. " El compilador arroja un error de que no se puede realizar modificación pq es una constante
* Si podemos modificar el valor de las variables


    lv_num2 = lc_num4. " SE LE asigna a esta variable el valor de una constante
    lv_num3 = lc_num5 + 5.  " SE LE asigna a esta variable el valor de una constante + literal

    out->write( | DESPUES DEL CAMBIO: value 1 = { lv_num1 } value 2 = { lv_num2 } value 3 = { lv_num3 } | ).    "concatenación |CADEna de caracteres| {trarer valor variable}


  ENDMETHOD.

ENDCLASS.
