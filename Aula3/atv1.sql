create or replace function nome_maiusculo()
returns trigger as $$
begin
	new.nome = upper(old.nome);
	raise notice 'O nome antigo era % e o novo nome é %', old.nome, new.nome;
	raise notice 'Operacao: %, Nivel: %', tg_op, tg_level;
	return new;
end; $$ language plpgsql;


create trigger t_nome_maiusculo
after update
on aluno
for each row
execute function nome_maiusculo();


create or replace function incomplete_name()
returns trigger as $$
begin
	if NULLIF(SPLIT_PART(new.nome, ' ', 2), '') IS NULL THEN
		raise notice 'Operacao: %, Nivel: %', tg_op, tg_level;
		raise 'Nome % não inserido pela falta de sobrenome!', new.nome;
		return null;
	end if;
return new;
end; $$ language plpgsql;


create trigger t_incomplete_name
before insert
on aluno
for each row
execute function incomplete_name();


create table aluno(
	id serial primary key,
	nome text not null
);

insert into aluno (nome)
	values
	('fulano'),
	('beltrano'),
	('ciclano')
	

select * from aluno