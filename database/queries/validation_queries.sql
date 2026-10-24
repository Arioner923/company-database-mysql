-- Lightweight validation queries for the modernized schema.
USE company_db;

SELECT 'branches' AS table_name, COUNT(*) AS row_count FROM branches
UNION ALL SELECT 'customers', COUNT(*) FROM customers
UNION ALL SELECT 'employees', COUNT(*) FROM employees
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'suppliers', COUNT(*) FROM suppliers
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL SELECT 'product_suppliers', COUNT(*) FROM product_suppliers;

-- Foreign-key orphan checks should all return zero rows.
SELECT oi.*
FROM order_items oi
LEFT JOIN orders o ON o.order_id = oi.order_id
LEFT JOIN products p ON p.product_code = oi.product_code
WHERE o.order_id IS NULL OR p.product_code IS NULL;

SELECT ps.*
FROM product_suppliers ps
LEFT JOIN products p ON p.product_code = ps.product_code
LEFT JOIN suppliers s ON s.supplier_tax_id = ps.supplier_tax_id
WHERE p.product_code IS NULL OR s.supplier_tax_id IS NULL;
