CLASS zcl_mpc_b7_ex12_1_dd_tipo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mpc_b7_ex12_1_dd_tipo IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  " DICCIONARIO DATOS
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " 1.1. Introducción Diccionario de datos
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*  🟡 ABAP Cloud Dictionary
*
*Es el centro del modelo de datos en SAP.
*
*Aquí se definen los objetos que describen cómo se guardan, bloquean y estructuran los datos del sistema.
*
*Todo lo que usa ABAP para trabajar con datos sale del Dictionary.
*
*📦 Tables
*1️⃣ Persistence Tables
*
*Son tablas físicas en la base de datos.
*
*Ejemplo:
*
*/DMO/BOOKING_M
*
*Sirven para guardar datos permanentemente.
*
*Ejemplo de datos:
*
*clientes
*
*pedidos
*
*vuelos
*
*2️⃣ Temporal Tables
*
*Son tablas temporales.
*
*Se usan para:
*
*cálculos
*
*procesos intermedios
*
*datos que no se guardan permanentemente
*
*Cuando termina el proceso se eliminan.
*
*📊 Index
*
*Los índices sirven para acelerar búsquedas en tablas.
*
*Como el índice de un libro.
*
*3️⃣ Table Index
*
*Índice creado para mejorar la velocidad de SELECT.
*
*Ejemplo:
*
*Si buscas mucho por:
*
*CARRIER_ID
*
*puedes crear un índice.
*
*Resultado:
*
*SELECT más rápido
*4️⃣ Extension Index
*
*Índice añadido por extensiones o clientes.
*
*Se usa cuando:
*
*no puedes modificar la tabla estándar
*
*pero necesitas un índice adicional
*
*Muy común en S/4HANA extensiones.
*
*🔒 Lock Objects
*
*Controlan bloqueos de datos.
*
*Evitan que dos usuarios modifiquen el mismo registro a la vez.
*
*Ejemplo:
*
*Usuario A edita un pedido.
*
*Usuario B intenta editarlo.
*
*SAP responde:
*
*Registro bloqueado
*⚡ Cache
*
*Guarda datos temporalmente en memoria para acceder más rápido.
*
*En vez de ir siempre a la base de datos.
*
*Resultado:
*
*mejor rendimiento
*🧱 Data Types
*
*Definen la estructura de los datos.
*
*5️⃣ Domains
*
*Define tipo técnico del dato.
*
*Ejemplo:
*
*tipo: CHAR
*longitud: 3
*valores permitidos: EUR, USD
*
*Es la base del campo.
*
*6️⃣ Data Elements
*
*Añade significado al dominio.
*
*Define:
*
*descripción
*
*etiqueta
*
*ayuda F1
*
*Ejemplo:
*
*CURRENCY_CODE
*7️⃣ Structures
*
*Conjunto de varios campos agrupados.
*
*No guarda datos.
*
*Ejemplo:
*
*Nombre
*Apellido
*Email
*Teléfono
*8️⃣ Table Types
*
*Define tipos de tablas internas ABAP.
*
*Ejemplo:
*
*STANDARD TABLE
*SORTED TABLE
*HASHED TABLE
*
*Sirve para declarar:
*
*DATA lt_flights TYPE TABLE OF sflight.
*📌 Resumen rápido
*Objeto  Para qué sirve
*Persistence Tables  Guardar datos
*Temporal Tables Datos temporales
*Table Index Acelerar SELECT
*Extension Index Índices extra
*Lock Objects    Bloquear registros
*Cache   Mejorar rendimiento
*Domains Tipo técnico del campo
*Data Elements   Significado del campo
*Structures  Agrupar campos
*Table Types Definir tablas internas
*
*✅ Idea clave que debes recordar en ABAP
*
*Domain → tipo técnico
*Data Element → significado
*Table → datos reales
*Structure → agrupación

"Los tipos (como elementos de datos, estructuras, tipo tablas,) se pueden incorporar en la lógica de programación
"aunque son objetos creados en el diccionardio de datos. Se pueden reutilizar
" Diccionario de datos . Cuando hablamos del modelado las tablas de bbdd se van a exponer
" como vistas de bases de datos  con core data services que es el núcleo que permite explotar la información
" también se pueden incorporar en la lógica de programación
" Puede haber interacción de la interfaz de usuario para manipular los datos de las tablas

" Diccionario de datos es el núcleo o corazón que permite interactura con la capa de persistencia
" y también con el tipo de datos que se van a usar en el servidor de aplicaciones
"para permitir escalar desde el servidor de base de datos a la lógica del servidor de aplicaciones
" para llegar después a la IU INTERFAZ DE USUARIO

  " 1.2. Dominio
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Se usa para describir el campo de valores posibles
" es un objeto de caracter técnico
" representación del nivel más bajo para determinar el tipo de datos de un objeto





  ENDMETHOD.
ENDCLASS.
