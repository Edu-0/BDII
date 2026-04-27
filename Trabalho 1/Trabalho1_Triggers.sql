-- Aqui serão feitas as triggers

-- Questão 3

-- 1
create or replace function log_insert()
returns trigger as $$
begin
	insert into log_pedidos(id_pedido, operacao, data_operacao)
		values(new.id, TG_OP, now());
	return new;
end;
$$
language plpgsql;

create trigger t_log_insert
after insert
on pedidos
for each row
execute function log_insert();

-- 2
create or replace function log_update()
returns trigger as $$
begin
	if new.status_pedido in ('processado', 'cancelado') then
		insert into log_pedidos(id_pedido, operacao, data_operacao)
			values(new.id, TG_OP, now());
	end if;
	return new;
end;
$$
language plpgsql;

create trigger t_log_update
after update
on pedidos
for each row
execute function log_update();

-- 3
create or replace function bloquear_delete()
returns trigger as $$
begin
	if old.status_pedido <> 'pendente' then
		raise exception 'Só podem ser deletados pedidos com situação Pendente';
	end if;
	return old;
end;
$$
language plpgsql;

create trigger t_bloquear_delete
before delete
on pedidos
for each row
execute function bloquear_delete();


-- Questão 4
create or replace function monitorar_pedidos()
returns trigger as $$
begin
	if TG_OP = 'INSERT' then
		insert into log_pedidos(id_pedido, operacao, data_operacao)
			values(new.id, TG_OP, now());
		return new;
	elsif TG_OP = 'UPDATE' then
		if new.status_pedido in ('processado', 'cancelado') then
			insert into log_pedidos(id_pedido, operacao, data_operacao)
				values(new.id, TG_OP, now());
		end if;
		return new;
	elsif TG_OP = 'DELETE' then
		if old.status_pedido <> 'pendente' then
			raise exception 'Só podem ser deletados pedidos com situação Pendente';
		end if;
		return old;
	end if;
	return null;
end;
$$
language plpgsql;


create trigger t_monitorar_pedidos
before insert or update or delete
on pedidos
for each row
execute function monitorar_pedidos();