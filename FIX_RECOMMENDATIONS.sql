-- ============================================
-- QUICK FIX: Update recommendation rules for V2 assessment
-- Run this to get recommendations working
-- ============================================

-- Step 1: Clear old rules (optional)
DELETE FROM recommendation_rules;

-- Step 2: Insert rules matching V2 goal structure
-- Weight loss goals
INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Moderate Weight Loss - Semaglutide',
    'weight_5_10kg',
    'All',
    id,
    'Semaglutide is effective for 5-10kg weight loss goals.',
    10,
    true
FROM products WHERE name LIKE '%Semaglutide%' LIMIT 1;

INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Significant Weight Loss - Tirzepatide',
    'weight_10_20kg',
    'All',
    id,
    'Tirzepatide shows superior efficacy for 10-20kg weight loss.',
    10,
    true
FROM products WHERE name LIKE '%Tirzepatide 15mg%' LIMIT 1;

INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Aggressive Weight Loss',
    'weight_20plus',
    'All',
    id,
    'Tirzepatide 30mg for significant weight loss (20+ kg).',
    10,
    true
FROM products WHERE name LIKE '%Tirzepatide 30mg%' LIMIT 1;

-- Energy & Recovery
INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Energy Boost',
    'energy_mild',
    'All',
    id,
    'BPC-157 supports energy and recovery.',
    10,
    true
FROM products WHERE name LIKE '%BPC-157%' LIMIT 1;

INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Athletic Recovery',
    'recovery_athletic',
    'All',
    id,
    'BPC-157 accelerates athletic recovery.',
    10,
    true
FROM products WHERE name LIKE '%BPC-157%' LIMIT 1;

-- Body Composition
INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Muscle Building',
    'muscle_building',
    'All',
    id,
    'CJC-1295 + Ipamorelin for muscle growth.',
    10,
    true
FROM products WHERE name LIKE '%CJC-1295%' LIMIT 1;

INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Body Recomposition',
    'body_recomposition',
    'All',
    id,
    'CJC-1295 for simultaneous fat loss and muscle retention.',
    10,
    true
FROM products WHERE name LIKE '%CJC-1295%' LIMIT 1;

-- Anti-Aging
INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Anti-Aging Protocol',
    'anti_aging',
    'All',
    id,
    'Epithalon supports cellular longevity.',
    10,
    true
FROM products WHERE name LIKE '%Epithalon%' LIMIT 1;

-- Verify
SELECT COUNT(*) as rules_created FROM recommendation_rules;
