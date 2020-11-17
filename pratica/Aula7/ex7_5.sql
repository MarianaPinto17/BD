use p3g4

--7.5

--a

--i)
create view title_book_authors as
select title,au_fname + ' ' + au_lname as au_name from pubs.dbo.titles	
	inner join pubs.dbo.titleauthor on titles.title_id=titleauthor.title_id
	inner join pubs.dbo.authors on titleauthor.au_id=authors.au_id

-- ii)
create view edi_func as
select pub_name, fname + ' ' + lname as func_name from pubs.dbo.publishers 
	inner join pubs.dbo.employee on publishers.pub_id=employee.pub_id

-- iii)
create view store_title as
select stor_name, title from pubs.dbo.stores 
	inner join pubs.dbo.sales on stores.stor_id = sales.stor_id
	inner join pubs.dbo.titles on sales.title_id = titles.title_id


--b

select * from title_book_authors

select * from edi_func

select * from store_title

--c

select distinct stor_name, au_name from title_book_authors inner join store_title on title_book_authors.title = store_title.title order by 1,2

--d

--i

insert into titles_business (title_id, title, type, pub_id, price, notes)
values('BDTst1', 'New BD Book','popular_comp', '1389', $30.00, 'A must-read for DB course.')

--Não tivemos sucesso na inserção. Sim faz sentido