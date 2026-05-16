-- SQL Setup Script for GearGrid Products

-- 1. Create the 'products' table
CREATE TABLE products (
  id text PRIMARY KEY,
  name text NOT NULL,
  price numeric NOT NULL,
  image_path text NOT NULL,
  category text NOT NULL,
  description text NOT NULL
);

-- 2. Insert the mock data into the table
INSERT INTO products (id, name, price, image_path, category, description) VALUES
('m1', 'CyberClick Pro Mouse', 89.99, 'assets/images/item_mouse_1.png', 'Mice', 'Ultra-lightweight RGB gaming mouse with 20K DPI sensor for pixel-perfect precision.'),
('m2', 'Stealth Glide V2', 75.00, 'assets/images/item_mouse_2.png', 'Mice', 'Ergonomic wireless gaming mouse featuring zero latency technology and custom weights.'),
('k1', 'Neon Tap Mechanical', 149.99, 'assets/images/item_keyboard_1.png', 'Keyboards', 'TKL mechanical keyboard with hot-swappable tactile switches and per-key RGB.'),
('k2', 'HoloType Wireless', 179.99, 'assets/images/item_keyboard_2.png', 'Keyboards', 'Low-profile wireless mechanical keyboard with aluminum frame and 100-hour battery.'),
('h1', 'AeroSonic 7.1', 129.50, 'assets/images/item_headset_1.png', 'Audio', '7.1 surround sound gaming headset with noise-canceling mic and cooling gel cushions.'),
('h2', 'Void Caster Headset', 199.99, 'assets/images/item_headset_2.png', 'Audio', 'High-fidelity wireless headset with studio-grade drivers and 50ft range.'),
('c1', 'Titan Comfort Chair', 349.00, 'assets/images/item_chair_1.png', 'Chairs', 'Premium ergonomic gaming chair with lumbar support, 4D armrests, and memory foam.'),
('c2', 'Aero Mesh Throne', 299.99, 'assets/images/item_chair_2.png', 'Chairs', 'Breathable mesh back gaming chair designed for extreme marathons without the sweat.'),
('mic1', 'Studio Pod Mic', 110.00, 'assets/images/item_mic_1.png', 'Audio', 'Condenser microphone for pristine voice capture, perfect for streaming and podcasting.'),
('mp1', 'GlidePad XL', 29.99, 'assets/images/item_mousepad_1.png', 'Accessories', 'Desk-sized micro-woven cloth mousepad engineered for maximum speed and control.'),
('mon1', 'Quantum View 27"', 450.00, 'assets/images/item_monitor_1.png', 'Monitors', '27-inch 1440p 165Hz IPS gaming monitor with 1ms response time and HDR support.'),
('ctrl1', 'OmniPad Pro', 65.00, 'assets/images/item_controller_1.png', 'Accessories', 'Customizable wireless controller with rear paddles, trigger stops, and haptic feedback.');

-- 3. Set up Row Level Security (RLS) allowing everyone to read the products
ALTER TABLE products ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read access"
ON products FOR SELECT
TO public
USING (true);
