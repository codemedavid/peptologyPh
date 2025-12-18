-- ============================================
-- BULK INSERT ALL PRODUCTS (WORKING VERSION)
-- This uses subqueries instead of DO blocks
-- ============================================

-- First, ensure all categories exist
INSERT INTO categories (name) 
SELECT 'Weight Management' WHERE NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Weight Management');

INSERT INTO categories (name) 
SELECT 'Recovery & Healing' WHERE NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Recovery & Healing');

INSERT INTO categories (name) 
SELECT 'Anti-Aging & Longevity' WHERE NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Anti-Aging & Longevity');

INSERT INTO categories (name) 
SELECT 'Cognitive Enhancement' WHERE NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Cognitive Enhancement');

INSERT INTO categories (name) 
SELECT 'Body Composition' WHERE NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Body Composition');

INSERT INTO categories (name) 
SELECT 'Energy & Metabolism' WHERE NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Energy & Metabolism');

INSERT INTO categories (name) 
SELECT 'Immune Support' WHERE NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Immune Support');

INSERT INTO categories (name) 
SELECT 'Aesthetic & Skin' WHERE NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Aesthetic & Skin');

INSERT INTO categories (name) 
SELECT 'Fat Loss Supplements' WHERE NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Fat Loss Supplements');

-- WEIGHT MANAGEMENT (using subquery for category)
INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'Semaglutide 10mg', 'Higher dose GLP-1 receptor agonist for enhanced weight loss results.', 7500, id, true, true
FROM categories WHERE name = 'Weight Management';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'Tirzepatide 15mg', 'Dual GIP/GLP-1 receptor agonist. Superior efficacy for significant weight loss goals.', 6000, id, true, true
FROM categories WHERE name = 'Weight Management';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'Tirzepatide 30mg', 'Maximum strength dual agonist for aggressive weight loss protocols.', 10500, id, true, true
FROM categories WHERE name = 'Weight Management';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'Retatrutide 10mg', 'Triple agonist (GIP/GLP-1/Glucagon) - cutting-edge weight management peptide.', 7500, id, true, false
FROM categories WHERE name = 'Weight Management';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'Retatrutide 20mg', 'High-dose triple agonist for maximum metabolic impact.', 10500, id, true, false
FROM categories WHERE name = 'Weight Management';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'AOD-9604 5mg', 'Fragment of HGH that specifically targets fat metabolism without affecting blood sugar.', 7500, id, true, false
FROM categories WHERE name = 'Weight Management';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'Tesamorelin 5mg', 'Growth hormone releasing hormone (GHRH) analog for visceral fat reduction.', 7500, id, true, false
FROM categories WHERE name = 'Weight Management';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'Cargilintide 5mg', 'Amylin analog that works synergistically with GLP-1 agonists for enhanced satiety.', 8400, id, true, false
FROM categories WHERE name = 'Weight Management';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'Cargilintide 10mg', 'Higher dose amylin analog for advanced weight management protocols.', 9900, id, true, false
FROM categories WHERE name = 'Weight Management';

-- RECOVERY & HEALING
INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'BPC-157 5mg + TB500 5mg', 'Powerful combination for systemic healing and recovery. Accelerates tissue repair.', 7500, id, true, true
FROM categories WHERE name = 'Recovery & Healing';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'BPC-157 10mg', 'Body Protection Compound for enhanced healing of tendons, ligaments, and gut health.', 6000, id, true, true
FROM categories WHERE name = 'Recovery & Healing';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'TB-500 5mg', 'Thymosin Beta-4 fragment. Promotes cell migration and tissue regeneration.', 6000, id, true, false
FROM categories WHERE name = 'Recovery & Healing';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'KPV 10mg', 'Anti-inflammatory peptide derived from alpha-MSH. Supports gut health and wound healing.', 6000, id, true, false
FROM categories WHERE name = 'Recovery & Healing';

-- BODY COMPOSITION
INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'CJC-1295 (w/o DAC) + Ipamorelin 10mg', 'Growth hormone secretagogue stack. Enhances muscle growth, fat loss, and recovery.', 7500, id, true, true
FROM categories WHERE name = 'Body Composition';

