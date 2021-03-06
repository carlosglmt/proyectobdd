--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 08/06/2019
--@Descripción: prueba del lob
commit;
declare
	v_xml clob;
	v_xml_invalido clob;
	v_xml_inexistente clob;
begin  

	--Un clob siempre se tiene que inicializar, si no puede generar
	--la excepción ORA-06502: numeric or value error. 
	dbms_output.put_line('=================================');
	dbms_output.put_line('Prueba 1');
	dbms_output.put_line('=================================');
	dbms_output.put_line('Enviando archivo válido');
	dbms_lob.createtemporary(v_xml,TRUE);
	sp_crea_clob(v_xml,'1.xml');
	dbms_output.put_line( dbms_lob.getlength(v_xml));
	insert into factura(factura_id,fecha,importe,xml)
	values (factura_seq.nextval,sysdate,1000,v_xml);
	dbms_output.put_line('=================================');
	dbms_output.put_line('Prueba 2');
	dbms_output.put_line('=================================');
	dbms_output.put_line('Enviando archivo inválido');
	sp_crea_clob(v_xml_invalido,'1.xml');
	dbms_output.put_line('=================================');
	dbms_output.put_line('Prueba 3');
	dbms_output.put_line('=================================');
	dbms_output.put_line('Enviando archivo inexistente');
	sp_crea_clob(v_xml_inexistente,'inexistente.xml');
	


end;
/
show errors
select factura_id,dbms_lob.getlength(xml)
from factura;
rollback;