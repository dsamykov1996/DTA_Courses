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