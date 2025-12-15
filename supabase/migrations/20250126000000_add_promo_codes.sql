-- Create promo_codes table
CREATE TABLE IF NOT EXISTS promo_codes (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  code TEXT NOT NULL UNIQUE,
  description TEXT,
  discount_type TEXT NOT NULL CHECK (discount_type IN ('percentage', 'fixed')),
  discount_value NUMERIC NOT NULL CHECK (discount_value >= 0),
  min_spend NUMERIC DEFAULT 0 CHECK (min_spend >= 0),
  usage_limit INTEGER DEFAULT NULL CHECK (usage_limit IS NULL OR usage_limit > 0),
  usage_count INTEGER DEFAULT 0 CHECK (usage_count >= 0),
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Enable RLS
ALTER TABLE promo_codes ENABLE ROW LEVEL SECURITY;

-- Create policies for promo_codes
CREATE POLICY "Allow public read access to active promo_codes" ON promo_codes
  FOR SELECT USING (is_active = true);

CREATE POLICY "Allow admin full access to promo_codes" ON promo_codes
  FOR ALL USING (true) WITH CHECK (true);

-- Add promo columns to orders table
ALTER TABLE orders 
ADD COLUMN IF NOT EXISTS promo_code_id UUID REFERENCES promo_codes(id),
ADD COLUMN IF NOT EXISTS discount_amount NUMERIC DEFAULT 0;

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS idx_promo_codes_code ON promo_codes(code);
CREATE INDEX IF NOT EXISTS idx_orders_promo_code_id ON orders(promo_code_id);
