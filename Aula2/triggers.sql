CREATE TABLE Funcionario
	(
		ID serial primary key,
		nome text,
		salario numeric (10,2)
	);

CREATE TABLE Funcionario_log
	(
		ID serial primary key,
	 	id_funcionario int,
		novo_salario numeric (10,2),
		data_alteracao TIMESTAMPTZ NOT NULL DEFAULT now()
	); -- timestamptz inclui fuso horário

create table Email_Enviado(
	ID serial primary key,
	id_funcionario int,
	enviado bool
)


insert into funcionario (nome, salario)
	values
	('Bob', 1000),
	('Eduardo', 1600),
	('Jose', 2100),
	('Souza', 1800),
	('Helo', 800);

insert into funcionario(nome, salario)
	values
	('Roberto Marinho', 1800)
	
select * from funcionario;

select * from funcionario_log;

delete from funcionario where id = 2

update funcionario set salario = 1100 where nome = 'Bob';

update funcionario set nome = 'Hello' where nome = 'Helo';

update funcionario set salario = 32000 where nome = 'Hello';

update funcionario set salario = 7000 where nome = 'Bob';

select * from email_enviado;

select
	f.nome, fl.novo_salario, data_alteracao
	from funcionario_log fl
	join funcionario f on fl.id_funcionario = f.id;