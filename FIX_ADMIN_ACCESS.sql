-- ============================================
-- FIX ADMIN ACCESS TO ASSESSMENTS
-- Run this to allow admin to view assessments
-- ============================================

-- Disable RLS on assessment_responses so admin can see them
ALTER TABLE assessment_responses DISABLE ROW LEVEL SECURITY;

-- Verify assessments exist
SELECT COUNT(*) as total_assessments FROM assessment_responses;

-- Show recent assessments
SELECT 
    id,
    goals,
    experience_level,
    created_at
FROM assessment_responses 
ORDER BY created_at DESC 
LIMIT 10;
