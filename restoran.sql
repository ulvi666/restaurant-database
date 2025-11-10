-- 1) Menyu cədvəli
CREATE TABLE menu (
    menu_id SERIAL PRIMARY KEY,
    NAME VARCHAR(100) NOT NULL,
    price NUMERIC(8,2) NOT NULL
);

-- 2) Sifarişlər cədvəli
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    order_date DATE DEFAULT CURRENT_DATE
);

-- 3) Sifariş detallar cədvəli
CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
    menu_id INT REFERENCES menu(menu_id),
    quantity INT NOT NULL CHECK (quantity > 0)
);
-- Menyu
INSERT INTO menu (NAME, price) VALUES
('Pizza Margherita', 8.50),
('Burger', 6.00),
('Salad', 4.50),
('Tea', 1.50),
('Coffee', 2.00);

-- Sifarişlər
INSERT INTO orders (customer_name) VALUES
('Eldar'),
('Samir'),
('Gunel'),
('Nigar'),
('Mehman'),
('Yusif'),
('Elgun'),
('Kerim'),
('Firuze'),
('Leman'),
('Yusif'),
('Aysel');

-- Sifariw detallari
INSERT INTO order_items (order_id, menu_id, quantity) VALUES
(1, 1, 2),  -- Eldar 2 pizza
(1, 5, 1),  -- Eldar 1 coffee
(2, 2, 1),  -- Aysel 1 burger
(2, 4, 2);  -- Aysel 2 tea



--Hər sifarişdə hansı məhsullar var:
SELECT o.order_id, o.customer_name, m.name AS menu_item, oi.quantity
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN menu m ON m.menu_id = oi.menu_id
ORDER BY o.order_id;



--her defe sifariw olduqda orders cedvelinde muwderilerin umumi xerclediyi pul miqdarini yeni yaratdigim setirde eks etdirsin

ALTER TABLE orders ADD COLUMN total_amount NUMERIC(10,2) DEFAULT 0; -- yeni setir yaradiram

CREATE OR REPLACE FUNCTION update_order_total()
RETURNS TRIGGER AS $$
BEGIN
    -- Her sifariwin cemi yenidən hesablanir
    UPDATE orders
    SET total_amount = COALESCE((
        SELECT SUM(oi.quantity * m.price)
        FROM order_items oi
        JOIN menu m ON m.menu_id = oi.menu_id
        WHERE oi.order_id = NEW.order_id
    ), 0)
    WHERE order_id = NEW.order_id;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--indi ise triggerin ozunu yaradiriq
CREATE TRIGGER trg_update_order_total
AFTER INSERT OR UPDATE OR DELETE
ON order_items
FOR EACH ROW
EXECUTE FUNCTION update_order_total();


INSERT INTO order_items (order_id, menu_id, quantity)
VALUES (14,5,1); -- order_id-ye uygun mehsulun id-si ve sayini daxil etdikde triggerimiz avtomatik olara total_amountu hesablayir








