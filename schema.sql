CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  full_name VARCHAR(100) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  sku VARCHAR(50) NOT NULL UNIQUE,				 -- product id
  name VARCHAR(200) NOT NULL,
  price_cents INT NOT NULL,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,     	-- remove without deleting
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CHECK (price_cents >= 0)
);
-- Inventory: current stock for each product
CREATE TABLE inventory (
  product_id INT PRIMARY KEY,                      -- also a FK to products.id
  stock INT NOT NULL,                              -- how many units available
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP,
  CHECK (stock >= 0),
  FOREIGN KEY (product_id) REFERENCES products(id)
    ON DELETE CASCADE
);
-- Orders placed by users
CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,   -- internal order ID
  user_id INT NOT NULL,                -- who placed the order
  status ENUM('PENDING','PAID','CANCELLED','REFUNDED')
         NOT NULL DEFAULT 'PENDING',
  total_cents INT NOT NULL DEFAULT 0,  -- total order value (cached)
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CHECK (total_cents >= 0),
  FOREIGN KEY (user_id) REFERENCES users(id)
);
-- Items inside an order (one row per product per order)
CREATE TABLE order_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  price_cents_at_purchase INT NOT NULL,  -- snapshot price at time of purchase

  CHECK (quantity > 0),
  CHECK (price_cents_at_purchase >= 0),

  UNIQUE (order_id, product_id),         -- prevents duplicate product rows in same order

  FOREIGN KEY (order_id) REFERENCES orders(id)
    ON DELETE CASCADE,

  FOREIGN KEY (product_id) REFERENCES products(id)
);

