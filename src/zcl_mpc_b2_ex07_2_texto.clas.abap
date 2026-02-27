CLASS zcl_mpc_b2_ex07_2_texto DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

   INTERFACES if_oo_adt_classrun .


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_b2_ex07_2_texto IMPLEMENTATION.




  METHOD if_oo_adt_classrun~main.

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " 4.1 TIPOS DE DATOS PARA CADENAS DE CARACTERES
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " TIPO STRING
  " puede cambiar de tamaño (=longitud) durante la ejecución de un programa abap
  " depende del valor que le vayamos asignando a la variable
  " valor inicial = cadena vacía con longitud es cero

  DATA lv_string TYPE string.

  lv_string = 'Hola Mundo'.

  out->write( lv_string ).

  " TIPO c
  " para caracteres alfanuméricos de longitud fija (debe especificarse de forma explicita en la declaración con LENGTH y no cambiará durante la ejecución del programa

  DATA: lv_char TYPE c LENGTH 10,
        lv_char2(10) TYPE c,
        lv_char3 TYPE c, " por defecto longitud 1
        lv_char4.        " por defecto c

  " TIPO N
  "para caracteres numéricos con longitud fija (números almacenados como texto).

  DATA: lv_n TYPE n LENGTH 20 VALUE '12345678'. " ej un nº  factura. nO PODEMOS exceder de la long definida

  out->write( lv_n ).


  "Tipo T y D
  "para caracteres de fecha (D) y hora (T). 8 Y 6 CARACTERES POR DEFECTO

  DATA: lv_t TYPE t VALUE '120505',
        lv_d TYPE d VALUE '20250225'.

  out->write( lv_t ).
  out->write( lv_d ).

 "---------------------------------------------------------
" Tipo X
"---------------------------------------------------------
" Se utiliza para representar datos binarios en formato hexadecimal.
" Sirve para manejar datos que no son necesariamente texto,
" como archivos binarios o datos encriptados.
"
"---------------------------------------------------------
" Tipo XSTRING
"---------------------------------------------------------
" Es una cadena en formato hexadecimal de longitud variable.
" Sirve para manejar grandes volúmenes de datos binarios,
" como archivos PDF o imágenes.

