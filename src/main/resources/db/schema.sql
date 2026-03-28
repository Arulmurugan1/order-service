-- =====================================================
-- Order Service Database Schema
-- =====================================================
-- Database: order_service_db
-- Description: Database schema for Order Service application
-- =====================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS order_service_db;
USE order_service_db;

-- =====================================================
-- Orders Table
-- =====================================================
CREATE TABLE IF NOT EXISTS orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique order identifier',
    order_number VARCHAR(50) NOT NULL UNIQUE COMMENT 'Unique order number',
    customer_name VARCHAR(100) NOT NULL COMMENT 'Name of the customer',
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING' COMMENT 'Order status (PENDING, PROCESSING, COMPLETED, CANCELLED)',
    total_amount DECIMAL(10, 2) NOT NULL DEFAULT 0.00 COMMENT 'Total order amount',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Order creation timestamp',
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Order last update timestamp',
    
    INDEX idx_order_number (order_number) COMMENT 'Index for order number lookup',
    INDEX idx_customer_name (customer_name) COMMENT 'Index for customer name search',
    INDEX idx_status (status) COMMENT 'Index for status filtering',
    INDEX idx_created_at (created_at) COMMENT 'Index for date range queries'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Orders table for order service';

-- =====================================================
-- Verify Table Creation
-- =====================================================
-- SHOW TABLES;
-- DESC orders;
