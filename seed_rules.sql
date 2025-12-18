-- 1. Weight Management -> Tirzepatide
INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Weight Management - Proven Efficacy',
    'weight_management',
    'All',
    id,
    'Tirzepatide is a dual GIP and GLP-1 receptor agonist, showing superior efficacy in clinical trials for weight management compared to single agonists.',
    10,
    true
FROM products WHERE name = 'Tirzepatide' LIMIT 1;

-- 2. Energy & Recovery -> BPC-157
INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Systemic Recovery Protocol',
    'energy_recovery',
    'All',
    id,
    'BPC-157 is renowned for its cytoprotective properties, accelerating tissue repair and modulating inflammation to support faster recovery.',
    10,
    true
FROM products WHERE name = 'BPC-157' LIMIT 1;

-- 3. Wellness / Longevity -> Epitalon (Use BPC-157 if Epitalon missing, or check TB-500)
-- Let's use TB-500 for now as it's in seed_peptides
INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Cellular Repair & Longevity',
    'wellness_longevity',
    'All',
    id,
    'TB-500 supports cellular migration and healing processes widely used in longevity protocols to maintain tissue health.',
    10,
    true
FROM products WHERE name = 'TB-500' LIMIT 1;

-- 4. Body Composition -> CJC-1295
INSERT INTO recommendation_rules (rule_name, target_goal, target_experience, primary_product_id, educational_note, priority, is_active)
SELECT 
    'Growth Hormone Optimization',
    'body_composition',
    'All',
    id,
    'CJC-1295 enhances natural growth hormone secretion, aiding in lean muscle retention and fat metabolism optimization.',
    10,
    true
FROM products WHERE name LIKE 'CJC-1295%' LIMIT 1;

-- Delete any duplicates if run multiple times (optional cleanup)
-- DELETE FROM recommendation_rules a USING recommendation_rules b
-- WHERE a.id < b.id AND a.target_goal = b.target_goal;
