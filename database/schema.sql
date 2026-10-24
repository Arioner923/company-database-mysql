-- Modernized MySQL 8.0 schema reconstructed from the original 2017 academic project.
-- The files under /original are preserved unchanged.

DROP DATABASE IF EXISTS company_db;
CREATE DATABASE company_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;
USE company_db;

CREATE TABLE branches (
    branch_id INT UNSIGNED PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    street VARCHAR(80) NOT NULL,
    street_number SMALLINT UNSIGNED NOT NULL,
    manager_employee_id VARCHAR(20) NULL
);

CREATE TABLE branch_phones (
    branch_id INT UNSIGNED NOT NULL,
    phone VARCHAR(20) NOT NULL,
    PRIMARY KEY (branch_id, phone),
    CONSTRAINT fk_branch_phones_branch
        FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    street VARCHAR(80) NOT NULL,
    street_number SMALLINT UNSIGNED NOT NULL
);

CREATE TABLE branch_customers (
    branch_id INT UNSIGNED NOT NULL,
    customer_id VARCHAR(20) NOT NULL,
    PRIMARY KEY (branch_id, customer_id),
    CONSTRAINT fk_branch_customers_branch
        FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_branch_customers_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE employees (
    employee_id VARCHAR(20) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    hire_date DATE NOT NULL,
    city VARCHAR(50) NOT NULL,
    street VARCHAR(80) NOT NULL,
    street_number SMALLINT UNSIGNED NOT NULL,
    branch_id INT UNSIGNED NOT NULL,
    role VARCHAR(40) NOT NULL,
    CONSTRAINT chk_employee_salary CHECK (salary >= 0),
    CONSTRAINT fk_employees_branch
        FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Circular relationship is added after employees exists.
ALTER TABLE branches
    ADD CONSTRAINT fk_branches_manager
    FOREIGN KEY (manager_employee_id) REFERENCES employees(employee_id)
    ON UPDATE CASCADE ON DELETE SET NULL;

CREATE TABLE technicians (
    employee_id VARCHAR(20) PRIMARY KEY,
    years_experience TINYINT UNSIGNED NOT NULL,
    professional_license_date DATE NOT NULL,
    CONSTRAINT fk_technicians_employee
        FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE accountants (
    employee_id VARCHAR(20) PRIMARY KEY,
    degree_date DATE NOT NULL,
    degree_title VARCHAR(100) NOT NULL,
    economic_chamber_level VARCHAR(50) NOT NULL,
    CONSTRAINT fk_accountants_employee
        FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE secretaries (
    employee_id VARCHAR(20) PRIMARY KEY,
    degree_date DATE NOT NULL,
    degree_title VARCHAR(100) NOT NULL,
    seminar_count SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    CONSTRAINT fk_secretaries_employee
        FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE dependents (
    employee_id VARCHAR(20) NOT NULL,
    dependent_name VARCHAR(50) NOT NULL,
    gender VARCHAR(20) NULL,
    age TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (employee_id, dependent_name),
    CONSTRAINT chk_dependent_age CHECK (age <= 120),
    CONSTRAINT fk_dependents_employee
        FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE orders (
    order_id INT UNSIGNED PRIMARY KEY,
    order_date DATE NOT NULL,
    shipping_address VARCHAR(150) NOT NULL,
    processed_date DATE NULL,
    total_cost DECIMAL(10,2) NOT NULL,
    employee_id VARCHAR(20) NOT NULL,
    customer_id VARCHAR(20) NOT NULL,
    CONSTRAINT chk_order_cost CHECK (total_cost >= 0),
    CONSTRAINT chk_order_dates CHECK (processed_date IS NULL OR processed_date >= order_date),
    CONSTRAINT fk_orders_employee
        FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE products (
    product_code VARCHAR(20) PRIMARY KEY,
    price DECIMAL(10,2) NOT NULL,
    warranty_years TINYINT UNSIGNED NOT NULL DEFAULT 0,
    manufacturer VARCHAR(60) NOT NULL,
    category VARCHAR(60) NOT NULL,
    CONSTRAINT chk_product_price CHECK (price >= 0)
);

CREATE TABLE order_items (
    order_id INT UNSIGNED NOT NULL,
    product_code VARCHAR(20) NOT NULL,
    quantity SMALLINT UNSIGNED NOT NULL DEFAULT 1,
    PRIMARY KEY (order_id, product_code),
    CONSTRAINT chk_order_item_quantity CHECK (quantity > 0),
    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_order_items_product
        FOREIGN KEY (product_code) REFERENCES products(product_code)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE suppliers (
    supplier_tax_id VARCHAR(15) PRIMARY KEY,
    name VARCHAR(80) NOT NULL,
    city VARCHAR(50) NOT NULL,
    street VARCHAR(80) NOT NULL,
    street_number SMALLINT UNSIGNED NOT NULL
);

CREATE TABLE supplier_phones (
    supplier_tax_id VARCHAR(15) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    PRIMARY KEY (supplier_tax_id, phone),
    CONSTRAINT fk_supplier_phones_supplier
        FOREIGN KEY (supplier_tax_id) REFERENCES suppliers(supplier_tax_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE product_suppliers (
    product_code VARCHAR(20) NOT NULL,
    supplier_tax_id VARCHAR(15) NOT NULL,
    supplier_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (product_code, supplier_tax_id),
    CONSTRAINT chk_supplier_price CHECK (supplier_price >= 0),
    CONSTRAINT fk_product_suppliers_product
        FOREIGN KEY (product_code) REFERENCES products(product_code)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_product_suppliers_supplier
        FOREIGN KEY (supplier_tax_id) REFERENCES suppliers(supplier_tax_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX idx_employees_branch ON employees(branch_id);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_employee ON orders(employee_id);
CREATE INDEX idx_orders_order_date ON orders(order_date);
CREATE INDEX idx_products_category ON products(category);
