-- ============================================
-- SMART GUIDE SYSTEM SCHEMA
-- ============================================

-- 1. Create guide-files bucket with public policies
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'guide-files',
  'guide-files',
  true,
  52428800, -- 50MB
  ARRAY[
    'image/jpeg', 'image/png', 'image/webp', 'image/gif', 'image/svg+xml',
    'application/pdf', 'application/msword',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'text/plain', 'text/csv'
  ]
) ON CONFLICT (id) DO UPDATE
SET 
  public = true,
  file_size_limit = 52428800;

-- Policies for storage
DROP POLICY IF EXISTS "Public read access for guide files" ON storage.objects;
CREATE POLICY "Public read access for guide files" ON storage.objects FOR SELECT TO public USING (bucket_id = 'guide-files');

DROP POLICY IF EXISTS "Anyone can upload guide files" ON storage.objects;
CREATE POLICY "Anyone can upload guide files" ON storage.objects FOR INSERT TO public WITH CHECK (bucket_id = 'guide-files');

DROP POLICY IF EXISTS "Anyone can update guide files" ON storage.objects;
CREATE POLICY "Anyone can update guide files" ON storage.objects FOR UPDATE TO public USING (bucket_id = 'guide-files');

DROP POLICY IF EXISTS "Anyone can delete guide files" ON storage.objects;
CREATE POLICY "Anyone can delete guide files" ON storage.objects FOR DELETE TO public USING (bucket_id = 'guide-files');

-- 2. Create Tables
CREATE TABLE IF NOT EXISTS public.smart_guides (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    title TEXT NOT NULL,
    is_active BOOLEAN DEFAULT true,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.smart_guide_files (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    guide_id UUID REFERENCES public.smart_guides(id) ON DELETE CASCADE,
    display_name TEXT NOT NULL,
    file_url TEXT NOT NULL,
    file_type TEXT NOT NULL,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Table Policies (Public Read, Public Write)
ALTER TABLE public.smart_guides ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.smart_guide_files ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Public Read Guides" ON public.smart_guides;
CREATE POLICY "Public Read Guides" ON public.smart_guides FOR SELECT USING (true);

DROP POLICY IF EXISTS "Public Write Guides" ON public.smart_guides;
CREATE POLICY "Public Write Guides" ON public.smart_guides FOR ALL USING (true);

DROP POLICY IF EXISTS "Public Read Guide Files" ON public.smart_guide_files;
CREATE POLICY "Public Read Guide Files" ON public.smart_guide_files FOR SELECT USING (true);

DROP POLICY IF EXISTS "Public Write Guide Files" ON public.smart_guide_files;
CREATE POLICY "Public Write Guide Files" ON public.smart_guide_files FOR ALL USING (true);

-- Enable Realtime
alter publication supabase_realtime add table smart_guides;
alter publication supabase_realtime add table smart_guide_files;
