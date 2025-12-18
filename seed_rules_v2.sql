-- ============================================
-- RECOMMENDATION RULES V2 - Updated for AssessmentWizardV2
-- Run this in Supabase SQL Editor AFTER running RUN_THIS_MIGRATION.sql
-- This will replace old rules with new ones that match the V2 goal structure
-- ============================================

-- Clear existing rules (optional - only if you want fresh start)
-- TRUNCATE recommendation_rules;

-- ============================================
-- WEIGHT MANAGEMENT GOALS
-- ============================================

-- 1. Lose 5-10kg -> Semaglutide (moderate weight loss)
INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Moderate Weight Loss - Semaglutide',
    'weight_5_10kg',
    'All',
    id,
    'Semaglutide (GLP-1 agonist) is highly effective for moderate weight loss goals. Clinical studies show average weight loss of 10-15% body weight over 68 weeks.',
    10,
    true
FROM products WHERE name = 'Semaglutide' LIMIT 1;

-- 2. Lose 10-20kg -> Tirzepatide (significant weight loss)
INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Significant Weight Loss - Tirzepatide',
    'weight_10_20kg',
    'All',
    id,
    'Tirzepatide is a dual GIP/GLP-1 receptor agonist showing superior efficacy for significant weight loss compared to single agonists. Studies demonstrate up to 22.5% body weight reduction.',
    10,
    true
FROM products WHERE name = 'Tirzepatide' LIMIT 1;

-- 3. Lose 20+ kg -> Tirzepatide (aggressive weight loss)
INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Aggressive Weight Loss Protocol',
    'weight_20plus',
    'All',
    id,
    'For significant weight loss goals (20+ kg), Tirzepatide offers the most robust clinical evidence with sustained results when combined with lifestyle modifications.',
    10,
    true
FROM products WHERE name = 'Tirzepatide' LIMIT 1;

-- 4. Weight Maintenance -> CJC-1295 (metabolism support)
INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Weight Maintenance & Metabolic Health',
    'weight_maintain',
    'All',
    id,
    'CJC-1295 enhances natural growth hormone secretion, supporting metabolic health and body composition maintenance. Ideal for those at goal weight.',
    10,
    true
FROM products WHERE name LIKE 'CJC-1295%' LIMIT 1;

-- ============================================
-- ENERGY & RECOVERY GOALS
-- ============================================

-- 5. Mild Fatigue -> BPC-157
INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Energy Boost - Recovery Support',
    'energy_mild',
    'All',
    id,
    'BPC-157 supports mitochondrial function and systemic recovery, helping combat mild fatigue through improved cellular energy production and tissue repair.',
    10,
    true
FROM products WHERE name = 'BPC-157' LIMIT 1;

-- 6. Chronic Fatigue -> TB-500
INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Chronic Fatigue Protocol',
    'energy_chronic',
    'All',
    id,
    'TB-500 promotes cellular migration and healing, addressing chronic fatigue at the cellular level through enhanced tissue repair and inflammation modulation.',
    10,
    true
FROM products WHERE name = 'TB-500' LIMIT 1;

-- 7. Athletic Recovery -> BPC-157
INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Athletic Recovery Enhancement',
    'recovery_athletic',
    'All',
    id,
    'BPC-157 is widely used by athletes for accelerated recovery. It supports tendon, ligament, and muscle repair while reducing inflammation.',
    10,
    true
FROM products WHERE name = 'BPC-157' LIMIT 1;

-- ============================================
-- BODY COMPOSITION GOALS
-- ============================================

-- 8. Muscle Building -> CJC-1295
INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Muscle Growth Protocol',
    'muscle_building',
    'All',
    id,
    'CJC-1295 stimulates growth hormone release, supporting lean muscle development, improved recovery, and enhanced protein synthesis.',
    10,
    true
FROM products WHERE name LIKE 'CJC-1295%' LIMIT 1;

-- 9. Body Recomposition -> Ipamorelin (if available, else CJC-1295)
INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Body Recomposition Stack',
    'body_recomposition',
    'All',
    id,
    'CJC-1295 enhances fat metabolism while supporting lean muscle retention, ideal for simultaneous fat loss and muscle preservation.',
    10,
    true
FROM products WHERE name LIKE 'CJC-1295%' LIMIT 1;

-- ============================================
-- LONGEVITY & WELLNESS GOALS
-- ============================================

-- 10. Anti-Aging -> Epitalon (or TB-500)
INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Anti-Aging & Longevity Protocol',
    'anti_aging',
    'All',
    id,
    'TB-500 supports cellular regeneration and tissue health, key factors in longevity protocols. Promotes healthy aging through enhanced repair mechanisms.',
    10,
    true
FROM products WHERE name = 'TB-500' LIMIT 1;

-- 11. Cognitive Enhancement -> Selank/Semax (if available, fallback to general)
-- Skipping for now - add when these products are in your catalog

-- 12. Immune Support -> Thymosin Alpha-1 (if available, else BPC-157)
INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Immune System Support',
    'immune_support',
    'All',
    id,
    'BPC-157 has immunomodulatory properties that support overall immune function and systemic health maintenance.',
    10,
    true
FROM products WHERE name = 'BPC-157' LIMIT 1;

-- ============================================
-- VERIFICATION QUERY
-- ============================================
-- SELECT rule_name, target_goal, target_experience, priority, is_active 
-- FROM recommendation_rules 
-- ORDER BY priority DESC, target_goal;
