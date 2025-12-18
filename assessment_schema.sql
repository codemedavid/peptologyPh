-- Create table for storing Assessment Responses
CREATE TABLE IF NOT EXISTS assessment_responses (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT NOT NULL,
    age_range TEXT NOT NULL, -- '18-24', '25-34', '35-44', '45+'
    location TEXT NOT NULL,
    
    -- Assessment Data
    goals TEXT[] NOT NULL, -- Array of selected goals e.g. ['weight_management', 'energy']
    experience_level TEXT NOT NULL, -- 'first_time', 'beginner', 'experienced', 'glp1_user'
    
    -- Format: { "format": "vial", "budget": "low", "frequency": "daily", "learning_style": "guided" }
    preferences JSONB DEFAULT '{}'::jsonb,
    
    -- Compliance / Consent
    consent_agreed BOOLEAN DEFAULT FALSE,
    agreed_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- System
    recommendation_generated JSONB DEFAULT NULL, -- Snapshot of what was recommended
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    status TEXT DEFAULT 'new' -- 'new', 'reviewed', 'contacted'
);

-- Create table for Recommendation Rules (Admin Configurable)
CREATE TABLE IF NOT EXISTS recommendation_rules (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    rule_name TEXT NOT NULL,
    
    -- Logic Triggers
    target_goal TEXT NOT NULL, -- e.g. 'Weight Management' (Must match form values)
    target_experience TEXT DEFAULT 'All', -- 'All', 'Beginner', 'Experienced'
    
    -- Outcomes
    primary_product_id UUID REFERENCES products(id), -- Main recommendation
    secondary_product_ids UUID[], -- List of supporting product IDs
    
    educational_note TEXT, -- "Why this aligns with your goal..."
    
    priority INTEGER DEFAULT 0, -- Higher priority rules take precedence if multiple match
    is_active BOOLEAN DEFAULT TRUE,
    
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE assessment_responses ENABLE ROW LEVEL SECURITY;
ALTER TABLE recommendation_rules ENABLE ROW LEVEL SECURITY;

-- Policies for Responses
-- Allow public to insert (submitting the form)
DROP POLICY IF EXISTS "Public can submit assessments" ON assessment_responses;
CREATE POLICY "Public can submit assessments" 
ON assessment_responses FOR INSERT 
TO anon, authenticated 
WITH CHECK (true);

-- Allow admins to view all responses (assuming auth simulation)
DROP POLICY IF EXISTS "Admins can view assessments" ON assessment_responses;
CREATE POLICY "Admins can view assessments" 
ON assessment_responses FOR SELECT 
TO authenticated 
USING (true);

-- Policies for Rules
-- Public can read active rules to generate results layout (or backend function)
DROP POLICY IF EXISTS "Public can read active rules" ON recommendation_rules;
CREATE POLICY "Public can read active rules" 
ON recommendation_rules FOR SELECT 
TO anon, authenticated 
USING (is_active = true);

-- Admins can manage rules
DROP POLICY IF EXISTS "Admins can manage rules" ON recommendation_rules;
CREATE POLICY "Admins can manage rules" 
ON recommendation_rules FOR ALL 
TO authenticated 
USING (true)
WITH CHECK (true);

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS idx_assessment_email ON assessment_responses(email);
CREATE INDEX IF NOT EXISTS idx_rules_goal ON recommendation_rules(target_goal);
