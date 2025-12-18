-- Enhanced Assessment Schema Migration
-- Run this AFTER the base assessment_schema.sql has been executed
-- This adds new columns for the comprehensive assessment flow

-- Add new columns to assessment_responses table
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
  ADD COLUMN IF NOT EXISTS weight_goal_kg DECIMAL(4,1), -- Target weight loss amount
  ADD COLUMN IF NOT EXISTS emotional_motivators TEXT[], -- Why they want to achieve goals
  
  -- Medical History
  ADD COLUMN IF NOT EXISTS medical_conditions TEXT[], -- List of selected conditions
  ADD COLUMN IF NOT EXISTS family_history_conditions TEXT[], -- Family medical history
  ADD COLUMN IF NOT EXISTS current_medications TEXT, -- Free text field
  ADD COLUMN IF NOT EXISTS previous_surgeries BOOLEAN DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS drug_allergies BOOLEAN DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS smoking_status TEXT CHECK (smoking_status IN ('smoker', 'non_smoker', 'other')),
  
  -- Pregnancy/Reproductive
  ADD COLUMN IF NOT EXISTS pregnancy_status TEXT[], -- 'pregnant', 'breastfeeding', 'planning', 'none'
  
  -- Peptide-Specific Experience
  ADD COLUMN IF NOT EXISTS peptide_experience_first_time BOOLEAN,
  ADD COLUMN IF NOT EXISTS current_prescription_glp1 BOOLEAN,
  
  -- Contact
  ADD COLUMN IF NOT EXISTS phone TEXT;

-- Create indexes for common queries
CREATE INDEX IF NOT EXISTS idx_assessment_dob ON assessment_responses(date_of_birth);
CREATE INDEX IF NOT EXISTS idx_assessment_weight ON assessment_responses(weight_kg);
CREATE INDEX IF NOT EXISTS idx_assessment_medical_conditions ON assessment_responses USING GIN (medical_conditions);

-- Add comment for documentation
COMMENT ON TABLE assessment_responses IS 'Enhanced peptide assessment responses with comprehensive medical screening';
