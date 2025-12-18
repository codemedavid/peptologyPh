-- ============================================
-- PEPTOLOGY.PH - COMPLETE PRODUCT CATALOG (SIMPLIFIED)
-- Updated: December 2025
-- ============================================

-- Step 1: Insert categories (will skip if already exist due to WHERE NOT EXISTS)
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

-- Step 2: Clear existing products (OPTIONAL - comment out if you want to keep old products)
-- TRUNCATE products;

-- Step 3: Insert all products
DO $$
DECLARE
    cat_weight_mgmt UUID;
    cat_recovery UUID;
    cat_antiaging UUID;
    cat_cognitive UUID;
    cat_body_comp UUID;
    cat_energy UUID;
    cat_immune UUID;
    cat_aesthetic UUID;
    cat_fatloss UUID;
BEGIN
    -- Get category IDs
    SELECT id INTO cat_weight_mgmt FROM categories WHERE name = 'Weight Management';
    SELECT id INTO cat_recovery FROM categories WHERE name = 'Recovery & Healing';
    SELECT id INTO cat_antiaging FROM categories WHERE name = 'Anti-Aging & Longevity';
    SELECT id INTO cat_cognitive FROM categories WHERE name = 'Cognitive Enhancement';
    SELECT id INTO cat_body_comp FROM categories WHERE name = 'Body Composition';
    SELECT id INTO cat_energy FROM categories WHERE name = 'Energy & Metabolism';
    SELECT id INTO cat_immune FROM categories WHERE name = 'Immune Support';
    SELECT id INTO cat_aesthetic FROM categories WHERE name = 'Aesthetic & Skin';
    SELECT id INTO cat_fatloss FROM categories WHERE name = 'Fat Loss Supplements';

    -- Weight Management
    INSERT INTO products (name, description, price, category, in_stock, is_featured) VALUES
    ('Semaglutide 5mg', 'GLP-1 receptor agonist for effective weight management. Reduces appetite and promotes satiety.', 5697, cat_weight_mgmt, true, true),
    ('Semaglutide 10mg', 'Higher dose GLP-1 receptor agonist for enhanced weight loss results.', 7500, cat_weight_mgmt, true, true),
    ('Tirzepatide 15mg', 'Dual GIP/GLP-1 receptor agonist. Superior efficacy for significant weight loss goals.', 6000, cat_weight_mgmt, true, true),
    ('Tirzepatide 30mg', 'Maximum strength dual agonist for aggressive weight loss protocols.', 10500, cat_weight_mgmt, true, true),
    ('Retatrutide 10mg', 'Triple agonist (GIP/GLP-1/Glucagon) - cutting-edge weight management peptide.', 7500, cat_weight_mgmt, true, false),
    ('Retatrutide 20mg', 'High-dose triple agonist for maximum metabolic impact.', 10500, cat_weight_mgmt, true, false),
    ('AOD-9604 5mg', 'Fragment of HGH that specifically targets fat metabolism without affecting blood sugar.', 7500, cat_weight_mgmt, true, false),
    ('Tesamorelin 5mg', 'Growth hormone releasing hormone (GHRH) analog for visceral fat reduction.', 7500, cat_weight_mgmt, true, false),
    ('Cargilintide 5mg', 'Amylin analog that works synergistically with GLP-1 agonists for enhanced satiety.', 8400, cat_weight_mgmt, true, false),
    ('Cargilintide 10mg', 'Higher dose amylin analog for advanced weight management protocols.', 9900, cat_weight_mgmt, true, false);

    -- Recovery & Healing
    INSERT INTO products (name, description, price, category, in_stock, is_featured) VALUES
    ('BPC-157 5mg + TB500 5mg', 'Powerful combination for systemic healing and recovery. Accelerates tissue repair.', 7500, cat_recovery, true, true),
    ('BPC-157 10mg', 'Body Protection Compound for enhanced healing of tendons, ligaments, and gut health.', 6000, cat_recovery, true, true),
    ('TB-500 5mg', 'Thymosin Beta-4 fragment. Promotes cell migration and tissue regeneration.', 6000, cat_recovery, true, false),
    ('KPV 10mg', 'Anti-inflammatory peptide derived from alpha-MSH. Supports gut health and wound healing.', 6000, cat_recovery, true, false);

    -- Body Composition
    INSERT INTO products (name, description, price, category, in_stock, is_featured) VALUES
    ('CJC-1295 (w/o DAC) + Ipamorelin 10mg', 'Growth hormone secretagogue stack. Enhances muscle growth, fat loss, and recovery.', 7500, cat_body_comp, true, true),
    ('Ipamorelin 10mg', 'Selective growth hormone secretagogue with minimal side effects. Supports lean muscle.', 6000, cat_body_comp, true, false);

    -- Anti-Aging & Longevity
    INSERT INTO products (name, description, price, category, in_stock, is_featured) VALUES
    ('Epithalon 50mg', 'Telomerase activator. Supports cellular longevity and circadian rhythm regulation.', 9900, cat_antiaging, true, true),
    ('NAD+ 100mg', 'Nicotinamide Adenine Dinucleotide. Essential coenzyme for cellular energy and DNA repair.', 5400, cat_antiaging, true, false),
    ('NAD+ 500mg', 'High-dose NAD+ for enhanced mitochondrial function and anti-aging benefits.', 8400, cat_antiaging, true, false),
    ('MOTS-C 10mg', 'Mitochondrial-derived peptide. Enhances metabolism and cellular energy production.', 7500, cat_antiaging, true, false),
    ('MOTS-C 40mg', 'High-dose MOTS-C for advanced longevity and metabolic optimization protocols.', 9000, cat_antiaging, true, false),
    ('SS-31 10mg', 'Mitochondrial-targeted antioxidant peptide. Protects against oxidative stress.', 8400, cat_antiaging, true, false),
    ('SS-31 50mg', 'High-potency mitochondrial protector for advanced longevity protocols.', 11400, cat_antiaging, true, false),
    ('DSIP 5mg', 'Delta Sleep-Inducing Peptide. Promotes deep, restorative sleep and stress reduction.', 6000, cat_antiaging, true, false);

    -- Cognitive Enhancement
    INSERT INTO products (name, description, price, category, in_stock, is_featured) VALUES
    ('Selank 5mg', 'Anxiolytic and nootropic peptide. Reduces anxiety while enhancing cognitive function.', 5400, cat_cognitive, true, false),
    ('Selank 10mg', 'Higher dose cognitive enhancer for improved focus, memory, and stress management.', 6900, cat_cognitive, true, false),
    ('Semax 10mg', 'Nootropic peptide that enhances mental clarity, focus, and neuroprotection.', 6900, cat_cognitive, true, false);

    -- Immune Support
    INSERT INTO products (name, description, price, category, in_stock, is_featured) VALUES
    ('Thymosin Alpha-1 5mg', 'Potent immunomodulator. Enhances T-cell function and overall immune response.', 8400, cat_immune, true, false);

    -- Aesthetic & Skin
    INSERT INTO products (name, description, price, category, in_stock, is_featured) VALUES
    ('GHK-Cu 100mg', 'Copper peptide for skin regeneration, collagen synthesis, and wound healing.', 5400, cat_aesthetic, true, true),
    ('AHK-Cu 100mg', 'Advanced copper peptide for skin repair and anti-aging benefits.', 7500, cat_aesthetic, true, false),
    ('Snap-8 10mg', 'Anti-wrinkle peptide that reduces expression lines similar to botox effect.', 4500, cat_aesthetic, true, false),
    ('Glutathione 1500mg', 'Master antioxidant for skin brightening, detoxification, and cellular protection.', 6900, cat_aesthetic, true, true),
    ('GLOW 70mg', 'Comprehensive skin brightening and anti-aging peptide blend.', 8400, cat_aesthetic, true, false);

    -- Energy & Metabolism
    INSERT INTO products (name, description, price, category, in_stock, is_featured) VALUES
    ('5-Amino-1MQ 5mg', 'NNMT inhibitor for enhanced fat metabolism and energy production.', 6000, cat_energy, true, false),
    ('5-Amino-1MQ 10mg', 'Higher dose metabolic enhancer for advanced fat loss protocols.', 7500, cat_energy, true, false),
    ('KLOW 80mg', 'Advanced metabolic and energy optimization blend.', 7500, cat_energy, true, false),
    ('PT-141 10mg', 'Melanocortin receptor agonist for enhanced libido and sexual function.', 6000, cat_energy, true, false),
    ('Kisspeptin 10mg', 'Reproductive hormone regulator for fertility and hormonal balance support.', 9000, cat_energy, true, false);

    -- Fat Loss Supplements
    INSERT INTO products (name, description, price, category, in_stock, is_featured) VALUES
    ('Lemon Bottle 10ml', 'Fat dissolving injection for localized fat reduction. Popular for stubborn fat areas.', 4500, cat_fatloss, true, false),
    ('Lipo-C with B12 10ml', 'Lipotropic injection with B12 for enhanced fat metabolism and energy.', 3600, cat_fatloss, true, false),
    ('FAT BLASTER LIPO-C', 'Advanced lipotropic formula for maximum fat burning and metabolic support.', 9900, cat_fatloss, true, false);

END $$;

-- Verification
SELECT COUNT(*) as total_products FROM products;
