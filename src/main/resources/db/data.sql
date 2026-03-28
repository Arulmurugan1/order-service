-- =====================================================
-- Sample Data for Order Service
-- =====================================================
-- Insert sample order records for testing

USE order_service_db;

-- Clear existing data (optional - use with caution)
-- TRUNCATE TABLE orders;

-- Insert sample orders
INSERT INTO orders (order_number, customer_name, status, total_amount, created_at, updated_at) VALUES
('ORD-2026-001', 'John Smith', 'COMPLETED', 1500.00, NOW(), NOW()),
('ORD-2026-002', 'Jane Doe', 'PROCESSING', 2750.50, NOW(), NOW()),
('ORD-2026-003', 'Michael Johnson', 'PENDING', 950.25, NOW(), NOW()),
('ORD-2026-004', 'Sarah Williams', 'CANCELLED', 500.00, DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 2 DAY)),
('ORD-2026-005', 'Robert Brown', 'COMPLETED', 3200.75, DATE_SUB(NOW(), INTERVAL 10 DAY), DATE_SUB(NOW(), INTERVAL 8 DAY)),
('ORD-2026-006', 'Emily Davis', 'PROCESSING', 1875.00, DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 1 DAY)),
('ORD-2026-007', 'David Martinez', 'PENDING', 2100.50, NOW(), NOW()),
('ORD-2026-008', 'Lisa Anderson', 'COMPLETED', 1250.25, DATE_SUB(NOW(), INTERVAL 15 DAY), DATE_SUB(NOW(), INTERVAL 14 DAY));

-- Verify data insertion
-- SELECT COUNT(*) as total_orders FROM orders;
-- SELECT * FROM orders;
