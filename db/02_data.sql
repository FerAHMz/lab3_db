-- Insertar datos en la tabla zona
INSERT INTO zona (nombre, descripcion, horario_apertura, horario_cierre) VALUES
('Sabana Africana', 'Exhibición de animales de la sabana africana', '09:00:00', '18:00:00'),
('Bosque Tropical', 'Hábitat de especies de bosques tropicales', '09:30:00', '17:30:00'),
('Desierto', 'Exhibición de flora y fauna desértica', '10:00:00', '17:00:00'),
('Polar', 'Zona de animales de climas fríos', '10:00:00', '16:30:00'),
('Aviario', 'Exhibición de aves exóticas', '09:00:00', '17:00:00');

-- Insertar datos en la tabla especie
INSERT INTO especie (nombre_cientifico, nombre_comun, familia, peligro_extincion, descripcion) VALUES
('Panthera leo', 'León', 'Felidae', 'Sí', 'Gran felino social de la sabana africana'),
('Giraffa camelopardalis', 'Jirafa', 'Giraffidae', 'Sí', 'Mamífero más alto del mundo'),
('Loxodonta africana', 'Elefante africano', 'Elephantidae', 'Sí', 'El mayor mamífero terrestre'),
('Crocodylus niloticus', 'Cocodrilo del Nilo', 'Crocodylidae', 'No', 'Gran reptil depredador'),
('Acinonyx jubatus', 'Guepardo', 'Felidae', 'Sí', 'El animal terrestre más rápido'),
('Ursus maritimus', 'Oso polar', 'Ursidae', 'Sí', 'Gran oso adaptado al Ártico'),
('Spheniscus demersus', 'Pingüino africano', 'Spheniscidae', 'Sí', 'Pingüino que habita en las costas africanas'),
('Panthera tigris', 'Tigre', 'Felidae', 'Sí', 'El mayor felino del mundo'),
('Bubo bubo', 'Búho real', 'Strigidae', 'No', 'Una de las mayores rapaces nocturnas'),
('Python regius', 'Pitón real', 'Pythonidae', 'No', 'Serpiente constrictora no venenosa');

-- Insertar datos en la tabla habitat
INSERT INTO habitat (nombre, tipo, capacidad, id_zona) VALUES
('Sabana principal', 'Sabana abierta', 5, 1),
('Lago de los cocodrilos', 'Humedal', 3, 1),
('Bosque denso', 'Selva tropical', 4, 2),
('Oasis del desierto', 'Zona desértica', 2, 3),
('Iceberg polar', 'Zona glacial', 3, 4),
('Pajarera grande', 'Aviario exterior', 15, 5),
('Cueva de depredadores', 'Zona rocosa', 2, 2),
('Pradera de herbívoros', 'Pastizales', 6, 1);

-- Insertar datos en la tabla cargo
INSERT INTO cargo (titulo, descripcion, salario_base) VALUES
('Veterinario jefe', 'Responsable del área médica del zoológico', 3500.00),
('Cuidador senior', 'Experto en cuidado de animales', 2500.00),
('Guía turístico', 'Encargado de tours y visitas guiadas', 1800.00),
('Especialista en nutrición', 'Diseña dietas para los animales', 2800.00),
('Mantenimiento', 'Encargado del cuidado de instalaciones', 1600.00),
('Veterinario general', 'Atención médica a los animales', 3000.00),
('Cuidador junior', 'Asistente en el cuidado de animales', 2000.00);

-- Insertar datos en la tabla empleado
INSERT INTO empleado (nombre, apellido, fecha_contratacion, salario, id_cargo) VALUES
('María', 'González', '2015-06-10', 3700.00, 1),
('Juan', 'Pérez', '2018-03-15', 2600.00, 2),
('Laura', 'Martínez', '2019-11-20', 1900.00, 3),
('Carlos', 'Rodríguez', '2017-05-05', 2900.00, 4),
('Ana', 'López', '2020-02-10', 1700.00, 5),
('Pedro', 'Sánchez', '2016-07-22', 3100.00, 6),
('Sofía', 'Fernández', '2021-01-30', 2100.00, 7),
('Diego', 'Gómez', '2018-09-12', 2700.00, 2),
('Elena', 'Díaz', '2019-04-18', 1950.00, 3),
('Javier', 'Ruiz', '2020-07-25', 1750.00, 5);

