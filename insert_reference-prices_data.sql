-- Drop and create a temporary table that matches your CSV
DROP TABLE IF EXISTS temp_ReferencePrices;
CREATE TEMP TABLE temp_ReferencePrices (
    ItemName            TEXT    NOT NULL,
    StoreID             INTEGER NOT NULL,
    UnitPrice           REAL    NOT NULL,
    Date                TEXT    NOT NULL, -- ISO 8601 'YYYY-MM-DD'
    Notes               TEXT,
    FOREIGN KEY (ItemName) REFERENCES Items(Name),
    FOREIGN KEY (StoreID)  REFERENCES Stores(ID) 
);

-- Set mode to CSV and import data into the temp table
.mode csv
.headers on
.import Data/reference-prices.csv temp_ReferencePrices

-- Insert into the actual ReferencePrices table (auto-generates ID)
INSERT INTO ReferencePrices (ItemName, StoreID, UnitPrice, Date, Notes)
SELECT ItemName, StoreID, UnitPrice, Date, Notes 
FROM temp_ReferencePrices
WHERE ItemName != 'ItemName';

-- Drop the temp table to clean up
DROP TABLE temp_ReferencePrices;
