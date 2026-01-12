SQL E-Commerce Database Project

A fully structured SQL database that simulates the backend of a modern e-commerce platform. It includes users, products, categories, inventory, orders, order items, addresses, carts, and analytics queries. This project demonstrates relational database design, foreign key usage, indexing, seed data creation, and real-world SQL analytics.

🗂 Project Structure

ecommerce-sql/ – schema.sql (all table definitions) – seed.sql (sample data) – queries.sql (analytics queries)

🧱 Database Features

Users – Basic customer info with timestamps.
Products & Categories – Products linked to categories with pricing and active status.
Inventory – Tracks stock with auto-updating timestamps.
Orders & Order Items – Orders with statuses and per-item breakdowns.
Addresses – Multiple saved addresses per user.
Carts & Cart Items – Full shopping cart structure before checkout.

🧪 Seed Data

seed.sql inserts: users, products, categories, inventory, addresses, carts, and cart items.

📊 Analytics Queries

queries.sql includes: revenue per customer, total revenue, order breakdowns, top products, low stock alerts, products by category, cart totals, user addresses, and orders per day.

🚀 How to Run
	1.	Create database: CREATE DATABASE ecommerce_db; USE ecommerce_db;
	2.	Load schema: SOURCE schema.sql;
	3.	Load seed data: SOURCE seed.sql;
	4.	Run analytics: SOURCE queries.sql;

📌 Tech

MySQL, SQL modeling, TablePlus / MySQL CLI.