-- Insertar datos en la tabla animal
INSERT INTO animal (nombre, fecha_nacimiento, sexo, id_especie, id_habitat, fecha_ingreso, estado) VALUES
('Simba', '2017-03-15', 'M', 1, 1, '2018-01-10', 'Saludable'),
('Nala', '2018-05-20', 'F', 1, 1, '2019-02-15', 'Saludable'),
('Melman', '2015-07-10', 'M', 2, 8, '2016-03-22', 'Saludable'),
('Dumbo', '2010-11-05', 'M', 3, 8, '2011-06-18', 'En tratamiento'),
('Rango', '2019-02-28', 'M', 4, 2, '2020-01-12', 'Saludable'),
('Flash', '2018-08-15', 'M', 5, 1, '2019-05-30', 'Saludable'),
('Nanuk', '2016-04-10', 'M', 6, 5, '2017-01-25', 'Saludable'),
('Pingu', '2019-06-12', 'F', 7, 5, '2020-03-08', 'Saludable'),
('Rajah', '2014-09-30', 'M', 8, 7, '2015-07-15', 'Saludable'),
('Hedwig', '2020-01-25', 'F', 9, 6, '2020-10-05', 'Saludable'),
('Kaa', '2018-11-15', 'F', 10, 3, '2019-08-20', 'Saludable'),
('Sarabi', '2016-12-05', 'F', 1, 1, '2017-09-18', 'Saludable'),
('Zari', '2019-03-22', 'F', 2, 8, '2020-01-10', 'Saludable'),
('Tantor', '2009-05-18', 'M', 3, 8, '2010-02-12', 'Saludable'),
('Snappy', '2017-07-30', 'M', 4, 2, '2018-04-15', 'Saludable');

-- Insertar datos en la tabla visitante
INSERT INTO visitante (nombre, apellido, fecha_nacimiento, tipo_entrada) VALUES
('Alejandro', 'García', '1990-05-15', 'Adulto'),
('Marta', 'Jiménez', '2015-08-22', 'Niño'),
('Roberto', 'Moreno', '1985-11-30', 'Adulto'),
('Lucía', 'Hernández', '1998-03-10', 'Estudiante'),
('Daniel', 'Alonso', '1955-07-18', 'Adulto mayor'),
('Sara', 'Torres', '2016-02-28', 'Niño'),
('Pablo', 'Vázquez', '1992-09-15', 'Adulto'),
('Eva', 'Ramírez', '1999-04-20', 'Estudiante'),
('Jorge', 'Serrano', '1948-12-05', 'Adulto mayor'),
('Claudia', 'Morales', '2017-06-12', 'Niño'),
('Ángel', 'Ortega', '1993-10-25', 'Adulto'),
('Nerea', 'Iglesias', '2000-01-08', 'Estudiante');

-- Insertar datos en la tabla evento
INSERT INTO evento (nombre, fecha_hora, descripcion, capacidad_maxima, id_zona) VALUES
('Alimentación de leones', '2023-06-15 11:00:00', 'Demostración de alimentación de felinos', 30, 1),
('Charlas de conservación', '2023-06-16 15:00:00', 'Charlas sobre especies en peligro', 50, 2),
('Noche de animales nocturnos', '2023-06-17 20:00:00', 'Visita especial para ver animales nocturnos', 25, 3),
('Encuentro con pingüinos', '2023-06-18 10:30:00', 'Experiencia cercana con pingüinos', 15, 4),
('Tour VIP tras bambalinas', '2023-06-19 09:00:00', 'Visita exclusiva a áreas restringidas', 10, 5),
('Taller infantil', '2023-06-20 12:00:00', 'Actividades educativas para niños', 20, 1);

