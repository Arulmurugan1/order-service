fn_get_status_description-- =====================================================
-- Useful Queries for Order Service
-- =====================================================

USE orders;

-- =====================================================
-- 1. Get All Orders
-- =====================================================
SELECT * FROM orders;

-- =====================================================
-- 2. Get Orders with Pagination
-- =====================================================
SELECT * FROM orders 
ORDER BY created_at DESC 
LIMIT 10 OFFSET 0;

-- =====================================================
-- 3. Get Order Count by Status
-- =====================================================
SELECT 
    status,
    COUNT(*) as order_count
FROM orders
GROUP BY status;

-- =====================================================
-- 4. Get Total Sales Amount
-- =====================================================
SELECT 
    SUM(total_amount) as total_sales,
    COUNT(*) as total_orders,
    AVG(total_amount) as average_order_value
FROM orders
WHERE status = 'COMPLETED';

-- =====================================================
-- 5. Get Top 10 Customers by Order Count
-- =====================================================
SELECT 
    customer_name,
    COUNT(*) as order_count,
    SUM(total_amount) as total_spent
FROM orders
GROUP BY customer_name
ORDER BY order_count DESC
LIMIT 10;

-- =====================================================
-- 6. Get Orders from Last 30 Days
-- =====================================================
SELECT * FROM orders
WHERE created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
ORDER BY created_at DESC;

-- =====================================================
-- 7. Get Orders by Status with Customer Details
-- =====================================================
SELECT 
    id,
    order_number,
    customer_name,
    status,
    total_amount,
    created_at,
    updated_at
FROM orders
WHERE status = 'PENDING'
ORDER BY created_at ASC;

-- =====================================================
-- 8. Get Completed Orders with High Value (>$2000)
-- =====================================================
SELECT 
    order_number,
    customer_name,
    total_amount,
    created_at
FROM orders
WHERE status = 'COMPLETED' AND total_amount > 2000
ORDER BY total_amount DESC;

-- =====================================================
-- 9. Get Customer Order History
-- =====================================================
SELECT * FROM orders
WHERE customer_name = 'John Smith'
ORDER BY created_at DESC;

-- =====================================================
-- 10. Find Duplicate Order Numbers
-- =====================================================
SELECT 
    order_number,
    COUNT(*) as count
FROM orders
GROUP BY order_number
HAVING count > 1;

-- =====================================================
-- 11. Orders Created vs Updated Today
-- =====================================================
SELECT 
    DATE(created_at) as creation_date,
    COUNT(*) as orders_created
FROM orders
WHERE DATE(created_at) = CURDATE()
GROUP BY creation_date;

-- =====================================================
-- 12. Get Orders for This Month
-- =====================================================
SELECT * FROM orders
WHERE YEAR(created_at) =YEAR(NOW())
  AND MONTH(created_at) = MONTH(NOW())
ORDER BY created_at DESC;

-- =====================================================
-- 13. Calculate Monthly Revenue
-- =====================================================
SELECT 
    MONTH(created_at) as month,
    SUM(total_amount) as monthly_revenue,
    COUNT(*) as order_count
FROM orders
WHERE status = 'COMPLETED'
GROUP BY MONTH(created_at)
ORDER BY month DESC;

-- =====================================================
-- 14. Search Orders by Order Number
-- =====================================================
SELECT * FROM orders
WHERE order_number LIKE '%2026%'
ORDER BY created_at DESC;

-- =====================================================
-- 15. Orders Summary Report
-- =====================================================
SELECT 
    status,
    COUNT(*) as count,
    SUM(total_amount) as total_revenue,
    AVG(total_amount) as avg_amount,
    MIN(total_amount) as min_amount,
    MAX(total_amount) as max_amount
FROM orders
GROUP BY status;

--

SELECT fn_get_status_description(status) FROM Orders;

--

EXECUTE sp_get_customer_total_sales('Michael Johnson');