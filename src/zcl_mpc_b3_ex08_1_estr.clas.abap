CLASS zcl_mpc_b3_ex08_1_estr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_b3_ex08_1_estr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " 1. ESTRUCTURAS DE CONTROL
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

   """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
     "1.1 EXPRESIONES LOGICAS
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   " Son condiciones que se utilizan para tomar decisiones en el flujo de un programa,
    "generalmente dentro de estructuras de control como IF, CASE, o bucles LOOP.
    "Estas expresiones evalúan una condición que puede ser verdadera o falsa, y
    " permiten ejecutar diferentes bloques de código según el resultado.

    "Una expresión lógica típica en ABAP incluye
        "operadores de comparación (como =, <>, >, <, >=, <=),
        " operadores lógicos (AND, OR, NOT), y
        " se puede usar con variables, literales o funciones.

   "expresiones relacionales individuales o expresiones combinadas (como por ejemplo
   "con booleanos como not, and y or

   "TIPOS DE OPERADORES (ver print pantalla)
   " COMPARACION
   " LOGICOS
   " Evaluación de una secuencia por ej not antes del and
   " expresiones lógicas especiales (por ejem ver si el contenido en una tabla es inicial
   " ver rangos entre expresiones o fechas
   " Podemos comporrar valores iguales, diferentes etc

   "BIFURCACIONES CONDICIONALES / CICLOS / ITERACIONES / EXPRESIONES LOGICAS

   """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
     "1.2 IF / ENDIF
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*   " BIFURCACION CONDICIONAL
*
*   "declaración en linea de una variable lv_char. Tipo de la variable se toma en el contexto de la ejecución dependiendo del valor que reciba la variable
*   "Dependiendo Si se cumple o no la condición se puede ejecutar o no cierta lógica.
*   " si no se cumple la condición no arroja nada
*   " por eso se recomienda usar ELSIF para que vaya a la 2º condición y ejecute el bloque de la siegunda condición
*   " solo se ejecuta el bloque del código que corresponde a la condición que se cumple
*   " ver a la izquierda de IF el bloque se puede maximizar o minimizar
*   " si ninguna condición se cumple incluimos un bloque ELSE para que se ejecute este camino
*   " se puede indicar un mensaje de que el valor está indefinido
*    "ELSIF Y ELSE son opcionales
*
*   "Ejemplo de bifurcación condicional
*  "Declaración en línea: se crea una variable tipo c(1) con valor inicial 'C' " I
*  "Ir cambiando el valor de la variable para ver cómo se va ejecutando los distintos ELSIF Y ELSE
*
*  DATA(lv_char) = 'C'.
*
*  "EQ (Equal): compara si la variable es exactamente 'A'
*  IF lv_char EQ 'A'.
*    out->write( lv_char ).
*
*  "Si no es 'A', evalúa si es 'B'
*  ELSEIF lv_char EQ 'B'.
*    out->write( lv_char ).
*
*  "Si no es 'A' ni 'B', evalúa si es 'C'
*  ELSEIF lv_char EQ 'C'.
*    out->write( lv_char ).
*
*  "Si no coincide con ningún caso anterior
*  ELSE.
*    out->write( 'Unidentified' ).
*
*  ENDIF.
*
*    "**** Ej2
*
*       " condiciones de bifurcación también se pueden incluir los operadores
*   " EQ
*   " NE
*   " LT
*   " GT
*   " LE
*   " GE
*   " AND
*   " OR
*   " NOT
*
*    "Declaración en línea: se crea lv_num con valor entero 3
*    DATA(lv_num) = 3.
*
*    "OR -> basta con que UNA de las condiciones sea verdadera /
*    " SE puede cambiar EQ por cualquier operador de comparación
*
*    IF lv_num EQ 3 OR lv_num EQ 4.
*      out->write( 'Valid values' ).
*    ENDIF.
*
*    "NOT -> necesita que la condición sea falsa para que se cumpla
*    IF NOT lv_num EQ 5.
*      out->write( 'Valid values' ).
*    ENDIF.
*
*    "AND -> necesita que la condición sea verdadera en ambas para que se cumpla
*    IF lv_num EQ 3 AND lv_char EQ 'A'.
*      out->write( 'Valid values' ).
*    ENDIF.
*
*    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    " INSTRUCCION IF ANIDADA / NESTED IF
*    " una Instrucción if dentro de otra instrucción if.  Es importante el orden para cada if cerrarlo con endif
*    " ver print pantalla diagrama de flujo ver bloque que se ejecuta según el resultado de condición si es falsa o verdadera
*
*    "NESTED IF -> Estructura condicional anidada (evaluaciones jerárquicas)
*
*    DATA(lv_text)  = 'ABAP'.
*    DATA(lv_text2) = 'Programming'.
*    DATA(lv_text3) = 'Classes'.
*
*    "Primer nivel: valida si lv_text cumple la condición
*    IF lv_text = 'ABAP'.
*
*      "Segundo nivel: solo se evalúa si el primero es verdadero
*      IF lv_text2 EQ 'Programming'.
*
*        "Tercer nivel: validación final dentro de la jerarquía
*        IF lv_text3 = 'Classes'.
*          out->write( 'Correct' ).
*        ELSE.
*          out->write( 'Incorrect' ).
*        ENDIF.
*
*      ENDIF.
*
*    ENDIF.
*
*    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    " limpiar la variabe
*    " Evaluar si la variable tiene o no contenido
*
*    "Inicializa la variable a su valor por defecto (0 para numéricos, vacío para string, etc.)
*    CLEAR lv_num.
*
*    "IS INITIAL -> verifica si la variable está en su valor inicial del tipo de dato
*    IF lv_num IS INITIAL.
*
*      out->write( 'The variable is empty' ).
*
*    ENDIF.


   """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
     "1.3 CASE / ENDCASE
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    "
*    " Declaración en línea de la var a usar. Usar una clase estándar para obtener en la ejecución un nº random
*    " elegimos entenro y navegamos al método create (parámetros:
*    " seed = cl_abap_random=>seed( ) Pasar un mínimo y máximo
*    " range =
*    ")->get_next( ) ).  para obtener el valor del número entero
*
*    " CASE la única condición obligatoria es la inicial. Al menos incluya una condición WHEN para indicar valores = condiciones
*    " Se pueden incluir distintos WHEN o condiciones
*    " USO  MAS LIMITADO AQUÍ a diferencia de IF no tenemos operadores comparativos o logicos ni anidados
*    " WHEN OTHERS mensaje informativo para usuario final si no se cumplen las condiciones
*
***DATA(lv_client) = cl_abap_random_int=>create( seed = cl_abap_random=
*
*    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    """""CASE/ENDCASE
*
*    "Se genera un número aleatorio entre 1 y 3 para simular un cliente
*    DATA(lv_client) = cl_abap_random_int=>create(  seed = cl_abap_random=>seed( )
*                                                   min  = 1
*                                                   max  = 3  )->get_next( ).
*
*    "CASE evalúa múltiples valores posibles de una misma variable (más limpio que varios IF)
*    CASE lv_client.
*
*      "WHEN 1 -> Ejecuta este bloque si lv_client = 1
*      WHEN 1.
*        out->write( lv_client ).
*        out->write( 'Company client 1' ).
*
*      "WHEN 2 -> Ejecuta este bloque si lv_client = 2
*      WHEN 2.
*        out->write( lv_client ).
*        out->write( 'Company client 2' ).
*
*      "WHEN 3 -> Ejecuta este bloque si lv_client = 3
*      WHEN 3.
*        out->write( lv_client ).
*        out->write( 'Company client 3' ).
*
*      "WHEN OTHERS -> Caso por defecto si no coincide ningún WHEN anterior
*      WHEN OTHERS.
*        out->write( 'Client not registered in the database' ).
*
*    ENDCASE.
*
*    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    " UNA instrucción CASE se puede reemplazar por un conjunto de bloques IF pero no al revés
*    " ya que case sólo verifica una sola variable
*    " mientras que en una instrucción if se pueden verificar varias condiciones, condiciones combinadas , comparaciones etc
*    " CASE estructura más simple

   """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
     "1.4 DO / ENDDO
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    " BUCLE
*    " Este bucle SE ejecuta hasta que se cumpla número de iteraciones incluido en el código
*    " o se abandona la iteración (exid, stop, regex, continue) . Se detiene la iteración que se genera en tiempo de ejecución
*    " continue - > se ignore el código que está debajo de la sentencia continue
*    " stop - > se abandona la iteración
*    " exid - > se abandona la iteración y se detiene la ejecución del bucle
*    " regex - > se abandona la iteración y se detiene la ejecución del bucle
*    " continue - > se abandona la iteración y se vuelve a la siguiente iteración
*    " (sigue hasta que el valor sea mayor que 3)
*
**    DO
*    " TIMES = ESPEficar un número máximo de iteraciones ( se recomienda para evitar nº infinito)
*    " el sistema tiene un time out normalmente 10 minutos transcurridos los cuales - > DUMP
**
**    DO n TIMES
**    ENDDO
*    " ej en cada repetición se incrementa el valor de la variable declarada en línea en 1 (se inicializó en cero)
*
*    DATA(lv_num) = 0.
*
**    DO.
**
**      out->write( lv_num ).
**
**      lv_num += 1.     "lv_num = lv_num + 1.
**
**    ENDDO.
*
*    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    """""DO/ENDDO
*
*    "Inicializa la variable contador en 0
*    DATA(lv_num) = 0.
*
*    "DO n TIMES -> bucle controlado que se ejecuta exactamente 3 veces
*    DO 3 TIMES.
*
*      out->write( lv_num ).
*      lv_num += 1.
*
*    ENDDO.
*
*    """""DO/ENDDO
*
*    "Inicializa la variable contador en 0
*    DATA(lv_num) = 0.
*
*    "DO sin límite -> bucle infinito controlado manualmente con EXIT
*    DO.
*
*      out->write( lv_num ).
*      lv_num += 1.
*
*      "GT (Greater Than) -> si lv_num es mayor que 8, se sale del bucle
*      IF lv_num GT 8.
*        EXIT.
*      ENDIF.
*
*    ENDDO.
*
*    """""DO/ENDDO
*
*    "Inicializa la variable contador en 0
*    DATA(lv_num) = 0.
*
*    "DO sin límite -> control interno con EXIT y CONTINUE
*    DO.
*
*      out->write( lv_num ).
*      lv_num += 1.
*
*      "Si lv_num > 8, termina completamente el bucle
*      IF lv_num GT 8.
*        EXIT.
*      ENDIF.
*
*      "Si lv_num > 3, salta a la siguiente iteración (no ejecuta lo que sigue)
*      IF lv_num GT 3.
*        CONTINUE.
*      ENDIF.
*
*      out->write( 'CONTINUE' ).
*      out->write( lv_num ).
*
*    ENDDO.
*


   """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
     "1.5 CHECK / ENDCHECK
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    " SE ejecuta en bucle de bifurcación evaluando una expresión lógica y si check es verdedador
*    " continua y si es falso finaliza y sal del bucle y el programa continua con la siguiente iteraciçpm del bucle
*    " las var del ssitema se rellenan en tiempo de ejecución SY-INDEX (GUARDA INDICE POR CADA ITERACIÓN)
*
*    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    " ej cuando sea par el resto será cero. aSi HASTA 20 iteraciones
*    " CHECK si se cumple div = 0 entonces escribimos el valor actual de la var en sistema
*    " Cuando se presenta que es impar no se imprime en pantalla pero continuá
*    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*    "CHECK -> actúa como un CONTINUE implícito si la condición no se cumple
*
*    DO 20 TIMES.
*
*      "sy-index contiene el número de iteración actual del DO
*      DATA(lv_div) = sy-index MOD 2.
*
*      "Si la condición es falsa, CHECK salta a la siguiente iteración
*      CHECK lv_div = 0.
*
*      out->write( sy-index ).
*
*    ENDDO.

   """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
     "1.6 SWITCH
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*   " OPERADOR CONDICIONAL para cambiar de un valor a otro en función de la condición establecida
*   " Buenas herramienta para verificar valores porque sólo verifica la igualdad
*   " Disponible desde versión ABAP 7.4
*
*   """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*   " EJ se repita el bucle 6 veces
*   " usar variable del sistema SY-INDEX
*   " # si se usa esa autoreferencia el tipo de valor de retorno se determina automáticamente
*   " en caso contrario hay que especificarlo de forma explicita
*   " siempre incluir un WHEN
*   " SWITCH #(indicar_variable  incluir_condiciones_con_WHEN ELSE: valor_por_defecto_ si no es ninguno de los valores anteriores # = valor de la iteración
*   " EN EL operador SWITCH la variable condición debe mencionarse sólo una vez a diferencia de COND
*
*   """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*    """""SWITCH
*
*    "DO 6 TIMES -> ejecuta el bloque 6 iteraciones usando sy-index
*    DO 6 TIMES.
*
*      "SWITCH -> expresión condicional que devuelve un valor según el caso evaluado
*      DATA(lv_value) = SWITCH #( sy-index
*                                  WHEN 1 THEN |Iteration 1|
*                                  WHEN 2 THEN |Iteration 2|
*                                  WHEN 3 THEN |Iteration 3|
*                                  ELSE |# Iteration greater than 3| ).
*
*      out->write( lv_value ).
*
*    ENDDO.



   """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
     "1.7 COND
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    " Nueva forma de aplicar la lógica de IF y elseif .
*
*
*    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    " DEClaración de una variable para colocar la hora del sistema con la clase del estándar (no hay que dar los valores porque es estándar sólo trabajamos con los resultados)
*    " COND indicar el tipo de datos no genérico = nombre explicito _> tipo()
*    " COND indicar el tipo de datos que se obtiene del operado ->   #()
*    "(en_cada_when_hay que indicar la variable a evaluar a diferencia de switch   pasar la condición
*    " THEN entonces | mostrar la hora actual del sistema formateada TIME = ISO) INDICAR AL usuario que es AM.
*    " Indicamos otra condición con WHEN_indicar_variable CONDICION THEN | otra concantenación. convertir el tipo de dato CONV del tipo t = time
*    " apliacar formula paramostrarlo en un formato de 12 horas y lo formateamos TIME = ISO parte de la jornada de la tarde PM
*    " ULTIMO CASO evaluar con WHEN si la variable es igual a xxxx THEN texto explícito
*    " ELSE se puede usar para que si no se cumple ninguna condición anterior se toma este camino . eje indicar que el tiempo no se ha dientificado
*
*    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    """""COND
*
*    "Obtiene la hora actual del sistema en formato interno HHMMSS
*    DATA(lv_get_time) = cl_abap_context_info=>get_system_time( ).
*
*    "COND -> expresión condicional moderna que devuelve un valor según la condición
*    DATA(lv_time) = COND #(
*                            "Si la hora es menor a 12:00:00 → formato ISO + AM
*                            WHEN lv_get_time < '120000' THEN |{ lv_get_time TIME = ISO } AM|
*
*                            "Si la hora es mayor a 12:00:00 → convierte a formato 12h y agrega PM
*                            WHEN lv_get_time > '120000' THEN |{ conv t( lv_get_time - 12 * 3600 ) TIME = ISO } PM|
*
*                            "Si es exactamente 12:00:00 → mediodía
*                            WHEN lv_get_time = '120000' THEN |High noon|
*
*                            "Caso por defecto
*                            ELSE |Unidentified time| ).
*
*    out->write( lv_time ).




     "1.8 WHILE / ENDWHILE
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    " el bloque se ejecuta de forma continua hasta que no se cumpla la condición
*    " se verifica la condición, se evalúa la variable y si es verdadera se ejecuta el bloque
*    " así se repite hasta que se deja de cumplir la condición en cuyo caso finaliza el bucle
*    " SE PUEDE usar la sentencia EXIT para salir o CONTINUE  para ignorar el código debajo de la sentencia
*
*
*    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    " ej
*    " clear para que no tome valor anterior
*    " se puede usar operaciones de comparación por ejemplo LE
*    " Siempre cerrar ENDWHILE para que compile
*    " sy-index guarda el número de iteraciones raelizada en cada ciclo
*    " en la concatenación || la variable siempre entre { }
*
*
*    """""WHILE/ENDWHILE
*
*    "CLEAR lv_num.  "Inicializaría la variable (aquí está comentado)
*
*    DATA lv_num TYPE i.  "Entero inicializado automáticamente a 0
*
*    WHILE lv_num LE 10.  "Bucle mientras la condición sea verdadera (evaluación previa)
*
*      out->write( lv_num ).  "Muestra el valor actual antes de incrementarlo
*
**      out->write( | Iteration = { sy-index } | ).
**      "sy-index en WHILE no es contador real del bucle (solo es fiable en DO/LOOP)
*
*      lv_num += 1.  "Incremento manual del contador (control explícito del ciclo)
*
*    ENDWHILE.  "Fin del bucle controlado por condición
*
*      out->write(  'End of program' ).
*
*
*      """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*        " Incluir bifurcación condicional
*        " ej si es mayor que 5 sal del proceso
*
*
**        IF lv_num GT 5.
**          EXIT.
**        ENDIF.
**
*
*        clear lv_num.
*
*        WHILE lv_num LE 10.  "Bucle mientras la condición sea verdadera (evaluación previa)
*
*          out->write( lv_num ).  "Muestra el valor actual antes de incrementarlo
*
**      out->write( | Iteration = { sy-index } | ).
**      "sy-index en WHILE no es contador real del bucle (solo es fiable en DO/LOOP)
*
*          lv_num += 1.  "Incremento manual del contador (control explícito del ciclo)
*
*          IF lv_num GT 5.
*            EXIT.
*          ENDIF.
*
*        ENDWHILE.  "Fin del bucle controlado por condición
*
*        out->write(  'End of program' ).
*
*
*    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*   " diferencia entre el bucle DO y WHILE
*   " DO si no tenemos ntimes el codigo se ejecuta al menos una vez si no tenemos sentencia
*   " EXIT o continua coN CONTINUE . cON Esas dos formas nos salvamos del bucle infinito
*   " WHILE SI NO se cumple la condición indicada no se ejecuta nunca el código
*
*   "ej  hacer un ejemplo poniendo un value 11 a la variable
*
*   CLEAR lv_num.
*
*   lv_num = 11.
*
*   WHILE lv_num LE 10.
*     out->write( lv_num ).
*     lv_num += 1.
*     IF lv_num GT 5.
*       EXIT.
*     ENDIF.
*
*   ENDWHILE.
*   out->write(  'End of program' ). " si no se cumple la condición no se ejecuta


     "1.9 LOOP / ENDLOOP
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    " este comando se usa para iterar sobre una tabla interna
*    " permite procesar cada fila de dicha TI de forma secuencial
*    " TI es un arreglo multidimensional como un array con fias y columnas
*
*
*
*
*    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*    " ej declarar tipo local con una columna num donde esperamos recibir datos de tipo enter
*    " declaramos una tabla interna donde asignamos esa estructura
*    " TI LT_NUM
*    " declaramos dos variables
*    " mediatne operador VALUE #() INGRESAMOS LOS VALORES
*    " LOOP AT ITERACION A LA TABLA INTERNA - INTO ESTRUCTURA DONDE ALMACENAMOS LA ITERACION
*    " guardamos el registro en una estructura ls_num = nomenclatura de la estructura
*    " dentro de LOOP lógica que queremos hacer - por ej asignar un valor a la variable (-num navegar el campo de num)
*    " el primer valor que toma es cero (inicializamos el valor de la variable lv_sum = 0)
*    " imprimimos dump - > ver show cx y linea amarilla
*
*
*    """""LOOP/ENDLOOP
*
*    TYPES: BEGIN OF lty_num,          "Define una estructura con un campo num
*             num TYPE i,
*           END OF lty_num.
*
*    DATA lt_num TYPE TABLE OF lty_num.  "Tabla interna basada en la estructura (ITAB)
*
*    DATA: lv_sum   TYPE i,              "Acumulador parcial
*          lv_total TYPE i.              "Resultado final
*
*    lt_num = VALUE #( ( num = 10 )      "Inicialización moderna de tabla interna
*                      ( num = 20 )
*                      ( num = 30 ) ).
*
*    lv_sum = 0.                         "Inicializa acumulador
*
*    LOOP AT lt_num INTO DATA(ls_num).   "Recorre cada línea de la tabla (work area inline)
*
*      lv_sum = lv_sum + ls_num-num.     "Suma el campo num de cada registro
*
*    ENDLOOP.                            "Fin del recorrido secuencial
*
*    lv_total = lv_sum.                  "Asigna el total acumulado
*    out->write( lv_total ).             "Muestra resultado (60)




   """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
     "1.10 TRY / ENDTRY
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " aYuda a realizar el tratamiento de las excepciones (eventos que sucenden durante la ejecución
    " de un programa abap y que interrumpen el flujo del programa por eje poner un tipo no compatible)
    " con un dump. para evitar esto hacemos el tratamiento de estas excepciones con TRY ENDTRY

    " CX_ CLASE DE EXCEPCION GLOBAL


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "EJ declaramos tres variables
    " división nº / 0 => dump

        """""TRY/ENTRY

