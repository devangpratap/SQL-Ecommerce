USE ecommerce_db;

-- USERS
INSERT INTO users (email, full_name) VALUES
  ('alice@example.com',   'Alice Kumar'),
  ('bob@example.com',     'Bob Singh'),
  ('charlie@example.com', 'Charlie Patel');

-- PRODUCTS
INSERT INTO products (sku, name, price_cents) VALUES
  ('SKU001', 'Mechanical Keyboard',          7500),
  ('SKU002', 'Wireless Mouse',               2500),
  ('SKU003', 'USB-C Cable',                   900),
  ('SKU004', 'Laptop Stand',                 3200),
  ('SKU005', 'Noise Cancelling Headphones', 15900);

-- INVENTORY (product_id must match the IDs above: 1..5)
INSERT INTO inventory (product_id, stock) VALUES
  (1, 50),
  (2, 150),
  (3, 300),
  (4, 80),
  (5, 40);

-- ORDERS (user_id must match users: 1..3)
INSERT INTO orders (user_id, status, total_cents) VALUES
  (1, 'PAID',     10000),  -- Alice: keyboard + mouse
  (2, 'PAID',     15900),  -- Bob: headphones
  (1, 'PENDING',   2500);  -- Alice: pending mouse

-- ORDER ITEMS (order_id, product_id)
INSERT INTO order_items (order_id, product_id, quantity, price_cents_at_purchase) VALUES
  (1, 1, 1, 7500),   -- order 1: 1x keyboard
  (1, 2, 1, 2500),   -- order 1: 1x mouse
  (2, 5, 1, 15900),  -- order 2: 1x headphones
  (3, 2, 1, 2500);   -- order 3: 1x mouse

  -----

  -- Category seed data
  INSERT INTO categories (name) VALUES
  ('Electronics'),
  ('Clothing'),
  ('Home & Kitchen'),
  ('Beauty'),
  ('Sports');

  -- Assign categories to existing products
  UPDATE products SET category_id = 1 WHERE id % 5 = 1;
  UPDATE products SET category_id = 2 WHERE id % 5 = 2;
  UPDATE products SET category_id = 3 WHERE id % 5 = 3;
  UPDATE products SET category_id = 4 WHERE id % 5 = 4;
  UPDATE products SET category_id = 5 WHERE id % 5 = 0;

  -- Sample user addresses
  INSERT INTO addresses (user_id, address_line1, city, state, country, postal_code)
  VALUES
  (1, '123 Ocean Drive', 'Miami', 'FL', 'USA', '33101'),
  (2, '55 Palm Street', 'Orlando', 'FL', 'USA', '32801'),
  (3, '22 River Rd', 'Tampa', 'FL', 'USA', '33601');

  -- Carts for three users
  INSERT INTO carts (user_id) VALUES (1), (2), (3);

  -- Items inside the carts
  INSERT INTO cart_items (cart_id, product_id, quantity)
  VALUES
  (1, 1, 2),
  (1, 3, 1),
  (2, 2, 1),
  (3, 4, 5);