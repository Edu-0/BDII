CREATE TABLE tb_lixo(
	id INT primary key,
	nome TEXT,
	val int
)

SELECT 'Essa tabela tem ' || count(*) || ' registros' as registro
	FROM tb_lixo;
	
INSERT INTO tb_lixo(id, nome, val)
	values(1, 'Apagar', 10),
	(2, 'Deletar', 20),
	(3, 'Manter', 30)
	
SELECT * FROM tb_lixo

delete from tb_lixo

truncate tb_lixo

drop table tb_lixo