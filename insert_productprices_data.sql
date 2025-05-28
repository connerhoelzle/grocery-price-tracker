-- Delete data from ProductPrices
delete from ProductPrices;

-- Drop and create a temporary table that matches your CSV
DROP TABLE IF EXISTS temp_ProductPrices;
CREATE TEMP TABLE temp_ProductPrices (
    ProductID INTEGER NOT NULL,   -- Link to Products
    StoreID INTEGER NOT NULL,     -- Link to Stores
    Date TEXT NOT NULL,           -- ISO 8601 (YYYY-MM-DD)
    Quantity REAL NOT NULL,       -- Quantity purchased or listed (e.g., 1 for one unit)
    TotalPrice REAL NOT NULL,     -- Full price paid or listed for the quantity
    UnitPrice REAL,               -- Optional precomputed price per oz/lb/etc.
    Source TEXT NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ID),
    FOREIGN KEY (StoreID) REFERENCES Stores(ID)
);

-- Set mode to CSV and import data into the temp table
.mode csv
.headers on
.import Data/product-prices.csv temp_ProductPrices

-- Insert into the actual ProductPrices table (auto-generates ID)
INSERT INTO ProductPrices (ProductID, StoreID, Date, Quantity, TotalPrice, UnitPrice, Source)
SELECT ProductID, StoreID, Date, Quantity, TotalPrice, UnitPrice, Source
FROM temp_ProductPrices
WHERE ProductID != 'ProductID';

-- Drop the temp table to clean up
DROP TABLE temp_ProductPrices;