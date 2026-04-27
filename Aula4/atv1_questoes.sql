-- Criar um SELECT que liste todos os funcionários e seus respectivos departamentos.

select f.nome, d.nome 
	from funcionarios f
	left join departamentos d on f.departamento_id = d.id


select * from funcionarios;
select * from departamentos;

-- Criar um SELECT que calcule o número total de funcionários em cada departamento.

select COUNT(f.departamento_id), d.nome
	from funcionarios f
	left join departamentos d on f.departamento_id = d.id
	group by d.nome
	order by d.nome

-- Criar um SELECT que liste os departamentos com mais de 5 funcionários.

select COUNT(f.departamento_id), d.nome
	from funcionarios f
	left join departamentos d on f.departamento_id = d.id
	group by d.nome
	having COUNT(f.departamento_id) > 5
	order by d.nome

-- Criar um SELECT que liste os funcionários que ganham mais do que a média salarial.

select nome, salario from funcionarios
	where salario > (SELECT avg(salario) from funcionarios)

-- Criar um SELECT que calcule a média salarial por departamento.

select avg(f.salario), d.nome
	from funcionarios f
	left join departamentos d on f.departamento_id = d.id
	group by d.nome

-- Criar um SELECT que liste os departamentos onde a média salarial é superior a $5000.

select avg(f.salario), d.nome
	from funcionarios f
	left join departamentos d on f.departamento_id = d.id
	group by d.nome
	having avg(f.salario) > 5000

-- Criar um SELECT que calcule o total de vendas por mês.

select EXTRACT(MONTH from data_venda) as mes, sum(valor) as total_vendas
	from vendas
	group by mes;

-- Criar um SELECT que liste os clientes que fizeram compras acima de $1000.

select sum(v.valor), c.nome
	from clientes c
	left join vendas v on v.cliente_id = c.id
	group by c.nome
	having sum(v.valor) > 1000

-- Criar um SELECT que liste os 5 produtos mais vendidos.

select p.nome, sum(iv.quantidade)
	from itens_venda iv
	left join produtos p on iv.produto_id = p.id
	group by p.nome
	order by sum(iv.quantidade) desc
	limit 5

-- Criar um SELECT que liste os funcionários e sua hierarquia de supervisão.

-- select f.supervisor_id as supervisor, fi.nome as nome_supervisor, f.nome as nome_funcionario 
-- 	from funcionarios f
-- 	join funcionarios fi on fi.supervisor_id = f.id
-- 	order by f.supervisor_id is not null, f.supervisor_id asc;

select f.nome as nome_funcionario, COALESCE(s.nome, 'Supervisor') as nome_supervisor
	from funcionarios as f
	left join funcionarios as s on f.supervisor_id = s.id