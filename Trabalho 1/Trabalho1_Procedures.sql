-- Aqui serão feitas as procedures

-- Questão 1
create or replace procedure registrar_pedido(nome_cliente text, valor_pedido decimal(10,2))
language plpgsql
as $$
declare
	id_inserido int;
begin
	insert into pedidos(cliente, data_pedido, valor, status_pedido)
		values (nome_cliente, now(), valor_pedido, 'pendente')
		returning id into id_inserido;

	raise notice 'Pedido inserido com id: %', id_inserido;
end;
$$;

-- Questão 2 com CTE
create or replace function relatorios_vendas (data_inicial date, data_final date)
returns table(
	cliente text,
	mes_ano text,
	relatorio numeric
)
language plpgsql
as $$
begin
	return query
	with tabela_limpa as(
		 select p.cliente::text as cliente_nome,
				to_char(p.data_pedido, 'Month/YYYY') as mes_ano,
				date_trunc('month', p.data_pedido) as mes_pedido,
		 		p.valor
		   from pedidos p
	 	  where p.status_pedido not in ('cancelado', 'pendente')
		    and p.data_pedido between data_inicial and data_final
	), soma_valores as (
		 select tl.cliente_nome,
				tl.mes_pedido,
		 		tl.mes_ano,
				sum(tl.valor) as relatorio
		   from tabela_limpa tl
		  group by tl.cliente_nome, tl.mes_pedido, tl.mes_ano
	)
	select sv.cliente_nome, sv.mes_ano, sv.relatorio
	  from soma_valores sv
	 order by relatorio desc;
end;
$$;