-- Insertar datos en la tabla exhibicion
INSERT INTO exhibicion (nombre, descripcion, horario, id_habitat) VALUES
('Los reyes de la sabana', 'Exhibición de leones en su hábitat', '11:00, 15:00, 17:00', 1),
('Gigantes gentiles', 'Exhibición de jirafas y elefantes', '10:30, 14:00, 16:30', 8),
('Depredadores del desierto', 'Exhibición de reptiles del desierto', '12:00, 15:30', 4),
('Mundo polar', 'Exhibición de osos y pingüinos polares', '11:30, 14:30, 16:00', 5),
('Aves exóticas', 'Exhibición de vuelo de aves', '10:00, 13:00, 16:00', 6);

-- Insertar datos en la tabla alimento
INSERT INTO alimento (nombre, tipo, unidad_medida, cantidad_disponible) VALUES
('Carne de res', 'Carnívoro', 'kg', 150.50),
('Pescado fresco', 'Carnívoro', 'kg', 200.75),
('Heno', 'Herbívoro', 'kg', 500.00),
('Frutas variadas', 'Herbívoro', 'kg', 300.25),
('Pienso para aves', 'Omnívoro', 'kg', 180.00),
('Insectos vivos', 'Insectívoro', 'unidades', 10000),
('Vegetales frescos', 'Herbívoro', 'kg', 250.75),
('Ratones', 'Carnívoro', 'unidades', 500),
('Carne de pollo', 'Carnívoro', 'kg', 175.30),
('Algas', 'Herbívoro', 'kg', 120.50);

-- Insertar datos en la tabla dieta
INSERT INTO dieta (id_animal, id_alimento, cantidad_diaria, frecuencia) VALUES
(1, 1, 5.0, 'Diaria'),
(1, 8, 3.0, '3 veces por semana'),
(2, 1, 4.5, 'Diaria'),
(3, 3, 10.0, 'Diaria'),
(3, 4, 3.0, 'Diaria'),
(4, 3, 20.0, 'Diaria'),
(4, 4, 5.0, 'Diaria'),
(4, 7, 8.0, 'Diaria'),
(5, 1, 2.0, '3 veces por semana'),
(6, 1, 3.0, 'Diaria'),
(7, 1, 6.0, 'Diaria'),
(7, 2, 4.0, '2 veces por semana'),
(8, 2, 1.5, 'Diaria'),
(9, 1, 5.0, 'Diaria'),
(10, 5, 0.5, 'Diaria'),
(10, 6, 20.0, 'Diaria'),
(11, 8, 2.0, '1 vez por semana'),
(12, 1, 4.0, 'Diaria'),
(13, 3, 8.0, 'Diaria'),
(14, 3, 25.0, 'Diaria'),
(15, 1, 1.5, '2 veces por semana');

-- Insertar datos en la tabla cuidado
INSERT INTO cuidado (id_empleado, id_animal, fecha_asignacion, responsabilidades) VALUES
(2, 1, '2023-01-10', 'Alimentación, limpieza del hábitat, observación de comportamiento'),
(2, 2, '2023-01-10', 'Alimentación, limpieza del hábitat, observación de comportamiento'),
(7, 3, '2023-01-15', 'Alimentación, limpieza del hábitat'),
(7, 4, '2023-01-15', 'Alimentación especial, administración de medicamentos'),
(8, 5, '2023-02-01', 'Alimentación, mantenimiento del hábitat acuático'),
(2, 6, '2023-02-05', 'Alimentación, enriquecimiento ambiental'),
(8, 7, '2023-02-10', 'Alimentación, control de temperatura del hábitat'),
(7, 8, '2023-02-15', 'Alimentación, limpieza del área polar'),
(2, 9, '2023-03-01', 'Alimentación, observación de comportamiento'),
(7, 10, '2023-03-05', 'Alimentación, mantenimiento del aviario'),
(8, 11, '2023-03-10', 'Alimentación, control de humedad del hábitat'),
(2, 12, '2023-03-15', 'Alimentación, observación de comportamiento social'),
(7, 13, '2023-04-01', 'Alimentación, limpieza del hábitat'),
(8, 14, '2023-04-05', 'Alimentación, cuidados especiales por edad'),
(7, 15, '2023-04-10', 'Alimentación, mantenimiento del hábitat acuático');

