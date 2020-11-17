--a) Todos os tuplos da tabela autores (authors);
SELECT * FROM authors;

--b) O primeiro nome, o último nome e o telefone dos autores;
SELECT au_fname, au_lname,phone FROM authors;

--c) Consulta definida em b) mas ordenada pelo primeiro nome (ascendente) e depois o último nome (ascendente);
SELECT au_fname, au_lname, phone FROM authors ORDER BY au_fname,au_lname;

--d) Consulta definida em c) mas renomeando os atributos para (first_name, last_name,telephone);
SELECT au_fname as first_name, au_lname as last_name, phone as telephone FROM authors ORDER BY au_fname,au_lname;;

--e) Consulta definida em d) mas só os autores da Califórnia (CA) cujo último nome é diferente de ‘Ringer’;
SELECT au_fname as first_name, au_lname as last_name, phone as telephone FROM authors WHERE state='CA' AND au_lname!='RINGER' ORDER BY au_fname,au_lname ;

--f) Todas as editoras (publishers) que tenham ‘Bo’ em qualquer parte do nome;
SELECT * FROM publishers WHERE pub_name LIKE '%Bo%';

--g) Nome das editoras que têm pelo menos uma publicação do tipo ‘Business’;
SELECT DISTINCT p.pub_name FROM p.publishers  AS p JOIN titles AS t ON p.pub_id = t.pub_id WHERE t.type= 'Business';

--h) Número total de vendas de cada editora; -- group by em vez de sum 
SELECT p.pub_id, p.pub_name, t.title, SUM(t.ytd_sales) AS total_sales FROM publishers AND p JOIN titles as t ON p.pub_id=t.pub_id WHERE t.ytd_sales != 0 ;

--i) Número total de vendas de cada editora agrupado por título;
SELECT p.pub_id, p.pub_name, t.title, SUM(t.ytd_sales) AS total_sales FROM publishers AND p JOIN titles as t ON p.pub_id=t.pub_id WHERE t.ytd_sales != 0 GROUP BY p.pub_id, p.pub_name, t.title ORDER BY p.pub_name;

--j) Nome dos títulos vendidos pela loja ‘Bookbeat’;
SELECT DISTINCT titles.title FROM (stores JOIN sales ON stores.stor_id = sales.stor_id) WHERE stores.stor_name = 'Bookbeat';

--k) Nome de autores que tenham publicações de tipos diferentes;
SELECT authors.au_fname,authors._lname FROM (authors JOIN titleauthor ON authors.au_id = titleauthor.au_id JOIN titles ON titles.au_id, authors.auf_name,authors.au_lname HAVING COUNT(titles.type) >1;

--l) Para os títulos, obter o preço médio e o número total de vendas agrupado por tipo (type) e editora (pub_id);
SELECT titles.type, avg(titles.price) as avg_price,sum(sales.qty) as num_sales FROM (titles JOIN sales ON titles.title_id=sales.title_id) GROUP BY titles.[type],titles.pub_id;

--m) Obter o(s) tipo(s) de título(s) para o(s) qual(is) o máximo de dinheiro “à cabeça” (advance) é uma vez e meia superior à média do grupo (tipo);
SELECT titles.type FROM titles GROUP BY titles.type HAVING MAX(advance)>1.5*AVG(advance);

--n) Obter, para cada título, nome dos autores e valor arrecadado por estes com a sua venda;
SELECT T.title, A.au_fname as first_name, A.au_lname as last_name, (TA.royaltyper/100.0)*(T.royalty/100.0)*ytd_sales*price as profit FROM titles as T JOIN titleauthor as TA ON T.title_id=TA.title_id JOIN authors as A ON TA.au_id=A.au_id;

--o) Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, a faturação total, o valor da faturação relativa aos autores e o valor da faturação relativa à editora;
SELECT DISTINCT t.title, t.ytd_sales, t.ytd_sales * t.price AS faturacao, t.royalty / 100.0 * (t.ytd_sales * t.price) AS auths_revenue, (t.ytd_sales * t.price) - (t.royalty / 100.0 * t.ytd_sales * t.price) AS pub_revenu FROM titles AS t WHERE t.ytd_sales > 0;

-- p) Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, o nome de cada autor, o valor da faturação de cada autor e o valor da faturação relativa à editora;
SELECT DISTINCT t.title, t.ytd_sales, CONCAT( a.au_fname, ' ', a.au_lname) AS author, t.ytd_sales * t.price AS faturacao, (t.royalty / 100.0) * (t.ytd_sales * t.price) * (ta.royaltyper / 100.0) AS auth_revenue,(t.ytd_sales * t.price) - (t.royalty / 100.0 * t.ytd_sales * t.price) 
AS pub_revenue FROM (titles AS t JOIN titleauthor AS ta ON t.title_id = ta.title_id) JOIN authors AS a ON a.au_id = ta.au_id WHERE t.ytd_sales > 0;

-- q) Lista de lojas que venderam pelo menos um exemplar de todos os livros;
SELECT stor_id, stor_name, unique_titles_sold FROM (SELECT COUNT(t.title_id) AS total_books FROM titles as t WHERE t.price > 0) AS total_books 
JOIN (SELECT s.stor_id, s.stor_name, COUNT(t.title_id) AS unique_titles_sold FROM ((titles AS t JOIN sales AS sa ON t.title_id = sa.title_id) 
JOIN stores AS s ON sa.stor_id = s.stor_id) GROUP BY s.stor_id, s.stor_name) AS shop_unique ON total_books = unique_titles_sold;

--r) Lista de lojas que venderam mais livros do que a média de todas as lojas.
SELECT stor_id, stor_name, average_sales FROM (SELECT AVG(qty) AS all_average_sales FROM sales AS sa JOIN stores as s ON sa.stor_id = s.stor_id) AS average_all JOIN (SELECT s.stor_id, stor_name, AVG(qty) AS average_sales FROM sales AS sa JOIN stores as s ON sa.stor_id = s.stor_id 
GROUP BY s.stor_id, s.stor_name) AS average_each ON average_sales > all_average_sales;

--s) Nome dos títulos que nunca foram vendidos na loja “Bookbeat”;
SELECT T.title FROM titles as T JOIN sales as S ON T.title_id=S.title_id JOIN stores as ST ON ST.stor_id=S.stor_id WHERE ST.store_name != 'Bookbeat';

-- t) Para cada editora, a lista de todas as lojas que nunca venderam títulos dessa editora;
SELECT P.pub_name,ST.stor_id FROM publishers AS P, stores AS ST GROUP BY P.pub_name,ST.stor_id EXCEPT SELECT P.pub_name,ST.stor_id FROM publishers AS P JOIN titles AS T ON P.pub_id=T.pub_id JOIN sales AS S ON T.title_id=S.title_id JOIN stores AS ST ON S.stor_id=ST.stor_id
GROUP BY P.pub_name,ST.stor_id;