create or replace function gerenciar_modificacoes()
returns trigger as $$
	declare tipo_op = TG_OP;
begin
	if tipo_op = 'INSERT' then

	else if tipo_op = 'DELETE' then

	else if tipo_op = 'UPDATE' then

	endif
end; $$ language plpgsql;


create or replace trigger t_gerenciar_modificacoes
	before insert or update or delete
	on public.aluno
	for each statement
	execute function gerenciar_modificacoes();