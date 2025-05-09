/*
  # Create Irish Names Table

  1. New Tables
    - `irish_names`
      - `id` (uuid, primary key)
      - `name` (text, unique)
      - `meaning` (text)
      - `gender` (text)
      - `created_at` (timestamp)

  2. Security
    - Enable RLS on `irish_names` table
    - Add policy for public read access
    - Add policy for authenticated users to manage names
*/

CREATE TABLE IF NOT EXISTS irish_names (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text UNIQUE NOT NULL,
  meaning text NOT NULL,
  gender text NOT NULL CHECK (gender IN ('boy', 'girl')),
  created_at timestamptz DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE irish_names ENABLE ROW LEVEL SECURITY;

-- Allow public read access
CREATE POLICY "Allow public read access"
  ON irish_names
  FOR SELECT
  TO public
  USING (true);

-- Allow authenticated users to manage names
CREATE POLICY "Allow authenticated users to manage names"
  ON irish_names
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Insert existing names
INSERT INTO irish_names (name, meaning, gender) VALUES
  INSERT INTO irish_names (name, meaning, gender) VALUES
('Aisling', 'Dream or vision', 'girl'),
('Áine', 'Brightness or splendor', 'girl'),
('Aodh', 'Fire', 'boy'),
('Ailbhe', 'White, noble, bright', 'girl'),
('Bláthnaid', 'Little flower', 'girl'),
('Bríd', 'Strength or exalted one', 'girl'),
('Branna', 'Raven', 'girl'),
('Brennan', 'Descendant of Braonán', 'boy'),
('Brian', 'Noble, strong', 'boy'),
('Bran', 'Raven', 'boy'),
('Cathal', 'Battle mighty', 'boy'),
('Caoilfhionn', 'Slender and fair', 'girl'),
('Cillian', 'Little church', 'boy'),
('Clodagh', 'Named after the River Clodagh', 'girl'),
('Colm', 'Dove', 'boy'),
('Cormac', 'Son of the charioteer', 'boy'),
('Daire', 'Fertile or fruitful', 'boy'),
('Dara', 'Oak tree', 'boy'),
('Dearbhla', 'True desire', 'girl'),
('Deirdre', 'Sorrowful or broken-hearted', 'girl'),
('Donal', 'World ruler', 'boy'),
('Donnacha', 'Brown-haired warrior', 'boy'),
('Eabha', 'Life', 'girl'),
('Eilis', 'Pledged to God', 'girl'),
('Eithne', 'Kernel or grain', 'girl'),
('Ériu', 'Ireland, from the goddess Ériu', 'girl'),
('Éabha', 'Life', 'girl'),
('Eoghan', 'Born of the yew tree', 'boy'),
('Fiachra', 'Raven', 'boy'),
('Fionnuala', 'Fair-shouldered', 'girl'),
('Gráinne', 'Love', 'girl'),
('Iarlaith', 'Prince or noble lord', 'boy'),
('Íde', 'Thirst or teacher', 'girl'),
('Labhrás', 'Laurelled', 'boy'),
('Laoghaire', 'Calf herder', 'boy'),
('Lorcan', 'Little fierce one', 'boy'),
('Lugh', 'Light or brightness', 'boy'),
('Maeve', 'Intoxicating', 'girl'),
('Maebh', 'She who intoxicates', 'girl'),
('Malachy', 'Messenger or angel', 'boy'),
('Máiréad', 'Pearl', 'girl'),
('Mairtín', 'Warlike', 'boy'),
('Muirenn', 'Sea-born', 'girl'),
('Muiris', 'Sea warrior', 'boy'),
('Naoise', 'Warrior in legend', 'boy'),
('Nessa', 'Ambitious, violent', 'girl'),
('Neasa', 'Not gentle', 'girl'),
('Nollaig', 'Christmas', 'unisex'),
('Órla', 'Golden princess', 'girl'),
('Pádraig', 'Noble', 'boy'),
('Rónán', 'Little seal', 'boy'),
('Ruairí', 'Red king', 'boy'),
('Ruarc', 'Mighty and red', 'boy'),
('Sadhbh', 'Sweet and goodly', 'girl'),
('Séamus', 'Supplanter', 'boy'),
('Senan', 'Little wise one', 'boy'),
('Shay', 'Stately or hawk-like', 'boy'),
('Sile', 'Heavenly', 'girl'),
('Sorcha', 'Bright, radiant', 'girl'),
('Tadhg', 'Poet or philosopher', 'boy'),
('Turlough', 'Abettor or assistant', 'boy'),
('Una', 'Lamb', 'girl'),
('Ultan', 'From Ulster', 'boy'),
('Ailis', 'Noble', 'girl'),
('Aodan', 'Little fire', 'boy'),
('Aoibheann', 'Pleasant, beautiful sheen', 'girl'),
('Beibhinn', 'Melodious woman', 'girl'),
('Berach', 'Sharp', 'boy'),
('Branán', 'Little raven', 'boy'),
('Caelan', 'Slender', 'boy'),
('Caoilte', 'Slender', 'boy'),
('Ciarán', 'Little dark one', 'boy'),
('Clíodhna', 'Shapely', 'girl'),
('Colleen', 'Girl', 'girl'),
('Conall', 'Strong wolf', 'boy'),
('Conchúr', 'Lover of hounds', 'boy'),
('Dervla', 'Daughter of a poet', 'girl'),
('Diarmuid', 'Without enemy', 'boy'),
('Dubhán', 'Little dark one', 'boy'),
('Éanna', 'Bird-like, freedom', 'boy'),
('Éibhir', 'Swift', 'girl'),
('Eochaidh', 'Horseman', 'boy'),
('Fergal', 'Brave, courageous', 'boy'),
('Fionán', 'Little fair one', 'boy'),
('Fódhla', 'Ancient name for Ireland', 'girl'),
('Gearóid', 'Spear strength', 'boy'),
('Grádaigh', 'Noble', 'boy'),
('Iseult', 'Fair lady', 'girl'),
('Keela', 'Beautiful', 'girl'),
('Labhaoise', 'Warrior', 'girl'),
('Laoise', 'Radiant girl', 'girl'),
('Liadan', 'Grey lady', 'girl'),
('Lorcán', 'Little fierce one', 'boy'),
('Mallaidh', 'Pearl', 'girl'),
('Muireann', 'Sea white or fair', 'girl'),
('Niam', 'Bright', 'girl'),
('Odrán', 'Little pale green one', 'boy'),
('Peadar', 'Rock', 'boy'),
('Raghnall', 'Wise power', 'boy'),
('Ríona', 'Queenly', 'girl'),
('Saorla', 'Free princess', 'girl'),
('Seosamh', 'God increases', 'boy'),
('Sibeal', 'Prophetess', 'girl'),
('Sláine', 'Health', 'girl'),
('Téarlach', 'Strong man', 'boy'),
('Treasa', 'Strength', 'girl'),
('Tuathal', 'Ruler of the people', 'boy')
ON CONFLICT (name) DO NOTHING;