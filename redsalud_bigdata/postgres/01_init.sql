-- Tabla pacientes
CREATE TABLE pacientes (
    id_paciente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    rut VARCHAR(12) UNIQUE NOT NULL,
    fecha_nacimiento DATE,
    genero VARCHAR(20),
    region VARCHAR(50),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla medicos
CREATE TABLE medicos (
    id_medico SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(80),
    region VARCHAR(50),
    disponibilidad_24_7 BOOLEAN DEFAULT FALSE
);

-- Tabla atenciones (log de eventos)
CREATE TABLE atenciones_medicas (
    id_atencion SERIAL PRIMARY KEY,
    id_paciente INT REFERENCES pacientes(id_paciente),
    id_medico INT REFERENCES medicos(id_medico),
    fecha_atencion TIMESTAMP NOT NULL,
    tipo_atencion VARCHAR(30),
    diagnostico TEXT,
    monto NUMERIC(10,2),
    estado VARCHAR(20),
    tiempo_respuesta_ms INT,
    region VARCHAR(50)
);

-- Índices para rendimiento
CREATE INDEX idx_atenciones_fecha ON atenciones_medicas(fecha_atencion);
CREATE INDEX idx_atenciones_region ON atenciones_medicas(region);
