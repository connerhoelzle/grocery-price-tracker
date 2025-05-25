INSERT INTO Receipts(StoreID, TripDateTime)
VALUES
    (1, '2025-05-22T20:17:18'),
    (2, '2025-0522T16:50:00')
;

INSERT INTO Items(ReceiptID, Name, Quantity, OriginalUnitPrice, PricePaid, Notes)
VALUES
    (1, '6oz Shredded Parmesan Cheese', 1, 2.24, 2.24, 'Great Value'),
    (2, 'Jeans', 2, 20.00, 20.00, 'Goodfellow & Co.'),
    (2, 'Baking Soda', 1, 0.99, 0.99, 'Good & Gather'),
    (2, 'Eucerin', 1, 12.99, 12.99, 'Eczema Cream'),
    (2, 'Toilet Paper', 1, 7.99, 7.99, 'Charmin Strong')
;