# Company Database — MySQL Academic Project (2017, Modernized)

A reconstructed and modernized version of an academic relational-database project originally completed in 2017.

The original assignment statement is no longer available. The project description below was reconstructed from the preserved ER model, relational model and SQL implementation. The original files are kept unchanged under [`original/`](original/).

## Project scope

The database models a company with multiple branches, employees, customers, orders, products and suppliers. It also includes employee specializations, multivalued phone attributes, M:N relationships and relationship attributes.

The original work followed the typical database-design flow:

**ER model → relational model → MySQL schema → sample data → basic SQL operations**

## Repository structure

```text
.
├── database/
│   ├── schema.sql
│   ├── sample_data.sql
│   └── queries/
│       ├── basic_queries.sql
│       ├── advanced_queries.sql
│       └── validation_queries.sql
├── docs/
│   ├── er_diagram.md
│   ├── relational_model.md
│   ├── reconstructed_project_description.md
│   └── assets/
├── original/
│   └── original 2017 files, preserved unchanged
├── report.md
└── README.md
```

## Original vs modernized version

### Original 2017 submission

The original material contains:

- ER model
- relational model
- one MySQL SQL script
- sample records
- basic `SELECT`, `UPDATE` and `DELETE` operations

It is preserved for historical/reference purposes and is **not edited**.

### Modernized GitHub version

The modernized version:

- uses consistent English table/column names;
- uses `DECIMAL` for monetary values instead of floating-point types;
- stores phone numbers and tax identifiers as strings;
- adds explicit constraints and indexes;
- gives junction tables appropriate composite primary keys;
- separates schema, data and queries;
- reconstructs malformed order-product inserts as individual rows;
- corrects one supplier-phone foreign-key typo from the original data;
- includes additional JOIN, aggregation, `GROUP BY`, `HAVING` and subquery examples for portfolio demonstration.

These improvements are documented in [`report.md`](report.md) and are not presented as part of the original 2017 submission.

## Requirements

- MySQL 8.0+
- A MySQL client such as MySQL Workbench, MySQL Shell, or VS Code with SQLTools + the MySQL/MariaDB driver

No application dependencies are required.

## Run the modernized project

From the MySQL client:

```sql
SOURCE database/schema.sql;
SOURCE database/sample_data.sql;
SOURCE database/queries/validation_queries.sql;
SOURCE database/queries/basic_queries.sql;
SOURCE database/queries/advanced_queries.sql;
```

Alternatively, execute the files in the same order using MySQL Workbench.


## Verification

The modernized version was rerun successfully against MySQL 8.0. The schema, sample data, validation checks, basic queries and advanced queries all executed successfully.

Verified sample row counts:

| Table | Rows |
|---|---:|
| `branches` | 5 |
| `customers` | 5 |
| `employees` | 5 |
| `orders` | 5 |
| `products` | 5 |
| `suppliers` | 5 |
| `order_items` | 8 |
| `product_suppliers` | 5 |

The foreign-key orphan checks returned no rows. The transaction example in `basic_queries.sql` was also verified to restore the original sample data after `ROLLBACK`.

## Data model highlights

- **1:N relationships:** branch → employees, customer → orders, employee → orders
- **M:N relationships:** branches ↔ customers, orders ↔ products, products ↔ suppliers
- **Specialization:** employees → technicians / accountants / secretaries
- **Multivalued attributes:** branch phones and supplier phones
- **Relationship attribute:** supplier price belongs to the product-supplier relationship

## ER diagram

See [`docs/er_diagram.md`](docs/er_diagram.md) for the clean GitHub-rendered model and [`docs/assets/original_er_diagram.png`](docs/assets/original_er_diagram.png) for the preserved project diagram.

## Query coverage

The original project demonstrated basic SQL operations. The modernized version additionally demonstrates:

- `INNER JOIN` / `LEFT JOIN`
- aggregate functions (`COUNT`, `SUM`, `AVG`)
- `GROUP BY`
- `HAVING`
- scalar subqueries
- multi-table reporting queries

## Academic provenance

This repository is a portfolio-oriented reconstruction of a 2017 academic project. The original assignment text is unavailable, so the project description is explicitly marked as reconstructed. No attempt is made to present newly added SQL queries or schema improvements as part of the original submission.
