create database G1;
use G1;
create table Cirugia(
	id_cirugia int,
    proposito varchar(32),
    fecha_hora datetime,
    id_tecnica_q int,
    id_paciente char(10),
    id_centrosalud int,
    id_cirujano char(10)
);

create table Factura(
	num_factura int,
    valor_pago decimal(10,2),
    fecha_emision date,
    estado boolean,
    id_cirugia int
);

create table Centro_Salud(
	id_centrosalud int,
    nombre varchar(70),
    categoria varchar(20),
    nivel int,
    direccion varchar(100)
);

create table tecnica_quirurgica(
	id_tecnica_q int,
    nombre_tecnica_q varchar(50)
);

create table persona(
	cedula char(10),
    nombres varchar(50),
    apellidos varchar(50),
    telefono char(10),
    correo varchar(64),
    esPaciente boolean,
    esCirujano boolean
);

create table cirujano(
	cedula char(10),
    especialidad varchar(50)
);

create table diagnostico(
	cedula char(10),
    diagnostico varchar(50),
    fecha date
);

create table tecnica_anestesia(
	id_tecnica_a int,
    nombre_tecnica_a varchar(50)
);

create table tecnica_anestesia_usada(
	id_tecnica_a int,
    id_cirugia int
);

alter table centro_salud
	add constraint PK primary key (id_centrosalud),
    add constraint check_nivel check(nivel>0 and nivel<5);
    
alter table persona
	add constraint PK primary key (cedula),
    add constraint check_tipo check(esPaciente=true or esCirujano=true),
    modify column telefono char(10) null,
    add column genero char(1),
    add column fecha_nacimiento date not null,
    add constraint check_genero check(genero = "M" or genero = "F");

alter table diagnostico
	add constraint FKpersona foreign key (cedula) references persona (cedula),
    add constraint PK primary key (cedula, diagnostico);
    
alter table cirujano
	add constraint FKpersona1 foreign key (cedula) references persona(cedula),
    add constraint PK primary key (cedula),
    modify column especialidad varchar(50) default "cirugia general";
    
alter table tecnica_anestesia
	add constraint PK primary key (id_tecnica_a),
    modify column nombre_tecnica_a varchar(50) unique;
    
alter table tecnica_quirurgica
	add constraint PK primary key (id_tecnica_q),
	modify column nombre_tecnica_q varchar(50) unique;

alter table cirugia
	add constraint PK primary key (id_cirugia),
    add constraint FKtecnica_q foreign key (id_tecnica_q) references tecnica_quirurgica (id_tecnica_q),
    add constraint FKpaciente foreign key (id_paciente) references persona (cedula),
    add constraint FKcentro_salud foreign key (id_centrosalud) references centro_salud (id_centrosalud),
    add constraint FKcirujano foreign key (id_cirujano) references cirujano (cedula),
    modify column fecha_hora date not null;
    
alter table tecnica_anestesia_usada
	add constraint FKtecnica_a foreign key (id_tecnica_a) references tecnica_anestesia (id_tecnica_a),
    add constraint FKcirugia1 foreign key (id_cirugia) references cirugia (id_cirugia),
    add constraint PK primary key (id_cirugia, id_tecnica_a);

alter table factura
	add constraint PK primary key (num_factura),
    add constraint FKcirugia2 foreign key (id_cirugia) references cirugia (id_cirugia);
    
INSERT INTO persona (cedula, nombres, apellidos, correo, espaciente, escirujano, genero, fecha_nacimiento) VALUES
	('1207160563', 'Roxana', 'Santillan Molina', 'santilla@hotmail.com', true, false, 'F', '1970-07-22'),
    ('0941014813', 'Mariana', 'Suarez Montoya', 'suarez@hotmail.com', true, false, 'F', '1972-07-22'),
    ('0951881846', 'Jacinto', 'Macías Velez', 'velez@hotmail.com', true, false, 'M', '1973-07-22');
    
INSERT INTO persona (cedula, nombres, apellidos, telefono, correo, espaciente, escirujano, genero, fecha_nacimiento) VALUES
    ('1234567890', 'Juan', 'Perez', '0987654321', 'juan.perez@example.com', false, true, 'M', '1974-07-22'),
    ('0987654321', 'Maria', 'Lopez', '0912345678', 'maria.lopez@example.com', false, true, 'F', '1975-07-22'),
    ('1122334455', 'Ana', 'Martinez', '0923456789', 'ana.martinez@example.com', false, true, 'F', '1976-07-22'),
    ('2233445566', 'Carlos', 'Gomez', '0934567890', 'carlos.gomez@example.com', false, true, 'M', '1977-07-22'),
    ('3344556677', 'Laura', 'Ramirez', '0945678901', 'laura.ramirez@example.com', false, true, 'F', '1978-07-22');
    
INSERT INTO tecnica_quirurgica (id_tecnica_q, nombre_tecnica_q) VALUES
    (1, 'Laparoscopia'),
    (2, 'Bypass gastrico'),
    (3, 'Artroscopia'),
    (4, 'Cirugia cardiaca'),
    (5, 'Microcirugia');
    
INSERT INTO centro_salud (id_centrosalud, nombre, categoria, nivel, direccion) VALUES
    (1, 'Hospital Central', 'Hospital', 3, 'Av. Principal 123'),
    (2, 'Clinica Moderna', 'Clinica', 2, 'Calle Secundaria 456'),
    (3, 'Centro Medico Norte', 'Centro Medico', 1, 'Av. Norte 789'),
    (4, 'Sanatorio del Sur', 'Sanatorio', 4, 'Av. Sur 321'),
    (5, 'Hospital del Este', 'Hospital', 3, 'Calle Este 654');
    
INSERT INTO cirujano (cedula, especialidad) VALUES
    ('1234567890', 'Cirugia General'),
    ('0987654321', 'Neurocirugia'),
    ('1122334455', 'Cirugia Plastica'),
    ('2233445566', 'Cirugia Cardiotorasica'),
    ('3344556677', 'Ortopedia');
    
INSERT INTO diagnostico (cedula, diagnostico, fecha) VALUES
    ('1207160563', 'Apendicitis aguda', '2024-07-19'),
    ('1207160563', 'Obesidad morbida', '2024-07-19'),
    ('0941014813', 'Desgarro del LCA', '2024-07-19'),
    ('0941014813', 'Estenosis aortica', '2024-07-20'),
    ('0951881846', 'Fractura de femur', '2024-07-20');
    
INSERT INTO tecnica_anestesia (id_tecnica_a, nombre_tecnica_a) VALUES
    (1, 'General'),
    (2, 'Local'),
    (3, 'Epidural'),
    (4, 'Raquidea'),
    (5, 'Sedacion');

INSERT INTO cirugia (id_cirugia, proposito, fecha_hora, id_tecnica_q, id_paciente, id_centrosalud, id_cirujano) VALUES
    (1, 'Apendicitis', '2024-07-20', 1, '1207160563', 1, '1234567890'),
    (2, 'Reduccion de peso', '2024-07-21', 2, '1207160563', 2, '1122334455'),
    (3, 'Reparacion de ligamentos', '2024-07-22', 3, '0941014813', 3, '3344556677'),
    (4, 'Reemplazo de valvula cardiaca', '2024-07-23', 4, '0941014813', 4, '2233445566'),
    (5, 'Correccion de fractura', '2024-07-24', 5, '0951881846', 5, '3344556677');