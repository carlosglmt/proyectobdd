--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 04/06/2019
--@Descripción: Procedimiento Virtual Travel

set serveroutput on
create or replace procedure sp_llena_temp_auto is

v_num_registros number := 0;
v_valor_secuencia number;

cursor cur_ext_auto is 
  select placa, anio, usuario_id, modelo_id, ubicacion_id
  from ext_auto;

begin
  --se llena temp_auto
  for fila in cur_ext_auto loop
    begin
    --dbms_output.put_line('valor antes: ' || v_valor_secuencia);
    insert into temp_auto values(auto_seq.nextval, fila.placa, fila.anio,
      fila.modelo_id, fila.usuario_id, fila.ubicacion_id);
    --dbms_output.put_line('valor despues: ' || v_valor_secuencia);
    exception
      when others then
        if sqlcode = -20001 or sqlcode = -20002 then
          --dbms_output.put_line('Se encontró error: ' || sqlcode);
          v_num_registros := v_num_registros + 1;
          continue;
        else
          dbms_output.put_line('Se encontró un error inesperado.');
          raise;
        end if;
    end;
  end loop;
  dbms_output.put_line('Registros no insertados: ' || v_num_registros);
  --se llena auto
  insert into auto(auto_id, placa, anio, modelo_id, usuario_id,ubicacion_id)
  select auto_id, placa, anio, modelo_id, usuario_id, ubicacion_id
  from temp_auto;
end;
/
show errors;