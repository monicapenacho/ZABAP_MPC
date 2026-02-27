CLASS zcl_mpc_b2_ex06_1_tyda DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_b2_ex06_1_tyda IMPLEMENTATION.



  METHOD if_oo_adt_classrun~main.


**********************************************************************
* TIPOS DE DATOS
**********************************************************************
*
*"1 TIPOS PRIMITIVOS
*        "COMPLETOS
*        "INCOMPLETOS
*
*"2 TIPOS DE DATOS COMPLEJOS
*
*"3. ESTRUCTURAS BIDIMENSIONALES
*
*"4. OBJETOS EN EL DICCIONARIO DE DATOS
*
*
**** 1. TIPOS PRIMITIVOS
*
*" TIPOS COMPLETOS E INCOMPLETOS
*" CADA OBJETO DE DATOS TIENE ASOCIADO UN TIPO DE DATOS (COMPLETOS E INCOMPLETOS)
*" DEF OBJETO DE DATOS:
*" son localizaciones de memoria que usamos para almacenar datos
*" mientras el programa se ejecuta
*  " CLASES OBJETO DE DATOS: 2 TIPOS
*  "1.- OBJETOS DE DATOS NO MODIFCALBES
*  "1.1 CONSTANTES
*  "1.2 LITERALES
*  " ver código
*  "2.- OBJETOS DE DATOS MODIFICABLES
*  "Cuando el programa se está ejecutando se puede modificar y leer el contenido de los objetos de datos
*  "Cuando el programa finaliza el sistema libera la memoria para todos los objetos
*  " y su contenido se pierde
*  "2.1 VARIABLES
*  "2.2 ESTRUCTURAS
*  "2.3 TABLAS INTERNAS
*  " NOMENCLATURA RECOMENDADA POR SAP
*
*      " Declaracion TIPOS
*
*      " TYPE
*      " DATA
*
*      " TIPOS GLOBALES: gty_
*      " VARIABLES GLOBALES: gv_
*
*      " TIPOS LOCALES: lty_
*      " VARIABLES LOCALES: lv_
*
*     "---------------------------------------------------------
*    " OBJETOS DE DATOS NO MODIFICABLES
*    "---------------------------------------------------------
*
*    "---------------------------
*    " 1️ CONSTANTES
*    "---------------------------
*
*    CONSTANTS gc_first TYPE c LENGTH 1 VALUE 'X'.
*
*    CONSTANTS gc_pi TYPE decfloat34
*      VALUE '3.141592653589793238462643383279503'.
*
*    out->write( |Constante gc_first: { gc_first }| ).
*    out->write( |Constante gc_pi   : { gc_pi }| ).
*
*    "---------------------------
*    " 2️ LITERALES
*    "---------------------------
*
*    out->write( 'My first program' ).
*    out->write( 'ABAP Tutorial' ).
*
*    "---------------------------------------------------------
*    " OBJETOS DE DATOS MODIFICABLES
*    "---------------------------------------------------------
*
*"---------------------------------------------------------
*    " 1️ VARIABLES
*    "---------------------------------------------------------
*
*    DATA gv_first TYPE c LENGTH 2.      " Variable tipo carácter longitud 2
*    DATA gv_myvar(15) TYPE n.           " Variable numérica texto (15 posiciones)
*    DATA(gv_myvar2) = '20250101'.       " Variable inferida automáticamente
*
*    gv_first  = 'AB'.
*    gv_myvar  = '12345'.
*
*    out->write( |gv_first  : { gv_first }| ).
*    out->write( |gv_myvar  : { gv_myvar }| ).
*    out->write( |gv_myvar2 : { gv_myvar2 }| ).
*
*    "1.1 anterior a versión 7.4
*
*    DATA gv_number TYPE i.   "declaro variable
*    gv_number = 10.          "asignación
*
*    "1.2 posterior a versión 7.4
*
*    DATA(gv_number2) = 10.  "Declaración en linea: declarar variable junto con asignación.
*                            "código más sencillo y fácil de implementar
*
*
*    "---------------------------------------------------------
*    " 2️ TYPES (Definición de estructura tipo)
*    "---------------------------------------------------------
*
*    TYPES:
*      BEGIN OF gty_demo,
*        field1 TYPE c,   " Carácter
*        field2 TYPE f,   " Float
*      END OF gty_demo.
*
*    DATA ls_demo TYPE gty_demo.
*
*    ls_demo-field1 = 'X'.
*    ls_demo-field2 = '3.14'.
*
*    out->write( |field1: { ls_demo-field1 }| ).
*    out->write( |field2: { ls_demo-field2 }| ).
*
*    " 2 TIPOS
*
*    " 2.1 TIPOS COMPLETOS
*    " Tienen una longitud fija definida por el tipo
*
*    " 2.2 TIPOS INCOMPLETOS
*    " No tienen una longitud fija
*    " La longitud se debe especificar junto con la declaración de la variable
*    "       LENGTH - define longitud (palabra reservada)
*    " En números p (empaquetados) además de LENGTH también puede especificarse
*    "       DECIMALS - posiciones de decimales
*    " Si no se indica ABAP por defecto asignará la longitud de un dígito o caracter
*
*    " NOTA si no se especifica el tipo en la declaración de la variable
*    " se tomará como una variable CHAR DE LONGITUD 1
*
*
*
*        "---------------------------------------------------------
*    " TIPOS DE DATOS COMPLETOS EN ABAP
*    "---------------------------------------------------------
*
*    "---------------------------------------------------------
*    " D - Fecha
*    " Longitud fija: 8 caracteres
*    " Formato interno: AAAAMMDD
*    "---------------------------------------------------------
*    DATA gv_fecha TYPE d.
*    gv_fecha = '20250101'.  " 1 Enero 2025
*
*
*    "---------------------------------------------------------
*    " T - Hora
*    " Longitud fija: 6 caracteres
*    " Formato interno: HHMMSS
*    "---------------------------------------------------------
*    DATA gv_hora TYPE t.
*    gv_hora = '153045'.  " 15:30:45
*
*
*    "---------------------------------------------------------
*    " I - Entero (Integer)
*    " Longitud: 4 bytes
*    "---------------------------------------------------------
*    DATA gv_entero TYPE i.
*    gv_entero = 100.
*
*
*    "---------------------------------------------------------
*    " F - Número de punto flotante
*    " Longitud: 8 bytes
*    "---------------------------------------------------------
*    DATA gv_float TYPE f.
*    gv_float = '3.14159'.
*
*
*    "---------------------------------------------------------
*    " DECFLOAT16 - Decimal flotante (16 decimales)
*    " Longitud: 8 bytes
*    "---------------------------------------------------------
*    DATA gv_dec16 TYPE decfloat16.
*    gv_dec16 = '12345.6789'.
*
*
*    "---------------------------------------------------------
*    " DECFLOAT34 - Decimal flotante alta precisión (34 decimales)
*    " Longitud: 16 bytes
*    "---------------------------------------------------------
*    DATA gv_dec34 TYPE decfloat34.
*    gv_dec34 = '3.141592653589793238462643383279503'.
*
*
*    "---------------------------------------------------------
*    " STRING - Cadena dinámica de caracteres
*    " Longitud: Dinámica
*    "---------------------------------------------------------
*    DATA gv_string TYPE string.
*    gv_string = 'ABAP Nivel 9'.
*
*
*    "---------------------------------------------------------
*    " XSTRING - Cadena hexadecimal dinámica (binaria)
*    " Longitud: Dinámica
*    "---------------------------------------------------------
*    DATA gv_xstring TYPE xstring.
*    gv_xstring = 'FF0A1B'.   " Valor hexadecimal
*
*
*    "---------------------------------------------------------
*    " C - Carácter fijo
*    "---------------------------------------------------------
*    DATA gv_char TYPE c LENGTH 5.
*    gv_char = 'ABCDE'.
*
*
*    "---------------------------------------------------------
*    " N - Numérico texto
*    " Solo números (pero almacenado como texto)
*    "---------------------------------------------------------
*    DATA gv_numeric TYPE n LENGTH 6.
*    gv_numeric = '123456'.
*
*    "---------------------------------------------------------
*    " TIPOS INCOMPLETOS EN ABAP
*    " (Necesitan especificar longitud)
*    "---------------------------------------------------------
*
*    "---------------------------------------------------------
*    " C - Cadena de caracteres (Texto fijo)
*    " Rango: 1 a 65535 caracteres
*    "---------------------------------------------------------
*    DATA gv_char TYPE c LENGTH 10.     " Texto fijo de 10 posiciones
*    gv_char = 'ABAP'.
*
*    " Si el texto es más corto, se rellena con espacios
*    " Si es más largo, se corta automáticamente
*
*
*
*    "---------------------------------------------------------
*    " N - Cadena numérica (solo números)
*    " Rango: 1 a 65535 caracteres
*    "---------------------------------------------------------
*    DATA gv_num TYPE n LENGTH 8.       " Numérico tipo texto
*    gv_num = '12345678'.
*
*    " Solo permite dígitos (0-9)
*    " Internamente es texto, NO número matemático
*
*
*
*    "---------------------------------------------------------
*    " X - Cadena hexadecimal (binaria)
*    " Rango: 1 a 65535 bytes
*    "---------------------------------------------------------
*    DATA gv_hex TYPE x LENGTH 4.       " 4 bytes hexadecimales
*    gv_hex = 'A1B2C3D4'.
*
*    " Se usa para datos binarios
*    " Cada byte representa valor hexadecimal
*
*
*
*    "---------------------------------------------------------
*    " P - Número empaquetado (Packed Number)
*    " Rango: 1 a 16 bytes
*    " Ideal para cálculos financieros
*    "---------------------------------------------------------
*    DATA gv_pack TYPE p LENGTH 8 DECIMALS 2.
*    gv_pack = '12345.67'.
*
*    " LENGTH indica bytes
*    " DECIMALS indica posiciones decimales
*    " Muy usado en importes (monedas)
*
*
*    "---------------------------------------------------------
*    " 3️ ESTRUCTURA DIRECTA (DATA BEGIN OF)
*    "---------------------------------------------------------
*
*    DATA:
*      BEGIN OF gty_structure,
*        field1 TYPE c LENGTH 2,
*        field2 TYPE d,
*      END OF gty_structure.
*
*    gty_structure-field1 = 'AA'.
*    gty_structure-field2 = sy-datum.
*
*    out->write( |Estructura field1: { gty_structure-field1 }| ).
*    out->write( |Estructura field2: { gty_structure-field2 }| ).
*
*
*
*    "---------------------------------------------------------
*    " 4️ TABLA INTERNA
*    "---------------------------------------------------------
*
*    DATA gt_demo TYPE STANDARD TABLE OF gty_demo
*                 WITH EMPTY KEY.
*
*    APPEND ls_demo TO gt_demo.
*
*    out->write( data = gt_demo name = 'Tabla Interna GT_DEMO' ).


  ENDMETHOD.
ENDCLASS.
