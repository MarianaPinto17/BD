-- a) Crie as bases de dados em SQL Server utilizando a linguagem SQL DDL. Tenha em atenção as restrições de integridade ao nível do domínio, entidade e referencial;

CREATE SCHEMA stock_orders;
GO

CREATE TABLE stock_orders.produto(
	Codigo		INT PRIMARY KEY NOT NULL,
	Preco		DECIMAL(10,2) CHECK(Preco > 0),
	Nome		VARCHAR(50) NOT NULL,
	Taxa_IVA	INT CHECK(Taxa_IVA >= 0 AND Taxa_IVA <= 100),
	No_unidades	INT CHECK(No_unidades >= 0)
);

CREATE TABLE stock_orders.tipo_fornecedor(
	Codigo		INT PRIMARY KEY NOT NULL,
	Designacao	VARCHAR(50)
);

CREATE TABLE stock_orders.fornecedor(
	NIF						BIGINT PRIMARY KEY NOT NULL CHECK(NIF > 0),
	Nome					VARCHAR(50) NOT NULL,
	No_FAX					BIGINT NOT NULL CHECK(No_FAX > 0),
	Endereco				VARCHAR(100),
	Condicoes_pagamento		VARCHAR(100),
	Tipo					INT REFERENCES stock_orders.tipo_fornecedor(Codigo) NOT NULL
);

CREATE TABLE stock_orders.encomenda(
	No_encomenda	INT PRIMARY KEY NOT NULL,
	Data			DATE NOT NULL,
	Fornecedor		BIGINT REFERENCES stock_orders.fornecedor(NIF) NOT NULL
);

CREATE TABLE stock_orders.contem(
	Codigo_produto			INT REFERENCES stock_orders.produto(Codigo) NOT NULL,
	No_encomenda			INT REFERENCES stock_orders.encomenda(No_encomenda) NOT NULL,
	No_itens_encomendados	INT NOT NULL CHECK(No_itens_encomendados > 0),
	PRIMARY KEY(Codigo_produto, No_encomenda)
);

-- b) Introduza dados nas bases de dados criadas. Sugere-se que utilize o dataset fornecido na última aula (disponível no Moodle);

INSERT INTO stock_orders.tipo_fornecedor VALUES(101,'Carnes');
INSERT INTO stock_orders.tipo_fornecedor VALUES	(102,'Laticinios');
INSERT INTO stock_orders.tipo_fornecedor VALUES	(103,'Frutas e Legumes');
INSERT INTO stock_orders.tipo_fornecedor VALUES	(104,'Mercearia');
INSERT INTO stock_orders.tipo_fornecedor VALUES	(105,'Bebidas');
INSERT INTO stock_orders.tipo_fornecedor VALUES	(106,'Peixe');
INSERT INTO stock_orders.tipo_fornecedor VALUES	(107,'Detergentes');

INSERT INTO stock_orders.fornecedor VALUES (509111222,'LactoSerrano',234872372,NULL,60,102);
INSERT INTO stock_orders.fornecedor VALUES 	(509121212,'FrescoNorte',221234567,'Rua do Complexo Grande - Edf 3',90,102);
INSERT INTO stock_orders.fornecedor VALUES 	(509294734,'PinkDrinks',2123231732,'Rua Poente 723',30,105);
INSERT INTO stock_orders.fornecedor VALUES 	(509827353,'LactoSerrano',234872372,NULL,60,102);
INSERT INTO stock_orders.fornecedor VALUES 	(509836433,'LeviClean',229343284,'Rua Sol Poente 6243',30,107);
INSERT INTO stock_orders.fornecedor VALUES 	(509987654,'MaduTex',234873434,'Estrada da Cincunvalacao 213',30,104);
INSERT INTO stock_orders.fornecedor VALUES 	(590972623,'ConservasMac', 234112233,'Rua da Recta 233',30,104);

