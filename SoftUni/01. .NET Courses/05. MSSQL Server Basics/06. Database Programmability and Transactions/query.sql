--problem1
CREATE PROC usp_GetEmployeesSalaryAbove35000
AS
    SELECT FirstName, LastName
    FROM Employees
    WHERE Salary > 35000

--problem2
CREATE PROC usp_GetEmployeesSalaryAboveNumber(@Number DECIMAl(18, 4))
AS
    SELECT FirstName, LastName
    FROM Employees
    WHERE Salary >= @Number

--problem3
CREATE PROC usp_GetTownsStartingWith(@param varchar(MAX))
AS
    SELECT t.Name n
    FROM Towns t
WHERE LEFT( t.Name, LEN(@param)) = @param

--problem4
CREATE PROC usp_GetEmployeesFromTown(@TownName varchar(50))
AS
    SELECT FirstName, LastName
FROM Employees JOIN Addresses A on Employees.AddressID = A.AddressID
JOIN Towns T2 on A.TownID = T2.TownID
WHERE T2.Name = @TownName

--problem5
CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS VARCHAR(50)
AS
    BEGIN
        DECLARE @salaryLevel VARCHAR(10)
        IF(@salary < 30000)
            SET @salaryLevel = 'Low'
        ELSE IF(@salary >= 30000 AND @salary <= 50000)
            SET @salaryLevel = 'Average'
        ELSE
            SET @salaryLevel = 'High'

        RETURN @salaryLevel
    END

--problem6
CREATE PROC usp_EmployeesBySalaryLevel(@level varchar(10))
AS
    SELECT FirstName, LastName
from Employees
WHERE ufn_GetSalaryLevel(Salary) = @level

--problem7
CREATE FUNCTION
ufn_IsWordComprised(@setOfLetters VARCHAR(50), @word VARCHAR(100))
RETURNS BIT
AS
    BEGIN
        DECLARE @cnt INT = 0;
        DECLARE @result BIT = 1;

        WHILE @cnt < LEN(@setOfLetters)

        BEGIN
            DECLARE @currentLetter VARCHAR(2) = LEFT(@word, @cnt)

            IF(CHARINDEX(@currentLetter, @setOfLetters)) = 0
            BEGIN
                SET @result = 0
            END


        END
        RETURN @result

    END

--problem8
CREATE PROC usp_DeleteEmployeesFromDepartment(@demartmentId INT)
AS
DELETE FROM Employees
WHERE DepartmentID = @demartmentId
DELETE FROM Departments
WHERE DepartmentID = @demartmentId


--problem9

CREATE PROC usp_GetHoldersFullName
AS
    SELECT FirstName + ' ' + LastName AS 'Full Name'
    FROM AccountHolders

--problem10
CREATE PROC usp_GetHoldersWithBalanceHigherThan(@number DECIMAL(18, 4))
AS
    SELECT ah.FirstName, ah.LastName
    FROM AccountHolders ah JOIN Accounts A on ah.Id = A.AccountHolderId
    GROUP BY ah.FirstName, ah.LastName HAVING SUM(Balance) > @number
ORDER BY FirstName, LastName

--problem11
CREATE FUNCTION ufn_CalculateFutureValue(
@sum DECIMAL(14, 4),
@rate FLOAT,
@years INT)
RETURNS DECIMAL(14, 4)
BEGIN
    RETURN @sum * (POWER(1 + @rate, @years))
END

--problem12
CREATE PROC usp_CalculateFutureValueForAccount(@AccountID int, @Interest FLOAT)
AS
    SELECT A2.Id, a.FirstName, a.LastName, A2.Balance, dbo.ufn_CalculateFutureValue(a2.Balance, @Interest, 5)
    AS [Balance in 5 years]
    FROM AccountHolders a
    JOIN Accounts A2 on a.Id = A2.AccountHolderId
    WHERE A2.Id = @AccountID
