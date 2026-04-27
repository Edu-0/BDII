CREATE OR REPLACE FUNCTION f_log_func() 
RETURNS TRIGGER AS $$ 
BEGIN 
  INSERT INTO Funcionario_log      (id_funcionario, novo_salario, data_alteracao) 
  VALUES (new.id, new.salario, now()); 
RETURN NEW; 
END; $$ LANGUAGE plpgsql; 


CREATE OR REPLACE FUNCTION block_salary_update() 
RETURNS TRIGGER AS $$ 
BEGIN
	if old.salario*2 < new.salario then
		raise 'Aumento de salário não permitido';
	end if;
return new;
END; $$ LANGUAGE plpgsql; 


create or replace function send_email()
returns trigger as $$
begin
	insert into email_enviado (id_funcionario, enviado)
	values (new.id, true);

	raise notice 'Email enviado, informações adicionadas: ID: id_funcionario=%, Nome: nome=%, Salario: salario=%', new.id, new.nome, new.salario;
	return new;
end; $$ language plpgsql;


create or replace function block_delete()
returns trigger as $$
begin
	if exists (
		select 1
		from funcionario_log
		where id_funcionario = old.id
	) then
		raise exception 'Não é permitido deletar funcionário que possui registro no log';
	end if;
	
	return old;
end; $$ language plpgsql;


CREATE TRIGGER g_logfunc
AFTER UPDATE
ON Funcionario
FOR EACH ROW
WHEN (old.salario<>new.salario)
EXECUTE FUNCTION f_log_func();


CREATE TRIGGER t_salary_increase_block
BEFORE UPDATE
ON Funcionario
FOR EACH ROW
WHEN (old.salario <> new.salario)
EXECUTE FUNCTION block_salary_update();


create trigger t_send_email
after insert
on Funcionario
for each row
execute function send_email();


create trigger t_block_delete
before delete
on Funcionario
for each row
execute function block_delete();