-- Basic queries corresponding to the style of the original 2017 submission.
USE company_db;

SELECT * FROM branches;
SELECT * FROM branch_phones;
SELECT * FROM customers;
SELECT * FROM branch_customers;
SELECT * FROM employees;
SELECT * FROM technicians;
SELECT * FROM accountants;
SELECT * FROM secretaries;
SELECT * FROM dependents;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM order_items;
SELECT * FROM suppliers;
SELECT * FROM supplier_phones;
SELECT * FROM product_suppliers;

-- Demonstration of the original UPDATE/DELETE ideas without permanently changing sample data.
START TRANSACTION;

UPDATE employees
SET salary = salary * 1.10
WHERE hire_date < '1997-12-31';

SELECT employee_id, first_name, last_name, salary
FROM employees
ORDER BY employee_id;

DELETE FROM orders
WHERE processed_date < '2015-12-31';

SELECT * FROM orders ORDER BY order_id;

ROLLBACK;
