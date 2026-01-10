-- 1) List all orders with customer info
SELECT
  o.id AS order_id,
  u.full_name AS customer,
  o.status,
  o.total_cents,
  o.created_at
FROM orders o
JOIN users u ON o.user_id = u.id
ORDER BY o.created_at DESC;

-- 2) Total revenue (only PAID orders)
SELECT
  SUM(o.total_cents) AS total_revenue_cents
FROM orders o
WHERE o.status = 'PAID';

-- 3) Revenue per customer (paid orders only)
SELECT
  u.full_name,
  u.email,
  SUM(o.total_cents) AS revenue_cents
FROM orders o
JOIN users u ON o.user_id = u.id
WHERE o.status = 'PAID'
GROUP BY u.id, u.full_name, u.email
ORDER BY revenue_cents DESC;

-- 4) Top products by revenue
SELECT
  p.name,
  p.sku,
  SUM(oi.quantity * oi.price_cents_at_purchase) AS product_revenue_cents
FROM order_items oi
JOIN orders o   ON oi.order_id = o.id
JOIN products p ON oi.product_id = p.id
WHERE o.status = 'PAID'
GROUP BY p.id, p.name, p.sku
ORDER BY product_revenue_cents DESC;

-- 5) Low-stock alert (threshold = 50 units)
SELECT
  p.name,
  p.sku,
  i.stock
FROM inventory i
JOIN products p ON i.product_id = p.id
WHERE i.stock < 50
ORDER BY i.stock ASC;

-- 6) Order details: products inside each order
SELECT
  o.id AS order_id,
  u.full_name AS customer,
  p.name AS product_name,
  oi.quantity,
  oi.price_cents_at_purchase
FROM order_items oi
JOIN orders o   ON oi.order_id = o.id
JOIN products p ON oi.product_id = p.id
JOIN users u    ON o.user_id = u.id
ORDER BY o.id, p.name;

-- 7) Total number of orders per user
SELECT
  u.full_name,
  COUNT(o.id) AS num_orders
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.full_name
ORDER BY num_orders DESC;

-- 8) Average order value (paid orders)
SELECT
  AVG(total_cents) AS avg_order_value_cents
FROM orders
WHERE status = 'PAID';

-- 9) Orders per day (simple analytics)
SELECT
  DATE(created_at) AS order_date,
  COUNT(*) AS num_orders
FROM orders
GROUP BY DATE(created_at)
ORDER BY order_date DESC;
-----
-- Products with category names
SELECT p.id, p.name, p.sku, c.name AS category
FROM products p
LEFT JOIN categories c ON p.category_id = c.id
ORDER BY p.id;

-- Count of products per category
SELECT c.name AS category, COUNT(*) AS num_products
FROM products p
JOIN categories c ON p.category_id = c.id
GROUP BY c.id
ORDER BY num_products DESC;

-- Full address list for each user
SELECT u.full_name, u.email, a.address_line1, a.city, a.country
FROM addresses a
JOIN users u ON a.user_id = u.id
ORDER BY u.id;

-- Cart contents with product names
SELECT c.user_id, ci.cart_id, p.name AS product, ci.quantity
FROM cart_items ci
JOIN carts c ON ci.cart_id = c.id
JOIN products p ON ci.product_id = p.id
ORDER BY ci.cart_id;

-- Cart total cost
SELECT
  ci.cart_id,
  SUM(ci.quantity * p.price_cents) AS cart_total_cents
FROM cart_items ci
JOIN products p ON ci.product_id = p.id
GROUP BY ci.cart_id;