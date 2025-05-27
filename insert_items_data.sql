-- Drop and create a temporary table that matches your CSV
DROP TABLE IF EXISTS temp_Items;
CREATE TEMP TABLE temp_Items (
    ReceiptID   INTEGER     NOT NULL,
    Name        TEXT        NOT NULL,
    Quantity    REAL        NOT NULL,
    OriginalUnitPrice   REAL    NOT NULL,
    DiscountedUnitPrice REAL,
    PricePaid           REAL   NOT NULL,
    Notes               TEXT,
    FOREIGN KEY (ReceiptID) REFERENCES Receipts(ID)
);

-- Set mode to CSV and import data into the temp table
.mode csv
.headers on
.import Data/items.csv temp_Items

-- Insert into the actual Items table (auto-generates ID)
INSERT INTO Items (ReceiptID, Name, Quantity, OriginalUnitPrice, DiscountedUnitPrice, PricePaid, Notes)
SELECT ReceiptID, Name, Quantity, OriginalUnitPrice, DiscountedUnitPrice, PricePaid, Notes 
FROM temp_Items
WHERE ReceiptID != 'ReceiptID';

-- Drop the temp table to clean up
DROP TABLE temp_Items;
