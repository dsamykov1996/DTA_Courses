-- items table
CREATE TABLE products(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  category TEXT NOT NULL,
  price NUMERIC(10,2) CHECK (price >= 0)
);

-- client table
CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT UNIQUE,
  city TEXT 
)

-- orders table
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_id INTEGER 
  REFERENCES customers(id) ON DELETE CASCADE,
  order_date DATE NOT NULL DEFAULT CURRENT_DATE
);

-- items of order table
CREATE TABLE order_item (
  order_id INTEGER
  REFERENCES orders(id) ON DELETE CASCADE,
  product_id INTEGER
  REFERENCES products(id) ON DELETE CASCADE,
  quantity INTEGER CHECK (quantity > 0),
  PRIMARY KEY (order_id, product_id)
);

-- Adding items
INSERT INTO products (name, category, price) 
VALUES() 

-- CRUD операції для таблиці products
-- CREATE: додати новий товар
INSERT INTO products (name, category, price) VALUES ('USB-C Cable', 'Electronics', 12.99);
-- READ: вибрати всі товари
SELECT * FROM products;
-- UPDATE: змінити ціну товару
UPDATE products SET price = 11.99 WHERE name = 'USB-C Cable';
-- DELETE: видалити товар
DELETE FROM products WHERE name = 'USB-C Cable';


-- Quantity of orders of all customers
SELECT c.name, COUNT(o.id) AS orders_count
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.identity
GROUP BY c.id, c.name 
ORDER BY orders_count DESC;

-- Summary of each order
SELECT 
  o.id AS order_id,
  SUM(oi.quantity * p.price) AS order_total
FROM orders o
JOIN order_item oi ON oi.order_id = o.id
JOIN products1 p ON p.id = oi.product_id
GROUP BY o.id
ORDER BY order_total DESC;

-- Top 3 most expensive items
SELECT name, price
FROM products
ORDER BY price DESC
LIMIT 3;

---------------------
-- Top 3 most expensive items
-- SELECT category, name, price
-- FROM (
--   SELECT category, name, price,
--   ROW_NUMBER() OVER 
--   (PARTITION BY category ORDER BY price DESC) 
--   AS rank_in_category
--   FROM products
-- ) ranked
-- WHERE rank_in_category <= 3
-- ORDER BY category, price DESC;

-- Transaction

BEGIN;
INSERT INTO orders (customer_id) VALUES (2); -- Taras
INSERT INTO order_item (order_id, product_id, quantity)
VALUES
(4, 2, 3),
(4, 5, 2),
(4, 4, 1);
COMMIT;

-- View that shows quantity of orders and customers spents

