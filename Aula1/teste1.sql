create table cliente(
	id int primary key,
	nome text
)

create table pedido(
	num_pedido int primary key,
	cliente int references cliente (id),
	data date,
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

select 
	sum(p.valor) as valor_total,
	c.nome as nome_cliente
	from cliente c
	left join pedido p on p.cliente = c.id
	group by c.nome
	having sum(p.valor) > 50
	order by sum(p.valor) desc, nome
	limit 1