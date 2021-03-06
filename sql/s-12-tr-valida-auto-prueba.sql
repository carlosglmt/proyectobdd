--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 09/06/2019
--@Descripción: Prueba Trigger Virtual Travel

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt Insertando auto con valores correctos
Prompt ========================================

insert into temp_auto(auto_id, placa, anio, modelo_id, usuario_id)
values(auto_seq.nextval, 'abc123', 2017, 1, 2);

var auto number
exec :auto := auto_seq.currval
select * from auto where auto_id = :auto;

Prompt OK, prueba 1 exitosa.

Prompt =======================================
Prompt Prueba 2.
prompt Insertando auto con año inválido
Prompt ========================================

declare
  v_codigo number;
  v_mensaje varchar2(1000);

begin
  insert into temp_auto(auto_id, placa, anio, modelo_id, usuario_id)
  values(auto_seq.nextval, 'cba123', 2012, 1, 5);
  -- Si se llega a este punto, significa que el trigger no está funcionando, se lanza
  --excepcion
  raise_application_error(-20020, 'Trigger programado incorrectamente');
exception
  when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20001 then
      dbms_output.put_line('OK, prueba 2 exitosa.');
    else
      dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
      raise;
    end if;
end;
/

Prompt =======================================
Prompt Prueba 3.
prompt Insertando 3 autos de un solo conductor
Prompt ========================================

declare
  v_codigo number;
  v_mensaje varchar2(1000);

begin
  insert into temp_auto(auto_id, placa, anio, modelo_id, usuario_id)
  values(auto_seq.nextval, 'def123', 2019, 1, 1);
  -- Si se llega a este punto, significa que el trigger no está funcionando, se lanza
  --excepcion
  raise_application_error(-20020, 'Trigger programado incorrectamente');
exception
  when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20002 then
      dbms_output.put_line('OK, prueba 3 exitosa.');
    else
      dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
      raise;
    end if;
end;
/

Prompt Pruebas concluidas, se hace rollback
rollback;