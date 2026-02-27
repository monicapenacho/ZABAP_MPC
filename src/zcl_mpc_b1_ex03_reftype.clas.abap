CLASS zcl_mpc_b1_ex03_reftype DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_b1_ex03_reftype IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.   " iNTERFAZ con método main para poder imprimir cq resultado en consola

**********************************************************************
* Tipos DE REFERENCIA TYPE REF TO
* Uso: declarar variables que almacenan direcciones de memoria de objetos en lugar de los propios objetos
* Una variable de tipo referencia no contiene el valor real de dicho objeto
* sino una referencia o puntero a la ubicación de memoria donde se encuentra nuestro objeto
* uso trabajar con objetos referenciados como clases y estructuras
* pero la referencia de estos objetos pueden ser de objetos de datos o instancias de clases

* DATA  TYPE REF TO - individual
* DATA: TYPE REF TO  - varios

******************
* 1.- referencia de tipos elementales
**********************************************************************

    DATA: lvr_int TYPE REF TO i,      "Variable tipo referencia
          lvr_str TYPE REF TO string.

    lvr_int = NEW #( ).
    lvr_str = NEW #( ).

    out->write( lvr_int ).
    out->write( lvr_str ).




**********************************************************************
* 2.- Referencia de otro tipo ya referenciado

    TYPES: ltyr_int TYPE REF TO i. "Este tipo local referenciado se puede usar en una variable
    DATA lvr_int3 TYPE ltyr_int. "Referencia en un tipo ya existente

**********************************************************************
* 3.- referencia de tablas: tablas internas de referencia

    DATA lt_itab TYPE TABLE OF REF TO /dmo/AIRPORT. "POR ejemplo puede hacer referencia a una bbdd estándar
    "NAVEGAR CON F3 A BBDD PARA observar su estructura
    "campos como airport_id, name, city, country
    "la tabla interna tomará como referencia esa estructura

**********************************************************************
* 4.- referencia de objetos

* Ultima forma para declarar esos tipos de referencia
* Hacer referencia a una clase global
* Uso hacer referencia a objetos de clases
*estos punteros se declaran utilizando el tipo de datos Object Ref
* y se hace la referencia de datos como instancias de clases
* Luego podeos crear la instancia mediante Create Object o mediante el operador de NEW


 DATA lo_ref TYPE REF TO zcl_mpc_b1_ex02_complexty. "HACEMOS referencia a una clase existente en el sistema


  ENDMETHOD.    "Si Establecemos un punto de interrupción en esta linea. Activamos y ejecutamos para que se active el modo debug
ENDCLASS.
