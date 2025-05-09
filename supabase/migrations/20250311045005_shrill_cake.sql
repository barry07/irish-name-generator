/*
  # Add function to get random name

  1. New Functions
    - `get_random_name`: Returns a random name from the irish_names table
      - Uses efficient random row selection
      - Returns all columns from the selected row
*/

CREATE OR REPLACE FUNCTION get_random_name()
RETURNS TABLE (
  id uuid,
  name text,
  meaning text,
  gender text,
  created_at timestamptz
) 
LANGUAGE sql
SECURITY DEFINER
AS $$
  SELECT *
  FROM irish_names
  OFFSET floor(random() * (SELECT COUNT(*) FROM irish_names))
  LIMIT 1;
$$;