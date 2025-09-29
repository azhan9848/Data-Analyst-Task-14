use coll;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    location VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Customers VALUES
(1, 'Alice', 'alice@mail.com', 'New York'),
(2, 'Bob', 'bob@mail.com', 'California'),
(3, 'Charlie', 'charlie@mail.com', 'Texas');

INSERT INTO Products VALUES
(201, 'Keyboard', 'Electronics', 50.00),
(202, 'Monitor', 'Electronics', 150.00),
(203, 'Mouse', 'Accessories', 100.00),
(204, 'Headphones', 'Electronics', 120.00);

INSERT INTO Orders VALUES
(101, 1, '2025-01-15', 250.00),
(102, 2, '2025-02-20', 400.00),
(103, 1, '2025-02-28', 150.00),
(104, 3, '2025-03-05', 300.00);

INSERT INTO Order_Items VALUES
(1, 101, 201, 2, 50.00),   
(2, 101, 202, 1, 150.00),  
(3, 102, 203, 3, 100.00),  
(4, 103, 201, 1, 50.00),  
(5, 104, 204, 2, 120.00); 

SELECT order_id, customer_id, order_date, total_amount
FROM Orders
WHERE YEAR(order_date) = 2025;

SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC;

SELECT o.order_id, c.name, o.order_date, o.total_amount
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id;

SELECT c.customer_id, c.name, o.order_id, o.total_amount
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;

SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING total_spent > (
    SELECT AVG(total_amount) FROM Orders
);

SELECT p.category, 
       SUM(oi.quantity * oi.price) AS total_sales,
       AVG(oi.price) AS avg_price
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.category;

CREATE VIEW Monthly_Sales AS
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       SUM(total_amount) AS total_sales
FROM Orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m');

SELECT * FROM Monthly_Sales;

CREATE INDEX idx_order_date ON Orders(order_date);