-- Insertar datos en la tabla visitante_evento
INSERT INTO visitante_evento (id_visitante, id_evento, fecha_registro) VALUES
(1, 1, '2023-06-01 10:00:00'),
(2, 1, '2023-06-01 10:05:00'),
(3, 2, '2023-06-02 11:30:00'),
(4, 2, '2023-06-02 11:35:00'),
(5, 3, '2023-06-03 09:45:00'),
(6, 3, '2023-06-03 09:50:00'),
(7, 4, '2023-06-04 08:30:00'),
(8, 4, '2023-06-04 08:35:00'),
(9, 5, '2023-06-05 07:15:00'),
(10, 6, '2023-06-06 10:20:00'),
(11, 6, '2023-06-06 10:25:00'),
(12, 6, '2023-06-06 10:30:00'),
(1, 3, '2023-06-07 14:00:00'),
(3, 5, '2023-06-08 08:45:00'),
(5, 1, '2023-06-09 12:30:00');

-- Insertar datos en la tabla horarios_alimentacion
INSERT INTO horarios_alimentacion (id_animal, hora, dias_semana, id_empleado_responsable) VALUES
(1, '11:00:00', 'Lunes, Miércoles, Viernes', 2),
(2, '11:00:00', 'Lunes, Miércoles, Viernes', 2),
(3, '10:00:00', 'Diario', 7),
(4, '10:30:00', 'Diario', 7),
(5, '12:00:00', 'Martes, Jueves, Sábado', 8),
(6, '11:30:00', 'Lunes, Miércoles, Viernes', 2),
(7, '14:00:00', 'Diario', 8),
(8, '15:00:00', 'Diario', 7),
(9, '16:00:00', 'Martes, Jueves, Sábado', 2),
(10, '09:30:00', 'Diario', 7),
(11, '13:00:00', 'Miércoles, Domingo', 8),
(12, '11:00:00', 'Lunes, Miércoles, Viernes', 2),
(13, '10:00:00', 'Diario', 7),
(14, '10:30:00', 'Diario', 8),
(15, '12:00:00', 'Martes, Jueves, Sábado', 7);

-- Insertar datos en la tabla registro_salud
INSERT INTO registro_salud (id_animal, fecha, peso, estado, observaciones, id_veterinario) VALUES
(1, '2023-05-01', 190.5, 'Excelente', 'Examen rutinario, todo normal', 1),
(2, '2023-05-01', 165.0, 'Bueno', 'Examen rutinario, pequeña herida en pata trasera', 1),
(3, '2023-05-02', 800.0, 'Excelente', 'Control de peso, en buen estado', 6),
(4, '2023-05-02', 4500.0, 'Regular', 'Problemas articulares, tratamiento iniciado', 6),
(5, '2023-05-03', 120.0, 'Bueno', 'Examen rutinario, todo normal', 1),
(6, '2023-05-03', 65.0, 'Excelente', 'Control de peso, muy activo', 1),
(7, '2023-05-04', 450.0, 'Bueno', 'Examen rutinario, pelaje en buen estado', 6),
(8, '2023-05-04', 3.2, 'Excelente', 'Control de peso, comportamiento normal', 6),
(9, '2023-05-05', 220.0, 'Bueno', 'Examen rutinario, dientes en buen estado', 1),
(10, '2023-05-05', 2.8, 'Excelente', 'Control de peso, plumas brillantes', 6),
(11, '2023-05-06', 5.5, 'Bueno', 'Examen rutinario, muda de piel iniciada', 6),
(12, '2023-05-06', 185.0, 'Excelente', 'Control de peso, comportamiento social normal', 1),
(13, '2023-05-07', 750.0, 'Bueno', 'Examen rutinario, todo normal', 6),
(14, '2023-05-07', 4800.0, 'Regular', 'Control de peso, problemas dentales', 6),
(15, '2023-05-08', 110.0, 'Bueno', 'Examen rutinario, cicatrización de herida', 1);