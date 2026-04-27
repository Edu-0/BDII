create or replace procedure Procedure_Simples()
language plpgsql
as $$
begin
	raise notice 'Minha primeira Data Base Procedure executada em %', now();
end;
$$;


call Procedure_Simples();


create or replace procedure Procedure_Simples_Param(num1 integer, num2 integer)
language plpgsql
as $$
begin
	raise notice 'Os números informados são num1: % e num2: %', num1, num2;
end;
$$

call Procedure_Simples_Param(5, 10);


create or replace procedure Procedure_mostrando_dados(p_id integer)
language plpgsql
as $$
	declare texto_saida TEXT;
begin
	select 'O produto ' || id_produto || ' é ' || nome_produto
	  from produtos where id_produto = p_id into texto_saida;
	raise notice '%', texto_saida; -- Ele só vai retornar 1 linha, pq é só uma variável
end;
$$

call Procedure_mostrando_dados(3);


create or replace procedure mostra_nome_produtos()
as $$
declare
	v_reg record; -- Tipo "registro", recebe todo o resultado do select
begin
	for v_reg in select nome_produto from produtos
	loop
		raise notice 'O nome é %', v_reg.nome_produto;
	end loop;
end;
$$ language plpgsql;

call mostra_nome_produtos();


create or replace procedure mostra_nome_produtos()
as $$
declare
	v_reg record; -- Tipo "registro", recebe todo o resultado do select
begin
	for v_reg in select id_produto, nome_produto from produtos
	loop
		raise notice 'O produto % é como nome %', 
		v_reg.id_produto, v_reg.nome_produto;
	end loop;
end;
$$ language plpgsql;

call mostra_nome_produtos();


create or replace procedure atualizar_maiusculo()
as $$
declare
	v_reg record;
begin
	for v_reg in select id_produto, nome_produto from produtos
	loop
		if v_reg.nome_produto <> upper(v_reg.nome_produto) then -- Economizar dando update só no que é minúsculo
			 raise notice 'Nome antigo: %, nome novo: %', v_reg.nome_produto, upper(v_reg.nome_produto);
			update produtos set nome_produto = upper(v_reg.nome_produto)
			 where id_produto = v_reg.id_produto;
		end if;
	end loop;
end;
$$ language plpgsql;

call atualizar_maiusculo();

select * from produtos;

-----------------------

-- somar qtde_compra
-- somar qtde_venda
-- saldo = compras - vendas

explain analyze
with prod as (
	select * from produtos
),
cte_compras as (
	select c.id_produto, sum (c.quantidade) as qt_compra
	from compras c
	join prod using (id_produto)
	group by c.id_produto
),
cte_vendas as (
	select v.id_produto, sum (v.quantidade) as qt_venda
	from vendas v
	join prod using (id_produto)
	group by v.id_produto
)
select
	p.id_produto,
	p.nome_produto,
	c.qt_compra,
	v.qt_venda,
	c.qt_compra - v.qt_venda as saldo
from prod p
join cte_compras c using (id_produto)
join cte_vendas v using (id_produto)

-- Tarefa: Colocar isso dentro de uma procedure e atualizar o saldo.
-- 		   Procedure de verificar saldo positivo

select * from compras;
select * from vendas;

create or replace procedure atualizar_saldo()
as $$
declare
	v_reg record;
	v_qtd_compras int;
	v_qtd_vendas int;
	v_saldo numeric(10,2);
begin
	for v_reg in
		select p.id_produto,
			   coalesce(sum(c.quantidade), 0) as qtd_compras,
			   coalesce(sum(v.quantidade), 0) as qtd_vendas
	from produtos p
	left join compras c using (id_produto)
	left join vendas v using
	group by c.id_produto
	loop
		v_saldo := qtd_compras - qtd_vendas;
	end loop
end;
$$ language plpgsql;