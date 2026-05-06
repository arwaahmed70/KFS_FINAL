create database hello
use hello

--retrieving the entire table
select * from [dbo].[Sample - Superstore ]

--creating a new table and puting some constraints 
CREATE TABLE Sales_Team(
	Emp_ID INT PRIMARY KEY NOT NULL,
	Emp_Name VARCHAR(50) NOT NULL,
	Emp_Email VARCHAR(50) UNIQUE, 
	City VARCHAR(50) DEFAULT 'Henderson',
	Region VARCHAR(50) NOT NULL
	);
--insetring values
INSERT INTO Sales_Team (Emp_ID,Emp_Name,Emp_Email,City,Region) VALUES
	 (1,'Ahmed','ahmed@11.com','Laguna Niguel','Central'),
	 (2,'Ali','Ail@11.com','Baltimore','Central'),
	 (3,'Mona','Mona@19.com','Lake Charles','East'),
	 (4,'Laila','Laila@41.com','Charlotte','South'),
	 (5,'Arwa','Arwa@901.com','Knoxville','West'),
	 (6,'Reham','Reham@31.com','Rome','West'),
	 (7,'Malak','Malak@18.com','Sierra Vista','East'),
	 (8,'Sara','Sara@23.com','Sunnyvale','West'),
	 (9,'Dina','Dina@12.com','Niagara Falls','West'),
	 (10,'Maha','Maha@71.com','Gaithersburg','South');

select * from Sales_Team

-- make Region as foreign key to connect Sample - Superstore and Sales_Team 
ALTER TABLE [dbo].[Sample - Superstore ]
ADD CONSTRAINT FK_STORE_REG
FOREIGN KEY (Region) REFERENCES Sales_Team(Region);

--creating a new table and puting some constraints 
CREATE TABLE DEPENDENTS(
DEP_NAME  VARCHAR(50) NOT NULL,
Emp_ID INT NOT NULL FOREIGN KEY REFERENCES Sales_Team (Emp_ID),
Emp_Name  VARCHAR(50) ,
Relationship VARCHAR(25),
PRIMARY KEY (DEP_NAME, Emp_Name),
);
--insetring values
INSERT INTO DEPENDENTS VALUES
('Alice',4,'Laila','Daughter'),
('Theodore',7,'Malak','Son'),
('Joy',9,'Dina','Spouse'),
('Abner',1,'Ahmed','Spouse'),
('Michael',3,'Mona','Son'),
('Alice',1,'Ahmed','Daughter'),
('Elizabeth',8,'Sara','Spouse');
select * from DEPENDENTS

-- select top orders of Los Angeles 
SELECT [Order_ID],[Customer_Name],[Profit]
FROM [dbo].[Sample - Superstore ]
WHERE [City]= 'New Henderson' AND [Profit] >= 100
ORDER BY [Profit] DESC;

--selecting ORDER ID AND DATE of orders whose profit is 500 and above  
select [Category] , sum([Sales]) as Total_Sales
from [dbo].[Sample - Superstore ]
group by [Category];

-- select cities tyhat have more than 10000 sales
select[City] , sum([Sales]) as City_Sales
from [dbo].[Sample - Superstore ]
group by [City]
having sum([Sales]) > 10000;

-- select orders greater than average
SELECT S.Order_ID,T.City,T.Emp_Name
FROM Sales_Team T
LEFT JOIN [dbo].[Sample - Superstore ] S ON T.City = S.City
SELECT [Order_ID],[Sales]
FROM [dbo].[Sample - Superstore ]
WHERE [Sales] > (SELECT AVG([Sales]) FROM [Sample - Superstore ])

--create a view table as a daily report
CREATE VIEW Daily_Performance AS 
	SELECT [Order_Date],SUM([Sales]) AS Daily_Sales,SUM([Profit]) AS Daily_Profit
	FROM [dbo].[Sample - Superstore ]
	GROUP BY [Order_Date];

SELECT * FROM Daily_Performance;

-- CREATE STORED PROCEDURE TO SEARCH ABOUT A CUSTOMER
CREATE PROCEDURE GetCustomerOrder @CustName VARCHAR(100) AS
BEGIN
	SELECT [Order_ID],[Order_Date],[Sales]
	FROM [dbo].[Sample - Superstore ]
	WHERE [Customer_Name] = @CustName
END;

EXEC GetCustomerOrder 'Claire Gute';

--top 5 products have loss
SELECT TOP 5 [Product_Name], SUM([Profit]) AS Total_Loss
FROM [dbo].[Sample - Superstore ]
GROUP BY [Product_Name]
ORDER BY Total_Loss ASC;

--update data in column City
UPDATE [dbo].[Sample - Superstore ] SET City = 'New Henderson'
WHERE City = 'Henderson';



