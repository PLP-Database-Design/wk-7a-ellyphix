-- Question 1: Achieving 1NF (First Normal Form)
-- Task: Transform the ProductDetail table into 1NF.
-- call the new table OrderProduct1NF.
/*
-- Conceptual Original Table (violates 1NF):
CREATE TABLE ProductDetail_Original (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Products VARCHAR(255) -- Contains comma-separated values
);
-- Inserting the sample data into the conceptual original table:
INSERT INTO ProductDetail_Original (OrderID, CustomerName, Products) VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');
*/
-- SQL to represent the data in 1NF:
CREATE TABLE OrderProduct1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    PRIMARY KEY (OrderID, Product) -- Composite primary key
);

-- Insert data into OrderProduct1NF, representing the 1NF transformation
INSERT INTO OrderProduct1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');


-- Question 2: Achieving 2NF
-- Task: Transform the OrderDetails table (which is in 1NF) into 2NF.
-- Split the table into two: one for Order information and one for Order Item details.
/*
CREATE TABLE OrderDetails_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product) -- Composite primary key
);

INSERT INTO OrderDetails_1NF (OrderID, CustomerName, Product, Quantity) VALUES
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);
*/

-- SQL to represent the data in 2NF:
-- Create the table structure for Orders
CREATE TABLE Orders2NF (
    OrderID INT PRIMARY KEY,       -- OrderID is the primary key
    CustomerName VARCHAR(100)      -- CustomerName depends fully on OrderID
);

-- Insert data into Orders2NF
INSERT INTO Orders2NF (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');
-- Create the table structure for Order Items
CREATE TABLE OrderItems2NF (
    OrderID INT,                  -- Foreign key referencing Orders2NF
    Product VARCHAR(100),         -- Part of the composite primary key
    Quantity INT,                 -- Depends fully on the composite key (OrderID, Product)
    PRIMARY KEY (OrderID, Product), -- Composite primary key
    FOREIGN KEY (OrderID) REFERENCES Orders2NF(OrderID) -- Define foreign key relationship
);
-- Insert data into OrderItems2NF
INSERT INTO OrderItems2NF (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- This split ensures that CustomerName is only stored once per OrderID,
