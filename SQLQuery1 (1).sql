CREATE DATABASE DataWarehouse;

USE DataWarehouse; -- Asegúrate de usar tu base de datos

CREATE TABLE DimCustomers (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(255),
    CustomerEmail NVARCHAR(255),
    CustomerPhone NVARCHAR(20)
);

CREATE TABLE DimEmployee (
    EmployeeID INT PRIMARY KEY,
    EmployeeName NVARCHAR(255),
    EmployeePosition NVARCHAR(100),
    HireDate DATE
);

CREATE TABLE DimShippers (
    ShipperID INT PRIMARY KEY,
    ShipperName NVARCHAR(255),
    ContactNumber NVARCHAR(20)
);

CREATE TABLE DimCategory (
    CategoryID INT PRIMARY KEY,
    CategoryName NVARCHAR(255),
    Description NVARCHAR(500)
);

CREATE TABLE DimProduct (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(255),
    CategoryID INT FOREIGN KEY REFERENCES DimCategory(CategoryID),
    Price DECIMAL(10, 2)
);


INSERT INTO DimCustomers (CustomerID, CustomerName, CustomerEmail, CustomerPhone)
VALUES 
(1, 'John Doe', 'john.doe@example.com', '123-456-7890'),
(2, 'Jane Smith', 'jane.smith@example.com', '987-654-3210'),
(3, 'Alice Brown', 'alice.brown@example.com', '555-123-4567'),
(4, 'Robert Johnson', 'robert.johnson@example.com', '555-987-6543'),
(5, 'Emily Davis', 'emily.davis@example.com', '444-555-6666'),
(6, 'Michael Wilson', 'michael.wilson@example.com', '777-888-9999'),
(7, 'Sarah Taylor', 'sarah.taylor@example.com', '111-222-3333'),
(8, 'David Anderson', 'david.anderson@example.com', '222-333-4444');

INSERT INTO DimEmployee (EmployeeID, EmployeeName, EmployeePosition, HireDate)
VALUES 
(1, 'Alice Johnson', 'Manager', '2020-05-01'),
(2, 'Bob Brown', 'Analyst', '2018-09-15'),
(3, 'Charlie Wilson', 'Developer', '2019-07-10'),
(4, 'Diana Evans', 'HR Specialist', '2017-03-20'),
(5, 'Evan Clark', 'Sales Associate', '2021-02-14'),
(6, 'Fiona Hall', 'Accountant', '2016-11-05'),
(7, 'George King', 'IT Support', '2018-01-22'),
(8, 'Hannah Wright', 'Product Manager', '2019-10-30');

INSERT INTO DimShippers (ShipperID, ShipperName, ContactNumber)
VALUES 
(1, 'Fast Shipping Co.', '555-1234'),
(2, 'Quick Transport', '555-5678'),
(3, 'Global Logistics', '555-4321'),
(4, 'Express Movers', '555-8765'),
(5, 'Prime Freight', '555-3456'),
(6, 'Reliable Carriers', '555-6543'),
(7, 'Swift Couriers', '555-7890'),
(8, 'Next Day Delivery', '555-9870');

INSERT INTO DimCategory (CategoryID, CategoryName, Description)
VALUES 
(1, 'Electronics', 'Devices and gadgets'),
(2, 'Furniture', 'Home and office furniture'),
(3, 'Clothing', 'Men and women apparel'),
(4, 'Books', 'Printed and digital books'),
(5, 'Toys', 'Kids and adult toys'),
(6, 'Groceries', 'Daily essentials and food items'),
(7, 'Sports', 'Sports equipment and gear'),
(8, 'Automotive', 'Car and bike accessories');


INSERT INTO DimProduct (ProductID, ProductName, CategoryID, Price)
VALUES 
(1, 'Laptop', 1, 799.99),
(2, 'Office Chair', 2, 129.99),
(3, 'T-Shirt', 3, 19.99),
(4, 'Fiction Book', 4, 14.99),
(5, 'Action Figure', 5, 29.99),
(6, 'Pasta Pack', 6, 4.99),
(7, 'Football', 7, 24.99),
(8, 'Car Charger', 8, 15.99),
(9, 'Smartphone', 1, 599.99),
(10, 'Bookshelf', 2, 199.99),
(11, 'Jeans', 3, 49.99),
(12, 'Cookbook', 4, 24.99),
(13, 'Board Game', 5, 39.99),
(14, 'Rice Bag', 6, 12.99),
(15, 'Tennis Racket', 7, 89.99),
(16, 'Car Vacuum', 8, 29.99);


CREATE PROCEDURE CleanDimensionsExtended
AS
BEGIN

    DELETE FROM DimCustomers
    WHERE CustomerID NOT IN (
        SELECT MIN(CustomerID)
        FROM DimCustomers
        GROUP BY CustomerName, CustomerEmail, CustomerPhone
    );


    DELETE FROM DimEmployee
    WHERE EmployeeID NOT IN (
        SELECT MIN(EmployeeID)
        FROM DimEmployee
        GROUP BY EmployeeName, EmployeePosition, HireDate
    );

 
    DELETE FROM DimShippers
    WHERE ShipperID NOT IN (
        SELECT MIN(ShipperID)
        FROM DimShippers
        GROUP BY ShipperName, ContactNumber
    );

    DELETE FROM DimCategory
    WHERE CategoryID NOT IN (
        SELECT MIN(CategoryID)
        FROM DimCategory
        GROUP BY CategoryName, Description
    );

    DELETE FROM DimProduct
    WHERE ProductID NOT IN (
        SELECT MIN(ProductID)
        FROM DimProduct
        GROUP BY ProductName, CategoryID, Price
    );


    DELETE FROM DimCustomers WHERE CustomerName IS NULL OR CustomerEmail IS NULL;
    DELETE FROM DimEmployee WHERE EmployeeName IS NULL OR EmployeePosition IS NULL;
    DELETE FROM DimShippers WHERE ShipperName IS NULL;
    DELETE FROM DimCategory WHERE CategoryName IS NULL;
    DELETE FROM DimProduct WHERE ProductName IS NULL OR Price IS NULL;
END;


SELECT * 
FROM DimProduct;




