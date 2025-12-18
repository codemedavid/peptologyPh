-- ============================================
-- SIMPLE PRODUCT INSERT (NO DO BLOCK)
-- Just insert a few test products first to verify schema
-- ============================================

-- First, let's see what categories exist
SELECT id, name FROM categories;

-- STOP HERE and copy one of the UUID values, then uncomment and run below:

-- Replace 'YOUR-CATEGORY-UUID-HERE' with actual UUID from above query
/*
INSERT INTO products (name, description, price, category, in_stock, is_featured) VALUES
('Test Semaglutide 5mg', 'Test product', 5697, 'YOUR-CATEGORY-UUID-HERE', true, true);

-- If that works, run this to see the product
SELECT * FROM products WHERE name LIKE 'Test%';
*/
