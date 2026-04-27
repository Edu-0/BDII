create or replace function houve_update()
returns trigger as $$
begin
	raise notice 'Operacao: %, Nivel: % em %', tg_op, tg_level, now();
	return new;
end; $$ language plpgsql;


-- drop trigger t_houve_update on public.aluno
create trigger t_houve_update
after insert or update or delete
on public.aluno
for each statement
execute function public.houve_update();

select * from aluno;

update aluno set nome = UPPER(nome) where id < 20;

delete from aluno where id in (1, 2)

INSERT INTO aluno (nome)
	VALUES
		('Ana Souza'),
		('Bruno Silva');
INSERT INTO aluno (nome)
	VALUES
		('Carlos Pereira'),
		('Daniela Costa'),
		('Eduardo Santos');
INSERT INTO aluno (nome)
	VALUES
		('Fernanda Oliveira'),
		('Gabriel Martins');
INSERT INTO aluno (nome)
	VALUES
		('Helena Rodrigues'),
		('Igor Almeida'),
		('Juliana Barros');