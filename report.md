# Project Report

## 1. Background

This repository modernizes a relational database project originally completed in 2017. The preserved material consists of an ER diagram, a relational model and a MySQL SQL script. The original assignment statement is no longer available, so the domain description is reconstructed from those artifacts.

The original artifacts remain unchanged in `original/`. The files in `database/` and `docs/` form the cleaned GitHub/portfolio version.

## 2. Reconstructed objective

The likely objective was to design and implement a relational database for a company operating multiple branches. The system stores information about branches, employees, employee specializations, customers, orders, products and suppliers, together with the relationships among them.

## 3. Original conceptual design

The preserved ER model includes:

- strong entities such as branches, customers, employees, orders, products and suppliers;
- composite address attributes;
- multivalued phone attributes;
- M:N relationships;
- an M:N relationship with its own attribute (supplier price);
- a weak/dependent entity for protected/dependent members;
- an ISA/specialization hierarchy for employee types.

These features show that the project was intended to exercise more than basic table creation.

## 4. Original relational implementation

The original SQL creates 15 tables and populates them with sample data. It uses primary keys and foreign keys, and it maps several M:N relationships to junction tables.

The script also includes basic reads plus `UPDATE` and `DELETE` operations.

### Original tables

- `Ypokatasthmata`
- `ThlefwnaYpok`
- `Pelates`
- `Sinergazetai`
- `Ypalliloi_eterias`
- `Texnikoi`
- `Logistes`
- `Grammatis`
- `Prost_melh`
- `Paragelia`
- `Prointa`
- `Prointa_Paragelias`
- `Promitheftes`
- `Thl_prom`
- `Exei`

## 5. Issues found in the preserved SQL

The original script is kept unchanged, including its defects. Important issues include:

1. Two `Prointa_Paragelias` inserts contain multiple product codes without separators and are syntactically invalid.
2. `Prointa_Paragelias` does not define a primary key.
3. One supplier phone row references supplier `3453265`, while the inserted supplier is `3453267`.
4. Phone numbers are stored as numeric `INT` values, although they are identifiers and can exceed signed integer ranges or contain formatting/leading zeroes.
5. Monetary fields use `FLOAT`; fixed-point `DECIMAL` is safer for money.
6. `Exei` includes `timh_prom` in the primary key even though supplier price is better treated as an attribute of the product-supplier pair.
7. `Logistes` and `Grammatis` include degree fields in their composite primary keys even though the employee identifier is sufficient to identify the subtype row in the intended 1:1 subtype mapping.
8. `Prost_melh` includes age in its primary key even though age is mutable.
9. The branch manager field exists but was not declared as a foreign key.
10. Customer-branch association is represented both by `Pelates.arithmos_ypok` and the `Sinergazetai` junction table. Without the original assignment, it is not possible to prove whether these represent two distinct business concepts or a redundant mapping.

## 6. Modernization decisions

The modernized schema intentionally keeps the original domain while improving relational implementation.

### Data types

- Monetary values use `DECIMAL(10,2)`.
- Phone numbers use `VARCHAR(20)`.
- Supplier tax identifiers use `VARCHAR(15)`.
- Small non-negative counters use unsigned integer types.

### Keys and relationships

- M:N relationships have explicit junction-table composite primary keys.
- Employee subtype tables use `employee_id` as both PK and FK.
- Product-supplier price is a non-key relationship attribute.
- Branch manager is constrained as an employee reference.
- Foreign-key actions are declared explicitly.

### Customer/branch relation

The modernized version uses the explicit `Sinergazetai` M:N relation as `branch_customers` and does not duplicate a branch foreign key in the customer table. This is a reconstruction decision based on the preserved ER material, not a claim about the missing original assignment.

### Order-product reconstruction

The malformed original rows appear intended to associate multiple product codes with orders `6754` and `2345`. The modernized sample data therefore expands them into individual `order_items` rows. This inference is documented explicitly.

### Supplier-phone correction

The original phone insert for supplier `3453265` would violate referential integrity because that supplier does not exist; `3453267` does. The modernized data uses `3453267` and marks the correction in a comment.

## 7. Additional portfolio SQL

Advanced queries were added to demonstrate presentational breadth beyond the preserved 2017 script. They include:

- multi-table joins;
- left joins;
- aggregate functions;
- `GROUP BY` and `HAVING`;
- subqueries;
- supplier-price analysis;
- employee/branch reporting.

These queries are explicitly labeled as additions and should not be interpreted as part of the original submission.

## 8. Reproducibility and verification

No original screenshot/result files were preserved because the queries were viewed interactively in the MySQL terminal. The modernized project was rerun successfully against MySQL 8.0 using the reconstructed schema and sample data.

Verification covered:

- successful schema creation;
- successful sample-data loading;
- expected row counts (`5, 5, 5, 5, 5, 5, 8, 5` across the principal validation tables);
- zero orphan rows in the tested M:N junction tables;
- successful execution of all basic queries;
- successful execution of the additional JOIN, aggregate, `GROUP BY`, `HAVING` and subquery examples;
- successful `ROLLBACK` of the demonstration `UPDATE` and `DELETE` transaction.

Screenshots are intentionally omitted because the SQL scripts and reproducible sample data are sufficient to verify the project directly.

## 9. Portfolio value

The preserved work demonstrates practical understanding of the ER-to-relational workflow, junction tables, keys, foreign keys, specialization, multivalued attributes and sample-data manipulation. The modernized version focuses on clarity, reproducibility, data integrity and broader SQL query coverage while retaining transparent provenance.
