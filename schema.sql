drop table if exists Stores;
drop table if exists Products;
drop table if exists ProductPrices;


-- Stores table
CREATE TABLE Stores (
    ID INTEGER PRIMARY KEY,
    Name TEXT NOT NULL,
    Location TEXT NOT NULL
);

-- Products table (normalized product catalog)
CREATE TABLE Products (
    ID INTEGER PRIMARY KEY,
    Name TEXT NOT NULL,           -- General product name (e.g., "Black Beans (store brand)")
    UnitSize REAL NOT NULL,       -- Numeric size of the unit (e.g., 15 for 15oz)
    UnitType TEXT NOT NULL,       -- Unit type (e.g., 'oz', 'lb', 'ct')
    Notes TEXT                    -- Optional notes (e.g., "no salt", "organic")
);

-- ProductPrices table (combined receipts and web scrapes)
CREATE TABLE ProductPrices (
    ID INTEGER PRIMARY KEY,
    ProductID INTEGER,   -- Foreign key to Products.ID
    StoreID INTEGER NOT NULL,     -- Foreign key to Stores.ID
    Date TEXT NOT NULL,           -- ISO 8601 format (YYYY-MM-DD)
    Quantity REAL NOT NULL,       -- Quantity purchased or observed (e.g., 1, 0.5, 2)
    TotalPrice REAL NOT NULL,     -- Total price for the quantity
    UnitPrice REAL,               -- Optional: listed or calculated price per unit
    Source TEXT NOT NULL,         -- 'receipt', 'web', etc.
    Notes TEXT,                   -- Optional notes
    FOREIGN KEY (ProductID) REFERENCES Products(ID),
    FOREIGN KEY (StoreID) REFERENCES Stores(ID)
);