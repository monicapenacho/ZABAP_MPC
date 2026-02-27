CLASS zcl_mpc_b2_ex06_5_conv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_b2_ex06_5_conv IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  "Forced type conversions CONV

    DATA(lv_date_inv) = '20250101'.  "fecha factura"
    out->write( lv_date_inv ).        " tipo c cadena de caracteres (breakdown)

    DATA(lv_date_inv2) = CONV d( lv_date_inv ).  "indicar el tipo al que queremos convertir despues de conv
    out->write( lv_date_inv2 ). "Impirimir el valor de la segunda variable. BREAKPOINT DEBUG - TIPO FECHA D

   "Date and Time

    DATA: lv_date  TYPE d,
          lv_time  TYPE t,
          lv_time2 TYPE c LENGTH 6.

    lv_date = cl_abap_context_info=>get_system_date(  ).     "fecha actual del servidor "cl es una clase global con la que podemos acceder al
                                         " método de formato UTC (TIEMPO coordinado universa)
                                         "formato generalizado para representar fecha actual

    lv_time = cl_abap_context_info=>get_system_time(  ). "hora actual del servidor

    lv_time2 = cl_abap_context_info=>get_user_time_zone(  ). "zona horaria

    out->write( lv_date ).
    out->write( lv_time ).
    out->write( lv_time2 ).

    """
    "OPERACION DIAS ENTRE DOS FECHAS

    DATA: lv_date3 TYPE d VALUE '20250101',
          lv_date4  TYPE d VALUE '20250622',
          lv_time5  TYPE t,
          lv_time6 TYPE c LENGTH 6.

    "declarar una variable para almacenar el resultado de la dif entre dos fechas (compilador lo convierte en nº entero)

    DATA(lv_days) = lv_date4 - lv_date3.

    out->write( lv_days ). "en nº entero. Modificamos fecha cambia el resultado . Hacer prueba


    """
    " OFFSET + LONGITUD fecha y hora acceder individualmente a los componentes DE UNA FECHA AAAAMMDD O HORA

*    DATA(lv_month) = lv_date3+4(2). "desplazamiento de posiciones(nº posiciones que tomamos para el mes). El mes 2 digitos
*    out->write( lv_month ). "Imprimir el mes
*
*    DATA(lv_year) = lv_date3(4). "no hay + porque no hay desplazamiento de posiciones(nº posiciones que tomamos para el año). El año 4 digitos
*    out->write( lv_year ). "Imprimir el año
*
*    DATA(lv_day) = lv_date3+6(2). "+ desplazamiento de posiciones(nº posiciones que tomamos para el dia). El dia 2 digitos
*    out->write( lv_day ). "Imprimir el dia
*
*    DATA(lv_hour) = lv_time5+0(2). "desplazamiento de posiciones

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " UTCLONG (FORMATO ISO 86 01)

*    DATA: lv_timestamp1 TYPE utclong ,
*          lv_timestamp2 TYPE utclong.
*
**    lv_timestamp1 = utclong_current(  ).
**
**    out->write( lv_timestamp1 ).
*
*"también se puede usar para operar (ejempo de 25 a 26 y de 10 a 9 horas)
*
**    lv_timestamp1 = utclong_add( val = lv_timestamp1 days = 1 hours = -1 ). "sumamos 1 día a la fecha anterior restamos horas con nº negativo
**
**    out->write( lv_timestamp1 ).
*
*        "diferencia entre dos fechas
*        lv_timestamp1 = utclong_current( ).      " Obtiene el timestamp actual en formato UTC de alta precisión (momento exacto ahora)
*
*        lv_timestamp2 = utclong_current( ).      " Obtiene nuevamente el timestamp actual (segundos/microsegundos después del anterior)
*
*        lv_timestamp2 = utclong_add(             " Modifica el segundo timestamp sumando/restando tiempo
*                           val   = lv_timestamp2 " Valor base sobre el que vamos a operar
*                           hours = -5 ).         " Restamos 5 horas (timestamp ahora representa 'hace 5 horas')
*
*        DATA(lv_diff) = utclong_diff(            " Calcula la diferencia entre dos timestamps UTC
*                             high = lv_timestamp1 " Timestamp mayor (más reciente)
*                             low  = lv_timestamp2 ). " Timestamp menor (más antiguo)
*        " Resultado: diferencia en segundos (tipo decfloat34)
*
*        out->write( lv_diff ). "ver resultado en segundos
*                                    "si queremos transformarlo a horas, días tenemos que reaelizar la conversión

        "" conversión
        DATA: lv_time10 TYPE utclong,
              lv_time11 TYPE utclong,
              lv_date12 TYPE d,
              lv_time13 TYPE t.

        lv_time10 = utclong_current( ).      " Obtiene el timestamp actual en formato UTC de alta precisión (momento exacto ahora)

        lv_time11 = utclong_current( ).      " Obtiene nuevamente el timestamp actual (segundos/microsegundos después del anterior)

        convert UTCLONG lv_time10
        TIME ZONE cl_abap_context_info=>get_user_time_zone( )            "acceder a zona horario del usuario actual (formato utc)
        INTO DATE lv_date12
        TIME lv_time13.

        out->write( lv_date12 ). "transformación de formato utclong a separación fecha y hora
        out->write( lv_time13 ). "transformación de formato utclong a separación fecha y hora

      ENDMETHOD.
ENDCLASS.
