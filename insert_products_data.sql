-- Delete data from Products
delete from Products;
-- Drop and create a temporary table that matches your CSV
DROP TABLE IF EXISTS temp_Products;
CREATE TEMP TABLE temp_Products (
    Name TEXT NOT NULL,           -- Specific item name from receipt or website
    Brand TEXT,                   -- Optional store or brand name
    GroupID INTEGER NOT NULL,     -- Foreign key to ProductGroups
    FOREIGN KEY (GroupID) REFERENCES ProductGroups(ID)
);

-- Set mode to CSV and import data into the temp table
.mode csv
.headers on
.import Data/products.csv temp_Products

-- Insert into the actual Products table (auto-generates ID)
INSERT INTO Products (Name, Brand, GroupID)
SELECT Name, Brand, GroupID
FROM temp_Products
WHERE Name != 'Name';

-- Drop the temp table to clean up
DROP TABLE temp_Products;