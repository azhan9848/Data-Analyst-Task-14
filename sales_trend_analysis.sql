-- SQL Script: Monthly Revenue and Order Volume Analysis

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(10,2),
    product_id VARCHAR(50)
);

-- Insert data here using your dataset

INSERT INTO orders (order_id, order_date, amount, product_id) VALUES
(1, '2025-01-01', 250.00, 'P101'),
(2, '2025-01-02', 120.00, 'P102'),
(3, '2025-01-03', 75.50, 'P103'),
(4, '2025-01-04', 300.00, 'P101'),
(5, '2025-01-05', 450.00, 'P104'),
(6, '2025-01-06', 99.99, 'P102'),
(7, '2025-01-07', 150.00, 'P105'),
(8, '2025-01-08', 200.00, 'P106'),
(9, '2025-01-09', 175.25, 'P101'),
(10, '2025-01-10', 350.00, 'P107'),
(11, '2025-01-11', 400.00, 'P108'),
(12, '2025-01-12', 220.00, 'P109'),
(13, '2025-01-13', 135.50, 'P110'),
(14, '2025-01-14', 500.00, 'P104'),
(15, '2025-01-15', 280.00, 'P106'),
(16, '2025-01-16', 199.99, 'P102'),
(17, '2025-01-17', 89.75, 'P103'),
(18, '2025-01-18', 310.00, 'P105'),
(19, '2025-01-19', 275.00, 'P107'),
(20, '2025-01-20', 145.00, 'P101');

-- Query for Monthly Revenue and Order Volume
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY year, month
ORDER BY year, month;