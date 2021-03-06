--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 31/05/2019
--@Descripción: Creacion de usuarios, roles, asignacion de permisos Virtual Travel

prompt Creando al usuario lm_proy_invitado
create user lm_proy_invitado
	identified by invitado
	quota unlimited 
	on users;

prompt Creando al usuario lm_proy_admin
create user lm_proy_admin	
	identified by admin
	quota unlimited
	on users;

prompt Creando roles
create role rol_admin;
create role rol_invitado;

grant create session,create table,
	create view,create synonym,
	create public synonym,
	create trigger,create sequence,
	create procedure 
	to rol_admin;


grant execute on dbms_crypto to rol_admin;
grant execute on dbms_crypto to lm_proy_admin;

grant rol_admin to lm_proy_admin;

grant create session, create synonym
	to rol_invitado;
grant rol_invitado to lm_proy_invitado;
