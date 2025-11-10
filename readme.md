🍽️ Simple Restaurant Database (PostgreSQL)
📖 Description

A simple PostgreSQL database project for a small restaurant.
It contains 3 main tables and a trigger that automatically calculates order totals.

🧱 Database Structure

Tables:

menu – stores available dishes and their prices

orders – stores customer orders and total amount

order_items – stores items included in each order

Relationships:

Each order can include multiple menu items

Each menu item can appear in multiple orders

When an order is deleted, its items are deleted automatically (ON DELETE CASCADE)

⚙️ Trigger

A trigger function update_order_total() automatically updates the total amount in the orders table whenever order details change (insert, update, or delete in order_items).

🧩 Example Data
INSERT INTO menu (name, price) VALUES
('Pizza Margherita', 8.50),
('Burger', 6.00),
('Salad', 4.50),
('Tea', 1.50),
('Coffee', 2.00);

INSERT INTO orders (customer_name) VALUES
('Eldar'),
('Aysel');

INSERT INTO order_items (order_id, menu_id, quantity) VALUES
(1, 1, 2),
(1, 5, 1),
(2, 2, 1),
(2, 4, 2);

🔍 Example Queries

1. View all orders with their items:

SELECT o.order_id, o.customer_name, m.name AS menu_item, oi.quantity
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN menu m ON m.menu_id = oi.menu_id
ORDER BY o.order_id;


2. Total sales and income by product:

SELECT m.name, SUM(oi.quantity) AS total_sold, SUM(oi.quantity * m.price) AS total_income
FROM order_items oi
JOIN menu m ON m.menu_id = oi.menu_id
GROUP BY m.name
ORDER BY total_income DESC;

💡 How to Use

Create a new PostgreSQL database (e.g. restaurant_db).

Run the SQL script in your SQL client or pgAdmin.

Try inserting or deleting order items — the trigger will automatically recalculate totals.

📦 Technologies

PostgreSQL

PL/pgSQL (for trigger logic)

👨‍💻 Author

Created by Ulvi Osmanov as a simple database project for portfolio purposes.



--------------------------------------------------------------




🍽️ Простая база данных ресторана (PostgreSQL)
📖 Описание

Простая учебная база данных для ресторана, созданная на PostgreSQL.
Проект содержит 3 основные таблицы и триггер, который автоматически пересчитывает общую сумму заказа при изменении данных.

🧱 Структура базы данных

Таблицы:

menu — список блюд и их цены

orders — заказы клиентов и их общая сумма

order_items — детали заказов (какие блюда и в каком количестве)

Связи:

Один заказ может содержать несколько позиций меню

Одно блюдо может входить в несколько заказов

При удалении заказа связанные позиции автоматически удаляются (ON DELETE CASCADE)

⚙️ Триггер

Функция-триггер update_order_total() автоматически обновляет поле total_amount в таблице orders после добавления, изменения или удаления записей в order_items.

🧩 Пример данных
INSERT INTO menu (name, price) VALUES
('Pizza Margherita', 8.50),
('Burger', 6.00),
('Salad', 4.50),
('Tea', 1.50),
('Coffee', 2.00);

INSERT INTO orders (customer_name) VALUES
('Эльдар'),
('Айсель');

INSERT INTO order_items (order_id, menu_id, quantity) VALUES
(1, 1, 2),
(1, 5, 1),
(2, 2, 1),
(2, 4, 2);

🔍 Примеры запросов

1. Посмотреть все заказы с позициями меню:

SELECT o.order_id, o.customer_name, m.name AS menu_item, oi.quantity
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN menu m ON m.menu_id = oi.menu_id
ORDER BY o.order_id;


2. Общие продажи и выручка по каждому блюду:

SELECT m.name, SUM(oi.quantity) AS total_sold, SUM(oi.quantity * m.price) AS total_income
FROM order_items oi
JOIN menu m ON m.menu_id = oi.menu_id
GROUP BY m.name
ORDER BY total_income DESC;

💡 Как использовать

Создайте новую базу данных PostgreSQL (например, restaurant_db).

Выполните SQL-скрипт в pgAdmin или любом другом клиенте.

Попробуйте добавить или удалить позиции заказа — триггер автоматически пересчитает итоговую сумму.

📦 Технологии

PostgreSQL

PL/pgSQL (для логики триггера)

👨‍💻 Автор

Проект создан Ульви Османов как учебный пример для портфолио.