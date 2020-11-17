-- b) Crie um stored procedure que retorne um record-set com os funcionários gestores
-- de departamentos, assim como o ssn e número de anos (como gestor) do
-- funcionário mais antigo dessa lista.
GO
CREATE PROCEDURE company.p_ManagersRecordSet 
	@OldestManagerSSN DECIMAL(9,0) OUTPUT,
	@OldestManagerYears INT OUTPUT
AS
BEGIN
	SELECT CONCAT(Fname, ' ', Minit, '. ', Lname) AS ManagerName, Ssn
	FROM company.employee;

	SELECT TOP 1 @OldestManagerSSN = Mgr_ssn, 
				 @OldestManagerYears = DATEDIFF(yy, Mgr_start_date, CAST(GETDATE() AS DATE))
	FROM company.department
	WHERE Mgr_start_date IS NOT NULL
	ORDER BY Mgr_start_date;
END
GO

-- d) Crie um trigger que não permita que determinado funcionário tenha um
-- vencimento superior ao vencimento do gestor do seu departamento. Nestes casos,
-- o trigger deve ajustar o salário do funcionário para um valor igual ao salário do
-- gestor menos uma unidade.
CREATE TRIGGER WageLimiter ON company.employee
AFTER INSERT, UPDATE
AS
BEGIN
	UPDATE company.employee
	SET Salary = outlier_employees.Salary - 1
	FROM
		(SELECT i.Ssn, e.Salary
		FROM inserted AS i JOIN employee AS e ON i.Super_ssn = e.Ssn
		WHERE i.Salary >= e.Salary) AS outlier_employees
	WHERE company.employee.Ssn = outlier_employees.Ssn;
END
GO

-- e) Crie uma UDF que, para determinado funcionário (ssn), devolva o nome e
-- localização dos projetos em que trabalha.

-- f) Crie uma UDF que, para determinado departamento (dno), retorne os funcionários
-- com um vencimento superior à média dos vencimentos desse departamento;
GO
CREATE FUNCTION company.AboveAVGSalaries(@dnum INT)
RETURNS @EmployeeInfo TABLE (
	employee_name		VARCHAR(40),
	employee_ssn		DECIMAL(9,0),
	employee_salary		DECIMAL(11,2))
AS
BEGIN
	INSERT @EmployeeInfo (employee_name, employee_ssn, employee_salary)
	
		SELECT CONCAT(Fname, ' ', Minit, '. ', Lname) AS [name], Ssn, Salary
		FROM employee
		WHERE Dno = @dnum
			AND Salary > (SELECT AVG(Salary) FROM employee WHERE Dno = @dnum);

	RETURN;
END
GO
-- g) Crie uma UDF que, para determinado departamento, retorne um record-set com os
-- projetos desse departamento. Para cada projeto devemos ter um atributo com seu o
-- orçamento mensal de mão de obra e outra coluna com o valor acumulado do
-- orçamento.
GO
CREATE FUNCTION company.ProjectInfo(@dnum INT)
RETURNS @ProjectInfo TABLE (
	pname		VARCHAR(20),
	pnumber		INT,
	plocation 	VARCHAR(60),
	dnum 		INT,
	budget		DECIMAL(8,2),
	totalbudget	DECIMAL(8,2))
AS
BEGIN
	DECLARE @pnumber		INT;
	DECLARE @pname			VARCHAR(20);
	DECLARE @plocation		VARCHAR(60);
	DECLARE @budget			DECIMAL(8,2);
	DECLARE @totalbudget	DECIMAL(8,2);
	DECLARE @totalhours		DECIMAL(7,1);

	-- iterate over each projetc using cursors
	DECLARE cur CURSOR FORWARD_ONLY READ_ONLY LOCAL
	FOR SELECT Pname, Pnumber, Plocation
		FROM company.project
		WHERE Dnum = @dnum;

	SET @totalbudget = 0;

	OPEN cur;
    FETCH NEXT FROM cur INTO @pname, @pnumber, @plocation;
    WHILE @@FETCH_STATUS = 0 BEGIN

		-- calculate budget ("hourly salary" * hours worked)
		SELECT @budget = SUM(w.Hours / 40 * e.Salary)
		FROM company.works_on AS w JOIN company.employee AS e ON w.Essn = e.Ssn
		WHERE w.Pno = @pnumber;

		-- calculate total budget (sum of budgets)
		SET @totalbudget += @budget;

		-- insert into table
		INSERT @ProjectInfo (pname, pnumber, plocation, dnum, budget, totalbudget) VALUES
			(@pname, @pnumber, @plocation, @dnum, @budget, @totalbudget);

		FETCH NEXT FROM cur INTO @pname, @pnumber, @plocation;
    END

    CLOSE cur;
    DEALLOCATE cur;

	RETURN;
END
GO

-- i) Relativamente aos stored procedure e UDFs, enumere as suas mais valias e as
-- características que as distingue. Dê exemplos de situações em que se deve utiliza
-- cada uma destas ferramentas;
/*

SPs ou Stored Procedures -> conjuntos de instruções T-SQL (batch) armazenadas sobre um dado nome.
São mais rápidos por são compilados apenas uma vez. Podem ter parametros de entrada, saída e 
devolver conjuntos de registos. Utilizados quando são nececárias funções não deterministas ou blocos TRY/Catch,
quando queremos alterar objetos da BD.

UDFs ou User Defined Functions -> Podem ser usados como fontes de dados e são semelhantes aos SPs. Usados quando é
necessário devolver uma tabela. Tem 3 tipos: inline table-valued, multi-statement table-valued e escalares. Um SPs 
pode invocar um ou mais UDFs (não vice-versa). 

Vantagens SPS:
- extensiveis
- melhor performance
- melhor segurança

Vantagens UDFs:
- melhorias na performance
- facilidade extensao, centralização e teste

*/
