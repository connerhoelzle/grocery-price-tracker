-- Drop and create a temporary table that matches your CSV
DROP TABLE IF EXISTS temp_Products;
CREATE TEMP TABLE temp_Products (
    Name TEXT NOT NULL,
    Brand TEXT NOT NULL,
    UnitSize REAL NOT NULL,
    UnitType TEXT NOT NULL,
    Notes TEXT
);

-- Set mode to CSV and import data into the temp table
.mode csv
.headers on
.import Data/products.csv temp_Products

-- Insert into the actual Products table (auto-generates ID)
INSERT INTO Products (Name, Brand, UnitSize, UnitType, Notes)
SELECT Name, Brand,  UnitSize, UnitType, Notes 
FROM temp_Products
WHERE Name != 'Name';

-- Drop the temp table to clean up
DROP TABLE temp_Products;