"""""""""""""""

" USAR LA LENGTH CUANDO QUEREMOS LIMITAR AL USUARIO EL NUMERO DE CARACTERES (EJ CODIGO POSTAL)

"" Declara una variable local inferida automáticamente y le asigna el valor literal 'ABC'

DATA(lv_string_f) = 'ABC'.
out->write( lv_string_f ).
out->write( |Valor de lv_string_f: { lv_string_f }| ). " hACER UN BREAK POINT PARA VER QUE EL compilador pone el tipo C de forma implicita

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 4.2 CONCATENACION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" uNIR o combinar dos o más cadenas de caracteres
*" VARIAS FORMAS:
*
*"1.- operador && ' ESPACIO ' &&
*
*
*"2.- corchetes ||
*
*"3.- concatenATE
*"pasar variables que quiero concatenar separadas con un espacio e INTO data PARA INCLUIR LA V
*"Var donde quiero guarder el resultado.
*"SEPARATED BY space o ''.
*
*"4.- CONCAT_LINES_OFF
*
*DATA(lv_string_concatenado) = |{ lv_string } { lv_string_f }|.
*
*out->write( lv_string_concatenado ).
*
*" CONCATENAR VARIOS VALORES EN UNA CADENA
*" ejemplos
*
*DATA: lv_string_a TYPE string VALUE 'Welcome to Manpower Group',
*      lv_string_b TYPE string.
*
*lv_string_b = 'ABAP' && ' ' && 'Student'.
*
*CONCATENATE lv_string_a lv_string_b INTO DATA(lv_fin_string) SEPARATED BY space. " volcamos ino en variable decalrada en linea
*
*out->write( | Concatenation 1: { lv_fin_string } | ).
*
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*" NO SE RESPETAN ESPACIOS
*
*CONCATENATE 'X ' 'Y ' 'Z ' INTO DATA(lv_string_c).
*
*out->write( | Concatenation 2: { lv_string_c } | ).
*
*" RESPECTING BLANKS SI SE RESPETAN ESPACIOS
*
*CONCATENATE 'X ' 'Y ' 'Z ' INTO DATA(lv_string_c2) RESPECTING BLANKS.
*
*out->write( | Concatenation 3: { lv_string_c2 } | ).
*
*" USAR CARACTERES LINEALES DE CONCATENACION ||
*" {Variables que toman valor duarante la ejecución}
*" se respetan los espacios (ojo espacio al principio sin necesidad de respecting blanks
*
*DATA(lv_fin_string2) = | Concatenation 3: { lv_string_a } / { lv_string_b } |.
*
*out->write( lv_fin_string2 ).


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 4.3 CONCATENACION LINEAS DE TABLAS CONCAT_LINES_OF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" sirve para concatenar lineas o registros de una tabla interna
*
*" SEP paraametro para separar es opcional
*"declaramos en linea la var donde queremos guardar los registros
*"traer info de una TI y guardar los registro en 1 VAR
*" tabla de base de datos: CONTRL CLICK PODEMOS VISUALIZAR LOS REG QUE TRAE LA TABLA
*
*SELECT FROM /dmo/flight
*  FIELDS carrier_id
*  INTO TABLE @DATA(lt_itab).
*
*DATA(lv_string_itab) = concat_lines_of(
*  table = lt_itab
*  sep   = ` `
*).
*
*out->write( lv_string_itab ).
*
*" concat_lines_of convierte todas las líneas de una tabla interna en una única cadena de texto uniendo cada fila con el separador indicado

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 4.4 CONDENSACION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Eliminar espacios en blanco dentro de las cadenas de caracteres
" 2 FORMAS
"1. CONDENSE
"2. CONDENSE()

DATA: lv_string_a TYPE string VALUE 'Welcome             to Manpower Group',
      lv_string_b TYPE string.

"1.- Condense
"elimina espacios innecesarios
"2.- ConDense NO-GAPS
"eLIMINA TODOS LOS ESPACIOS
"3 CONDENSE(). pUEDE FUNCIONAR también con declaración en linea o declaración anterior
"en el ej lo guardamos en la misma var para reducir código
"elimina espacios innecesarios
" VAL variable que queremos operar
" FROM elimina espacios iniciales y finales 'espacio'
" TO queremos eliminar todos los espacios 'sin espacio'. SIMILAR NO GAPS
" DEL INDICAR el caracter que queremos eliminard de inicio y fin

" CONDENSE (instrucción clásica)

out->write( lv_string_a ).

*CONDENSE lv_string_a.           " Elimina espacios duplicados dejando solo uno entre palabras
CONDENSE lv_string_a NO-GAPS.  " Elimina todos los espacios

out->write( lv_string_a ).


" condense() (función moderna)

lv_string_a = 'Welcome      to Logali     Group'.

lv_string_a = condense( lv_string_a ).  " Devuelve la cadena sin espacios múltiples

out->write( lv_string_a ).

" condense() reemplazando múltiples espacios por uno solo
lv_string_a = condense( val = lv_string_a from = ` ` ).

lv_string_a = condense( val = lv_string_a to = ` ` ).
out->write( lv_string_a ).

" condense() eliminando un carácter específico
lv_string_a = condense( val = '!!!ABAP!!!Course!!!' del = '!' ).
out->write( lv_string_a ).

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 4.5 SPLIT
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Con esta operación podemos dividir cadenas de caracteres en varios bloques o segmentos
" el resultado de esta operación se puede almacenar en objetos de datos separados
" o incluso en tablas internas donde los tipos de datos sean compatibles
**********************************************************************
"declaración en linea

DATA(lv_string45) = 'Manpower-Group-SAP-Academy'.

"apliar split - pasamos la variable y el patrón de separación de cada bloque. eL PATRÓN no lo almacena
"INTO se puede hacer declaración en línea para las 4 que voy a recibir por cada separación (: realizada)
" visualizar resultado

SPLIT lV_string45 AT '-' INTO DATA(lv_string1)
                            DATA(lv_string2)
                            DATA(lv_string3)
                            DATA(lv_string4).
out->write( lv_string1 ).
out->write( lv_string2 ).
out->write( lv_string3 ).
out->write( lv_string4 ).

*** SEGMENT
"Otra forma para separación de cadena de caracteres
"vak = variable a separar
"index es opcional y sólo si queremos obtener una separación en específico
"la variable guarda un valor
"sep = patrón de separación

lv_string3 = segment(
  val   = lv_string45
  index = 2
  sep   = '-'
).

out->write( lv_string3 ).

lv_string3 = segment(
  val   = lv_string45
  index = 2
  sep   = '-'
).

out->write( lv_string3 ).



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 4.6 SHIFT / SHIFT LEFT / SHIFT RIGHT
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Cuando necesitamos desplazar la cadena de caracteres a una posición específica ya sea izq o dcha

"declaramos una constante con espacios en blanco
"declaramos un valor en linea donde asignamos el valor de la constante
"imprimimos el valor inicial
"aplicamos operación SHIFT colocando la variable con la que queremos operar (elimina espacio izq)
"ver resultados en consola
"SHIFT variable LEFT mover un nº de espacios (si no indicamos LEFT por defecto siempre se mueve a la izquierda)

"*** SHIFT

CONSTANTS gc_initial(10) TYPE c VALUE '    ABC123'.

DATA(gv_final_str) = gc_initial.

out->write( | Initial value { gv_final_str } | ).

**SHIFT gv_final_str.  " sólo quita un espacio a la izquierda
**SHIFT gv_final_str BY 8 PLACES. "por defecto desplaza a la izquierda. Le hemos indicado 8 posiciones
**SHIFT gv_final_str BY 8 PLACES LEFT. "desplaza a la izquierda. Le hemos indicado 8 posiciones
**SHIFT gv_final_str BY 3 PLACES RIGHT. " desplaza a la DERECHA. Le hemos indicado 3 posiciones = ELIMINA los ultimos 3 caracteres
*                                       "entran tres espacios nuevos a la izquierda
*                                       " los tres últimos se pierden por desplazamiento (n o los elimina)
*
*" SHIFT RIGHT DELETING TRAILING
*"indicar el caracter o patrón que queremos eliminar
*
*" Desplaza la cadena hacia la derecha eliminando al final
*" los caracteres indicados en el literal especificado
*
*SHIFT gv_final_str RIGHT DELETING TRAILING '123'.
*out->write( | Final value1 { gv_final_str } | ).
*" RIGHT → mueve el contenido hacia la derecha
*" DELETING TRAILING → elimina los caracteres indicados si están al final
*" '123' → elimina cualquier combinación final formada por 1, 2 o 3
*" Ejemplo: si gv_final_str = 'ABC123' el resultado será 'ABC'
*" elimina cualquier combinación formada por 1, 2, o 3
*"no se añaden espacios a la izquierda porque no hay desplazamiento sólo eliminación
*
*"BY n places right no elimina contenido y si desplaza posiciones
*"deleting trailing si elimina contenido y no desplaza posiciones
*
*SHIFT gv_final_str LEFT DELETING LEADING space.
*"mover a la izq eliminando los caracteres de la izquierda que indiquemos


*out->write( | Final value2 { gv_final_str } | ).


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 4.7 FUNCION SHIFT
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"Desplazan texto de izq a dcha según parámetro
*" val valor de la variable
*" a continuación indicar los lugares con places que queremos que se mueve
*" argumento circular = 5 los caracteres que desaparecen por la izq aparecen por la derecha si pongo shift_left
*" otro argumento sub que elimine los caracteres 123 de la drecha
*"si no especificamos ningún código lo considera como espacio si sólo indicamos la variable que queremos tratar.
*"el compliador se posiciona a la izquierda y borra todos los espacios a la ziquierda
*"shift_right reduce longitud de cadena. Se pueden incluri parametros places, circular.....
*"shift alarga cadena o la manteniene
*
*"*** FUNCIONES SHIFT (versión funcional moderna)
*
*" Desplaza 2 posiciones a la izquierda (pierde los 2 primeros caracteres)
*" gv_final_str = shift_left( val = gv_final_str places = 2 ).
*
*" Desplaza 2 posiciones a la derecha (pierde los 2 últimos caracteres)
*" gv_final_str = shift_right( val = gv_final_str places = 2 ).
*
*" Desplazamiento circular: mueve 5 posiciones a la izquierda
*" Los caracteres que salen por la izquierda vuelven por la derecha
*gv_final_str = shift_left( val = gv_final_str circular = 5 ).
*
*out->write( gv_final_str ).
*
*
*" Restauramos valor original
*gv_final_str = gc_initial.
*
*" Desplaza a la derecha eliminando el patrón indicado al final
*" Elimina '123' si aparece al final de la cadena
*gv_final_str = shift_right( val = gv"*** FUNCIONES SHIFT (versión funcional moderna)
*
*" Desplaza 2 posiciones a la izquierda (pierde los 2 primeros caracteres)
*" gv_final_str = shift_left( val = gv_final_str places = 2 ).
*
*" Desplaza 2 posiciones a la derecha (pierde los 2 últimos caracteres)
*" gv_final_str = shift_right( val = gv_final_str places = 2 ).
*
*" Desplazamiento circular: mueve 5 posiciones a la izquierda
*" Los caracteres que salen por la izquierda vuelven por la derecha
*gv_final_str = shift_left( val = gv_final_str circular = 5 ).
*
*out->write( gv_final_str ).
*
*
*" Restauramos valor original
*gv_final_str = gc_initial.
*
*" Desplaza a la derecha eliminando el patrón indicado al final
*" Elimina '123' si aparece al final de la cadena
*gv_final_str = shift_right( val = gv_final_str sub = '123' ).
*
*out->write( gv_final_str ).
*
*
*" Restauramos nuevamente el valor original
*gv_final_str = gc_initial._final_str sub = '123' ).
*
*out->write( gv_final_str ).
*
*
*" Restauramos nuevamente el valor original
*gv_final_str = gc_initial.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 4.8 FUNCION Funciones STRLEN y NUMOFCHARS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" STRLEN devuelve la longitud de una cadena de texto
*" NUMOFCHARS devuelve el nº de caract.que hay en una cadena de texto
*"longitud de la cadena para exlcuir los espacios. EXCLUYE ESPACIOS
*" en el ejemplo no declaramos en linea lv_length2 porque ya lo hicimos en la parte superior
*
*"strelen
*"1 dentro agregamos cadena de caracteres con espacios e imprimimos
*"tipo c no tiene en cuenta los espacios. Tipo de dato de longitud fija
*"2 declaramos en linea
*"tipo string tiene en cuenta los espacios
*
*
*
*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
***** STRLEN Function
*
*DATA lv_length TYPE c LENGTH 6.
*lv_length = strlen( 'Logali Group ' ).
*" STRLEN devuelve la longitud física del literal tal como está escrito
*" En este caso cuenta los espacios iniciales y finales del string
*
*out->write( lv_length ).
*
*DATA(lv_length2) = strlen( ' Logali Group ' ).
*" Declaración en línea
*" STRLEN cuenta todos los caracteres visibles del literal
*" incluyendo espacios al inicio y al final
*
*out->write( lv_length2 ).
*
*****num of char
*
*lv_length = numofchar( 'Logali Group ' ).
*" NUMOFCHAR devuelve la longitud lógica del texto
*" excluyendo espacios iniciales y finales
*
*out->write( lv_length ).
*
*lv_length2 = numofchar( ' Logali Group ' ).
*" NUMOFCHAR no cuenta los espacios en blanco al inicio ni al final
*" por eso devuelve menor longitud que STRLEN en este caso
*
*out->write( lv_length2 ).

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 4.9 FUNCION Funciones TO_LOWER y TO_UPPER - TRANSLATE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"Transforman cadenas de caracteres
*" TO_LOWER convierte una cadena de texto en minúsculas
*" TO_UPPER convierte una cadena de texto en mayúsculas
*
***********************************************************************
*"declarar en linea una factura
*"ej 1 transformar cadena de caracteres a may e imprimir la variable
*" activamos y ejecutamos para verlo en consola
*"ej 2 igual pero en minísculas (alternamos may y min)
*"Translate "Ej 3 pasamos variables y le decimos si queremos may o min con To UPPER/lower CASE
*"Ej 3 SE PUEDE trabajar en la misma variable
*"esto es no solo se pueden pasar textos hardcodeados sino también variables
*
***** LOWER / UPPER
*
*DATA(lv_invoice) = to_upper( 'abcdexyec' ).
*" Convierte el literal a MAYÚSCULAS y devuelve el resultado (función moderna)
*
*out->write( lv_invoice ).
*
*lv_invoice = to_lower( 'INVaXXYYZz' ).
*" Convierte el literal a minúsculas y devuelve el resultado (función moderna)
*
*out->write( lv_invoice ).
*
*
*" TRANSLATE
*
*lv_invoice = '123clientinv02'.
*" Asignamos valor original
*
*TRANSLATE lv_invoice TO UPPER CASE.
*" Instrucción clásica: modifica directamente la variable a MAYÚSCULAS
*
*out->write( lv_invoice ).
*
*lv_invoice = '123clientinv02'.
*" Restauramos valor original
*
*TRANSLATE lv_invoice TO LOWER CASE.
*" Instrucción clásica: modifica directamente la variable a minúsculas
*
*out->write( lv_invoice ).
*
*
*lv_invoice = to_upper( lv_invoice ).
*" Aplica nuevamente la función moderna sobre el valor actual de la variable
*
*out->write( lv_invoice ).
*
*lv_invoice = to_lower( lv_invoice ).
*" Aplica nuevamente la función moderna sobre el valor actual de la variable
*
*out->write( lv_invoice ).



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 4.10 FUNCION  Funciones INSERT y REVERSE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"INSERT insertar una cadena de texto en otra
*"REVERSE invertir una cadena de texto. Cambia el orden de los caracteres dentro de nuestra cadena principal
*
***********************************************************************
*"declarar en linea una variable
*"ej 1 insertar una cadena en otra - Hay tres parámetros:
*" val donde almacenamos la cadena de caracteres ,
*"sub = valor de la subcadenam que queremos introducir en la cadena principal
*" off = posición donde se debe agregar ( valor predeterimado será cero si no se indica nada
*"activamos y ejecutamos para verlo en consola
*"ej 2 en vez de poner en val una cadena colocamos una variable y quitamos off
*"ej 3 invertir cadena de texto
*"activamos y ejecutamos para verlo en consola
*
***** INSERT / REVERSE
*
***** INSERT
*
*
*DATA(lv_ins_string) = insert( val = '123CLIENT02' sub = 'INV' off = 3 ).
*" Inserta la subcadena 'INV' en la posición 3 (offset empieza en 0)
*" Resultado: 123INVCLIENT02
*
*out->write( lv_ins_string ).
*
*
*lv_ins_string = '123CLIENT02'.
*" Restauramos valor original
*
*lv_ins_string = insert( val = lv_ins_string sub = 'INV' ).
*" Inserta 'INV' al inicio (si no se indica OFF, el default es posición 0)
*
*out->write( lv_ins_string ).
*
*
*" REVERSE
*
*lv_ins_string = reverse( lv_ins_string ).
*" Invierte completamente el orden de los caracteres de la cadena
*
*out->write( lv_ins_string ).


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 5 OPERACIONES DE CADEMAS DE CARACTERES II
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 5.1 OVERLAY
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" rEEMPLAZAR caracteres en una variable con los caracteres en otras variables
*" superponer el contenido de cada una de las variables, de una sobre otra
*" sensible a may y min
*
***********************************************************************
*
*"ej 1 declaramos 2 variables
*" lv_name la superponemos con lv_company
*"Los caractres iniciales se han puesto con la primera variable y el resto que queda el valor de la 2ª variable
*" ej 2 CON ONLY especificamos los caracteres que queremos supeponer
*
***** OVERLAY
*
*DATA(lv_company) = '------------->Logali Group'.
*" Cadena base que contiene guiones y el nombre de la empresa
*
*DATA(lv_name) = 'ABAP_Class'.
*" Cadena que vamos a superponer (overlay)
*
*OVERLAY lv_name WITH lv_company.
*" Sustituye en lv_name los espacios por los caracteres correspondientes de lv_company
*" Los caracteres no vacíos de lv_name se mantienen
*
*out->write( lv_name ).
*
*
*DATA(lv_superponer)  = 'a.b.c.a.b.c.A'.
*" Cadena original con letras y puntos
*
*DATA(lv_superponer2) = 'z.x.y.Z.x.y.z'.
*" Cadena que servirá como patrón para superponer
*
*OVERLAY lv_superponer WITH lv_superponer2 ONLY 'ab'.
*" Solo reemplaza en lv_string los caracteres 'a' o 'b'
*" usando los caracteres correspondientes de lv_string2 en esas posiciones
*" Sensible a may y min por eso la última n ola reempza
*
*out->write( lv_superponer ).

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 5.2 SUBSTRING / SUBSTRING_FROM / SUBSTRING_AFTER _BEFORE _TO
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"Función SUBSTRING
*
*"Esta función permite extraer subcadenas específicas de una cadena principal. Podemos definir varios parámetros, como la posición inicial y la longitud de la subcadena, entre otros, para obtener exactamente lo que necesitamos.
*
*" 3 parametros CTRL SPACE
**VAL:
**Lo usamos dentro de la función para especificar la variable que almacenará el contenido de la cadena principal.
**
**OFF:
**Especifica la posición desde donde comienza la extracción, el valor predeterminado de off es cero, lo que significa que la subcadena se extrae desde el inicio de la cadena principal.
**
**LEN:
**Especifica la longitud. (toma n caracteres).
**SUB
** Especificar un parámetro o patrón o cadena de búsqueda _> cambiar a substring_from _BEFOER ANTES Y _after DESPUES del patrón especificando. to
*
***********************************************************************
*
*DATA: lv_string_c TYPE string VALUE 'Welcome        to Logali        Group',
*      lv_string_d TYPE string.
*
*
***** SUBSTRING
*
*lv_string_c = 'LOGALI GROUP'.
*out->write( lv_string_c ).
*
*lv_string_c = substring( val = lv_string_c off = 7 len = 4 ).
*" Extrae 4 caracteres empezando desde la posición 7 (offset inicia en 0)
*
*out->write( lv_string_c ).
*
*
*lv_string_c = 'LOGALI GROUP'.
*out->write( lv_string_c ).
*
*lv_string_c = substring_from( val = lv_string_c sub = 'GA' len = 6 ).
*" Devuelve la cadena desde donde encuentra 'GA' con longitud 6
*
*out->write( lv_string_c ).
*
*
*lv_string_c = 'LOGALI GROUP'.
*
*lv_string_c = substring_after( val = lv_string_c sub = 'GA' ).
*" Devuelve todo lo que está después de la subcadena 'GA'
*
*out->write( lv_string_c ).
*
*
*lv_string_c = 'LOGALI GROUP'.
*
*lv_string_c = substring_before( val = lv_string_c sub = 'GA' ).
*" Devuelve todo lo que está antes de la subcadena 'GA'
*
*out->write( lv_string_c ).
*
*
*lv_string_c = 'LOGALI GROUP'.
*
*lv_string_c = substring_to( val = lv_string_c sub = 'GA' ).
*" Devuelve desde el inicio hasta justo antes de encontrar 'GA' incluido GA
*
*out->write( lv_string_c ).

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 5.3 FIND / COUNT
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"FIND
*
*"La operación FIND permite realizar búsquedas específicas en cadenas de caracteres utilizando la función find() y la sentencia FIND. Inicialmente, se usan operadores de comparación como CA (contiene cualquiera) o NA (no contiene ninguno) para verificar
"s
*"i el contenido especificado está dentro de la cadena.
*
*"CA (Contains Any) (Contiene cualquiera)
*"NA (No contiene ninguno)
*"NA (Not contain Any)
*
*"Case Sensitive
*"Estas búsquedas distinguen entre mayúsculas y minúsculas. La variable del sistema SY-FDPOS almacena, en tiempo de ejecución, la posición del primer carácter encontrado, y si no se encuentra ningún resultado, su valor será la longitud de la cadena. El v
"a
*"lor inicial de esta variable es cero, representando la primera posición.
*
*"FIND_ANY_OF
*" VAL = variable con la que vamos a trabajar
*" SUB = patrón de búsqueda  (cq de esos caracteres)
*
*"lv_pos = SY-FDPOS + 1. Para visualizar el resultado Como empieza en cero sumamos un 1 para saber posición real donde lo ha encontrado
*
*"FIND_ANY_OF
*" VAL = variable con la que vamos a trabajar
*" SUB = patrón de búsqueda  (cq de esos caracteres)
*
*"lv_pos = SY-FDPOS + 1. como sy-fdpos por defecto es 0 lo incrementamos en 1 para mostrar valor real de la posición dentro de la cadena de caract
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"ej 1 busca e minuscula y dice en qué posición lo ha encontrado
*"ej 2 no encuentra similitud y muestra -1
*"ej 3 find - > lv_regex que contenga números del 0 al 9
*"declarar valores en linea
*" podemos incluir variables. A partir de la pos 6 ha encontrado el primer nº
*
*"FIN ALL OCURRENCIES OF
*"encontrar todas las ocurrencias o similitudes dentro de la cadena de caracteres
*" ej valor de la varialbe, nº , letra o simulo .
**IN buscamos en variable,
**MATCH COUNT DATA(VARIABLE donde se guarda el resultado)
*
*
**DATA: lv_string_a TYPE string VALUE 'Welcome to Manpower Group',
**      lv_string_b TYPE string.
*
***** FIND
*
*lv_string_a = 'ABAP Student'.
*" Cadena base sobre la que realizamos búsquedas
*
*out->write( lv_string_a ).
*
*DATA(lv_pos) = find_any_of( val = lv_string_a sub = 'x523z4e' ).
*" Busca si alguno de esos caracteres existe en la cadena y devuelve la posición
*
*lv_pos = sy-fdpos + 1.
*" sy-fdpos devuelve posición base 0, sumamos 1 para formato humano
*
*out->write( lv_pos ).
*
*lv_pos = find_any_of( val = lv_string_a sub = 'zwq85x' ).
*" Si no encuentra coincidencia devuelve -1
*
*out->write( lv_pos ).
*
*
*"REGEX
*
*DATA: lv_string_c TYPE string VALUE 'ERP #### 1 a nivel mundial desde 1972*****',
*      lv_regex    TYPE string VALUE '[0-9]'.
*" Texto base y patrón regex que detecta cualquier dígito
*
*DATA(lv_find) = find( val = lv_string_c regex = lv_regex ).
*" FIND con REGEX devuelve la posición del primer número encontrado
*
*out->write( lv_find ).
*
*FIND ALL OCCURRENCES OF '#' IN lv_string_c MATCH COUNT DATA(lv_count).
*" Cuenta todas las apariciones del carácter '#'
*
*out->write( lv_count ).
*
*lv_count = count( val = lv_string_c sub = '*' ).
*" COUNT devuelve cuántas veces aparece el patrón indicado
*
*out->write( lv_count ).
*
**🎓 Conceptos clave nivel 9
**
**find_any_of → busca cualquier carácter del conjunto indicado.
**
**sy-fdpos → posición técnica base 0.
**
**regex → búsqueda avanzada por patrón.
**
**FIND ALL OCCURRENCES → conteo clásico.
**
**count() → función moderna de conteo.


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 5.4 REPLACE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Reemplazar cadena de caracteres

"sy_ si toma el valor cero es que los caracteres se han reemplazado correctamente
" = 4 no se ha encontrado el patrón de búsqueda. No se ha realizado la operación
**********************************************************************

*Ej 1 replace + caracter que queremos pasar (se puede poner de forma explicita entre comillas simples o con la variable que hemos asignado)
" WITH - > con que valor queremos reemplazar
" INto -> en donde lo queremos reemplazar
" IMPORTANTE - > sólo se reemplaza el primer caracter que haya encontrado

**********************************************************************
"REPLACE ALL OCURRENCIES OF
" si queremos reemplazar todos los caracteres que haya encontrado = al patrón
" Ej 2 of patrón IN variable en donde lo queremos reemplazar y WITH - > con que valor queremos reemplazar



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 5.4 FUNCION REPLACE()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" PARAMETROS
*" VAL = variable que vamos a tratar
*" sub = patrón que queremos reemplazar nuestra cadena (harcode o variable)
*" WITH = con qué queremos reemplazar el patrón
*" OCC = posición desde la que queremos que empiece el reemplazo
*" OCC = 0 si queremos reemplazar todos los parámetros
*" OFF = desde qué o qué posición queremos cambiar. Recordar que el conteo empieza desde cero
*" LEN = qué longitud queremos que reemplace. (nº posiciones hasta dónde va a reemplazar)
*
***********************************************************************
*" Ej 3
*" Ej 4
*
*
***** REPLACE
*
*DATA(lv_replace) = 'Logali-Group-SAP-Academy'.
*" Cadena original sobre la que aplicaremos reemplazos
*
*DATA(lv_sign) = '-'.
*" Carácter que queremos sustituir
*
*out->write( lv_replace ).
*
*
** REPLACE lv_sign WITH '/' INTO lv_replace.
*" Instrucción clásica: reemplaza la primera coincidencia
*
** REPLACE ALL OCCURRENCES OF lv_sign IN lv_replace WITH '/'.
*" Instrucción clásica: reemplaza todas las coincidencias
*
** out->write( lv_replace ).
*
*
*"Function replace()
*
*lv_replace = replace( val = lv_replace sub = lv_sign with = '/' occ = 0 ).
*" Función moderna: occ = 0 significa reemplazar TODAS las ocurrencias
*
*out->write( lv_replace ).
*
*
*lv_replace = replace( val = lv_replace with = '#' off = 5 len = 3 ).
*" Reemplaza 3 caracteres desde la posición 5 por '#'
*" (reemplazo posicional, no por patrón)
*
*
*out->write( lv_replace ).


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 5.5 OPERADORES DE COMPARACION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" PARA realizar búsquedas o reemplazos dentro de las cadenas de caracteres
*" sy-fdpos donde se guardan el número de posiciones que se obtienen como resultado
*
*"CA CONTAINS ANY O CONTIENE CUALQUIERA
*"que contenga cualquiera de estos valores
*" CASE SANSITIVE
*" NA
*"no contiene ninguno
*" NA (Not Contains Any)
*" CO contiene
*"CN si una cadena contiene caracteres distintos a los del patrón
*"ej contiene más caracteres que el patrón
*
*"CS CONTAINS STRING
*"que contenga una subcadena ( la cadena indicada)
*" NS NOT CONTAINS STRING
*" que no contenga la cadena indicada
*"CP CONTAINS PATTERN
*" que contenga el patrón indicado
*" NP NOT CONTAINS PATTERN
*" que no contenga el patrón indicado
*"CS CONTAINS STRING
*"que contenga una subcadena ( la cadena indicada)
*" NS NOT CONTAINS STRING
*" que no contenga la cadena indicada
*"CP CONTAINS PATTERN
*" que contenga el patrón
*" ** va a tomar cualquier secuencia de caracteres incluidos los espacios en blanco
** # el siguiente caracter tiene que estar exactamente en la búsqueda en caso contrario falso (en este caso _)
** NP NOT CONTAINS PATTERN
*" que no contenga el patrón indicado
*
***********************************************************************
*
**DATA: lv_match TYPE abap_bool,
**      lv_text  TYPE string.
**
**lv_text = 'ABAP'.
**
**lv_match = lv_text
**si encuentra un patrón la variable sy-fdpos devuelve el desplazamiento de la primera aparición
*" de lo contrario contiene la longitud de la variable buscada
*"NP NOT CONTAINS PATTERN
*" que no contenga el patrón indicado
*"patrón g* = si no contiene ese patrón de g y otro caracter más después de g no existe (puede ser un espacio
*"patrón *g = si no contiene ese patrón de g y otro caracter más antes de g no existe
*
***********************************************************************
**Eh 1
*" Lv_match variable booleana para verdadero y falso según el resultado esperado
*" lv_text cadena de caracteres
*
***********************************************************************
*
*****Comparison Operators
*
*"CP -> Comprueba si la cadena cumple un patrón usando comodines (* y +)
*
*"CP
*
*DATA lv_match TYPE abap_bool.
*
*DATA(lv_text) = 'This is an example text for SAP_ABAP programming.'.
*
*IF lv_text CP '*SAP#_*'.
*  lv_match = abap_true.
*  out->write( 'The text contains the pattern "SAP_"' ).
*ELSE.
*  lv_match = abap_false.
*  out->write( 'The text does not contain the pattern "SAP"' ).
*ENDIF.
*
*
*"NP -> Devuelve verdadero si la cadena NO cumple el patrón indicado
*
*"NP
**
**DATA lv_match TYPE abap_bool.
**
**DATA(lv_text) = 'This is an example text for SAP_ABAP programmingx'.
*
*IF lv_text NP '*g+'.
*  lv_match = abap_true.
*  out->write( 'The text does not contain the pattern "g"' ).
*ELSE.
*  lv_match = abap_false.
*  out->write( 'The text contains the pattern "g"' ).
*ENDIF.


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 5.6 PCRE REGEX
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

*"PCRE pearl compatible Regular Expressions
*" PARA POder usarlo nuestro sistema debe soportar las expresiones compatibles con PERL (SAP VERSION 7.2)
*" USO en expresiones de find y replace
*"Una expresión regular es una plantilla, se utiliza para verificar
*" si una cadena de texto cumple con ciertas características.
*" Puede ser un fragmento de texto como una línea o incluso un libro completo.
*"SE Usa para búsquedas complejas en cadaes de caracteres
*" REGEX OBSOLETA - > MIGRAR A EXPRESIONES REGULARES PCRE
*" EXPRESION REGULAR SE USA CUANDO SE BUSCAN PATRONES COMPLEJOS (EJ TELEFONO, MAIL)
*" sy-subrc = 0 operación satisfactoria y diferente de cero (ej 4) no satisfactoria (no se realizó correctamente)
*" IMPORTANTE una cadena vacía no es una expresión regular válida
*
*
*"REPLACE ALL OCURRENCIES OF PCRE 'Nº O TEXTO' IN LV_VARIABLE WITH | | O SPACE.
*"CQ CARACTER QUE NO SEA Nº O TEXTO EN LA CADENA LV_VARIABLE SERÁ REMPLAZADO POR UN ESPACIO
*
*****PCRE regex
*
*"Definimos una expresión regular PCRE para validar estructura de email
*
*DATA(lv_pcre) = '^[a-z0-9]+(\.[_a-z0-9-]+)*@[a-z0-9]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$'.
*
*"Email que vamos a comprobar contra el patrón regex
*
*DATA(lv_email) = 'alumno@logali.com'.
*
*"Búsqueda usando motor PCRE (expresiones regulares modernas tipo Perl)
*
*"FIND REGEX lv_pcre IN lv_email.
*
*FIND PCRE lv_pcre IN lv_email.
*
*"Si sy-subrc = 0 significa que el patrón coincide correctamente
*
** IF sy-subrc EQ 0.
**   out->write( 'OK' ).
**
** ELSE.
**   out->write( 'no OK' ).
**
** ENDIF.
*
*"Texto con caracteres especiales para limpiar usando PCRE
*
*DATA(lv_text56) = '123A?*Z100004#~€-AA'.
*
*"Reemplaza todos los caracteres NO alfanuméricos por espacio usando regex PCRE
*
*REPLACE ALL OCCURRENCES OF PCRE '[^A-Za-z0-9]+' IN lv_text56 WITH | |.
*
*out->write( lv_text56 ).

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 5.7 EXPRESIONES REGULARES
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" adicionar restricciones más específicas en una cadena de caracteres

**** REPLACE
" VAL = DONDE ESTÁ EL CONTENIDO QUE QUEREMOS EVALUAR O REEMPLAZAR
" PCRE = PATRON (CASE SENSITIVE)
"EJ BUSCA p en minúsculas entre 2 o 4 repeticiones
" WUTH con qúé caracter se reemplaza (si cumple lo anterior)
" occ = o En todos los casos que localice
" ej PCRE = [^SAP] lo que no cumple lo reemplaza con * (with)
" letras inidividuales, S, A, P.
" EJ \s queremos busar un espacio y lo reemplaza por //

*** REPLACE ALL OCURRENCIES OF pcre ExpresionRegular IN variable WITH reemplazamos con.
" Ej espacio reemplza con ?




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 5.8 REPETICIONES DE STRINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
**** REPEAT
*""" Cadena que contiene el contenido específico val y lo repito tantas veces como se indique occ
*"" devuelve cero si val está vacío o occ = 0
*
***********************************************************************
*" ej 1 repetir val 4 veces
*" eJ 2 repetir 10 espacios
*" ej 3 si occ <0 -> dum error programación
*" para omitir hay que tratar con try ENDTRY y colocar la excepción cx_sy entre DATA y la impresión.
*" EL cx_sy se toma del show
***********************************************************************
*
*****Repeat
*
*"repeat() repite una cadena tantas veces como indique el parámetro occ
*
*DATA(lv_text) = repeat( val = 'Logali' occ = 4 ).
*out->write( lv_text ).
*
*"repeat() puede usarse dentro de una expresión string template
*
*DATA(lv_text2) = | abap { repeat( val = ' ' occ = 10 ) } abap |.
*out->write( lv_text2 ).
*
*"Si occ es negativo, repeat lanza excepción CX_SY_STRG_PAR_VAL
*
*
*    DATA(lv_text3) = | abap { repeat( val = ' ' occ = -10 ) } abap |.
*    out->write( 'Invalid operation' ).
*
*

