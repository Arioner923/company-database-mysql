-- Additional portfolio queries added in the modernized GitHub version.
-- These were NOT part of the preserved original submission.
USE company_db;

-- 1. Orders with customer and employee information.
SELECT
    o.order_id,
    o.order_date,
    CONCAT(c.first_name, ' ', c.last_name) AS customer,
    CONCAT(e.first_name, ' ', e.last_name) AS handled_by,
    o.total_cost
FROM orders AS o
JOIN customers AS c ON c.customer_id = o.customer_id
JOIN employees AS e ON e.employee_id = o.employee_id
ORDER BY o.order_date DESC;

-- 2. Products contained in each order.
SELECT
    oi.order_id,
    p.product_code,
    p.manufacturer,
    p.category,
    oi.quantity
FROM order_items AS oi
JOIN products AS p ON p.product_code = oi.product_code
ORDER BY oi.order_id, p.product_code;

-- 3. Number of orders and total recorded order value per customer.
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer,
    COUNT(o.order_id) AS order_count,
    COALESCE(SUM(o.total_cost), 0) AS total_order_value
FROM customers AS c
LEFT JOIN orders AS o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_order_value DESC;

-- 4. Customers with more than one order (GROUP BY + HAVING).
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer,
    COUNT(*) AS order_count
FROM customers AS c
JOIN orders AS o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(*) > 1;

-- 5. Average product price by category.
SELECT
    category,
    COUNT(*) AS product_count,
    ROUND(AVG(price), 2) AS average_price
FROM products
GROUP BY category
ORDER BY average_price DESC;

-- 6. Employees earning above the company average (subquery).
SELECT
    employee_id,
    first_name,
    last_name,
    salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;

-- 7. Supplier options and margin between retail and supplier price.
SELECT
    p.product_code,
    p.manufacturer,
    p.category,
    s.name AS supplier,
    ps.supplier_price,
    p.price AS retail_price,
    ROUND(p.price - ps.supplier_price, 2) AS price_difference
FROM product_suppliers AS ps
JOIN products AS p ON p.product_code = ps.product_code
JOIN suppliers AS s ON s.supplier_tax_id = ps.supplier_tax_id
ORDER BY price_difference DESC;

-- 8. Branch/customer collaborations.
SELECT
    b.branch_id,
    b.name AS branch,
    CONCAT(c.first_name, ' ', c.last_name) AS customer
FROM branch_customers AS bc
JOIN branches AS b ON b.branch_id = bc.branch_id
JOIN customers AS c ON c.customer_id = bc.customer_id
ORDER BY b.branch_id, customer;

-- 9. Employees by branch, including the branch manager reference.
SELECT
    b.branch_id,
    b.name AS branch,
    CONCAT(e.first_name, ' ', e.last_name) AS employee,
    e.role,
    e.salary,
    CASE WHEN e.employee_id = b.manager_employee_id THEN 'Yes' ELSE 'No' END AS is_manager
FROM branches AS b
JOIN employees AS e ON e.branch_id = b.branch_id
ORDER BY b.branch_id, e.last_name;

-- 10. Products supplied below the average supplier price.
SELECT
    p.product_code,
    p.manufacturer,
    s.name AS supplier,
    ps.supplier_price
FROM product_suppliers AS ps
JOIN products AS p ON p.product_code = ps.product_code
JOIN suppliers AS s ON s.supplier_tax_id = ps.supplier_tax_id
WHERE ps.supplier_price < (SELECT AVG(supplier_price) FROM product_suppliers)
ORDER BY ps.supplier_price;
