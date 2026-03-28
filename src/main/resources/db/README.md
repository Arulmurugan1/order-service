# Order Service Database Scripts

This directory contains all SQL scripts for the Order Service application.

## Files Overview

### 1. **schema.sql**
Contains the database and table creation scripts.
- Creates `order_service_db` database
- Creates `orders` table with all necessary columns
- Defines indexes for performance optimization
- **Purpose**: Run this FIRST to set up the initial database schema

**Table Structure:**
| Column | Type | Description |
|--------|------|-------------|
| id | BIGINT (PK) | Auto-increment primary key |
| order_number | VARCHAR(50) UNIQUE | Unique order identifier |
| customer_name | VARCHAR(100) | Customer name |
| status | VARCHAR(50) | Order status (PENDING, PROCESSING, COMPLETED, CANCELLED) |
| total_amount | DECIMAL(10, 2) | Total order amount |
| created_at | TIMESTAMP | Creation timestamp |
| updated_at | TIMESTAMP | Last update timestamp |

---

### 2. **data.sql**
Contains sample data for testing and development.
- Inserts 8 sample orders with various statuses
- Creates realistic test scenarios
- **Purpose**: Run after schema.sql to populate test data

**Sample Data Includes:**
- Orders in different statuses (COMPLETED, PROCESSING, PENDING, CANCELLED)
- Various order amounts and dates
- Multiple customer names

**How to Insert:**
```sql
source /path/to/data.sql;
```

---

### 3. **stored-procedures.sql**
Contains useful stored procedures and functions.

**Procedures:**
- `sp_get_order_by_id` - Retrieve order by ID
- `sp_get_orders_by_status` - Get all orders with specific status
- `sp_get_orders_by_customer` - Search orders by customer name
- `sp_create_order` - Create new order
- `sp_update_order_status` - Update order status
- `sp_get_customer_total_sales` - Get customer sales summary
- `sp_get_orders_by_date_range` - Get orders within date range

**Functions:**
- `fn_get_status_description` - Get human-readable status description

**Usage Example:**
```sql
CALL sp_get_order_by_id(1);
CALL sp_get_orders_by_status('COMPLETED');
CALL sp_create_order('ORD-2026-009', 'New Customer', 'PENDING', 1500.00, @order_id);
```

---

### 4. **queries.sql**
Contains 15 commonly used SELECT queries for reporting and analysis.

**Query Categories:**
- Basic order retrieval
- Pagination queries
- Aggregation and reporting
- Status analysis
- Customer insights
- Date range queries
- Top customers
- Revenue calculations

---

### 5. **migrations.sql**
Contains database migration scripts for version upgrades.

**Current Version**: 1.0.1

**Migration History:**
- **v1.0.0**: Initial schema with orders table
- **v1.0.1**: Added payment_status and shipping_address columns

**Rollback Instructions**: Provided in the script

---

## Setup Instructions

### Step 1: Create Database Schema
```bash
mysql -u root -p < schema.sql
```

### Step 2: Insert Sample Data (Optional)
```bash
mysql -u root -p order_service_db < data.sql
```

### Step 3: Create Stored Procedures (Optional but Recommended)
```bash
mysql -u root -p order_service_db < stored-procedures.sql
```

### Step 4: Run Migrations (If upgrading)
```bash
mysql -u root -p order_service_db < migrations.sql
```

---

## Alternative: Using MySQL Workbench

1. Open MySQL Workbench
2. Create new query tab
3. Copy content from each .sql file
4. Execute in order: schema.sql → data.sql → stored-procedures.sql

---

## Environment Configuration

Add to your `application.properties`:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/order_service_db
spring.datasource.username=root
spring.datasource.password=your_password
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.jpa.hibernate.ddl-auto=validate
spring.jpa.show-sql=false
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL8Dialect
spring.jpa.properties.hibernate.format_sql=true
```

---

## Connection String

**JDBC URL:** `jdbc:mysql://localhost:3306/order_service_db`

**Default Credentials:**
- Username: `root`
- Password: (set during MySQL installation)

---

## Index Strategy

Indexes defined for performance:
- `idx_order_number` - Fast order lookup by order number
- `idx_customer_name` - Customer name searches
- `idx_status` - Filter orders by status
- `idx_created_at` - Date range queries

---

## Maintenance Commands

### View All Orders
```sql
SELECT COUNT(*) as total_orders FROM orders;
```

### Check Index Usage
```sql
SELECT * FROM information_schema.STATISTICS WHERE TABLE_NAME='orders';
```

### Backup Database
```bash
mysqldump -u root -p order_service_db > backup.sql
```

### Restore Database
```bash
mysql -u root -p order_service_db < backup.sql
```

---

## Notes

- All timestamps use UTC format
- Order numbers should be unique
- Status field supports: PENDING, PROCESSING, COMPLETED, CANCELLED
- Consider adding more columns as per business requirements
- Use migrations.sql for future schema changes

---

## Support & Troubleshooting

### Issue: Character encoding problems
**Solution:**
```sql
ALTER DATABASE order_service_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### Issue: Cannot create procedure
**Credential Issue**: Ensure user has procedure creation privileges:
```sql
GRANT ALL PRIVILEGES ON order_service_db.* TO 'username'@'localhost';
FLUSH PRIVILEGES;
```

---

## Version: 2026-03-28
