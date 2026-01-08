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