-- ============================================
-- DISABLE RLS ON ALL TABLES
-- Run this to make ALL tables unrestricted (easier for admin)
-- ============================================

-- E-commerce tables
ALTER TABLE categories DISABLE ROW LEVEL SECURITY;
ALTER TABLE products DISABLE ROW LEVEL SECURITY;
ALTER TABLE product_variations DISABLE ROW LEVEL SECURITY;
ALTER TABLE variations DISABLE ROW LEVEL SECURITY;
ALTER TABLE menu_items DISABLE ROW LEVEL SECURITY;
ALTER TABLE add_ons DISABLE ROW LEVEL SECURITY;
ALTER TABLE payment_methods DISABLE ROW LEVEL SECURITY;

-- Site content
ALTER TABLE site_settings DISABLE ROW LEVEL SECURITY;
ALTER TABLE journey_sections DISABLE ROW LEVEL SECURITY;

-- Assessment tables
ALTER TABLE assessment_responses DISABLE ROW LEVEL SECURITY;
ALTER TABLE recommendation_rules DISABLE ROW LEVEL SECURITY;

-- Orders (if exists)
-- ALTER TABLE orders DISABLE ROW LEVEL SECURITY;

-- ============================================
-- VERIFICATION - Check which tables still have RLS enabled
-- ============================================
SELECT 
    schemaname,
    tablename,
    rowsecurity as rls_enabled
FROM pg_tables 
WHERE schemaname = 'public'
ORDER BY tablename;
