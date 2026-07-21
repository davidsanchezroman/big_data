graph TB
    subgraph Clientes["👥 Capa de Clientes"]
        A1[📱 App Móvil<br/>Pacientes]
        A2[💻 Portal Web<br/>Médicos]
        A3[🚑 Sistema<br/>Urgencias 24/7]
    end
    
    subgraph Balanceo["⚖️ Capa de Balanceo"]
        LB[Load Balancer<br/>Nginx]
        API[🔌 API Gateway<br/>Node.js/Python]
    end
    
    subgraph PostgreSQL["🟢 PostgreSQL Cluster - ACID"]
        direction TB
        PG1[(PostgreSQL<br/>Master)]
        PG2[(PostgreSQL<br/>Réplica Lectura)]
        PG1 -.Replicación<br/>Streaming.-> PG2
    end
    
    subgraph MongoDB["🔵 MongoDB Cluster - BASE (Sharded)"]
        direction TB
        M1[(Shard 1<br/>Región Metropolitana)]
        M2[(Shard 2<br/>Región Valparaíso)]
        M3[(Shard 3<br/>Región Biobío)]
        CS{{Config Server}}
        M1 --- CS
        M2 --- CS
        M3 --- CS
    end
    
    RC[(🟡 Redis<br/>Cache Sesiones)]
    LOG[(📊 Sistema<br/>Logs/Monitoreo)]
    
    A1 --> LB
    A2 --> LB
    A3 --> LB
    LB --> API
    API -->|Transacciones<br/>ACID Clínicas| PG1
    API -->|Logs Atenciones<br/>BASE| M1
    API -->|Cache<br/>Sesiones| RC
    PG1 --> LOG
    M1 --> LOG
    
    classDef postgres fill:#E8F5E9,stroke:#2E7D32,stroke-width:2px
    classDef mongodb fill:#E3F2FD,stroke:#1565C0,stroke-width:2px
    classDef cache fill:#FFF9C4,stroke:#F9A825,stroke-width:2px
    classDef logs fill:#F3E5F5,stroke:#6A1B9A,stroke-width:2px
    
    class PG1,PG2 postgres
    class M1,M2,M3,CS mongodb
    class RC cache
    class LOG logs
