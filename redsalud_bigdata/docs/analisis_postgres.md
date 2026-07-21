==========================================
   ANALISIS COMPARATIVO - REDSALUD DIGITAL
==========================================

=== 1. CONTEO DE REGISTROS ===
   tabla    | registros 
------------+-----------
 pacientes  |        20
 medicos    |         4
 atenciones |        25
(3 rows)


=== 2. VALIDACION DE INTEGRIDAD REFERENCIAL ===
 atenciones_huerfanas 
----------------------
                    0
(1 row)


=== 3. ATENCIONES POR TIPO (caso RedSalud) ===
 tipo_atencion | total | promedio_ms 
---------------+-------+-------------
 urgencia      |     9 |      116.11
 teleconsulta  |     8 |       76.88
 control       |     8 |      112.50
(3 rows)


=== 4. ATENCIONES POR REGION (sharding key propuesto) ===
    region     | total | monto_promedio 
---------------+-------+----------------
 Metropolitana |    15 |          42067
 Valparaiso    |     4 |          26250
 Biobio        |     1 |          65000
 Coquimbo      |     1 |          42000
 Araucania     |     1 |          22000
 Antofagasta   |     1 |          28000
 O'Higgins     |     1 |          12000
 Maule         |     1 |          35000
(8 rows)


=== 5. TOP 5 DIAGNOSTICOS ===
      diagnostico      | casos 
-----------------------+-------
 Resfriado comun       |     1
 Infeccion urinaria    |     1
 Hipertension arterial |     1
 Apendicitis           |     1
 Control asma          |     1
(5 rows)


=== 6. CARGA POR MEDICO (con especialidad) ===
             nombre             |   especialidad   | atenciones 
--------------------------------+------------------+------------
 Dra. Patricia Salazar Rojas    | Medicina General |          7
 Dr. Ricardo Fuentes Mendez     | Cardiologia      |          7
 Dr. Mauricio Concha Vidal      | Pediatria        |          6
 Dra. Lorena Espinoza Gutierrez | Urgencias        |          5
(4 rows)


=== 7. PACIENTES CON MAS DE 1 ATENCION ===
 id_paciente |        nombre         | total_atenciones 
-------------+-----------------------+------------------
           9 | Valentina Rojas Diaz  |                2
           3 | Ana Munoz Rojas       |                2
           5 | Carla Diaz Castro     |                2
           7 | Sofia Lopez Henriquez |                2
           1 | Maria Gonzalez Silva  |                2
(5 rows)