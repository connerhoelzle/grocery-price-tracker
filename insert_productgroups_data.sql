-- Delete data from ProductGroups
delete from ProductGroups;

-- Drop and create a temporary table that matches your CSV
DROP TABLE IF EXISTS temp_ProductGroups;
CREATE TEMP TABLE temp_ProductGroups (
    Name TEXT NOT NULL,           -- e.g., "Whole Milk"
    UnitSize REAL NOT NULL,      -- e.g., 1.0
    UnitType TEXT NOT NULL       -- e.g., 'gal', 'oz', etc.
);

-- Set mode to CSV and import data into the temp table
.mode csv
.headers on
.import Data/product-groups.csv temp_ProductGroups

-- Insert into the actual ProductGroups table (auto-generates ID)
INSERT INTO ProductGroups (Name, UnitSize, UnitType)
SELECT Name, UnitSize, UnitType
FROM temp_ProductGroups
WHERE Name != 'Name';

-- Drop the temp table to clean up
DROP TABLE temp_ProductGroups;