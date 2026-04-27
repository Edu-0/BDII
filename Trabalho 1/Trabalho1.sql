CREATE TABLE pedidos ( 
	id serial PRIMARY KEY, 
	cliente VARCHAR(100) NOT NULL, 
	data_pedido TIMESTAMP, 
	valor NUMERIC(10,2) , 
	status_pedido VARCHAR(20)
);

CREATE TABLE log_pedidos(
	id serial primary key,
	pedido_id int,
	operacao text,
	data_log timestamp
);

SELECT * FROM pedidos order by id;

SELECT * FROM log_pedidos;

call registrar_pedido('Tutancamón II', 120.05);

select * from relatorios_vendas('2024-01-01', '2026-12-31');

update pedidos set status_pedido = 'processado' where id = 6

delete from pedidos where id = 1

-- Executar 1 por 1 para que dê certo

-- Parte de testes

truncate table pedidos restart identity cascade;
truncate table log_pedidos restart identity;

call registrar_pedido('Teste Insert', 100);

update pedidos
   set status_pedido = 'processado'
 where cliente = 'Teste Insert';

update pedidos
   set status_pedido = 'pendente'
 where cliente = 'Teste Insert';

delete from pedidos
 where cliente = 'Teste Insert';

insert into pedidos (cliente, data_pedido, valor, status_pedido)
values ('Teste Bloqueio', now(), 200, 'processado');

delete from pedidos
 where cliente = 'Teste Bloqueio';

select * from log_pedidos order by id;

-- Inserts iniciais gerados para conferência das questões
insert into pedidos (cliente, data_pedido, valor, status_pedido) values
	('Saldanha', '2024-01-10', 500.00, 'concluido'),
	('Saldanha', '2024-01-15', 1080.00, 'concluido'),
	('Fulano', '2025-02-05', 600.00, 'concluido'),
	('Fulano', '2025-02-20', 500.00, 'concluido'),
	('Maria', '2024-03-12', 750.00, 'concluido'),
	('Maria', '2024-03-20', 250.00, 'cancelado'),
	('João', '2024-04-01', 900.00, 'concluido'),
	('João', '2024-04-10', 300.00, 'pendente'),
	('Ana', '2024-05-05', 1200.00, 'concluido'),
	('Ana', '2024-05-15', 800.00, 'concluido'),
	('Carlos', '2024-06-10', 400.00, 'concluido'),
	('Carlos', '2024-06-18', 600.00, 'concluido'),
	('Pedro', '2025-01-02', 1000.00, 'concluido'),
	('Pedro', '2025-01-15', 500.00, 'cancelado'),
	('Lucas', '2025-02-10', 700.00, 'concluido'),
	('Lucas', '2025-02-25', 300.00, 'concluido'),
	('Julia', '2025-03-05', 1500.00, 'concluido'),
	('Julia', '2025-03-15', 500.00, 'pendente'),
	('Bruno', '2025-04-01', 2000.00, 'concluido'),
	('Bruno', '2025-04-10', 1000.00, 'concluido');