-- ============================================
-- FIX RLS AND SCHEMA ISSUES
-- Run this FIRST before inserting products
-- ============================================

-- Step 1: Disable RLS on categories and products (for easier admin management)
ALTER TABLE categories DISABLE ROW LEVEL SECURITY;
ALTER TABLE products DISABLE ROW LEVEL SECURITY;

-- Step 2: Ensure categories table has proper UUID generation
-- (Only add if missing - this is safe to run)
ALTER TABLE categories 
  ALTER COLUMN id SET DEFAULT gen_random_uuid();

-- Step 3: Ensure products table has proper UUID generation
ALTER TABLE products 
  ALTER COLUMN id SET DEFAULT gen_random_uuid();

-- Step 4: Verify
SELECT 
    table_name, 
    column_name, 
    column_default,
    is_nullable
FROM information_schema.columns 
WHERE table_name IN ('categories', 'products') 
  AND column_name = 'id';

-- Success! Now you can run INSERT_PRODUCTS_SIMPLE.sql