*        DATA: lv_num1 TYPE i VALUE 10,   "Numerador con valor 10
*              lv_num2 TYPE i VALUE 0,    "Denominador en 0 (provocará división inválida)
*              lv_res  TYPE f.            "Resultado en tipo flotante
*
*        lv_res = lv_num1 / lv_num2.      "División: genera excepción CX_SY_ZERODIVIDE (división por cero)
*
*        out->write( lv_res ).            "No se ejecuta si ocurre la excepción




    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Ej
    " copiar la excepción cx del dump
    " capturamos la excepción en una variable lv_zero_divideº
    " mostrar un mensaje más amigable


    """""TRY/ENTRY

    TRY.  "Inicio de bloque de control de excepciones

      DATA: lv_num1 TYPE i VALUE 10,   "Numerador con valor válido
            lv_num2 TYPE i VALUE 0,    "Denominador en 0 (provoca excepción)
            lv_res  TYPE f.            "Resultado en tipo flotante

      lv_res = lv_num1 / lv_num2.      "Genera CX_SY_ZERODIVIDE (división por cero)

      out->write( lv_res ).            "Solo se ejecuta si no hay error

    CATCH cx_sy_zerodivide INTO DATA(lx_zero_divide).  "Captura excepción específica

      out->write( 'Error: division by zero detected' ).  "Manejo controlado del error

    ENDTRY.  "Fin del bloque protegido



   """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
     "2 ESTRUCTURAS Y TIPOS LOCALES
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


   """""""""""""""""""""""""""""""""""

  ENDMETHOD.
ENDCLASS.