*TRY.
*    DATA(lv_text3) = | abap { repeat( val = ' ' occ = -10 ) } abap |.
*CATCH cx_sy_strg_par_val.
*    out->write( 'Invalid operation' ).
*ENDTRY.


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 5.9 FUNCION ESCAPE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Se usa para manejar caracteres especiales en cadenas de texto, como comillas simples y dobles,
"especialmente en contextos como SQL, JSON, o XML, donde es necesario evitar errores de sintaxis.
" Devuelve cadena de caracteres dependiendo del formato que usamos dentro de sus parametros
    " val = cadena de caracteres
    " format = cl_abap_format=>url_full / e_json_string / e-string_tpl
    " recordar CL es clase global

**********************************************************************
" por ej formato url, json o plantillas de strings

**********************************************************************
" ejemplo 3 tipos de conversiones

****ESCAPE

"URLs -> escape convierte caracteres especiales a formato válido para URL (codificación %)

DATA(lv_url) = escape( val = 'Logali ABAP Academy @300' format = cl_abap_format=>e_url_full ).
out->write( lv_url ).

"JSON -> escape adapta caracteres especiales al estándar JSON (comillas, \, etc.)

DATA(lv_json) = escape( val = 'Logali "ABAP" test json \ Academy @300' format = cl_abap_format=>e_json_string ).
out->write( lv_json ).

"String templates -> escape protege caracteres especiales usados en templates (\ | { })

DATA(lv_string_escape) = escape( val = 'Special characters in string templates: |, \, {, }' format = cl_abap_format=>e_string_tpl ).
out->write( lv_string_escape ).













  ENDMETHOD.

ENDCLASS.
