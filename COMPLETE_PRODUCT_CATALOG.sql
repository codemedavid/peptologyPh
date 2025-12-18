-- ============================================
-- PEPTOLOGY.PH - COMPLETE PRODUCT CATALOG
-- Updated: December 2025
-- ============================================

-- First, let's ensure we have the right categories
INSERT INTO categories (name) VALUES 
('Weight Management'),
('Recovery & Healing'),
('Anti-Aging & Longevity'),
('Cognitive Enhancement'),
('Body Composition'),
('Energy & Metabolism'),
('Immune Support'),
('Aesthetic & Skin'),
('Fat Loss Supplements')
ON CONFLICT (name) DO NOTHING;

-- Get category IDs for reference
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
    standard_inclusions TEXT;
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

    standard_inclusions := E'**Included per set:**\n• Syringe for reconstitution\n• 6 pcs insulin syringes\n• 10 pcs alcohol pads\n• Transparent vial case';

    -- ============================================
    -- WEIGHT MANAGEMENT PEPTIDES
    -- ============================================
    
    INSERT INTO products (name, description, price, category, in_stock, is_featured) VALUES
    ('Semaglutide 5mg', 
     E'GLP-1 receptor agonist for effective weight management. Reduces appetite and promotes satiety.\n\n' || standard_inclusions,
     5697, cat_weight_mgmt, true, true),
    
    ('Semaglutide 10mg', 
     E'Higher dose GLP-1 receptor agonist for enhanced weight loss results.\n\n' || standard_inclusions,
     7500, cat_weight_mgmt, true, true),
    
    ('Tirzepatide 15mg', 
     E'Dual GIP/GLP-1 receptor agonist. Superior efficacy for significant weight loss goals.\n\n' || standard_inclusions,
     6000, cat_weight_mgmt, true, true),
    
    ('Tirzepatide 30mg', 
     E'Maximum strength dual agonist for aggressive weight loss protocols.\n\n' || standard_inclusions,
     10500, cat_weight_mgmt, true, true),
    
    ('Retatrutide 10mg', 
     E'Triple agonist (GIP/GLP-1/Glucagon) - cutting-edge weight management peptide.\n\n' || standard_inclusions,
     7500, cat_weight_mgmt, true, false),
    
    ('Retatrutide 20mg', 
     E'High-dose triple agonist for maximum metabolic impact.\n\n' || standard_inclusions,
     10500, cat_weight_mgmt, true, false),
    
    ('AOD-9604 5mg', 
     E'Fragment of HGH that specifically targets fat metabolism without affecting blood sugar.\n\n' || standard_inclusions,
     7500, cat_weight_mgmt, true, false),
    
    ('Tesamorelin 5mg', 
     E'Growth hormone releasing hormone (GHRH) analog for visceral fat reduction.\n\n' || standard_inclusions,
     7500, cat_weight_mgmt, true, false),
    
    ('Cargilintide 5mg', 
     E'Amylin analog that works synergistically with GLP-1 agonists for enhanced satiety.\n\n' || standard_inclusions,
     8400, cat_weight_mgmt, true, false),
    
    ('Cargilintide 10mg', 
     E'Higher dose amylin analog for advanced weight management protocols.\n\n' || standard_inclusions,
     9900, cat_weight_mgmt, true, false)
    ON CONFLICT (name) DO UPDATE SET
        price = EXCLUDED.price,
        description = EXCLUDED.description,
        in_stock = EXCLUDED.in_stock;

    -- ============================================
    -- RECOVERY & HEALING PEPTIDES
    -- ============================================
    
    INSERT INTO products (name, description, price, category, in_stock, is_featured) VALUES
    ('BPC-157 5mg + TB500 5mg', 
     E'Powerful combination for systemic healing and recovery. Accelerates tissue repair.\n\n' || standard_inclusions,
     7500, cat_recovery, true, true),
    
    ('BPC-157 10mg', 
     E'Body Protection Compound for enhanced healing of tendons, ligaments, and gut health.\n\n' || standard_inclusions,
     6000, cat_recovery, true, true),
    
    ('TB-500 5mg', 
     E'Thymosin Beta-4 fragment. Promotes cell migration and tissue regeneration.\n\n' || standard_inclusions,
     6000, cat_recovery, true, false),
    
    ('KPV 10mg', 
     E'Anti-inflammatory peptide derived from alpha-MSH. Supports gut health and wound healing.\n\n' || standard_inclusions,
     6000, cat_recovery, true, false)
    ON CONFLICT (name) DO UPDATE SET
        price = EXCLUDED.price,
        description = EXCLUDED.description,
        in_stock = EXCLUDED.in_stock;

    -- ============================================
    -- BODY COMPOSITION & GROWTH HORMONE
    -- ============================================
    
    INSERT INTO products (name, description, price, category, in_stock, is_featured) VALUES
    ('CJC-1295 (w/o DAC) + Ipamorelin 10mg', 
     E'Growth hormone secretagogue stack. Enhances muscle growth, fat loss, and recovery.\n\n' || standard_inclusions,
     7500, cat_body_comp, true, true),
    
    ('Ipamorelin 10mg', 
     E'Selective growth hormone secretagogue with minimal side effects. Supports lean muscle.\n\n' || standard_inclusions,
     6000, cat_body_comp, true, false)
    ON CONFLICT (name) DO UPDATE SET
        price = EXCLUDED.price,
        description = EXCLUDED.description,
        in_stock = EXCLUDED.in_stock;

    -- ============================================
    -- ANTI-AGING & LONGEVITY
    -- ============================================
    
    INSERT INTO products (name, description, price, category, in_stock, is_featured) VALUES
    ('Epithalon 50mg', 
     E'Telomerase activator. Supports cellular longevity and circadian rhythm regulation.\n\n' || standard_inclusions,
     9900, cat_antiaging, true, true),
    
    ('NAD+ 100mg', 
     E'Nicotinamide Adenine Dinucleotide. Essential coenzyme for cellular energy and DNA repair.\n\n' || standard_inclusions,
     5400, cat_antiaging, true, false),
    
    ('NAD+ 500mg', 
     E'High-dose NAD+ for enhanced mitochondrial function and anti-aging benefits.\n\n' || standard_inclusions,
     8400, cat_antiaging, true, false),
    
    ('MOTS-C 10mg', 
     E'Mitochondrial-derived peptide. Enhances metabolism and cellular energy production.\n\n' || standard_inclusions,
     7500, cat_antiaging, true, false),
    
    ('MOTS-C 40mg', 
     E'High-dose MOTS-C for advanced longevity and metabolic optimization protocols.\n\n' || standard_inclusions,
     9000, cat_antiaging, true, false),
    
    ('SS-31 10mg', 
     E'Mitochondrial-targeted antioxidant peptide. Protects against oxidative stress.\n\n' || standard_inclusions,
     8400, cat_antiaging, true, false),
    
    ('SS-31 50mg', 
     E'High-potency mitochondrial protector for advanced longevity protocols.\n\n' || standard_inclusions,
     11400, cat_antiaging, true, false),
    
    ('DSIP 5mg', 
     E'Delta Sleep-Inducing Peptide. Promotes deep, restorative sleep and stress reduction.\n\n' || standard_inclusions,
     6000, cat_antiaging, true, false)
    ON CONFLICT (name) DO UPDATE SET
        price = EXCLUDED.price,
        description = EXCLUDED.description,
        in_stock = EXCLUDED.in_stock;

    -- ============================================
    -- COGNITIVE ENHANCEMENT
    -- ============================================
    
    INSERT INTO products (name, description, price, category, in_stock, is_featured) VALUES
    ('Selank 5mg', 
     E'Anxiolytic and nootropic peptide. Reduces anxiety while enhancing cognitive function.\n\n' || standard_inclusions,
     5400, cat_cognitive, true, false),
    
    ('Selank 10mg', 
     E'Higher dose cognitive enhancer for improved focus, memory, and stress management.\n\n' || standard_inclusions,
     6900, cat_cognitive, true, false),
    
    ('Semax 10mg', 
     E'Nootropic peptide that enhances mental clarity, focus, and neuroprotection.\n\n' || standard_inclusions,
     6900, cat_cognitive, true, false)
    ON CONFLICT (name) DO UPDATE SET
        price = EXCLUDED.price,
        description = EXCLUDED.description,
        in_stock = EXCLUDED.in_stock;

    -- ============================================
    -- IMMUNE SUPPORT
    -- ============================================
    
    INSERT INTO products (name, description, price, category, in_stock, is_featured) VALUES
    ('Thymosin Alpha-1 5mg', 
     E'Potent immunomodulator. Enhances T-cell function and overall immune response.\n\n' || standard_inclusions,
     8400, cat_immune, true, false)
    ON CONFLICT (name) DO UPDATE SET
        price = EXCLUDED.price,
        description = EXCLUDED.description,
        in_stock = EXCLUDED.in_stock;

    -- ============================================
    -- AESTHETIC & SKIN HEALTH
    -- ============================================
    
    INSERT INTO products (name, description, price, category, in_stock, is_featured) VALUES
    ('GHK-Cu 100mg', 
     E'Copper peptide for skin regeneration, collagen synthesis, and wound healing.\n\n' || standard_inclusions,
     5400, cat_aesthetic, true, true),
    
    ('AHK-Cu 100mg', 
     E'Advanced copper peptide for skin repair and anti-aging benefits.\n\n' || standard_inclusions,
     7500, cat_aesthetic, true, false),
    
    ('Snap-8 10mg', 
     E'Anti-wrinkle peptide that reduces expression lines similar to botox effect.\n\n' || standard_inclusions,
     4500, cat_aesthetic, true, false),
    
    ('Glutathione 1500mg', 
     E'Master antioxidant for skin brightening, detoxification, and cellular protection.\n\n' || standard_inclusions,
     6900, cat_aesthetic, true, true),
    
    ('GLOW 70mg', 
     E'Comprehensive skin brightening and anti-aging peptide blend.\n\n' || standard_inclusions,
     8400, cat_aesthetic, true, false)
    ON CONFLICT (name) DO UPDATE SET
        price = EXCLUDED.price,
        description = EXCLUDED.description,
        in_stock = EXCLUDED.in_stock;

    -- ============================================
    -- ENERGY & METABOLISM
    -- ============================================
    
    INSERT INTO products (name, description, price, category, in_stock, is_featured) VALUES
    ('5-Amino-1MQ 5mg', 
     E'NNMT inhibitor for enhanced fat metabolism and energy production.\n\n' || standard_inclusions,
     6000, cat_energy, true, false),
    
    ('5-Amino-1MQ 10mg', 
     E'Higher dose metabolic enhancer for advanced fat loss protocols.\n\n' || standard_inclusions,
     7500, cat_energy, true, false),
    
    ('KLOW 80mg', 
     E'Advanced metabolic and energy optimization blend.\n\n' || standard_inclusions,
     7500, cat_energy, true, false),
    
    ('PT-141 10mg', 
     E'Melanocortin receptor agonist for enhanced libido and sexual function.\n\n' || standard_inclusions,
     6000, cat_energy, true, false),
    
    ('Kisspeptin 10mg', 
     E'Reproductive hormone regulator for fertility and hormonal balance support.\n\n' || standard_inclusions,
     9000, cat_energy, true, false)
    ON CONFLICT (name) DO UPDATE SET
        price = EXCLUDED.price,
        description = EXCLUDED.description,
        in_stock = EXCLUDED.in_stock;

    -- ============================================
    -- FAT LOSS SUPPLEMENTS & INJECTIONS
    -- ============================================
    
    INSERT INTO products (name, description, price, category, in_stock, is_featured) VALUES
    ('Lemon Bottle 10ml', 
     E'Fat dissolving injection for localized fat reduction. Popular for stubborn fat areas.\n\nNo syringes included - direct injection product.',
     4500, cat_fatloss, true, false),
    
    ('Lipo-C with B12 10ml', 
     E'Lipotropic injection with B12 for enhanced fat metabolism and energy.\n\nNo syringes included - direct injection product.',
     3600, cat_fatloss, true, false),
    
    ('FAT BLASTER LIPO-C', 
     E'Advanced lipotropic formula for maximum fat burning and metabolic support.\n\nNo syringes included - direct injection product.',
     9900, cat_fatloss, true, false)
    ON CONFLICT (name) DO UPDATE SET
        price = EXCLUDED.price,
        description = EXCLUDED.description,
        in_stock = EXCLUDED.in_stock;

END $$;

-- ============================================
-- VERIFICATION QUERY
-- ============================================
-- SELECT c.name as category, p.name, p.price, p.is_featured 
-- FROM products p 
-- JOIN categories c ON p.category = c.id 
-- ORDER BY c.name, p.price DESC;
