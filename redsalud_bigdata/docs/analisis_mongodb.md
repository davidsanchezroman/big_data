redsalud_db> ==========================================

redsalud_db>    ANALISIS COMPARATIVO - MONGODB

redsalud_db> ==========================================

redsalud_db> 

redsalud_db> 
redsalud_db> === 1. CONTEO DE REGISTROS ===

redsalud_db> pacientes: 20

redsalud_db> medicos: 4

redsalud_db> atenciones: 25

redsalud_db> 
redsalud_db> 

redsalud_db> === 2. INTEGRIDAD (documentos embebidos completos) ===

redsalud_db> atenciones con paciente embebido: 25

redsalud_db> atenciones con medico embebido: 25

redsalud_db> 
redsalud_db> 

redsalud_db> === 3. ATENCIONES POR TIPO ===

redsalud_db> | | {"_id":"teleconsulta","total":8,"promedio_ms":76.875}
{"_id":"urgencia","total":9,"promedio_ms":116.11111111111111}
{"_id":"control","total":8,"promedio_ms":112.5}

redsalud_db> 
redsalud_db> 

redsalud_db> === 4. ATENCIONES POR REGION ===

redsalud_db> | | {"_id":"Metropolitana","total":13,"monto_promedio":34384.61538461538}
{"_id":"Coquimbo","total":1,"monto_promedio":15000}
{"_id":"Maule","total":2,"monto_promedio":36500}
{"_id":"Valparaiso","total":4,"monto_promedio":25500}
{"_id":"Antofagasta","total":1,"monto_promedio":120000}
{"_id":"Araucania","total":1,"monto_promedio":28000}
{"_id":"Biobio","total":2,"monto_promedio":53500}
{"_id":"OHiggins","total":1,"monto_promedio":48000}

redsalud_db> 
redsalud_db> 

redsalud_db> === 5. TOP 5 DIAGNOSTICOS ===

redsalud_db> | | | | {"_id":"Fractura brazo derecho","casos":1}
{"_id":"Seguimiento hipertension","casos":1}
{"_id":"Alergia estacional","casos":1}
{"_id":"Crisis de ansiedad","casos":1}
{"_id":"Reflujo gastroesofagico","casos":1}

redsalud_db> 
redsalud_db> 

redsalud_db> === 6. CARGA POR ESPECIALIDAD ===

redsalud_db> | | | {"_id":"Medicina General","atenciones":7}
{"_id":"Cardiologia","atenciones":7}
{"_id":"Pediatria","atenciones":6}
{"_id":"Urgencias","atenciones":5}

redsalud_db> 
redsalud_db> 

redsalud_db> === 7. PACIENTES CON MAS DE 1 ATENCION ===

redsalud_db> | | | {"_id":3,"nombre":"Ana Munoz Rojas","total":2}
{"_id":1,"nombre":"Maria Gonzalez Silva","total":2}
{"_id":5,"nombre":"Carla Diaz Castro","total":2}
{"_id":7,"nombre":"Sofia Lopez Henriquez","total":2}
{"_id":9,"nombre":"Valentina Rojas Diaz","total":2}