-- ANTI-AGING & LONGEVITY
INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'Epithalon 50mg', 'Telomerase activator. Supports cellular longevity and circadian rhythm regulation.', 9900, id, true, true
FROM categories WHERE name = 'Anti-Aging & Longevity';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'NAD+ 100mg', 'Nicotinamide Adenine Dinucleotide. Essential coenzyme for cellular energy and DNA repair.', 5400, id, true, false
FROM categories WHERE name = 'Anti-Aging & Longevity';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'NAD+ 500mg', 'High-dose NAD+ for enhanced mitochondrial function and anti-aging benefits.', 8400, id, true, false
FROM categories WHERE name = 'Anti-Aging & Longevity';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'MOTS-C 10mg', 'Mitochondrial-derived peptide. Enhances metabolism and cellular energy production.', 7500, id, true, false
FROM categories WHERE name = 'Anti-Aging & Longevity';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'MOTS-C 40mg', 'High-dose MOTS-C for advanced longevity and metabolic optimization protocols.', 9000, id, true, false
FROM categories WHERE name = 'Anti-Aging & Longevity';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'SS-31 10mg', 'Mitochondrial-targeted antioxidant peptide. Protects against oxidative stress.', 8400, id, true, false
FROM categories WHERE name = 'Anti-Aging & Longevity';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'SS-31 50mg', 'High-potency mitochondrial protector for advanced longevity protocols.', 11400, id, true, false
FROM categories WHERE name = 'Anti-Aging & Longevity';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'DSIP 5mg', 'Delta Sleep-Inducing Peptide. Promotes deep, restorative sleep and stress reduction.', 6000, id, true, false
FROM categories WHERE name = 'Anti-Aging & Longevity';

-- COGNITIVE ENHANCEMENT
INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'Selank 5mg', 'Anxiolytic and nootropic peptide. Reduces anxiety while enhancing cognitive function.', 5400, id, true, false
FROM categories WHERE name = 'Cognitive Enhancement';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'Selank 10mg', 'Higher dose cognitive enhancer for improved focus, memory, and stress management.', 6900, id, true, false
FROM categories WHERE name = 'Cognitive Enhancement';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'Semax 10mg', 'Nootropic peptide that enhances mental clarity, focus, and neuroprotection.', 6900, id, true, false
FROM categories WHERE name = 'Cognitive Enhancement';

-- IMMUNE SUPPORT
INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'Thymosin Alpha-1 5mg', 'Potent immunomodulator. Enhances T-cell function and overall immune response.', 8400, id, true, false
FROM categories WHERE name = 'Immune Support';

-- AESTHETIC & SKIN
INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'GHK-Cu 100mg', 'Copper peptide for skin regeneration, collagen synthesis, and wound healing.', 5400, id, true, true
FROM categories WHERE name = 'Aesthetic & Skin';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'AHK-Cu 100mg', 'Advanced copper peptide for skin repair and anti-aging benefits.', 7500, id, true, false
FROM categories WHERE name = 'Aesthetic & Skin';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'Snap-8 10mg', 'Anti-wrinkle peptide that reduces expression lines similar to botox effect.', 4500, id, true, false
FROM categories WHERE name = 'Aesthetic & Skin';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'Glutathione 1500mg', 'Master antioxidant for skin brightening, detoxification, and cellular protection.', 6900, id, true, true
FROM categories WHERE name = 'Aesthetic & Skin';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'GLOW 70mg', 'Comprehensive skin brightening and anti-aging peptide blend.', 8400, id, true, false
FROM categories WHERE name = 'Aesthetic & Skin';

-- ENERGY & METABOLISM
INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT '5-Amino-1MQ 5mg', 'NNMT inhibitor for enhanced fat metabolism and energy production.', 6000, id, true, false
FROM categories WHERE name = 'Energy & Metabolism';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT '5-Amino-1MQ 10mg', 'Higher dose metabolic enhancer for advanced fat loss protocols.', 7500, id, true, false
FROM categories WHERE name = 'Energy & Metabolism';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'KLOW 80mg', 'Advanced metabolic and energy optimization blend.', 7500, id, true, false
FROM categories WHERE name = 'Energy & Metabolism';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'PT-141 10mg', 'Melanocortin receptor agonist for enhanced libido and sexual function.', 6000, id, true, false
FROM categories WHERE name = 'Energy & Metabolism';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'Kisspeptin 10mg', 'Reproductive hormone regulator for fertility and hormonal balance support.', 9000, id, true, false
FROM categories WHERE name = 'Energy & Metabolism';

-- FAT LOSS SUPPLEMENTS
INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'Lemon Bottle 10ml', 'Fat dissolving injection for localized fat reduction. Popular for stubborn fat areas.', 4500, id, true, false
FROM categories WHERE name = 'Fat Loss Supplements';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'Lipo-C with B12 10ml', 'Lipotropic injection with B12 for enhanced fat metabolism and energy.', 3600, id, true, false
FROM categories WHERE name = 'Fat Loss Supplements';

INSERT INTO products (name, description, base_price, category, available, featured) 
SELECT 'FAT BLASTER LIPO-C', 'Advanced lipotropic formula for maximum fat burning and metabolic support.', 9900, id, true, false
FROM categories WHERE name = 'Fat Loss Supplements';

-- FINAL COUNT
SELECT COUNT(*) as total_products FROM products;
