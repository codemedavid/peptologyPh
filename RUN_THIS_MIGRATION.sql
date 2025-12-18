-- ============================================
-- ASSESSMENT V2 - COMPLETE MIGRATION SCRIPT
-- Run this in Supabase SQL Editor
-- ============================================

-- Step 1: Add all new columns to assessment_responses table
ALTER TABLE assessment_responses 
  -- Demographics
  ADD COLUMN IF NOT EXISTS date_of_birth DATE,
  ADD COLUMN IF NOT EXISTS sex_assigned TEXT CHECK (sex_assigned IN ('male', 'female', 'other')),
  
  -- Physical Metrics
  ADD COLUMN IF NOT EXISTS height_cm DECIMAL(5,2),
  ADD COLUMN IF NOT EXISTS weight_kg DECIMAL(5,2),
  ADD COLUMN IF NOT EXISTS waist_inches DECIMAL(4,1),
  ADD COLUMN IF NOT EXISTS hip_inches DECIMAL(4,1),
  
  -- Goal Specificity
  ADD COLUMN IF NOT EXISTS weight_goal_kg DECIMAL(4,1),
  ADD COLUMN IF NOT EXISTS emotional_motivators TEXT[],
  
  -- Medical History
  ADD COLUMN IF NOT EXISTS medical_conditions TEXT[],
  ADD COLUMN IF NOT EXISTS family_history_conditions TEXT[],
  ADD COLUMN IF NOT EXISTS current_medications TEXT,
  ADD COLUMN IF NOT EXISTS previous_surgeries BOOLEAN DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS drug_allergies BOOLEAN DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS smoking_status TEXT CHECK (smoking_status IN ('smoker', 'non_smoker', 'other')),
  
  -- Pregnancy/Reproductive
  ADD COLUMN IF NOT EXISTS pregnancy_status TEXT[],
  
  -- Peptide-Specific Experience
  ADD COLUMN IF NOT EXISTS peptide_experience_first_time BOOLEAN,
  ADD COLUMN IF NOT EXISTS current_prescription_glp1 BOOLEAN,
  
  -- Contact
  ADD COLUMN IF NOT EXISTS phone TEXT;

-- Step 2: Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_assessment_dob ON assessment_responses(date_of_birth);
CREATE INDEX IF NOT EXISTS idx_assessment_weight ON assessment_responses(weight_kg);
CREATE INDEX IF NOT EXISTS idx_assessment_medical_conditions ON assessment_responses USING GIN (medical_conditions);

-- Step 3: Add table comment
COMMENT ON TABLE assessment_responses IS 'Enhanced peptide assessment responses with comprehensive medical screening (V2)';

-- ============================================
-- VERIFICATION QUERY
-- Run this after migration to confirm success
-- ============================================
-- SELECT column_name, data_type 
-- FROM information_schema.columns 
-- WHERE table_name = 'assessment_responses' 
-- ORDER BY ordinal_position;
