create table cliente(
	id INT primary key,
	nome TEXT
)

create table pedido(
	num_pedido INT primary key,
	cliente INT references cliente (id),
	data DATE,
	valor decimal(10,2)	
)

insert into cliente (id, nome) values
	(1, 'Eduardo'),
	(2, 'Edward')

insert into pedido values
	(1, 1, '2026-03-02', 10.5),
	(2, 1, '2026-02-01', 15.7),
	(3, 2, '2025-02-11', 9.2),
	(4, 2, '2026-04-11', 55.8),
	(5, 2, '2023-08-27', 77.8),
	(6, 2, '2024-03-27', 23.8)

-- O meu
select sum(pedido.valor), cliente.nome from cliente
	left join pedido ON cliente.id = pedido.cliente
	group by cliente.nome
	having sum(valor) > 50
	order by sum(pedido.valor) desc
	limit 1

-- Do professor
select nome as cliente,
sum(valor) as total_vendas
from cliente
left join pedido on (id = cliente)
group by nome
having sum(valor) > 50
order by sum(valor) desc, nome
limit 1