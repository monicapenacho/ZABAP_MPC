CLASS zcl_mpc_b2_ex07_1_texto DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_b2_ex07_1_texto IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " ELEMENTO TEXTO
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  "1.- TRADUCCION INTERNA:🔹 La conversión automática que hace el sistema entre el formato interno y el formato externo de un dato. EJ FORMATO DECIMAL

  "2.- TRADUCCION DEPENDIENTE DEL IDIOMA
  "TEXTOS SE CREAN EN LENGUAJE ORIGINAL (INGLES POR EJ)
  "HAY QUE TRADUCIRSE AL TEXTO DEL IDIOMA DE INGRESO DEL  USUARIO FINAL

  "3.- VALOES LITERALES: texto dentro de código fuente. En todos los idiomas aparece el = texto. Sin traducciones
*
*  out->write( 'Welcome ABAP Student').
*  out->write( 'This is your text symbol').

  "4.- lo ideal es usar SIMBOLOS DE TEXTO

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " 3.2 SIMBOLOS DE TEXTO O TEXT SYMBOLs - dentro de la clase global
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   " eLEMENTOS para gestionar y mostrar texto en los programas de forma dinámica
   " permiten múltiples idiomas (internalización y localización de app)
   " mantenimiento centralizado de los texto (en un único lugar y Reutilizables
   " cod más limpio y facil de leer
   " almacenan en el grupo de texto de las clases globales
   " Situarnos encima de la clase global y ponemos clic derecho Open Others Text Elements
   "@MaxLenght: 30  máxima longtud. Identificador 3 caracteres alfanuméricos por eje 001. sin espaciosossss

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   " aplicación simbolos de texto ctrl espacio
     out->write( text-001 ).
     out->write( text-msg ).
     out->write( 'This is your text symbol'(msg) )."Si msg no existe muestra el literal escrito antes del (). Deben coincidir

    "nota los identificadores sólo son visibles dentro del código de la clase global en la que estamos trabajando

    " borrar datos en editor de texto. Si nos posicionamos en primer id + fn f2 no hay info disponible del código
    "

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " 3.2 SIMBOLOS DE TEXTO O TEXT SYMBOLs - dentro del código fuente
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " nos posicionamos encima y botón derecho y quick fix -> length automatico y lo coloca en editor de texto de forma automatica

     out->write( text-002 ).
     out->write( text-ms2 ). " imprime el id no el texto original
     out->write( 'This is yur first text symbol_EDIT'(ms2) )." imprime el id no el texto original (lo está omitiendo)

    " si nos ponemos encima del id y con CTRL +1 podemos borrar el contenido, editar el contenido
    " convertirlo en text-ms2 o añadir el valor literal del id
    "
  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " 3.3 FUNCIONES PARA CADENAS DE CARACTERES
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   "1.- Funciones de descripción - NUM OF CHARS, NUM OF CHR, NUM OF CHARACTERS
     "ayudan a analizar el contenido de una cadena de caracteres devolviendo un número como resultado
   "eje conteo caracteres, nº posiciones, pos donde tenemos un patrón.

   "2.-Funciones de reemplazo - REPLACE, REPLACE REGEX, REPLACE ALL, REPLACE ALL OCURRENCES
   " SE evalua una cadena de car y busca un patrón y luego lo reemplaza

   "3.- Funciones de predicado -  CONTAINS
    "Devuelven un valor de verdadero. Se usa como expresión lógica
    " SE PUEDE incluir en un IF para evaluar si algún patrón


