-- Creación de tipos personalizados (mínimo 2)
CREATE TYPE tipo_alimento AS ENUM ('Carnívoro', 'Herbívoro', 'Omnívoro', 'Insectívoro');
CREATE TYPE estado_salud AS ENUM ('Excelente', 'Bueno', 'Regular', 'Malo', 'Crítico');

-- Tabla zona
CREATE TABLE zona (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL,
    descripcion TEXT,
    horario_apertura TIME NOT NULL,
    horario_cierre TIME NOT NULL
);

-- Tabla especie
CREATE TABLE especie (
    id SERIAL PRIMARY KEY,
    nombre_cientifico VARCHAR(100) UNIQUE NOT NULL,
    nombre_comun VARCHAR(100) NOT NULL,
    familia VARCHAR(100),
    peligro_extincion VARCHAR(10) NOT NULL CHECK (peligro_extincion IN ('Sí', 'No')),
    descripcion VARCHAR(500)
);

-- Tabla habitat
CREATE TABLE habitat (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    capacidad INTEGER NOT NULL CHECK (capacidad > 0),
    id_zona INTEGER NOT NULL REFERENCES zona(id)
);

-- Tabla animal
CREATE TABLE animal (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    sexo VARCHAR(1) NOT NULL CHECK (sexo IN ('M', 'F')),
    id_especie INTEGER NOT NULL REFERENCES especie(id),
    id_habitat INTEGER NOT NULL REFERENCES habitat(id),
    fecha_ingreso DATE NOT NULL,
    estado VARCHAR(20) NOT NULL CHECK (estado IN ('Saludable', 'En tratamiento', 'Fallecido', 'Trasladado'))
);

-- Tabla cargo
CREATE TABLE cargo (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    salario_base DECIMAL(10,2) NOT NULL
);

-- Tabla empleado
CREATE TABLE empleado (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_contratacion DATE NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    id_cargo INTEGER NOT NULL REFERENCES cargo(id)
);

-- Tabla visitante
CREATE TABLE visitante (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    tipo_entrada VARCHAR(20) NOT NULL CHECK (tipo_entrada IN ('Adulto', 'Niño', 'Estudiante', 'Adulto mayor'))
);

-- Tabla evento
CREATE TABLE evento (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha_hora TIMESTAMP NOT NULL,
    descripcion TEXT,
    capacidad_maxima INTEGER NOT NULL,
    id_zona INTEGER NOT NULL REFERENCES zona(id)
);

-- Tabla exhibicion
CREATE TABLE exhibicion (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    horario VARCHAR(100) NOT NULL,
    id_habitat INTEGER NOT NULL REFERENCES habitat(id)
);

-- Tabla alimento
CREATE TABLE alimento (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL,
    tipo tipo_alimento NOT NULL,
    unidad_medida VARCHAR(20) NOT NULL,
    cantidad_disponible DECIMAL(10,2) NOT NULL
);

-- Tabla dieta (relación N:M entre animal y alimento)
CREATE TABLE dieta (
    id SERIAL PRIMARY KEY,
    id_animal INTEGER NOT NULL REFERENCES animal(id),
    id_alimento INTEGER NOT NULL REFERENCES alimento(id),
    cantidad_diaria DECIMAL(10,2) NOT NULL CHECK (cantidad_diaria > 0),
    frecuencia VARCHAR(50) NOT NULL,
    UNIQUE (id_animal, id_alimento)
);

-- Tabla cuidado (relación N:M entre empleado y animal)
CREATE TABLE cuidado (
    id SERIAL PRIMARY KEY,
    id_empleado INTEGER NOT NULL REFERENCES empleado(id),
    id_animal INTEGER NOT NULL REFERENCES animal(id),
    fecha_asignacion DATE NOT NULL,
    responsabilidades VARCHAR(300),
    UNIQUE (id_empleado, id_animal, fecha_asignacion) 
);

-- Tabla visitante_evento (relación N:M entre visitante y evento)
CREATE TABLE visitante_evento (
    id SERIAL PRIMARY KEY,
    id_visitante INTEGER NOT NULL REFERENCES visitante(id),
    id_evento INTEGER NOT NULL REFERENCES evento(id),
    fecha_registro TIMESTAMP NOT NULL,
    UNIQUE (id_visitante, id_evento) 
);

-- Tabla horarios_alimentacion
CREATE TABLE horarios_alimentacion (
    id SERIAL PRIMARY KEY,
    id_animal INTEGER NOT NULL REFERENCES animal(id),
    hora TIME NOT NULL,
    dias_semana VARCHAR(50) NOT NULL,
    id_empleado_responsable INTEGER NOT NULL REFERENCES empleado(id)
);

-- Tabla registro_salud
CREATE TABLE registro_salud (
    id SERIAL PRIMARY KEY,
    id_animal INTEGER NOT NULL REFERENCES animal(id),
    fecha DATE NOT NULL,
    peso DECIMAL(10,2) NOT NULL,
    estado estado_salud NOT NULL,
    observaciones TEXT,
    id_veterinario INTEGER NOT NULL REFERENCES empleado(id)
);

CREATE VIEW vista_animales_dieta AS
SELECT
    a.id AS id_animal,
    a.nombre AS nombre_animal,
    a.estado,
    al.nombre AS alimento,
    d.cantidad_diaria,
    d.frecuencia
FROM animal a
JOIN dieta d ON a.id = d.id_animal
JOIN alimento al ON d.id_alimento = al.id;
