-- EJERCICIO 3

drop database medicos;
create database if not exists MEDICOS;
USE MEDICOS;

-- Creación tabla especialidad:
create table if not exists especialidad (
	ID_especialidad varchar(3) not null,
    nombre varchar(45) not null,
    descripcion varchar(55),
    primary key (ID_especialidad));
    
-- Creación tabla medico:
create table if not exists medico (
	DNI_medico varchar(10) not null,
    nombre varchar(45) not null,
    apellido1 varchar(45) not null,
    apellido2 varchar(45),
    direccion varchar(55),
    telf varchar(15) not null,
    ID_especialidad varchar(3) not null,
    primary key (DNI_medico),
    constraint FK_med_esp foreign key (ID_especialidad) references especialidad(ID_especialidad));

-- Creación tabla enfermera:
create table if not exists enfermera (
	DNI_enfermera varchar(10) not null,
    nombre varchar(45) not null,
    apellido1 varchar(45) not null,
    apellido2 varchar(45),
    direccion varchar(55),
    telf varchar(15) not null,
    DNI_medico varchar(10) not null,
    primary key (DNI_enfermera),
    CONSTRAINT FK_enfermera_med FOREIGN KEY(DNI_medico) REFERENCES medico(DNI_medico));
    
-- Creación tabla enfermedad:
create table if not exists enfermedad (
	ID_enfermedad varchar(10) not null,
    nombre varchar(45) not null,
    descripcion varchar(55),
    primary key (ID_enfermedad));
    
-- Creación tabla abarca:
create table if not exists abarca (
	ID_enfermedad varchar(10) not null,
    ID_especialidad varchar(3) not null,
    primary key (ID_enfermedad,ID_especialidad),
    constraint FK_abarca_enfermedad foreign key(ID_enfermedad) references enfermedad(ID_enfermedad),
    constraint FK_abarca_espec foreign key(ID_especialidad) references especialidad(ID_especialidad));
    
-- Creación tabla trabajar:
create table if not exists trabajar (
	DNI_enfermera varchar(10) not null,
    DNI_medico varchar(10) not null,
    fecha  date not null,
    turno varchar(2),
    primary key (DNI_enfermera,DNI_medico,fecha),
    constraint FK_trab_enfermera foreign key(DNI_enfermera) references enfermera(DNI_enfermera),
    constraint FK_trab_med foreign key(DNI_medico) references medico(DNI_medico));

-- Creación tabla paciente:
create table if not exists paciente (
	DNI_paciente varchar(10) not null,
    num_ss varchar(12) not null,
	nombre varchar(45) not null,
    apellido1 varchar(45) not null,
    apellido2 varchar(45),
    fecha_nac date,
    direccion varchar(55),
    telf varchar(15) not null,
    DNI_medico varchar(10) not null,
    primary key (DNI_paciente),
    constraint FK_pac_med foreign key(DNI_medico) references medico(DNI_medico));
    
-- Creación tabla visitado:
create table if not exists visitado (
	DNI_paciente varchar(10) not null,
    DNI_medico varchar(10) not null,
    fecha  date not null,
    resultado varchar(55),
    primary key (DNI_paciente,DNI_medico,fecha),
    constraint FK_visit_pac foreign key(DNI_paciente) references paciente(DNI_paciente),
    constraint FK_visit_med foreign key(DNI_medico) references medico(DNI_medico));
    
-- Creación tabla tiene:
create table if not exists tiene (
	ID_enfermedad varchar(10) not null,
    DNI_paciente varchar(10) not null,
    primary key (ID_enfermedad,DNI_paciente),
    constraint FK_tiene_enfermedad foreign key(ID_enfermedad) references enfermedad(ID_enfermedad),
    constraint FK_tiene_pac foreign key(DNI_paciente) references paciente(DNI_paciente));
    
/* EJERCICIO 4.
 * CREACIÓN DE INDICES.
 */
 
-- Búsquedas por el campo num_ss sobre la entidad paciente.
create index idx_pac_nss on paciente(num_ss);

-- Búsquedas por el campo DNI_paciente sobre la entidad paciente.
create index idx_pac_dni on paciente(DNI_paciente);

/* EJERCICIO 5.
 * CREACIÓN DE INDICES.
 */

-- Busquedas por nombre y primer apellido del médico.
create index idx_med_nom on medico(apellido1,nombre);
