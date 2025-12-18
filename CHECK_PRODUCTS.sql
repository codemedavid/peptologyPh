-- ============================================
-- PRODUCT TROUBLESHOOTING QUERIES
-- Run these one at a time to diagnose the issue
-- ============================================

-- 1. Check if categories were created
SELECT * FROM categories ORDER BY name;

-- 2. Check if any products exist
SELECT COUNT(*) as total_products FROM products;

-- 3. Check products with their categories
SELECT 
    c.name as category, 
    p.name as product_name, 
    p.price, 
    p.in_stock,
    p.is_featured
FROM products p 
JOIN categories c ON p.category = c.id 
ORDER BY c.name, p.name
LIMIT 20;

-- 4. Check for ALL products (including out of stock)
SELECT 
    name, 
    price, 
    in_stock,
    is_featured,
    category
FROM products 
ORDER BY name;

-- 5. If products exist but aren't visible, check RLS policies
SELECT 
    schemaname, 
    tablename, 
    policyname, 
    permissive, 
    roles, 
    cmd
FROM pg_policies 
WHERE tablename IN ('products', 'categories');
