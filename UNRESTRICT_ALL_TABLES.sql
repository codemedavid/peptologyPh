-- ============================================
-- DISABLE RLS ON ALL EXISTING TABLES
-- This safely disables RLS only on tables that exist
-- ============================================

DO $$
DECLARE
    table_record RECORD;
BEGIN
    -- Loop through all tables in public schema with RLS enabled
    FOR table_record IN 
        SELECT tablename 
        FROM pg_tables 
        WHERE schemaname = 'public' AND rowsecurity = true
    LOOP
        -- Disable RLS for each table
        EXECUTE format('ALTER TABLE %I DISABLE ROW LEVEL SECURITY', table_record.tablename);
        RAISE NOTICE 'Disabled RLS on table: %', table_record.tablename;
    END LOOP;
END $$;

-- ============================================
-- VERIFICATION
-- Show all tables and their RLS status
-- ============================================
SELECT 
    tablename,
    rowsecurity as rls_enabled
FROM pg_tables 
WHERE schemaname = 'public'
ORDER BY tablename;

-- All tables should show rls_enabled = false
