-- Update all products to be available and have stock
UPDATE products 
SET 
  stock_quantity = 50, 
  available = true,
  updated_at = NOW();

-- Update all variations to have stock as well
UPDATE product_variations 
SET 
  stock_quantity = 50;
