CREATE DATABASE kiosk_db;

USE kiosk_db;

-- Creating tables

CREATE TABLE Admin(
  admin_id INT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  email VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL
  );

CREATE TABLE Products (
    product_id INT Primary KEY,
    category VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    is_available BOOLEAN DEFAULT TRUE
);

CREATE TABLE Orders (
  order_id INT PRIMARY KEY,
  queue_number INT,
  date DATE NOT NULL,
  status ENUM('preparing', 'ready', 'completed') DEFAULT 'preparing',
  payment_method ENUM('cash', 'e-cash') NOT NULL,
  total DECIMAL(10,2)
);

CREATE TABLE OrderItems (
	order_item_id INT PRIMARY KEY,
	order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  subtotal DECIMAL(10,2)
);

-- Inserting values
INSERT INTO Admin
VALUES 	(1, 'alyssa.bascal', 'bacsal.alyssa@gmail.com', '12345678'),
		    (2, 'diane_nicole', 'diane99@gmail.com', '@admin123');

INSERT INTO Products
VALUES 	(1, 'Ulam', 'Dinuguan', 60, 1),
    		(2, 'Ulam', 'Adobo', 60, 1),
    		(3, 'Ulam', 'Kaldereta', 60, 1),
    		(4, 'Ulam', 'Sisig', 60, 1),
    		(5, 'Ulam', 'Sinigang', 60, 1),
    		(6, 'Ulam', 'Chopsuey', 60, 1),
    		(7, 'Ulam', 'Kare-kare', 60, 1),
    		(8, 'Ulam', 'Chicken', 60, 1),
    		(9, 'Add-ons', 'Rice', 20, 1),
    		(10, 'Add-ons', 'Leche Flan', 120, 1),
    		(11, 'Add-ons', 'Ice Cream', 45, 1),
    		(12, 'Add-ons', 'Saging', 20, 1),
    		(13, 'Silog', 'Tapsilog', 130, 1),
    		(14, 'Silog', 'Hatsilog', 100, 1),
    		(15, 'Silog', 'Tosilog', 120, 1),
    		(16, 'Silog', 'Bangsilog', 120, 1),
    		(17, 'Drinks', 'Coke (1.5L)', 85, 1),
    		(18, 'Drinks', 'Sprite (1.5L)', 85, 1),
    		(19, 'Drinks', 'Royal (1.5L)', 85, 1),
    		(20, 'Drinks', 'Yakult', 12, 1);

INSERT INTO Orders
VALUES	(1007910, 23089, '2026-05-10', 'completed', 'cash', 145),
    		(1007911, 23090, '2026-05-10', 'completed', 'e-cash', 235),
    		(1007912, 23091, '2026-05-11', 'completed', 'cash', 120),
    		(1007913, 23092, '2026-05-11', 'ready', 'cash', 145),
    		(1007914, 23093, '2026-05-11', 'preparing', 'e-cash', 260);

INSERT INTO OrderItems
VALUES	(678534, 1007910, 4, 1, 60, 60),
    		(678535, 1007910, 17, 1, 85, 85),
    
    		(678536, 1007911, 13, 1, 130, 130),
    		(678537, 1007911, 12, 1, 20, 20),
    		(678538, 1007911, 18, 1, 85, 85),
    
    		(678539, 1007912, 15, 1, 120, 120),
    
    		(678540, 1007913, 14, 1, 100, 100),
    		(678541, 1007913, 11, 1, 45, 45),
    
    		(678542, 1007914, 13, 2, 130, 260);

-- To view the most bought products 

CREATE VIEW vw_most_bought_products AS
SELECT
    p.product_id,
    p.name AS product_name,
    p.category,
    SUM(oi.quantity) AS total_sold,
    SUM(oi.subtotal) AS total_revenue
FROM OrderItems oi
JOIN Products p ON oi.product_id = p.product_id
JOIN Orders o   ON oi.order_id   = o.order_id
GROUP BY p.product_id, p.name, p.category
ORDER BY total_sold DESC
LIMIT 5;

SELECT * FROM vw_most_bought_products 

-- To view the total sales per day

CREATE VIEW vw_total_sales AS
SELECT
    date AS order_date,
    COUNT(order_id) AS total_orders,
    SUM(total) AS total_sales
FROM Orders
GROUP BY date
ORDER BY date DESC;

SELECT * FROM vw_total_sales;
