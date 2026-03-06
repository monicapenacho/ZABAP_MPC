CLASS zcl_mpc_b5_ex10_3_fs DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_b5_ex10_3_fs IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  "•    2. Field symbols
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " 2.1. Concepto y Declaración
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*  " FIELD-SYMBOLS
*  " apuntadores o símbolos de campo
*  " punteros a datos
*  " permiten trabajar con datos de manera dinámica y flexible
*  " por eje referencia a área de memoria que cambia durante el tipo de ejecución. apunta a una ubicación en memoria donde se almacenan los datos
*  " declaración CON FIELD-SYMBOLS y luego se asigna con ASSIGN
*  " No reserva espacio en memoria
*
*  " FIELD-SYMBOLS TIPOS
*        " F-S CON TIPO
*        " F-S GENERICOS
*
*  " SINTAXIS
*   "FIELD-SYMBOLS <gfs_nombre_apuntador> TYPE tipo_que_espera_recibir.
*   "ASSING asignar_area_de_memoria_ej_espacio_en_memoria_de_la_variable_gv_employee TO gfs_nombre_del_apuntador
*   " gfs_nombre_apuntador = dar_valor_al_apuntador
*   " IMPRIMIR ( colocar_la_variable_no_el_apuntador)
*
*
*  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"FIELD-SYMBOL TIPO STRING
*  "Este bloque demuestra el uso de FIELD-SYMBOLS como referencia dinámica a una variable existente,
*"mediante la sentencia ASSIGN para enlazar gv_employee con <gfs_employee>,
*"evidenciando que la asignación a través del field-symbol modifica directamente
*"el contenido de la variable original al compartir la misma dirección de memoria.
*
*DATA gv_employee TYPE string.
*
*FIELD-SYMBOLS <gfs_employee> TYPE string.
*
*ASSIGN gv_employee TO <gfs_employee>.
*
*<gfs_employee> = 'Maria'.
*
*out->write( gv_employee ).
*
*  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"FIELD-SYMBOL TIPO DE TABLA BASE DE DATOS
*
*"traer la info de la bbdd con una lectura select FROM
*"volcamos la info en una tabla interna gt_employees (declarada en línea con data)
*" con la ayuda del apuntador FS vamos a modificar la información de algún campo ej mail
*" añadimos con una iteración con LOOP at con una estructura para guardar los registros
*" otro loop AT para asignar el apuntador-
*
*
*"Este bloque demuestra la diferencia entre el procesamiento tradicional de una tabla interna usando LOOP INTO
*"(que trabaja con una copia de la línea) y el uso de LOOP ASSIGNING con FIELD-SYMBOLS
*"(que trabaja directamente sobre la referencia en memoria), evidenciando la modificación eficiente
*"de registros sin copia intermedia y mostrando el resultado antes y después del uso de field-symbols.
*
*FIELD-SYMBOLS <gfs_employee2> TYPE zemploy_table.
*
*SELECT FROM zemplpy_table
*  FIELDS *
*  INTO TABLE @DATA(gt_employees).
*
*LOOP AT gt_employees INTO DATA(gs_employee).
*  gs_employee-email = 'NEW-EMAIL@LOGALIGROUP.COM'.
*ENDLOOP.
*
*out->write( data = gt_employees name = 'Structure' ).
*
*LOOP AT gt_employees ASSIGNING <gfs_employee2>.
*  <gfs_employee2>-email = 'NEW-EMAIL@LOGALIGROUP.COM'.
*ENDLOOP.
*
*out->write( data = gt_employees name = 'Field Symbols' ).

