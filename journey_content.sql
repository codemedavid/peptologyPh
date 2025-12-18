-- Create the journey_sections table
CREATE TABLE IF NOT EXISTS journey_sections (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    section_identifier TEXT NOT NULL UNIQUE, -- e.g., 'hero', 'story', 'science', 'results', 'values', 'cta'
    title TEXT,
    subtitle TEXT,
    content TEXT, -- Markdown or HTML supported
    image_url TEXT,
    order_index INTEGER DEFAULT 0,
    metadata JSONB DEFAULT '{}'::jsonb, -- Store list items, extra fields, styles
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE journey_sections ENABLE ROW LEVEL SECURITY;

-- Policy: Everyone can read
CREATE POLICY "Public can view journey sections" 
ON journey_sections FOR SELECT 
TO anon, authenticated 
USING (true);

-- Policy: Only admins can update (Simulated for now as authenticated users)
CREATE POLICY "Admins can update journey sections" 
ON journey_sections FOR UPDATE
TO authenticated 
USING (true)
WITH CHECK (true);

-- Seed Data (Matches the current hardcoded content)

-- 1. Hero
INSERT INTO journey_sections (section_identifier, title, subtitle, content, order_index)
VALUES (
    'hero', 
    'My Peptide Journey', 
    'Why I chose peptides and how they fundamentally changed my approach to wellness, performance, and longevity.',
    NULL,
    1
) ON CONFLICT (section_identifier) DO NOTHING;

-- 2. The Beginning (Story)
INSERT INTO journey_sections (section_identifier, title, subtitle, content, image_url, order_index)
VALUES (
    'beginning', 
    'It Started With Frustration.', 
    'The Beginning',
    'Like many, my journey didn''t start with a clear answer. It started with a problem. Despite maintaining what I thought was a "healthy" lifestyle—regular exercise, decent diet, and enough sleep—I hit a wall.\n\nRecovery was slower. Energy was inconsistent. Brain fog was becoming a daily companion.\n\nI wasn''t looking for a magic pill. I was looking for a way to optimize the systems my body already had. That''s when I stumbled upon peptide therapy.',
    '/assets/journey-1.png',
    2
) ON CONFLICT (section_identifier) DO NOTHING;

-- 3. Science
INSERT INTO journey_sections (section_identifier, title, subtitle, content, image_url, order_index, metadata)
VALUES (
    'science', 
    'Learning The Mechanism.', 
    'The Science',
    'At first, the science seemed complex, and the market felt unregulated. But digging into clinical studies revealed a simple truth: these aren''t synthetic drugs forcing the body. They are signaling molecules.',
    '/assets/journey-2.png',
    3,
    '{"points": [{"title": "Quality is Key", "desc": "99% vs 99.9% purity creates a massive difference in results."}, {"title": "Protocols Matter", "desc": "Consistency and proper dosage beat random experimentation every time."}]}'::jsonb
) ON CONFLICT (section_identifier) DO NOTHING;

-- 4. Results
INSERT INTO journey_sections (section_identifier, title, subtitle, content, image_url, order_index, metadata)
VALUES (
    'results', 
    'What Changed For Me.', 
    'The Outcome',
    NULL,
    '/assets/journey-3.png',
    4,
    '{"milestones": [{"step": "1", "title": "Mental Clarity", "desc": "The afternoon crash disappeared. I could focus for longer periods without needing caffeine."}, {"step": "2", "title": "Accelerated Recovery", "desc": "Workouts that left me sore for days now felt manageable the next morning."}, {"step": "3", "title": "A New Standard", "desc": "It wasn''t about ''fixing'' anymore; it was about optimizing."}]}'::jsonb
) ON CONFLICT (section_identifier) DO NOTHING;

-- 5. Values
INSERT INTO journey_sections (section_identifier, title, subtitle, content, order_index, metadata)
VALUES (
    'values', 
    'Why Peptology Exists', 
    NULL,
    'This journey is why Peptology exists.',
    5,
    '{"cards": [{"title": "Uncompromising Quality", "desc": "If I wouldn''t use it myself, it doesn''t go on the shelf."}, {"title": "Education First", "desc": "We don''t just sell; we educate. Knowledge is power."}, {"title": "Transparency", "desc": "No hidden fillers, no vague labeling."}]}'::jsonb
) ON CONFLICT (section_identifier) DO NOTHING;

-- 6. Disclaimer
INSERT INTO journey_sections (section_identifier, title, content, order_index)
VALUES (
    'disclaimer', 
    NULL, 
    '"This is a personal experience narrative and is not intended as medical advice. Peptides should be used responsibly and under the guidance of a healthcare professional."',
    6
) ON CONFLICT (section_identifier) DO NOTHING;

-- 7. CTA
INSERT INTO journey_sections (section_identifier, title, subtitle, content, order_index)
VALUES (
    'cta', 
    'Ready to Start Your Own Journey?', 
    NULL,
    'Explore our researched-grade collection and take the first step towards optimization.',
    7
) ON CONFLICT (section_identifier) DO NOTHING;
