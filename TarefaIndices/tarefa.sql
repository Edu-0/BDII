create table rel_nomes(
	id serial primary key,
	nome text
);

SET enable_indexscan = off;
SET enable_bitmapscan = off;

SET enable_indexscan = on;
SET enable_bitmapscan = on;

explain analyze
select nome from rel_nomes;

explain analyze
select id, nome from Rel_nomes
where nome = 'Roy Little';

explain analyze
select id, nome from Rel_nomes
where id = 13500000;

-- Puro
-- "Seq Scan on rel_nomes  (cost=0.00..4087888.00 rows=250000000 width=32) (actual time=0.302..21464.783 rows=250000000 loops=1)"
-- "Planning Time: 14.443 ms"
-- "Execution Time: 26313.716 ms"

-- Puro + WHERE
-- "Gather  (cost=1000.00..3015971.33 rows=1250000 width=36) (actual time=18.100..10866.140 rows=350 loops=1)"
-- "  Workers Planned: 2"
-- "  Workers Launched: 2"
-- "  ->  Parallel Seq Scan on rel_nomes  (cost=0.00..2889971.33 rows=520833 width=36) (actual time=59.283..10829.459 rows=117 loops=3)"
-- "        Filter: (nome = 'Roy Little'::text)"
-- "        Rows Removed by Filter: 83333217"
-- "Planning Time: 9.445 ms"
-- "Execution Time: 10866.378 ms"

-- WHERE id
-- "Gather  (cost=1000.00..2890876.85 rows=1 width=19) (actual time=16001.874..16012.283 rows=1 loops=1)"
-- "  Workers Planned: 2"
-- "  Workers Launched: 2"
-- "  ->  Parallel Seq Scan on rel_nomes  (cost=0.00..2889876.75 rows=1 width=19) (actual time=10924.925..15950.518 rows=0 loops=3)"
-- "        Filter: (id = 13500000)"
-- "        Rows Removed by Filter: 83333333"
-- "Planning Time: 0.089 ms"
-- "Execution Time: 16012.303 ms"

create index idx_nome on rel_nomes(nome); -- 19 min 11 secs.

-- Com índice
-- "Seq Scan on rel_nomes  (cost=0.00..4087888.00 rows=250000000 width=32) (actual time=0.018..22581.076 rows=250000000 loops=1)"
-- "Planning Time: 7.696 ms"
-- "Execution Time: 27031.283 ms"

-- Com WHERE e Índice
-- "Gather  (cost=18272.07..2963443.72 rows=1250000 width=36) (actual time=5.167..80.612 rows=350 loops=1)"
-- "  Workers Planned: 2"
-- "  Workers Launched: 2"
-- "  ->  Parallel Bitmap Heap Scan on rel_nomes  (cost=17272.07..2837443.72 rows=520833 width=36) (actual time=7.561..18.074 rows=117 loops=3)"
-- "        Recheck Cond: (nome = 'Roy Little'::text)"
-- "        Heap Blocks: exact=350"
-- "        ->  Bitmap Index Scan on idx_nome  (cost=0.00..16959.57 rows=1250000 width=0) (actual time=1.032..1.032 rows=350 loops=1)"
-- "              Index Cond: (nome = 'Roy Little'::text)"
-- "Planning Time: 7.778 ms"
-- "Execution Time: 80.979 ms"

-- Com WHERE aquecido
-- "Index Scan using idx_nome on rel_nomes  (cost=0.57..1137.50 rows=282 width=19) (actual time=0.036..0.302 rows=350 loops=1)"
-- "  Index Cond: (nome = 'Roy Little'::text)"
-- "Planning Time: 0.082 ms"
-- "Execution Time: 0.333 ms"

-- WHERE id
-- "Index Scan using rel_nomes_pkey on rel_nomes  (cost=0.57..8.59 rows=1 width=19) (actual time=0.019..0.021 rows=1 loops=1)"
-- "  Index Cond: (id = 13500000)"
-- "Planning Time: 0.081 ms"
-- "Execution Time: 0.037 ms"

drop index idx_nome;

-- Precisei de 250 milhões de registros para que o overhead do comando de SELECT n fosse maior que o tempo de selecionar todos.

-- Índice reduziu o tempo em mais de 130 vezes.