" 2.2 DECLARACION EN LINEA
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" Se pueden declarar en linea, variables, estructuras, tabla interna, apuntador
*" se asigna el apuntador a un área de memoria dentro de la declaración
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*DATA gv_employee TYPE string.
*
*ASSIGN gv_employee TO FIELD-SYMBOL(<gfs_employee>). "Declaración en línea
*
*<gfs_employee> = 'Maria'.
*
*out->write( gv_employee ).
*
**UNASSIGN <gfs_employee>. "eliminación de la referencia del apuntador a la variable
**
**<gfs_employee> = 'Maria'.
**
**out->write( gv_employee ). " ERROR de programación porque lo he desreferenciado
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
**SELECT FROM zemplpy_table
**  FIELDS *
**  INTO TABLE @DATA(gt_employees).
**
**LOOP AT gt_employees INTO DATA(gs_employee).
**  gs_employee-email = 'NEW-EMAIL@LOGALIGROUP.COM'.
**ENDLOOP.
**
**out->write( data = gt_employees name = 'Structure' ).
**
**LOOP AT gt_employees ASSIGNING FIELD-SYMBOL(<gfs_employee2>). "Declaración en línea
**  <gfs_employee2>-email = 'NEW-EMAIL@LOGALIGROUP.COM'.
**ENDLOOP.
**
**out->write( data = gt_employees name = 'Field Symbols' ).
*
*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*"DECLARACION IMPLICITA CON EL FOR
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
**DATA gt_employees_for TYPE STANDARD TABLE OF zemploy_table.
**
**SELECT FROM zemplpy_table
**  FIELDS *
**  INTO TABLE @DATA(gt_employees).
**
**LOOP AT gt_employees INTO DATA(gs_employee).
**  gs_employee-email = 'NEW-EMAIL@LOGALIGROUP.COM'.
**ENDLOOP.
**
**out->write( data = gt_employees name = 'Structure' ).
**
**LOOP AT gt_employees ASSIGNING FIELD-SYMBOL(<gfs_employee2>). "Declaración en línea
**  <gfs_employee2>-email = 'NEW-EMAIL@LOGALIGROUP.COM'.
**ENDLOOP.
**
**out->write( data = gt_employees name = 'Field Symbols' ).
**
**"Este bloque demuestra el uso de la expresión FOR dentro de VALUE
**" para construir una nueva tabla interna recorriendo gt_employees,
**"utilizando un field-symbol como variable de iteración
**"y la expresión CORRESPONDING para mapear automáticamente los campos
**"con el mismo nombre, generando así una copia estructurada y
**"tipada de los registros en una sola instrucción declarativa.
**
**gt_employees_for = VALUE #(
**  FOR <gfs_employee3> IN gt_employees
**    ( CORRESPONDING #( <gfs_employee3> ) )
**).
**
**out->write( data = gt_employees_for name = 'gt_employees_for' ).


*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" tabla
*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*DATA gt_employees TYPE zcl_mpc_zemploy_table_itab=>zemp_itab.

" 2.3 AÑADIR REGISTROS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" PUEDEN añadir, insertar o leer registros
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*" APPEND INITIAL LINE TO indicar_donde_lo queremos_añadir
*"declaramos field-symbol dentro de assign
*
*SELECT FROM zemploy_table
*  FIELDS *
*  INTO TABLE @DATA(gt_employees).
*
*"agregamos una línea inicial vacía y luego datos con el id siguiente que corresponde
*
*" Este bloque demuestra el uso de APPEND INITIAL LINE ASSIGNING FIELD-SYMBOL
*" para crear dinámicamente una nueva línea en una tabla interna y rellenarla
*" mediante la expresión constructora VALUE #(), modificando directamente la
*" referencia en memoria sin variables auxiliares intermedias.
*
*APPEND INITIAL LINE TO gt_employees ASSIGNING FIELD-SYMBOL(<lfs_employee_apd>).
*
*<lfs_employee_apd> = VALUE #(
*  mandt         = sy-mandt
*  id            = '00000000000000000005'
*  first_name    = 'Daniel'
*  last_name     = 'Mora'
*  email         = 'dmora@logaligroup.com'
*  phone_number  = 123456
*  salary        = '6000'
*  currency_code = 'EUR'
*).
*
*out->write( data = gt_employees name = 'gt_employees' ).
*
*" si necesitamos variso registros necesitamos una iteración.
*" para incluir info dentro de TI podemos usar estructura o apuntador (recomendación)

" 2.4 INSERTAR REGISTROS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*"APPEND - SE AÑADE EL REGISTRO SIEMPRE EN LA ULTIMA POSICION
*"INSERT - SE AÑADE EL REGISTRO DEPENDIENDO DEL INDICE QUE LE INDIQUEMOS
*
*"APPEND TO
*    SELECT FROM zemploy_table
*      FIELDS *
*      INTO TABLE @DATA(gt_employees).
*
*    APPEND INITIAL LINE TO gt_employees ASSIGNING FIELD-SYMBOL(<lfs_employee_apd>).
*
*    <lfs_employee_apd> = VALUE #(
*                                      mandt         = sy-mandt
*                                      id            = '00000000000000000005'
*                                      first_name    = 'Daniel'
*                                      last_name     = 'Mora'
*                                      email         = 'dmora@logaligroup.com'
*                                      phone_number  = 123456
*                                      salary        = '6000'
*                                      currency_code = 'EUR'
*                                ).
*
*    out->write( data = gt_employees name = 'gt_employees' ).
*
*" INSERT INTO
*
*" colocar de forma explícita el índice. Si no se coloca se pone en la posición 1
*
*" Este bloque demuestra el uso de INSERT INITIAL LINE INTO ... INDEX
*" para insertar una nueva línea en una posición específica de la tabla interna,
*" asignando la referencia mediante FIELD-SYMBOL y rellenando sus componentes
*" con la expresión constructora VALUE #(), controlando explícitamente el orden lógico de los registros.
*
*    INSERT INITIAL LINE INTO gt_employees ASSIGNING FIELD-SYMBOL(<lfs_employee_ins>) INDEX 2.
*
*    <lfs_employee_ins> = VALUE #(
*                                      mandt         = sy-mandt
*                                      id            = 00006
*                                      first_name    = 'Sofia'
*                                      last_name     = 'Martinez'
*                                      email         = 'smartinez@logaligroup.com'
*                                      phone_number  = 456789
*                                      salary        = '2000'
*                                      currency_code = 'COP'
*                                    ).
*
*    out->write( data = gt_employees name = 'gt_employees' ).

