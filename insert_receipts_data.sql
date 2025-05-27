-- Drop and create a temporary table that matches your CSV
DROP TABLE IF EXISTS temp_Receipts;
CREATE TEMP TABLE temp_Receipts (
    StoreID     INTEGER     NOT NULL,
    TripDateTime    TEXT    NOT NULL,
    Notes           TEXT,
    FOREIGN KEY (StoreID) REFERENCES Stores(ID)
);

-- Set mode to CSV and import data into the temp table
.mode csv
.headers on
.import Data/receipts.csv temp_Receipts

-- Insert into the actual Receipts table (auto-generates ID)
INSERT INTO Receipts (StoreID, TripDateTime, Notes)
SELECT StoreID, TripDateTime, Notes 
FROM temp_Receipts
WHERE StoreID != 'StoreID';

-- Drop the temp table to clean up
DROP TABLE temp_Receipts;
