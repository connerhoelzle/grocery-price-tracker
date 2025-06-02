drop table if exists Stores;
drop table if exists Products;
drop table if exists ProductPrices;
drop table if exists ProductGroups;
drop view if exists AveragePriceByStore;


-- Stores table
CREATE TABLE Stores (
    ID INTEGER PRIMARY KEY,
    Name TEXT NOT NULL,
    Location TEXT NOT NULL
);

-- ProductGroups table (normalized comparison unit)
CREATE TABLE ProductGroups (
    ID INTEGER PRIMARY KEY,
    Name TEXT NOT NULL,           -- e.g., "Whole Milk"
    UnitSize REAL NOT NULL,      -- e.g., 1.0
    UnitType TEXT NOT NULL       -- e.g., 'gal', 'oz', etc.
);

-- Products table (store-specific instances of a product group)
CREATE TABLE Products (
    ID INTEGER PRIMARY KEY,
    Name TEXT NOT NULL,           -- Specific item name from receipt or website
    Brand TEXT,                   -- Optional store or brand name
    GroupID INTEGER NOT NULL,     -- Foreign key to ProductGroups
    FOREIGN KEY (GroupID) REFERENCES ProductGroups(ID)
);

-- ProductPrices table (each observation of a product's price)
CREATE TABLE ProductPrices (
    ID INTEGER PRIMARY KEY,
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

CREATE VIEW AveragePriceByStore AS 
SELECT s.Name AS Store, pg.Name AS Product, PRINTF("%.2f", ROUND(AVG(pp.TotalPrice), 2)) AS AveragePrice
FROM ProductGroups pg
JOIN Products p ON pg.ID=p.GroupID
JOIN ProductPrices pp ON p.ID=pp.ProductID
JOIN Stores s ON pp.StoreID=s.ID
GROUP BY pg.Name, s.Name
