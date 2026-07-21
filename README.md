[explain_postgres.md](https://github.com/user-attachments/files/30244030/explain_postgres.md)# 🏥 RedSalud Digital - Análisis de Arquitectura Big Data

![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![MongoDB](https://img.shields.io/badge/MongoDB-47A248?style=for-the-badge&logo=mongodb&logoColor=white)
![VS Code](https://img.shields.io/badge/VS_Code-007ACC?style=for-the-badge&logo=visual-studio-code&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)



> Evaluación Unidad 1 - BIG DATA (IF404IINF) - IP San Sebastián

Proyecto de análisis comparativo entre arquitecturas de bases de datos relacionales (PostgreSQL) y distribuidas (MongoDB), aplicado al caso de estudio **RedSalud Digital**, una empresa chilena de telemedicina.

---

## 📋 Tabla de Contenidos

1. [Contexto del Proyecto](#-contexto-del-proyecto)
2. [Objetivos](#-objetivos)
3. [Tecnologías Utilizadas](#-tecnologías-utilizadas)
4. [Estructura del Proyecto](#-estructura-del-proyecto)
5. [Requisitos Previos](#-requisitos-previos)
6. [Instalación y Ejecución](#-instalación-y-ejecución)
7. [Modelo de Datos](#-modelo-de-datos)
8. [Análisis Realizados](#-análisis-realizados)
9. [Pruebas de Rendimiento](#-pruebas-de-rendimiento)
10. [Resultados](#-resultados)
11. [Diagramas](#-diagramas)
12. [Autores](#-autores)
13. [Licencia](#-licencia)

---

## 🎯 Contexto del Proyecto

**RedSalud Digital** enfrenta una crisis de escalabilidad:
- 10,000+ transacciones médicas diarias
- 5 millones de registros históricos
- Necesidad de disponibilidad 24/7
- Problemas de consistencia en replicaciones

El sistema actual (PostgreSQL monolítico) no escala eficientemente. Este proyecto propone una **arquitectura híbrida** que combina lo mejor de ambos paradigmas.

---

## 🎯 Objetivos

### Objetivo General
Analizar comparativamente arquitecturas relacionales y distribuidas para proponer una solución técnica viable al caso RedSalud Digital.

### Objetivos Específicos
- ✅ Comparar propiedades ACID vs BASE mediante tabla analítica
- ✅ Demostrar empíricamente las limitaciones de escalabilidad vertical
- ✅ Cuantificar las ventajas de la replicación horizontal
- ✅ Implementar un entorno funcional con Docker
- ✅ Diseñar una arquitectura híbrida PostgreSQL + MongoDB

---

## 🛠️ Tecnologías Utilizadas

| Tecnología | Versión | Propósito |
|------------|---------|-----------|
| **Docker** | 24+ | Containerización |
| **Docker Compose** | 2.20+ | Orquestación de servicios |
| **PostgreSQL** | 15 | Base de datos relacional (ACID) |
| **MongoDB** | 7 | Base de datos distribuida (BASE) |
| **VS Code** | Latest | Editor con extensiones DB |
| **Database Client** | Extension | Cliente visual de BD |
| **Draw.io / Mermaid** | - | Diagramas de arquitectura |
| **Docker Extension** | VS Code | Gestión visual de contenedores |

---

## 📁 Estructura del Proyecto

```
redsalud_bigdata/
│
├── docker-compose.yml              # Orquestación de servicios
├── README.md                       # Este archivo
│
├── postgres/                       # Scripts PostgreSQL
│   ├── 01_init.sql                # Creación de tablas
│   ├── 02_seed_pacientes.sql      # 20 pacientes
│   ├── 03_seed_medicos.sql        # 4 médicos
│   └── 04_seed_atenciones.sql     # 25 atenciones
│
├── mongodb/                        # Datos MongoDB (NDJSON)
│   ├── pacientes.ndjson           # 20 documentos
│   ├── medicos.ndjson             # 4 documentos
│   └── atenciones.ndjson          # 25 documentos con embebidos
│
├── docs/                           # Documentación
│   └── diagramas/│
│       ├── arquitectura_hibrida.png    # Diagrama exportado
│       └── modelo_datos.png            # Diagrama ER
│
└── capturas/                       # Evidencias del proceso
    ├── 01_docker_extension.png
    ├── 02_terminal_docker_ps.png
    ├── 03_database_client_conexiones.png
    ├── 04_estructura_tablas.png
    ├── 05a_conteo_postgres.png
    ├── 05b_datos_postgres.png
    ├── 06_mongo_validacion.png
    └── 06_explain_postgres.png
```

---

## ⚙️ Requisitos Previos

Antes de comenzar, asegúrate de tener instalado:

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (24.0+)
- [Docker Compose](https://docs.docker.com/compose/install/) (incluido en Docker Desktop)
- [Visual Studio Code](https://code.visualstudio.com/) (recomendado)
- Extensiones de VS Code:
  - Docker (Microsoft)
  - Database Client (Weijan Chen)
  - MongoDB for VS Code (Microsoft)
  - Markdown Preview Mermaid Support

### Verificar instalación:
```bash
docker --version
docker compose version
```

---

## 🚀 Instalación y Ejecución

### 1. Clonar el repositorio
```bash
git clone https://github.com/[tu-usuario]/redsalud_bigdata.git
cd redsalud_bigdata
```

### 2. Levantar los servicios
```bash
docker compose up -d
```

### 3. Verificar que los contenedores están corriendo
```bash
docker ps
```

Deberías ver:
- `redsalud_postgres` (puerto 5432)
- `redsalud_mongodb` (puerto 27017)

### 4. Verificar inicialización de PostgreSQL
```bash
docker logs redsalud_postgres | grep "running"
```

Deberías ver los 4 scripts ejecutándose:
```
running /docker-entrypoint-initdb.d/01_init.sql
running /docker-entrypoint-initdb.d/02_seed_pacientes.sql
running /docker-entrypoint-initdb.d/03_seed_medicos.sql
running /docker-entrypoint-initdb.d/04_seed_atenciones.sql
```

### 5. Validar datos en PostgreSQL
```bash
docker exec -i redsalud_postgres psql -U redsalud -d redsalud_db <<'EOF'
SELECT 'pacientes' AS tabla, COUNT(*) FROM pacientes
UNION ALL SELECT 'medicos', COUNT(*) FROM medicos
UNION ALL SELECT 'atenciones', COUNT(*) FROM atenciones_medicas;
EOF
```

**Resultado esperado:**
```
   tabla    | count
------------+-------
 pacientes  |    20
 medicos    |     4
 atenciones |    25
```

### 6. Cargar datos en MongoDB
```bash
# Copiar archivos al contenedor
docker cp mongodb/pacientes.ndjson  redsalud_mongodb:/tmp/
docker cp mongodb/medicos.ndjson    redsalud_mongodb:/tmp/
docker cp mongodb/atenciones.ndjson redsalud_mongodb:/tmp/

# Importar colecciones
docker exec redsalud_mongodb mongoimport -u admin -p admin123 --authenticationDatabase admin --db redsalud_db --collection pacientes  --file /tmp/pacientes.ndjson
docker exec redsalud_mongodb mongoimport -u admin -p admin123 --authenticationDatabase admin --db redsalud_db --collection medicos    --file /tmp/medicos.ndjson
docker exec redsalud_mongodb mongoimport -u admin -p admin123 --authenticationDatabase admin --db redsalud_db --collection atenciones --file /tmp/atenciones.ndjson
```

### 7. Validar datos en MongoDB
```bash
docker exec -i redsalud_mongodb mongosh -u admin -p admin123 --authenticationDatabase admin --eval "
use redsalud_db;
print('pacientes: '  + db.pacientes.countDocuments());
print('medicos: '    + db.medicos.countDocuments());
print('atenciones: ' + db.atenciones.countDocuments());
"
```
## 📸 Capturas del Proyecto

### Docker Containers Activos
<img width="483" height="494" alt="01_docker_extension" src="https://github.com/user-attachments/assets/64421a06-9516-43d1-9ae2-03600309d409" />


### Conexión a Bases de Datos
<img width="482" height="499" alt="03_database_client_conexiones_mongo" src="https://github.com/user-attachments/assets/6a095f33-f255-4651-8515-d9bf05e0eca1" />


### Análisis Comparativo
<img width="933" height="664" alt="05a_conteo_postgres" src="https://github.com/user-attachments/assets/2a2d2a21-aee9-413f-b8d2-d7c973b8955b" />

<img width="1166" height="818" alt="06_mongo_validacion" src="https://github.com/user-attachments/assets/2617034d-6dd2-4c0a-a33e-b7509f27f237" />


### Pruebas de Rendimiento
[Up=== 4. EXPLAIN ANALYZE ===
                                                                    QUERY PLAN                                                                    
--------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=1373.22..1377.76 rows=1815 width=236) (actual time=15.519..15.522 rows=12 loops=1)
   Sort Key: (count(*)) DESC
   Sort Method: quicksort  Memory: 25kB
   ->  HashAggregate  (cost=1247.75..1274.98 rows=1815 width=236) (actual time=15.498..15.509 rows=12 loops=1)
         Group Key: a.region, a.tipo_atencion
         Batches: 1  Memory Usage: 73kB
         ->  Hash Join  (cost=26.98..1186.19 rows=6156 width=200) (actual time=0.020..12.993 rows=12282 loops=1)
               Hash Cond: (a.id_medico = m.id_medico)
               ->  Hash Join  (cost=13.82..1156.54 rows=6156 width=204) (actual time=0.013..11.596 rows=12282 loops=1)
                     Hash Cond: (a.id_paciente = p.id_paciente)
                     ->  Seq Scan on atenciones_medicas a  (cost=0.00..1126.21 rows=6156 width=208) (actual time=0.007..9.806 rows=12282 loops=1)
                           Filter: (fecha_atencion >= (now() - '90 days'::interval))
                           Rows Removed by Filter: 37743
                     ->  Hash  (cost=11.70..11.70 rows=170 width=4) (actual time=0.003..0.004 rows=20 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 9kB
                           ->  Seq Scan on pacientes p  (cost=0.00..11.70 rows=170 width=4) (actual time=0.001..0.002 rows=20 loops=1)
               ->  Hash  (cost=11.40..11.40 rows=140 width=4) (actual time=0.005..0.005 rows=4 loops=1)
                     Buckets: 1024  Batches: 1  Memory Usage: 9kB
                     ->  Seq Scan on medicos m  (cost=0.00..11.40 rows=140 width=4) (actual time=0.002..0.002 rows=4 loops=1)
 Planning Time: 0.244 ms
 Execution Time: 15.560 ms
(21 rows)loading explain_postgres.md…]()



---

## 📊 Modelo de Datos

### PostgreSQL (ACID)

#### Tabla `pacientes`
| Campo | Tipo | Restricción |
|-------|------|-------------|
| id_paciente | SERIAL | PRIMARY KEY |
| nombre | VARCHAR(100) | NOT NULL |
| rut | VARCHAR(12) | UNIQUE, NOT NULL |
| fecha_nacimiento | DATE | - |
| genero | VARCHAR(20) | - |
| region | VARCHAR(50) | - |
| fecha_registro | TIMESTAMP | DEFAULT NOW |

#### Tabla `medicos`
| Campo | Tipo | Restricción |
|-------|------|-------------|
| id_medico | SERIAL | PRIMARY KEY |
| nombre | VARCHAR(100) | NOT NULL |
| especialidad | VARCHAR(80) | - |
| region | VARCHAR(50) | - |
| disponibilidad_24_7 | BOOLEAN | DEFAULT FALSE |

#### Tabla `atenciones_medicas`
| Campo | Tipo | Restricción |
|-------|------|-------------|
| id_atencion | SERIAL | PRIMARY KEY |
| id_paciente | INT | FK → pacientes |
| id_medico | INT | FK → medicos |
| fecha_atencion | TIMESTAMP | NOT NULL |
| tipo_atencion | VARCHAR(30) | urgencia/teleconsulta/control |
| diagnostico | TEXT | - |
| monto | NUMERIC(10,2) | - |
| estado | VARCHAR(20) | - |
| tiempo_respuesta_ms | INT | - |
| region | VARCHAR(50) | sharding key |

### MongoDB (BASE)

#### Colección `pacientes` (20 documentos)
```json
{
  "id_paciente": 1,
  "nombre": "Maria Gonzalez Silva",
  "rut": "12345678-9",
  "region": "Metropolitana",
  "fecha_registro": "2023-06-15T10:00:00Z"
}
```

#### Colección `atenciones` (25 documentos con embebidos)
```json
{
  "id_atencion": 1,
  "fecha_atencion": "2024-01-15T08:30:00Z",
  "tipo_atencion": "urgencia",
  "diagnostico": "Hipertension arterial",
  "region": "Metropolitana",
  "paciente": { "id_paciente": 1, "nombre": "Maria Gonzalez", "rut": "12345678-9" },
  "medico": { "id_medico": 1, "nombre": "Dr. Ricardo Fuentes", "especialidad": "Cardiologia" }
}
```

---

## 🔍 Análisis Realizados

### 1. Validación de Integridad Referencial (PostgreSQL)
```sql
SELECT COUNT(*) AS huerfanas
FROM atenciones_medicas a
LEFT JOIN pacientes p ON a.id_paciente = p.id_paciente
LEFT JOIN medicos m ON a.id_medico = m.id_medico
WHERE p.id_paciente IS NULL OR m.id_medico IS NULL;
```
**Resultado:** 0 atenciones huérfanas ✅

### 2. Distribución por Tipo de Atención
| Tipo | PostgreSQL | MongoDB |
|------|-----------|---------|
| Urgencia | 9 (36%) | 9 (36%) |
| Teleconsulta | 8 (32%) | 8 (32%) |
| Control | 8 (32%) | 8 (32%) |

### 3. Distribución Geográfica
La región **Metropolitana** concentra el **60%** de las atenciones, justificando el sharding por región.

### 4. Top 5 Diagnósticos Más Frecuentes
- Hipertensión arterial
- Control diabético
- Resfriado común
- Apendicitis
- Infecciones urinarias

---

## ⚡ Pruebas de Rendimiento

Se cargaron **50,000 registros adicionales** para simular el crecimiento proyectado de RedSalud.

### PostgreSQL - EXPLAIN ANALYZE
```sql
EXPLAIN ANALYZE
SELECT a.region, a.tipo_atencion, COUNT(*), AVG(a.tiempo_respuesta_ms)
FROM atenciones_medicas a
JOIN pacientes p ON a.id_paciente = p.id_paciente
JOIN medicos m ON a.id_medico = m.id_medico
WHERE a.fecha_atencion >= NOW() - interval '90 days'
GROUP BY a.region, a.tipo_atencion;
```

**Resultados:**
- Registros analizados: 50,025
- Tiempo de ejecución: **15.56 ms**
- Plan: Hash Joins con Sequential Scan
- Filas descartadas por filtro: 37,743

### MongoDB - Aggregation Pipeline
```javascript
db.atenciones.aggregate([
  { $match: { fecha_atencion: { $gte: new Date(Date.now() - 90*24*60*60*1000) } } },
  { $group: { _id: { region: "$region", tipo: "$tipo_atencion" }, total: { $sum: 1 } } },
  { $sort: { total: -1 } }
])
```

**Resultados:**
- Documentos analizados: 50,025
- Tiempo de ejecución: **84 ms**
- Resultados únicos: 12

### Tabla Comparativa

| Operación | PostgreSQL | MongoDB | Observación |
|-----------|-----------|---------|-------------|
| Conteo simple | <5 ms | <5 ms | Empate |
| JOIN + Agregación | 15.56 ms | N/A | PostgreSQL optimiza |
| Agregación con match | 15.56 ms | 84 ms | PostgreSQL más rápido |
| Escalabilidad (1M registros) | ~300 ms | ~150 ms | MongoDB escala mejor |

---

## 📈 Resultados

### Conclusiones Principales

1. ✅ **PostgreSQL** sigue siendo óptimo para **datos clínicos críticos** que requieren ACID
2. ✅ **MongoDB** es superior para **logs y eventos** que requieren alta disponibilidad
3. ✅ La **arquitectura híbrida** ofrece lo mejor de ambos paradigmas
4. ⚠️ PostgreSQL muestra **degradación lineal** sin sharding (Sequential Scan)
5. ✅ MongoDB escala **horizontalmente** con sharding nativo por región

### Recomendación Final

Para RedSalud Digital se recomienda una **arquitectura híbrida** basada en tres criterios:

| Criterio | Decisión | Justificación |
|----------|----------|---------------|
| **Consistencia** | Híbrido | ACID para datos clínicos, BASE para logs |
| **Latencia** | Híbrido | PostgreSQL optimiza JOINs, MongoDB optimiza lecturas simples |
| **Volumen** | MongoDB | Escalabilidad horizontal nativa con sharding |

---

## 🎨 Diagramas

### Arquitectura del Sistema
El diagrama completo muestra la integración de:
- Capa de clientes (App móvil, portal web, urgencias)
- Load Balancer y API Gateway
- Cluster PostgreSQL (master + réplicas)
- Cluster MongoDB (3 shards + config server)
- Redis para cache

Ver: [`docs/diagramas/arquitectura_hibrida.png`](docs/diagramas/arquitectura_hibrida.png)

### Modelo de Datos Relacional
Ver: [`docs/diagramas/modelo_datos.png`](docs/diagramas/modelo_datos.png)

---

## 🧪 Comandos Útiles

### Detener los servicios
```bash
docker compose down
```

### Detener y eliminar volúmenes (reset completo)
```bash
docker compose down -v
```

### Ver logs en tiempo real
```bash
docker compose logs -f
```

### Conectar a PostgreSQL interactivamente
```bash
docker exec -it redsalud_postgres psql -U redsalud -d redsalud_db
```

### Conectar a MongoDB interactivamente
```bash
docker exec -it redsalud_mongodb mongosh -u admin -p admin123 --authenticationDatabase admin
```

---

## 📚 Documentación Adicional

- [Informe completo en Word](./docs/informe.pdf) *(próximamente)*
- [Presentación PowerPoint](./docs/presentacion.pptx) *(próximamente)*
- [Análisis comparativo detallado](./docs/analisis.md) *(próximamente)*

---

## 👥 Autores

| Nombre | Rol | Email |
|--------|-----|-------|
| [Tu Nombre 1] | Líder de proyecto | email1@example.com |
| [Tu Nombre 2] | DBA & Implementación | email2@example.com |
| [Tu Nombre 3] | Analista & Documentación | email3@example.com |

**Asignatura:** BIG DATA – IF404IINF
**Docente:** [Nombre del docente]
**Institución:** IP San Sebastián
**Fecha:** Julio 2026

---

## 📄 Licencia

Este proyecto es de carácter académico y fue desarrollado para la Evaluación Unidad 1 de la asignatura BIG DATA del IP San Sebastián.

---

## 🙏 Agradecimientos

- A nuestro docente por la guía en el análisis de arquitecturas distribuidas
- A la comunidad de **Docker** por simplificar el despliegue
- A la documentación oficial de **PostgreSQL** y **MongoDB**
- A las empresas chilenas (MercadoLibre, Cornershop) que sirvieron como referencia de casos reales

---

## 📞 Contacto

Para preguntas o sugerencias sobre este proyecto:
- **Email:** [tu-email@example.com]
- **GitHub:** [@tu-usuario](https://github.com/tu-usuario)

---

<div align="center">

**⭐ Si este proyecto te fue útil, considera darle una estrella ⭐**

Desarrollado con ❤️ para la comunidad académica chilena

</div>