*   "2.- Funciones de búsqueda - FIND, FIND REGEX, FIND FIRST, FIND_ALL
*
*
*   "4.-Funciones de partición - SPLIT, SPLIT AT POSITION, SPLIT AT REGEX
*   "5.-Funciones de concatenación - CONCATE_WITH_SPACE, CONCATE_WITH

     """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " 3.4 PARAMETROS ej FIND( val = ... sub = ...)
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  "parámetros más comunes que se encuentran en las funciones
  " fc find búsqueda ctrl espacio salen parametors


    DATA lv_text TYPE string VALUE 'MONI'.

    DATA(lv_string1) = find( val = lv_text  sub = 'MI' ).

    DATA(lv_string3) = find(
      val  = lv_text
      sub  = 'GA'
      case = abap_true
      occ  = 2
      off  = 2
      len = 1
    ).

    " val
    " Texto principal donde se realiza la búsqueda
*    DATA(lv_pos) = find( val = 'MONI' ).

    " sub
    " Subcadena que se quiere localizar dentro del texto principal
    DATA(lv_pos2) = find( val = 'MONI' sub = 'MI' ).

    " off
    " Posición desde la cual comienza la búsqueda (offset)
    " Desplazamiento ¿desde dónde queremos leer?
    " por defecto cero
    DATA(lv_pos3) = find( val = 'MONIMONI' sub = 'MI' off = 4 ).

    " occ
    " Número de ocurrencia o posición de una coincidencia que se desea buscar (1ª, 2ª, 3ª...)
    " el conteeo inica en cero
    " de izquiera a derecha si occ es positivo (0, 1, 2 )
    " de derecha a izq  si occ es negativo
    " si no se indica por defecto occ = 1
    DATA(lv_pos4) = find( val = 'MONIMONI' sub = 'MI' occ = 2 ).

    " case
    " Indica si distingue mayúsculas/minúsculas (abap_true / abap_false)
    " abap_x vacío verdadero (distingue) o falso (no distingue)
    DATA(lv_pos5) = find( val = 'Moni' sub = 'MI' case = abap_false ).

    " len
    " Limita la longitud del texto que será analizado
    " tamaño de nuestra cadena de caracteres
    DATA(lv_pos6) = find( val = 'MONIMONI' sub = 'MI' len = 4 ).

         """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " 3.5 FUNCIONES DE DESCRIPCION
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "PERMITE ANALIZAR EL CONTENIDO DE UNA ENTRADA DE TIPO DE CADENA DE CARACTERES
    " 3 TIPOS

                "1. Funciones de LONGITUD
                "2. Funciones de CONTEO DE CARACTERES
                "3. Funciones de BUSQUEDA

     "1. Funciones de LONGITUD NUMOFCHAR( text ) STRLEN( text ) Dif espacios en blanco

     "devuelve un resultado de número entero.
     "conteo de posiciones que tenemos dentro de cadena de caracteres


       "strlen()
       "ignoara espacios

       DATA(lv_num20) = strlen(  '  MONIQUE  ' ).
       out->write( lv_num20 ).

       "numofchar()
       "En algunas ocasiones cuenta también los espacios en blanco

       lv_num20 = numofchar(  '  MONIQUE  ' ).
       out->write( lv_num20 ).


    "2. Funciones de CONTEO DE CARACTERES
    "3. Funciones de BUSQUEDA - obtener resultados de posición
        " COUNT
        " ocurrencias o concurrencias exactas de la busqueda dentro de una cadena de caracteres de coincidencia con un patrón
        "También devuelve un nº entero como resultado de la operación

        DATA lv_string20 TYPE string VALUE ' LONICAL local '.
        lv_num20 = COUNT( val = lv_string20 sub = 'LO' ). "OJO está activo el case sensitive. Tiene en cuenta las mayusculas
        out->write( lv_num20 ).

        "COUNT ANY OF
        "Coincidencias sin importar el orden pero en mayúsculas si está activo
        "cyakqyuer caracter contenido en el patrón

         lv_num20 = COUNT_ANY_OF( val = lv_string20 sub = 'LO' ). "L lo tenemos dos veces en may (es case sensitive) y la O 1 vez en may
        out->write( lv_num20 ).

      "COUNT ANY NOT OF "
        " Conteo de no coincidencias con el patrón


         lv_num20 = COUNT_ANY_NOT_OF( val = lv_string20 sub = 'LO' ). "ojo contar también espacios Parece que no cuenta los finales"
        out->write( lv_num20 ).

        "FIND
        "devuelve un número que es la posición
        "desde dicha posición se obtiene el resultado de la coincidencia con el patrón que le hemos pasado

        lv_num20 = FIND( val = lv_string20 sub = 'AL' ). "OJO está activo el case sensitive.Comienza por posición 0. Cuenta espacios
        out->write( lv_num20 ).

        "FIND ANY OF
        "devuelve un número que es la posición
        "SE Evalúa cada caracter de forma inidividual

         lv_num20 = FIND_ANY_OF( val = lv_string20 sub = 'AL' ). "OJO EMPIEZA A CONTAR POR POSICION 0
        out->write( lv_num20 ).

        "FIND ANY NOT OF
        "devuelve un número que es la posición
        "cualquier otra posición donde no se encuentre este patrón

         lv_num20 = FIND_ANY_NOT_OF( val = lv_string20 sub = 'AL' ). "OJO EMPIEZA A CONTAR POR POSICION 0
        out->write( lv_num20 ).

         """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " 3.6 FUNCIONES DE PROCESAMIENTO
          """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        "obtiene cadena de caracteres. Case sensitive

        DATA lv_string TYPE string VALUE ' ¡LOGALI GROUP! Welcome to ABAP Cloud Master '.

        " MAYUS minus
        out->write( |TO_UPPER        = { to_upper( lv_string ) }| ).
        out->write( |TO_LOWER        = { to_lower( lv_string ) }| ).
        out->write( |TO_MIXED        = { to_mixed( lv_string ) }| ).
        out->write( |FROM_MIXED      = { from_mixed( lv_string ) }| ).

        " Orden
        out->write( |REVERSE         = { reverse( lv_string ) }| ).
        out->write( |SHIFT_LEFT (places)= { shift_left(  val = lv_string places = 5 ) }| ).
        out->write( |SHIFT_RIGHT(places)= { shift_right( val = lv_string places = 5 ) }| ).
        out->write( |SHIFT_LEFT (circ)  = { shift_left(  val = lv_string circular = 5 ) }| ).
        out->write( |SHIFT_RIGHT(circ)  = { shift_right( val = lv_string circular = 5 ) }| ).

        " Substring
        out->write( |SUBSTRING        = { substring( val = lv_string off = 9 len = 6 ) }| ).
        out->write( |SUBSTRING_FROM   = { substring_from( val = lv_string sub = 'ABAP' ) }| ).
        out->write( |SUBSTRING_AFTER  = { substring_after( val = lv_string sub = 'ABAP' ) }| ).
        out->write( |SUBSTRING_TO     = { substring_to( val = lv_string sub = 'ABAP' ) }| ).
        out->write( |SUBSTRING_BEFORE = { substring_before( val = lv_string sub = 'ABAP' ) }| ).

        " Others
        out->write( |CONDENSE   = { condense( val = lv_string ) }| ).
        out->write( |REPEAT     = { repeat( val = lv_string occ = 2 ) }| ).
        out->write( |SEGMENT1   = { segment( val = lv_string sep = '!' index = 1 ) }| ).
        out->write( |SEGMENT2   = { segment( val = lv_string sep = '!' index = 2 ) }| ).

        """"

                " MAYUS minus (Funciones de conversión de texto)

        out->write( |TO_UPPER = { to_upper( lv_string ) }| ).
        " Convierte todo el texto a MAYÚSCULAS.

        out->write( |TO_LOWER = { to_lower( lv_string ) }| ).
        " Convierte todo el texto a minúsculas.

        out->write( |TO_MIXED = { to_mixed( lv_string ) }| ).
        " Convierte el texto a formato mixto (Primera letra en mayúscula de cada palabra).

        out->write( |FROM_MIXED = { from_mixed( lv_string ) }| ).
        " Convierte desde formato mixto a formato técnico (normalmente elimina capitalización tipo título).


        " Orden (Funciones que alteran la posición de caracteres. Modificar el orden de la cadena de caracteres)

        out->write( |REVERSE = { reverse( lv_string ) }| ).
        " Invierte completamente el orden de los caracteres del texto.

        out->write( |SHIFT_LEFT (places)= { shift_left( val = lv_string places = 5 ) }| ).
        " Desplaza el texto 5 posiciones a la izquierda (rellena con espacios a la derecha). Con places se eliminan los caract.

        out->write( |SHIFT_RIGHT (places)= { shift_right( val = lv_string places = 5 ) }| ).
        " Desplaza el texto 5 posiciones a la derecha (rellena con espacios a la izquierda). Con places se eliminan los caract.

        out->write( |SHIFT_LEFT (circ)= { shift_left( val = lv_string circular = 5 ) }| ).
        " Desplazamiento circular a la izquierda 5 posiciones (los caracteres que salen por la izquierda entran por la derecha).

        out->write( |SHIFT_RIGHT (circ)= { shift_right( val = lv_string circular = 5 ) }| ).
        " Desplazamiento circular a la derecha 5 posiciones (los caracteres que salen por la derecha entran por la izquierda).


        " Substring (Funciones de extracción de partes del texto)

        out->write( |SUBSTRING = { substring( val = lv_string off = 9 len = 6 ) }| ).
        " Extrae una subcadena empezando en la posición 9 con longitud 6 caracteres.
        " Si no colocamos len traería todo desde la posición 9

        out->write( |SUBSTRING_FROM = { substring_from( val = lv_string sub = 'ABAP' ) }| ).
        " Devuelve el texto desde la primera aparición de 'ABAP' hasta el final.

        out->write( |SUBSTRING_AFTER = { substring_after( val = lv_string sub = 'ABAP' ) }| ).
        " Devuelve el texto que aparece después de 'ABAP'. Sin incluir el patrón.

        out->write( |SUBSTRING_TO = { substring_to( val = lv_string sub = 'ABAP' ) }| ).
        " Devuelve el texto desde el inicio hasta donde empieza 'ABAP'. Incluye el patrón

        out->write( |SUBSTRING_BEFORE = { substring_before( val = lv_string sub = 'ABAP' ) }| ).
        " Devuelve el texto que aparece antes de 'ABAP'.


        " Others (Otras funciones útiles de procesamiento)

        out->write( |CONDENSE = { condense( val = lv_string ) }| ).
        " Elimina espacios duplicados y deja un único espacio entre palabras.
        " Condensación de cadena de caracteres

        out->write( |REPEAT = { repeat( val = lv_string occ = 2 ) }| ).
        " Repite el texto completo (contenido de la cadena de caracteres) 2 veces.

        out->write( |SEGMENT1 = { segment( val = lv_string sep = '!' index = 1 ) }| ).
        " Divide el texto usando '!' como separador y devuelve el segmento 1.

        out->write( |SEGMENT2 = { segment( val = lv_string sep = '!' index = 2 ) }| ).
        " Divide el texto usando '!' como separador y devuelve el segmento 2.


         """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " 3.7 FUNCIONES DE PROCESAMIENTO
          """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Contains
" sin contiene el subvalor de la cadena que indquemos en el parámetro sub en la cadena principal

DATA: lv_text31    TYPE string,
      lv_pattern31 TYPE string.

lv_text31    = 'The employee`s number is: 123-456-7890'.
lv_pattern31 = '\d{3}-\d{3}-\d{4}'.  " Phone number "expresión regular que corresponde a un teléfono ej 3 dígitos separados de un guión..

"se puede incluir en un bloque if

if contains( val = lv_text31 pcre = lv_pattern31 ). "pasar la expresión regular que neceistamos buscar en la cadena de caracteres . Los parámetros rege son obsoletos
out->write(  'The text contains a phone number' ).
ELSE.
out->write(  'The text does not contain a phone number' ). "hacer también la prueba modificando lv_text y quitar caracteres
ENDIF.
"PCRE = Perl Compatible Regular Expressions
"Le estás diciendo a ABAP que interprete el patrón como una expresión regular estilo Perl (más potente y moderna).


" Contains any of


" Contains any not of


" Match y Matches
" sin coincide con alguna expresión regular (regex)

" MATCH

"Si la cadena de caracteres completa coincide con la expresión regular . funciona de forma similar a find
"pero en lugar devolver la posición se devuelve la subcadena que hemos encontrado

DATA(lv_number30) = MATCH( val = lv_text31 pcre = lv_pattern31 occ = 1 ). "occ = 1 la primera que encuentre dentro de nuestra cadena principal
out->write( lv_number30 ).


         """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " 3.8 FUNCIONES CON EXPRESIONES REGULARES
          """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    "eXPRESIONES REGULARES O REGEX

    " PCRE - Perl Compatible Regular Expressions
" PCRE significa: Expresiones Regulares Compatibles con Perl.
" Permite usar patrones avanzados y flexibles para búsqueda de texto.

" Las expresiones regulares permiten definir patrones de búsqueda flexibles y precisos.
" Se pueden utilizar para verificar si una cadena coincide con un patrón específico.
" También permiten encontrar todas las ocurrencias de un patrón.
" Además permiten reemplazar texto basado en un patrón definido.

" Funciones built-in en ABAP que soportan el parámetro PCRE:

" FIND( )
" Permite buscar un patrón dentro de una cadena usando expresiones regulares.

" COUNT( )
" Cuenta las coincidencias que cumplen un patrón definido con PCRE.

" CONTAINS( )
" Verifica si una cadena contiene un patrón regex.

" REPLACE( )
" Reemplaza texto que coincida con un patrón regex.

" SUBSTRING_* ( )
" Permite extraer partes del texto basadas en patrones.

" MATCHES( )
" Devuelve verdadero si la cadena completa coincide con el patrón regex.

" MATCH( )
" Devuelve información de la coincidencia encontrada según el patrón.

" PCRE se utiliza cuando necesitamos validaciones complejas como:
" - Validación de emails
" - Validación de números de teléfono
" - Validación de formatos específicos
" - Búsquedas avanzadas dentro de textos

" Una búsqueda de una expresión regular es más simple que una búsqueda de una cadena de caracteres (tef, mail)
" pcre es una alternativa para el parámetro sub. El compilador con pcre sabe que se trabaja con una expresión regular
" no simultáneo pcre con sub

""""""""""""""""""""""
"Ejemplo buscar un mail

