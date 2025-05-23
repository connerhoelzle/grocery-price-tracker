-- Create the stores table

CREATE TABLE Stores (
	ID			INTEGER		PRIMARY KEY,
	Name			TEXT		NOT NULL,
	LOCATION		TEXT		NOT NULL
);

-- Create the receipts table

CREATE TABLE Receipts (
	ID			INTEGER		PRIMARY KEY,
	StoreID			INTEGER		NOT NULL,
	TripDateTime		TEXT		NOT NULL, -- use ISO 8601
	Notes			TEXT,	-- optional
	FOREIGN KEY (StoreID) REFERENCES Stores(ID)
);

-- grCreate the Items table

CREATE TABLE Items (
	ID			INTEGER		PRIMARY KEY,
	ReceiptID		INTEGER		NOT NULL,
	Name			TEXT		NOT NULL,
	OriginalPrice		REAL		NOT NULL,
	DiscountedPrice		REAL		NOT NULL,
	TruePrice		REAL, -- optional, can be calculated during analysis
	Category		TEXT, -- optional
	Notes			TEXT, -- optional
	FOREIGN KEY (ReceiptID) REFERENCES Receipts(ID)
);		     