" 2.5 LEER REGISTROS - READ TABLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*" READ TABLE WITH KEY - Hay que especificar el campo y el valor del campo que queremos leer
*" de esta forma el FS apunta a ese registro o espacio de memoria
*" una vez leido lo cambiamos
*
*"
*" Este bloque demuestra el uso de READ TABLE ... ASSIGNING FIELD-SYMBOL
*" para localizar dinámicamente un registro por clave (WITH KEY) en una tabla interna,
*" modificando directamente sus componentes en memoria mediante desreferenciación,
*" sin copiar datos a una estructura auxiliar, optimizando rendimiento y claridad.
*
*READ TABLE gt_employees ASSIGNING FIELD-SYMBOL(<lfs_employee_rd>) WITH KEY first_name = 'Sofia'.
*
*<lfs_employee_rd>-last_name = 'Rivera'.
*<lfs_employee_rd>-email     = 'srivera@experis.com'.
*
*out->write( data = gt_employees name = 'gt_employees' ).
*
*
*" La tabla de BBDD sigue exactamente igual (SALVO INSERT, MODIFY, UPDATE, DELETE)


" 2.6. Coerción – Casteo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Conversiones con especificaciones de forma implícita o explícita
" forzamos el casteo

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


*TYPES: BEGIN OF  gty_date,
*                 year(4)  TYPE n,
*                 month(2) TYPE n,
*                 day(2)   TYPE n,
*       END OF    gty_date.
*
*FIELD-SYMBOLS <lfs_date> TYPE gty_date.
*
*DATA(lv_date) = cl_abap_context_info=>get_system_date( ).
*
**ASSIGN lv_date TO <lfs_date>. "error son incompatibles
*
*"CASTEO IMPLICITO: CASTING
*
*" Este bloque demuestra el uso de CASTING con ASSIGN para reinterpretar
*" el contenido binario de un campo tipo DATS (YYYYMMDD) como una estructura
*" compuesta por año, mes y día, permitiendo acceder a sus componentes sin copia
*" de datos, mediante desreferenciación directa en memoria.
*
*ASSIGN lv_date TO <lfs_date> CASTING. "CASTEO IMPLICITO
*
*out->write( <lfs_date>-year ).
*out->write( <lfs_date>-month ).
*out->write( <lfs_date>-day ).

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CASTEO EXPICITO: CASTING TYPE
" CREAR VARIOS APUNTADORES
" Este bloque demuestra el uso combinado de CASTING genérico y ASSIGN COMPONENT
" para recorrer dinámicamente los componentes de una estructura reinterpretada
" desde un campo DATS, accediendo a sus partes (año, mes, día) mediante
" asignación dinámica en tiempo de ejecución y controlando el fin con sy-subrc.

TYPES: BEGIN OF  gty_date,
                 year(4)  TYPE n,
                 month(2) TYPE n,
                 day(2)   TYPE n,
       END OF    gty_date.

FIELD-SYMBOLS: <lfs_date>  TYPE gty_date,
               <lfs_date2> TYPE any,                        "TIPO GENERICO - requiere CASTEO EXPLICITO: CASTING TYPE
               <lfs_date3> TYPE n.


DATA(lv_date) = cl_abap_context_info=>get_system_date( ).


ASSIGN lv_date TO <lfs_date> CASTING.                                      "CASTEO IMPLICITO
ASSIGN lv_date TO <lfs_date2> CASTING TYPE gty_date.                       "CASTEO EXPLICITO - pasamos tipo de conversión

*out->write( <lfs_date2>-year ). "ERROR ACCESO a componentes porque field-symbol no tiene estructura
                                                             "y no encuentra el componente de año
                                 " con un do le asignamos los componentes
                                 " tenemos que indicar una salida al do en do

DO.

  ASSIGN COMPONENT sy-index OF STRUCTURE <lfs_date2> TO <lfs_date3>.

  IF sy-subrc NE 0.
    EXIT.
  ENDIF.

  out->write( <lfs_date3> ).

ENDDO.




  ENDMETHOD.
ENDCLASS.
