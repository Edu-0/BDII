with media_salarial as (
select round(avg(salario),2) as media_salarial
	from funcionarios
), -- Fazendo um extra para aprender.
lista_funcionarios as (
select nome, salario, media_salarial
	from funcionarios
cross join media_salarial
)

select * from lista_funcionarios

select nome, salario, media_salarial,
	salario - media_salarial as diferenca
from lista_funcionarios
where salario - media_salarial > 0
order by salario - media_salarial desc
-- Isso teria dado 4 subquerries e seria muito pesado.

-- Questão 2:
with min_max_avg_dpto as(
select 	f.departamento_id,
		max(f.salario) as max_dpto,
		min(f.salario) as min_dpto,
		round(avg(f.salario),2) as media_dpto
	from funcionarios f
	group by f.departamento_id
),
media_tudo as(
select 	round(avg(salario),2) as media_salarial
		from funcionarios
)

select d.nome, mma.media_dpto, mma.max_dpto, mma.min_dpto, media_salarial
	from departamentos d
	left join min_max_avg_dpto mma on d.id = mma.departamento_id
	cross join media_tudo