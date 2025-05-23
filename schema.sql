CREATE TABLE Stores (
    ID                  INTEGER PRIMARY KEY,
    Name                TEXT    NOT NULL,
    Location            TEXT    NOT NULL
)
;

CREATE TABLE Receipts (
    ID                  INTEGER PRIMARY KEY,
    StoreID             INTEGER NOT NULL,
    TripDateTime        TEXT    NOT NULL -- ISO 8601: 'YYYY-MM-DDTHH:MM:SS',
    Notes               TEXT,
    FOREIGN KEY (StoreID) REFERENCES Stores(ID)
)
;

CREATE TABLE Items (
    ID                  INTEGER PRIMARY KEY,
    ReceiptID           INTEGER NOT NULL,  
    Name                TEXT    NOT NULL,
    Quantity            REAL    NOT NULL,
    OriginalUnitPrice   REAL    NOT NULL,
    DiscountedUnitPrice REAL    NOT NULL,
    PricePaid           REAL    NOT NULL,
    Notes               TEXT,
    FOREIGN KEY (ReceiptID) REFERENCES Receipts(ID)
)
;

CREATE TABLE ReferencePrices (
    ID                  INTEGER PRIMARY KEY,
    ItemName            TEXT    NOT NULL,
    StoreID             INTEGER NOT NULL,
    UnitPrice           REAL    NOT NULL,
    Date                TEXT    NOT NULL, -- ISO 8601 'YYYY-MM-DD'
    Notes               TEXT,
    FOREIGN KEY (ItemName) REFERENCES Items(Name),
    FOREIGN KEY (StoreID)  REFERENCES Stores(ID) 
)
;