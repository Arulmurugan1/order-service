-- =====================================================
-- Database Migration Scripts for Order Service
-- =====================================================
-- These scripts handle database version upgrades
-- Version: 1.0.0 -> 1.0.1

USE order_service_db;

-- =====================================================
-- MIGRATION 1.0.0 -> 1.0.1
-- Add order tracking fields
-- =====================================================

-- Add if column doesn't exist
ALTER TABLE orders ADD COLUMN payment_status VARCHAR(50) DEFAULT 'PENDING' COMMENT 'Payment status' AFTER status;
ALTER TABLE orders ADD COLUMN shipping_address VARCHAR(255) COMMENT 'Shipping address' AFTER total_amount;

-- Add index for new columns
ALTER TABLE orders ADD INDEX idx_payment_status (payment_status) COMMENT 'Index for payment status';

-- =====================================================
-- ROLLBACK VERSION - Undo Migration 1.0.1
-- =====================================================

-- To rollback, uncomment and run these commands:
-- ALTER TABLE orders DROP COLUMN IF EXISTS payment_status;
-- ALTER TABLE orders DROP COLUMN IF EXISTS shipping_address;
-- ALTER TABLE orders DROP INDEX IF EXISTS idx_payment_status;

-- =====================================================
-- VERSION HISTORY
-- =====================================================
-- v1.0.0 - Initial schema with orders table
-- v1.0.1 - Added payment_status and shipping_address columns
