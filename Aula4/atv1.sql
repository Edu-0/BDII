-- Tabela de Funcionários 
CREATE TABLE funcionarios ( 
    id serial PRIMARY KEY, 
    nome VARCHAR(100), 
    departamento_id INT, 
    supervisor_id INT, 
    data_contratacao DATE, 
    salario DECIMAL(10, 2), 
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id), 
    FOREIGN KEY (supervisor_id) REFERENCES funcionarios(id) 
); 
 -- Tabela de Departamentos 
CREATE TABLE departamentos ( 
    id serial PRIMARY KEY, 
    nome VARCHAR(100) 
); 
 -- Tabela de Vendas 
CREATE TABLE vendas ( 
    id serial PRIMARY KEY, 
    cliente_id INT, 
    data_venda DATE, 
    valor DECIMAL(10, 2), 
    FOREIGN KEY (cliente_id) REFERENCES clientes(id) 
); 
 -- Tabela de Itens de Venda 
CREATE TABLE itens_venda ( 
    id serial PRIMARY KEY, 
    venda_id INT, 
    produto_id INT, 
    quantidade INT, 
    valor_unitario DECIMAL(10, 2), 
    FOREIGN KEY (venda_id) REFERENCES vendas(id), 
    FOREIGN KEY (produto_id) REFERENCES produtos(id) 
); 
 -- Tabela de Clientes 
CREATE TABLE clientes ( 
    id serial PRIMARY KEY, 
    nome VARCHAR(100) 
); 
 -- Tabela de Produtos 
CREATE TABLE produtos ( 
    id serial PRIMARY KEY, 
	nome VARCHAR(100), 
    categoria_id INT, 
    FOREIGN KEY (categoria_id) REFERENCES categorias(id) 
);

-- Tabela de Categorias 
CREATE TABLE categorias ( 
    id serial PRIMARY KEY, 
    nome VARCHAR(100) 
); 
 -- Tabela de Estoque 
CREATE TABLE estoque ( 
    id serial PRIMARY KEY, 
    produto_id INT, 
    quantidade INT, 
    FOREIGN KEY (produto_id) REFERENCES produtos(id) 
); 

-- Inserir Departamentos 
INSERT INTO departamentos (id, nome) VALUES 
(1, 'Vendas'), 
(2, 'RH'), 
(3, 'Financeiro'), 
(4, 'TI'); 
 -- Inserir Funcionários 
INSERT INTO funcionarios (id, nome, departamento_id, supervisor_id, data_contratacao, 
salario) VALUES 
(1, 'João', 1, NULL, '2015-01-15', 5000), 
(2, 'Maria', 1, 1, '2018-03-20', 4500), 
(3, 'Carlos', 2, 2, '2017-06-10', 5500), 
(4, 'Ana', 2, 2, '2019-11-05', 4800), 
(5, 'Pedro', 3, 3, '2016-08-25', 6000), 
(6, 'Marta', 3, 3, '2020-02-12', 5200), 
(7, 'José', 4, 4, '2014-04-30', 7000), 
(8, 'Luiza', 4, 7, '2018-09-18', 4800); 
 -- Inserir Clientes 
INSERT INTO clientes (id, nome) VALUES 
(1, 'Cliente A'), 
(2, 'Cliente B'), 
(3, 'Cliente C'); 
 -- Inserir Produtos 
INSERT INTO produtos (id, nome, categoria_id) VALUES 
(1, 'Produto 1', 1), 
(2, 'Produto 2', 1), 
(3, 'Produto 3', 2), 
(4, 'Produto 4', 2); 
 -- Inserir Categorias 
INSERT INTO categorias (id, nome) VALUES 
(1, 'Eletrônicos'), 
(2, 'Roupas'); 
 -- Inserir Vendas 
INSERT INTO vendas (id, cliente_id, data_venda, valor) VALUES 
(1, 1, '2023-01-05', 1500), 
(2, 2, '2023-01-10', 2000), 
(3, 3, '2023-01-15', 1000), 
(4, 1, '2023-02-05', 1800), 
(5, 2, '2023-02-10', 2200), 
(6, 3, '2023-02-15', 1200); 
 -- Inserir Itens de Venda 
INSERT INTO itens_venda (id, venda_id, produto_id, quantidade, valor_unitario) VALUES 
(1, 1, 1, 2, 750), 
(2, 1, 2, 1, 500), 
(3, 2, 3, 3, 200), 
(4, 3, 1, 1, 800), 
(5, 4, 2, 2, 1000), 
(6, 5, 3, 2, 600); 
 -- Inserir Estoque
INSERT INTO estoque (id, produto_id, quantidade) VALUES 
(1, 1, 50), 
(2, 2, 30), 
(3, 3, 100), 
(4, 4, 20);

INSERT INTO funcionarios (id, nome, departamento_id, supervisor_id, data_contratacao, salario) VALUES
(9, 'Bruno', 1, 1, '2021-01-10', 4200),
(10, 'Fernanda', 1, 2, '2022-05-14', 4300),
(11, 'Ricardo', 2, 3, '2020-07-22', 5100),
(12, 'Juliana', 2, 4, '2021-09-30', 4700),
(13, 'Roberto', 3, 5, '2019-12-11', 5800),
(14, 'Patricia', 3, 6, '2021-03-19', 5300),
(15, 'Lucas', 4, 7, '2017-08-08', 6900),
(16, 'Camila', 4, 8, '2022-02-27', 4600),
(17, 'André', 1, 1, '2020-11-13', 4400),
(18, 'Aline', 2, 3, '2018-06-21', 5000),
(19, 'Gustavo', 3, 5, '2016-10-05', 6100),
(20, 'Tatiane', 4, 7, '2019-04-17', 4700),
(21, 'Eduardo', 1, 2, '2023-01-09', 4100),
(22, 'Vanessa', 2, 4, '2022-07-23', 4900),
(23, 'Marcelo', 3, 6, '2021-11-02', 5400),
(24, 'Daniela', 4, 8, '2023-03-15', 4500),
(25, 'Felipe', 1, 1, '2017-02-28', 4600),
(26, 'Carla', 2, 3, '2018-12-12', 5200),
(27, 'Rafael', 3, 5, '2020-06-06', 5700),
(28, 'Simone', 4, 7, '2021-08-29', 4800);