INSERT INTO stock_orders.produto VALUES (10001,'Bife da Pa', 8.75,23,125);
INSERT INTO stock_orders.produto VALUES (10002,'Laranja Algarve',1.25,23,1000);
INSERT INTO stock_orders.produto VALUES (10003,'Pera Rocha',1.45,23,2000);
INSERT INTO stock_orders.produto VALUES (10004,'Secretos de Porco Preto',10.15,23,342);
INSERT INTO stock_orders.produto VALUES (10005,'Vinho Rose Plus',2.99,13,5232);
INSERT INTO stock_orders.produto VALUES (10006,'Queijo de Cabra da Serra',15.00,23,3243);
INSERT INTO stock_orders.produto VALUES (10007,'Queijo Fresco do Dia',0.65,23,452);
INSERT INTO stock_orders.produto VALUES (10008,'Cerveja Preta Artesanal',1.65,13,937);
INSERT INTO stock_orders.produto VALUES (10009,'Lixivia de Cor', 1.85,23,9382);
INSERT INTO stock_orders.produto VALUES (10010,'Amaciador Neutro', 4.05,23,932432);
INSERT INTO stock_orders.produto VALUES (10011,'Agua Natural',0.55,6,919323);
INSERT INTO stock_orders.produto VALUES (10012,'Pao de Leite',0.15,6,5434);
INSERT INTO stock_orders.produto VALUES (10013,'Arroz Agulha',1.00,13,7665);
INSERT INTO stock_orders.produto VALUES (10014,'Iogurte Natural',0.40,13,998);

INSERT INTO stock_orders.encomenda VALUES (1,'2015-03-03',509111222);
INSERT INTO stock_orders.encomenda VALUES (2,'2015-03-04',509121212),
INSERT INTO stock_orders.encomenda VALUES (3,'2015-03-05',509987654),
INSERT INTO stock_orders.encomenda VALUES (4,'2015-03-06',509827353),
INSERT INTO stock_orders.encomenda VALUES (5,'2015-03-07',509294734),
INSERT INTO stock_orders.encomenda VALUES (6,'2015-03-08',509836433),
INSERT INTO stock_orders.encomenda VALUES (7,'2015-03-09',509121212),
INSERT INTO stock_orders.encomenda VALUES (8,'2015-03-10',509987654),
INSERT INTO stock_orders.encomenda VALUES (9,'2015-03-11',509836433),
INSERT INTO stock_orders.encomenda VALUES (10,'2015-03-12',509987654);


INSERT INTO stock_orders.contem VALUES (1,10001,200);
INSERT INTO stock_orders.contem VALUES (1,10004,300);
INSERT INTO stock_orders.contem VALUES (2,10002,1200);
INSERT INTO stock_orders.contem VALUES (2,10003,3200);
INSERT INTO stock_orders.contem VALUES (3,10013,900);
INSERT INTO stock_orders.contem VALUES (4,10006,50);
INSERT INTO stock_orders.contem VALUES (4,10007,40);
INSERT INTO stock_orders.contem VALUES (4,10014,200);
INSERT INTO stock_orders.contem VALUES (5,10005,500);
INSERT INTO stock_orders.contem VALUES (5,10008,10);
INSERT INTO stock_orders.contem VALUES (5,10011,1000);
INSERT INTO stock_orders.contem VALUES (6,10009,200);
INSERT INTO stock_orders.contem VALUES (6,10010,200);
INSERT INTO stock_orders.contem VALUES 7,10003,1200);
INSERT INTO stock_orders.contem VALUES (8,10013,350);
INSERT INTO stock_orders.contem VALUES (9,10009,100);
INSERT INTO stock_orders.contem VALUES (9,10010,300);
INSERT INTO stock_orders.contem VALUES (10,10012,200);

-- c) Converta as queries AR em queries SQL.

----a) Lista dos fornecedores que nunca tiveram encomendas;
SELECT * FROM stock_orders.fornecedor EXCEPT SELECT NIF,F.Nome,No_FAX,Endereco,Condicoes_pagamento,Tipo FROM stock_orders.fornecedor as F JOIN stock_orders.encomenda as E ON F.NIF=E.Fornecedor;

----b) Número médio de unidades encomendadas para cada produto;
SELECT I.Codigo_produto,avg(I.No_itens_encomendados) as avg_unidades FROM stock_orders.contem as I GROUP BY I.Codigo_produto;
SELECT * FROM stock_orders.contem as I;

----c) Número médio de produtos por encomenda; (nota: não interessa o número de unidades);SELECT avg(Cast(R.num_occurences as float)) as avg_num_prod FROM (SELECT count(I.Codigo_produto) as num_occurences FROM stock_orders.contem as I GROUP BY I.No_encomenda) as R;

----d)Lista de produtos (e quantidades) fornecidas por cada fornecedor;

SELECT E.Fornecedor,I.Codigo_produto, sum(I.No_itens_encomendados) as quantity FROM stock_orders.contem as I JOIN stock_orders.encomenda as E ON I.No_encomenda=E.No_encomenda GROUP BY E.Fornecedor,I.Codigo_produto ORDER BY E.Fornecedor;
