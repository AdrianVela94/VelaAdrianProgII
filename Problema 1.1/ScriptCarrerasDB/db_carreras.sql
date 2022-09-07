
Create database carreras_db

use carreras_db

create table Carreras (
id_carrera int identity(1,1),
nombre varchar(100) not null,
--activo varchar (1) NOT NULL, -- 1 Activo. 0 inactivo
constraint pk_Carreras primary key (id_carrera)
)
alter table Carreras
drop column activo

create table Asignaturas (
id_asignatura int identity(1,1),
nombre varchar(100) not null,
constraint pk_Asignaturas primary key (id_asignatura)
)

create table DetalleCarreras(
id_detalleCarrera int identity(1,1),
anio_cursado tinyint not null,
cuatrimestre tinyint not null,
id_carrera int not null,
id_asignatura int not null,
constraint pk_DetalleCarreras primary key (id_detalleCarrera),
constraint fk_Carreras foreign key (id_carrera) references Carreras (id_carrera),
constraint fk_Asignaturas foreign key (id_asignatura) references Asignaturas(id_asignatura)
)

--INSERTS

insert into asignaturas values ('Algebra 1')
insert into asignaturas values ('Algebra 2')
insert into asignaturas values ('Estad�stica')
insert into asignaturas values ('Fisica')
insert into asignaturas values ('Ingl�s 1')
insert into asignaturas values ('Ingl�s 2')
insert into asignaturas values ('Laboratorio 1')
insert into asignaturas values ('Laboratorio 2')
insert into asignaturas values ('Matem�tica')
insert into asignaturas values ('Programaci�n 1')
insert into asignaturas values ('Programaci�n 2')
insert into asignaturas values ('Qu�mica')
insert into asignaturas values ('Sistemas Operativos 1')
insert into asignaturas values ('Sistemas Operativos 2')

select * from asignaturas



--PROCEDIMIENTOS ALMACENADOS


--consultas
create procedure sp_consultar_asignaturas
as
begin
	select id_asignatura, nombre from asignaturas
	order by nombre
end

create procedure sp_consultar_carreras
as
begin
	select id_carrera, nombre from carreras
	order by id_carrera
end

create procedure sp_consultar_detalleCarreras
as
begin
	select c.nombre as 'Carrera',
	a.nombre as 'Nombre Asignatura',
	dc.anio_cursado as 'A�o Cursado', 
	dc.cuatrimestre as 'Cuatrimestre'
	from detalleCarreras as dc 
	inner join asignaturas as a on dc.id_asignatura = a.id_asignatura
	inner join carreras as c on dc.id_carrera = c.id_carrera
	order by c.id_carrera
end

--inserts
create proc sp_insertar_carrera
@nombre varchar(100),
@new_id_carrera int output
as
begin
	insert into carreras(nombre) values(@nombre);
	set @new_id_carrera = SCOPE_IDENTITY();
end

create proc sp_insertar_detalleCarreras
@anioCursado tinyint,
@cuatrimestre tinyint,
@id_carrera int,
@id_asignatura int

as
begin
	insert into DetalleCarreras(anio_cursado, cuatrimestre, id_carrera, id_asignatura)
	values(@anioCursado, @cuatrimestre, @id_carrera, @id_asignatura)
end