" Regular Expressions

DATA: lv_text40    TYPE string,
      lv_pattern40 TYPE string.

lv_text40 = 'Please contact us at support@logali.com for more information'.
lv_pattern40 = '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b'.  " regex for an email

IF contains( val = lv_text40 pcre = lv_pattern40 ). " rgex obsoleto . usar pcre para pasar expresiones regulares
  out->write( 'The text contains an email address' ).

  DATA(lv_count) = count( val = lv_text40 pcre = lv_pattern40 ).
    out->write( lv_count ).

  DATA(lv_pos) = find(
  val  = lv_text40
  pcre = lv_pattern40
  occ  = 1
    ).
    out->write( lv_pos ).

ELSE.
  out->write( 'The text does not contain an email address' ).
ENDIF.

*"---------------------------------------------------------
*" COUNT con expresión regular (PCRE)
"¿cuántes veces se repiten la coincidencia?
*" Cuenta cuántas coincidencias del patrón existen en el texto
*" Devuelve un número entero con el total de ocurrencias encontradas
*DATA(lv_count) = count( val = lv_text pcre = lv_pattern ).
*out->write( lv_count ).
*
*
*"---------------------------------------------------------
*" FIND con expresión regular (PCRE)
*" Busca la posición de la coincidencia dentro del texto
*" occ = 1 indica que queremos la primera ocurrencia encontrada
*" Devuelve la posición (offset) donde empieza la coincidencia
*DATA(lv_pos) = find(
*  val  = lv_text
*  pcre = lv_pattern
*  occ  = 1
*).
*out->write( lv_pos ).

  ENDMETHOD.
ENDCLASS.
