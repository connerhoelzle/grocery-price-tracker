-- Drop and create a temporary table that matches your CSV
DROP TABLE IF EXISTS temp_ProductPrices;
CREATE TEMP TABLE temp_ProductPrices (
    ProductID INTEGER,
    StoreID INTEGER NOT NULL,
    Date TEXT NOT NULL,
    Quantity REAL NOT NULL,
    TotalPrice REAL NOT NULL, 
    UnitPrice REAL,       
    Source TEXT NOT NULL,    
    Notes TEXT,
    FOREIGN KEY (ProductID) REFERENCES Products(ID),
    FOREIGN KEY (StoreID) REFERENCES Stores(ID)
);

-- Set mode to CSV and import data into the temp table
.mode csv
.headers on
.import Data/product-prices.csv temp_ProductPrices

-- Insert into the actual ProductPrices table (auto-generates ID)
INSERT INTO ProductPrices (ProductID, StoreID, Date, Quantity, TotalPrice, UnitPrice, Source, Notes)
SELECT ProductID, StoreID, Date, Quantity, TotalPrice, UnitPrice, Source, Notes
FROM temp_ProductPrices
WHERE ProductID != 'ProductID';

-- Drop the temp table to clean up
DROP TABLE temp_ProductPrices;