-- Drop and create a temporary table that matches your CSV
DROP TABLE IF EXISTS temp_Stores;
CREATE TEMP TABLE temp_Stores (
    Name TEXT NOT NULL,
    Location TEXT NOT NULL
);

-- Set mode to CSV and import data into the temp table
.mode csv
.headers on
.import Data/stores.csv temp_Stores

-- Insert into the actual Stores table (auto-generates ID)
INSERT INTO Stores (Name, Location)
SELECT Name, Location 
FROM temp_Stores
WHERE Name != 'Name';

-- Drop the temp table to clean up
DROP TABLE temp_Stores;
