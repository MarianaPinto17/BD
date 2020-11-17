-- a) Crie as bases de dados em SQL Server utilizando a linguagem SQL DDL. Tenha em atenção as restrições de integridade ao nível do domínio, entidade e referencial;

CREATE SCHEMA company;
GO

ALTER TABLE company.employee ADD CONSTRAINT fk FOREIGN KEY(Dno) REFERENCES company.department(Dnumber);

CREATE TABLE company.dependent (
	Essn 			DECIMAL(9,0) 	NOT NULL,
	Dependent_name 	VARCHAR(100)	NOT NULL,
	Sex 			CHAR(1),
	Bdate 			DATE,
	Relationship	VARCHAR(20)		NOT NULL,
	PRIMARY KEY(Essn, Dependent_name),
	FOREIGN KEY(Essn) REFERENCES company.employee(Ssn)
);

CREATE TABLE company.employee (
	Fname 		VARCHAR(15) 	NOT NULL,
	Minit 		CHAR(1),
	Lname 		VARCHAR(20) 	NOT NULL,
	Ssn   		DECIMAL(9,0) 	NOT NULL, 
	Bdate 		DATE, 
	Address		VARCHAR(60), 
	Sex			CHAR(1), 
	Salary		DECIMAL(11,2), 
	Super_ssn	DECIMAL(9,0), 
	Dno 		INT 			NOT NULL,
	PRIMARY KEY(Ssn),
	FOREIGN KEY(Super_ssn) REFERENCES company.employee(Ssn) 
);

CREATE TABLE company.department (
	Dname 			VARCHAR(25)	NOT NULL,
	Dnumber 		INT 		NOT NULL,
	Mgr_ssn 		DECIMAL(9,0),
	Mgr_start_date 	DATE,
	PRIMARY KEY(Dnumber),
	FOREIGN KEY(Mgr_ssn) REFERENCES company.employee(Ssn)
);

CREATE TABLE company.project (
	Pname 		VARCHAR(20)	NOT NULL,
	Pnumber 	INT 		NOT NULL,
	Plocation 	VARCHAR(60),
	Dnum 		INT 		NOT NULL,
	PRIMARY KEY(Pnumber),
	FOREIGN KEY(Dnum) REFERENCES company.department(Dnumber)
);

CREATE TABLE company.dept_location (
	Dnumber		INT 		NOT NULL,
	Dlocation 	VARCHAR(60)	NOT NULL,
	PRIMARY KEY(Dnumber, Dlocation),
	FOREIGN KEY(Dnumber) REFERENCES company.department(Dnumber)
);

CREATE TABLE company.works_on (
	Essn 	DECIMAL(9,0)	NOT NULL,
	Pno 	INT 			NOT NULL,
	Hours	DECIMAL(6,1),
	PRIMARY KEY(Essn, Pno),
	FOREIGN KEY(Essn) REFERENCES company.employee(Ssn),
	FOREIGN KEY(Pno) REFERENCES company.project(Pnumber)
);

-- b) Introduza dados nas bases de dados criadas. Sugere-se que utilize o dataset fornecido na última aula (disponível no Moodle);

INSERT INTO company.employee VALUES ('Paula', 'A', 'Sousa', 183623612, '20010811', 'Rua da FRENTE', 'F', 1450.00, NULL, 3);
INSERT INTO company.employee VALUES ('Carlos', 'D', 'Gomes', 21312332, '20000101', 'Rua XPTO', 'M', 1200.00, NULL, 1);
INSERT INTO company.employee VALUES ('Juliana', 'A', 'Amaral', 321233765, '19800811', 'Rua BZZZZ', 'F', 1350.00, NULL, 3);
INSERT INTO company.employee VALUES ('Maria', 'I', 'Pereira', 342343434, '20010501', 'Rua JANOTA', 'F', 1250.00, 21312332, 2);
INSERT INTO company.employee VALUES ('Joao', 'G', 'Costa', 41124234, '20010101', 'Rua YGZ', 'M', 1300.00, 21312332, 2);
INSERT INTO company.employee VALUES ('Ana', 'L', 'Silva', 12652121, '19900303', 'Rua ZIG ZAG', 'F', 1400.00, 21312332, 2);

INSERT INTO company.department VALUES ('Investigacao', 1, 21312332, '20100802');
INSERT INTO company.department VALUES ('Comercial', 2, 321233765, '20130516');
INSERT INTO company.department VALUES ('Logistica', 3, 41124234, '20130516');
INSERT INTO company.department VALUES ('Recursos Humanos', 4, 12652121, '20140402');
INSERT INTO company.department VALUES ('Desporto', 5, NULL, NULL);

