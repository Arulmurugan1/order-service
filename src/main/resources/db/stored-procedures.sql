-- =====================================================
-- Stored Procedures for Order Service
-- =====================================================

USE order_service_db;

-- =====================================================
-- Procedure: Get Order by ID
-- =====================================================
DELIMITER //

DROP PROCEDURE IF EXISTS sp_get_order_by_id//

CREATE PROCEDURE sp_get_order_by_id(
    IN p_order_id BIGINT
)
BEGIN
    SELECT * FROM orders WHERE id = p_order_id;
END//

DELIMITER ;

-- =====================================================
-- Procedure: Get Orders by Status
-- =====================================================
DELIMITER //

DROP PROCEDURE IF EXISTS sp_get_orders_by_status//

CREATE PROCEDURE sp_get_orders_by_status(
    IN p_status VARCHAR(50)
)
BEGIN
    SELECT * FROM orders 
    WHERE status = p_status
    ORDER BY created_at DESC;
END//

DELIMITER ;

-- =====================================================
-- Procedure: Get Orders by Customer Name
-- =====================================================
DELIMITER //

DROP PROCEDURE IF EXISTS sp_get_orders_by_customer//

CREATE PROCEDURE sp_get_orders_by_customer(
    IN p_customer_name VARCHAR(100)
)
BEGIN
    SELECT * FROM orders 
    WHERE customer_name LIKE CONCAT('%', p_customer_name, '%')
    ORDER BY created_at DESC;
END//

DELIMITER ;

-- =====================================================
-- Procedure: Create New Order
-- =====================================================
DELIMITER //

DROP PROCEDURE IF EXISTS sp_create_order//

CREATE PROCEDURE sp_create_order(
    IN p_order_number VARCHAR(50),
    IN p_customer_name VARCHAR(100),
    IN p_status VARCHAR(50),
    IN p_total_amount DECIMAL(10, 2),
    OUT p_order_id BIGINT
)
BEGIN
    INSERT INTO orders (order_number, customer_name, status, total_amount)
    VALUES (p_order_number, p_customer_name, p_status, p_total_amount);
    
    SET p_order_id = LAST_INSERT_ID();
END//

DELIMITER ;

-- =====================================================
-- Procedure: Update Order Status
-- =====================================================
DELIMITER //

DROP PROCEDURE IF EXISTS sp_update_order_status//

CREATE PROCEDURE sp_update_order_status(
    IN p_order_id BIGINT,
    IN p_new_status VARCHAR(50)
)
BEGIN
    UPDATE orders 
    SET status = p_new_status, updated_at = NOW()
    WHERE id = p_order_id;
END//

DELIMITER ;

-- =====================================================
-- Procedure: Get Total Sales by Customer
-- =====================================================
DELIMITER //

DROP PROCEDURE IF EXISTS sp_get_customer_total_sales//

CREATE PROCEDURE sp_get_customer_total_sales(
    IN p_customer_name VARCHAR(100)
)
BEGIN
    SELECT 
        customer_name,
        COUNT(*) as order_count,
        SUM(total_amount) as total_sales,
        AVG(total_amount) as avg_order_value
    FROM orders
    WHERE customer_name = p_customer_name AND status = 'COMPLETED'
    GROUP BY customer_name;
END//

DELIMITER ;

-- =====================================================
-- Procedure: Get Orders by Date Range
-- =====================================================
DELIMITER //

DROP PROCEDURE IF EXISTS sp_get_orders_by_date_range//

CREATE PROCEDURE sp_get_orders_by_date_range(
    IN p_start_date DATETIME,
    IN p_end_date DATETIME
)
BEGIN
    SELECT * FROM orders 
    WHERE created_at BETWEEN p_start_date AND p_end_date
    ORDER BY created_at DESC;
END//

DELIMITER ;

-- =====================================================
-- Function: Get Order Status Description
-- =====================================================
DELIMITER //

DROP FUNCTION IF EXISTS fn_get_status_description//

CREATE FUNCTION fn_get_status_description(p_status VARCHAR(50))
RETURNS VARCHAR(200) DETERMINISTIC
BEGIN
    DECLARE v_description VARCHAR(200);
    
    CASE p_status
        WHEN 'PENDING' THEN SET v_description = 'Order is awaiting processing';
        WHEN 'PROCESSING' THEN SET v_description = 'Order is being prepared';
        WHEN 'COMPLETED' THEN SET v_description = 'Order has been completed';
        WHEN 'CANCELLED' THEN SET v_description = 'Order has been cancelled';
        ELSE SET v_description = 'Unknown status';
    END CASE;
    
    RETURN v_description;
END//

DELIMITER ;
