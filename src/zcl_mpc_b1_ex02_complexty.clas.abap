CLASS zcl_mpc_b1_ex02_complexty DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun . "VER RESULTADOS EN CONSOLA
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_b1_ex02_complexty IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

**********************************************************************
* Tipos de datos complejos se componen de otros tipos (eje estructurado, tabla, enumerado...)

**********************************************************************

**********************************************************************
* 1.- Tipos Estructurados BEGIN OF  END OF
**********************************************************************

TYPES: BEGIN OF lty_employee,           "Tipo local estructurado
        id TYPE i,
        name TYPE string,
        age TYPE i,
      END OF lty_employee.

 DATA ls_employee TYPE lty_employee.    " Declarar una estructura que guarde esta información
                                        " asignamos el tipo estructurado creado arriba

 ls_employee = VALUE #( id = 1          "asginar valor a estructura o tabla interna VALUE #()
                        name = 'Juan'
                        age = 35 ).

* out->write( | ID: { ls_employee-id } Name: { ls_employee-name } Age: { ls_employee-age }| ). " CONCATENACION | CADENA DE CARACTERES |{VARIABLE } ver en consola. Con out navegamos a write
                                         "recordar cerrar con punto las lineas de instrucciones para evitar errores
                                         "Borrar consola, activar clase global y ejecutar con F9
                                         "Comentar la salida para no verla en consola

**********************************************************************
* 2.- Tipos ENumerados BEGIN OF ENUM  END OF ENUM
* Representa un grupo de valores con su tipo definido

**********************************************************************

TYPES: BEGIN OF ENUM lty_invoices_status,           "Tipo local enumerado
       pending_payment,
       paid,
      END OF ENUM lty_invoices_status.

DATA lv_status TYPE lty_invoices_status.    "Declarar una variable donde guardemos la ino

*lv_status = pending_payment.                 "Asignar valor y hacer múltiples operaciones
lv_status = paid.                 "Asignar valor y hacer múltiples operaciones

                                             "CASE evaluar cada estado

out->write( lv_status ).                     "Mostrar en pantalla el valor de la variable en su estado actual
                                             "activar y ejecutar
                                             "Cambiar valor a paid, activar y ejecutar

**********************************************************************
* 3.- Tipos MESH (MALLA)
* Contiene sólo tablas como componentes

**********************************************************************

  ENDMETHOD.
ENDCLASS.