INSERT INTO company.dependent VALUES (21312332, 'Joana Costa', 'F', '20080401', 'Filho');
INSERT INTO company.dependent VALUES (21312332, 'Maria Costa', 'F', '19901005', 'Neto');
INSERT INTO company.dependent VALUES (21312332, 'Rui Costa', 'M', '20000804', 'Neto');
INSERT INTO company.dependent VALUES (321233765, 'Filho Lindo', 'M', '20010222', 'Filho');
INSERT INTO company.dependent VALUES (342343434, 'Rosa Lima', 'F', '20060311', 'Filho');
INSERT INTO company.dependent VALUES (41124234, 'Ana Sousa', 'F', '20070413', 'Neto');
INSERT INTO company.dependent VALUES (41124234, 'Gaspar Pinto', 'M', '20060208', 'Sobrinho');

INSERT INTO company.dept_location VALUES (2, 'Aveiro');
INSERT INTO company.dept_location VALUES (3, 'Coimbra');

INSERT INTO company.project VALUES ('Aveiro Digital', 1, 'Aveiro', 3);
INSERT INTO company.project VALUES ('BD Open Day', 2, 'Espinho', 2);
INSERT INTO company.project VALUES ('Dicoogle', 3, 'Aveiro', 3);
INSERT INTO company.project VALUES ('GOPACS', 4, 'Aveiro', 3);

INSERT INTO company.works_on VALUES (183623612, 1, 20.0);
INSERT INTO company.works_on VALUES (183623612, 3, 10.0);
INSERT INTO company.works_on VALUES (21312332, 1, 20.0);
INSERT INTO company.works_on VALUES (321233765, 1, 25.0);
INSERT INTO company.works_on VALUES (342343434, 1, 20.0);
INSERT INTO company.works_on VALUES (342343434, 4, 25.0);
INSERT INTO company.works_on VALUES (41124234, 2, 20.0);
INSERT INTO company.works_on VALUES (41124234, 3, 30.0);

-- c) Converta as queries AR em queries SQL.

-----a) Obtenha uma lista contendo os projetos e funcionários (ssn e nome completo) que lá trabalham.
SELECT Pname, Pnumber, Plocation, Dnum, Fname, Minit, Lname, Ssn FROM (company.project JOIN company.works_on ON Pnumber = Pno) JOIN company.employee ON Essn = Ssn;

----b) Obtenha o nome de todos os funcionários supervisionados por ‘Carlos D Gomes’.
SELECT e.Fname, e.Minit, e.Lname FROM company.employee AS e JOIN (SELECT  * FROM company.employee WHERE Fname = 'Carlos' AND Minit='D' AND Lname='Gomes') AS man ON e.Super_ssn = man.Ssn; 

----c) Para cada projeto, listar o seu nome e o número de horas (por semana) gastos nesse projeto por todos os funcionários;
SELECT Pname, SUM(Hours) AS total_hours FROM company.project JOIN company.works_on ON Pnumber=Pno GROUP BY Pname;

----d) Obter o nome de todos os funcionários do departamento 3 que trabalham mais de 20 horas por semana no projeto ‘Aveiro Digital’;
SELECT Fname, Minit, Lname FROM (company.employee JOIN company.works_on ON Ssn=Essn AND Dno=3) JOIN company.project ON Pno=Pnumber AND Pname='Aveiro Digital' WHERE Hours > 20;

----e) Nome dos funcionários que não trabalham para projetos;
SELECT Fname, Minit, Lname FROM company.employee LEFT OUTER JOIN company.works_on ON Ssn=Essn WHERE Pno IS NULL;

----f) Para cada departamento, listar o seu nome e o salário médio dos seus funcionários do sexo feminino;
SELECT Dname, AVG(Salary) AS avg_Salary FROM company.employee JOIN company.department ON Dno=Dnumber WHERE Sex='F' GROUP BY Dno, Dname;

----g) Obter uma lista de todos os funcionários com mais do que dois dependentes;
SELECT Fname, Minit, Lname FROM company.employee JOIN company.dependent ON Ssn=Essn GROUP BY Fname, Minit, Lname, Ssn HAVING COUNT(Essn)> 2;

----h) Obtenha uma lista de todos os funcionários gestores de departamento que não têm dependentes;
SELECT Fname, Minit, Lname FROM (company.employee JOIN company.department ON Ssn=Mgr_ssn) LEFT OUTER JOIN company.dependent ON Ssn=Essn GROUP BY Fname, Minit, Lname, Ssn HAVING COUNT(Essn) = 0;

----i) Obter os nomes e endereços de todos os funcionários que trabalham em, pelo menos, um projeto localizado em Aveiro mas o seu departamento não tem nenhuma localização em Aveiro.
SELECT DISTINCT Ssn, Fname, Minit, Lname, Address FROM company.employee JOIN company.works_on ON Ssn=Essn JOIN company.project ON Pno=Pnumber AND Plocation='Aveiro' JOIN (SELECT company.department.* FROM (company.department LEFT OUTER JOIN company.dept_location 
ON company.department.Dnumber=company.dept_location.Dnumber) WHERE Dlocation!='Aveiro' OR Dlocation IS NULL) AS deps ON Dno=Dnumber;
