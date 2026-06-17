create database project;
use project;

-- Creating Tables

CREATE TABLE Restaurant (
    RestaurantID INT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(100),
    ContactInfo VARCHAR(100)
);

CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Role VARCHAR(50),
    RestaurantID INT,
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);

CREATE TABLE WasteCategory (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50)
);

CREATE TABLE FoodItem (
    ItemID INT PRIMARY KEY,
    ItemName VARCHAR(100),
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES WasteCategory(CategoryID)
);

CREATE TABLE WasteLog (
    LogID INT PRIMARY KEY,
    RestaurantID INT,
    ItemID INT,
    Quantity DECIMAL(10,2),
    WasteDate DATE,
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID),
    FOREIGN KEY (ItemID) REFERENCES FoodItem(ItemID)
);

CREATE TABLE RecipientOrg (
    OrgID INT PRIMARY KEY,
    OrgName VARCHAR(100),
    ContactPerson VARCHAR(100),
    Address VARCHAR(200)
);

CREATE TABLE Donation (
    DonationID INT PRIMARY KEY,
    DonationDate DATE,
    Status VARCHAR(20),
    RestaurantID INT,
    OrgID INT,
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID),
    FOREIGN KEY (OrgID) REFERENCES RecipientOrg(OrgID)
);

CREATE TABLE WasteReductionGoal (
    GoalID INT PRIMARY KEY,
    TargetQuantity DECIMAL(10,2) NOT NULL, 
    Deadline DATE,
    Status VARCHAR(20), 
    RestaurantID INT,
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);

-- Inserting Sample Data
INSERT INTO Restaurant VALUES 
(1, 'Green Table', 'Downtown', '555-1234'),
 (2, 'Urban Eats', 'Northside', '555-5678');
  
INSERT INTO WasteCategory VALUES 
(10, 'Vegetables'), 
(20, 'Dairy'), 
(30, 'Bakery');

INSERT INTO Staff (StaffID, Name, Role, RestaurantID) VALUES 
(1, 'Ahmed Khan', 'Manager', 1),
(2, 'Sara Ali', 'Kitchen Supervisor', 1),
(3, 'John Doe', 'Inventory Clerk', 1),
(4, 'Zainab Bibi', 'Head Chef', 2),
(5, 'Usman Sheikh', 'Manager', 2),
(6, 'Fatima Noor', 'Donation Coordinator', 2),
(7, 'Robert Smith', 'Staff Assistant', 1),
(8, 'Maria Garcia', 'Kitchen Supervisor', 2),
(9, 'Ali Raza', 'Inventory Clerk', 2),
(10, 'Hamza Malik', 'Head Chef', 1);

INSERT INTO FoodItem VALUES 
(101, 'Spinach', 10), 
(102, 'Milk', 20), 
(103, 'Bread', 30), 
(104, 'Carrots', 10);

INSERT INTO WasteLog VALUES 
(1, 1, 101, 5.2, '2026-05-01'), 
(2, 1, 103, 2.0, '2026-05-02'),
(3, 2, 102, 10.5, '2026-05-03'), 
(4, 2, 104, 3.1, '2026-05-04'),
(5, 1, 101, 1.5, '2026-05-05');

INSERT INTO RecipientOrg VALUES 
(50, 'Food For All', 'Alice', '123 Hope St'), 
(51, 'Community Kitchen', 'Bob', '456 Care Ln');

INSERT INTO Donation VALUES 
(1, '2026-05-02', 'Completed', 1, 50), 
(2, '2026-05-04', 'Pending', 2, 51);

INSERT INTO WasteReductionGoal (GoalID, TargetQuantity, Deadline, Status, RestaurantID) VALUES 
(501, 50.00, '2026-06-30', 'In Progress', 1),
(502, 30.00, '2026-05-15', 'Achieved', 1),
(503, 100.00, '2026-12-31', 'In Progress', 2),
(504, 25.00, '2026-04-01', 'Achieved', 2),
(505, 40.00, '2026-07-20', 'In Progress', 1),
(506, 15.00, '2026-03-10', 'Failed', 2),
(507, 60.00, '2026-08-15', 'In Progress', 2),
(508, 20.00, '2026-05-01', 'Achieved', 1),
(509, 80.00, '2026-11-30', 'In Progress', 1),
(510, 10.00, '2026-02-28', 'Achieved', 2);

SELECT * FROM WasteLog WHERE Quantity > 5.0;
SELECT * FROM WasteLog ORDER BY WasteDate DESC;
SELECT DISTINCT Location FROM Restaurant;
SELECT COUNT(*) AS TotalLogs FROM WasteLog;
SELECT * FROM FoodItem WHERE ItemName LIKE 'S%';
SELECT * FROM Staff ORDER BY Role;
SELECT Name, RestaurantID FROM Staff WHERE Role = 'Manager';

-- using where and order by clause
SELECT * FROM WasteLog 
WHERE Quantity > 10.0 
ORDER BY Quantity DESC;

SELECT FoodItem.ItemName, WasteCategory.CategoryName
FROM FoodItem 
JOIN WasteCategory ON FoodItem.CategoryID = WasteCategory.CategoryID 
WHERE WasteCategory.CategoryName = 'Bakery';

SELECT DonationID, DonationDate, RestaurantID, OrgID 
FROM Donation 
WHERE Status = 'Pending';

SELECT DonationID, DonationDate, RestaurantID, OrgID 
FROM Donation 
WHERE Status = 'Pending';

SELECT RestaurantID, TargetQuantity, Deadline, Status 
FROM WasteReductionGoal 
ORDER BY TargetQuantity DESC;

SELECT LogID, ItemID, Quantity, WasteDate 
FROM WasteLog 
WHERE RestaurantID = 1 
ORDER BY WasteDate ASC;

SELECT * FROM Donation 
WHERE Status = 'Completed' 
ORDER BY DonationDate DESC;

-- inner join
SELECT Staff.Name, Restaurant.Name 
FROM Staff 
INNER JOIN Restaurant 
ON Staff.RestaurantID = Restaurant.RestaurantID;

SELECT FoodItem.ItemName, WasteCategory.CategoryName 
FROM FoodItem 
INNER JOIN WasteCategory 
ON FoodItem.CategoryID = WasteCategory.CategoryID;

SELECT FoodItem.ItemName, WasteCategory.CategoryName 
FROM FoodItem 
INNER JOIN WasteCategory 
ON FoodItem.CategoryID = WasteCategory.CategoryID;

SELECT Donation.DonationID, RecipientOrg.OrgName 
FROM Donation 
INNER JOIN RecipientOrg 
ON Donation.OrgID = RecipientOrg.OrgID;

SELECT Restaurant.Name, WasteReductionGoal.TargetQuantity 
FROM Restaurant 
INNER JOIN WasteReductionGoal 
ON Restaurant.RestaurantID = WasteReductionGoal.RestaurantID;

-- natutral join 
SELECT * 
FROM Restaurant 
NATURAL JOIN Staff;

SELECT ItemName, CategoryName 
FROM FoodItem 
NATURAL JOIN WasteCategory;

SELECT LogID, ItemName 
FROM WasteLog 
NATURAL JOIN FoodItem; 

SELECT DonationID, Name 
FROM Donation 
NATURAL JOIN Restaurant;

SELECT GoalID, Name 
FROM WasteReductionGoal 
NATURAL JOIN Restaurant;

-- left join 
SELECT Restaurant.Name, Staff.Name 
FROM Restaurant 
LEFT JOIN Staff 
ON Restaurant.RestaurantID = Staff.RestaurantID;

SELECT WasteCategory.CategoryName, FoodItem.ItemName 
FROM WasteCategory 
LEFT JOIN FoodItem 
ON WasteCategory.CategoryID = FoodItem.CategoryID;

SELECT FoodItem.ItemName, WasteLog.Quantity 
FROM FoodItem 
LEFT JOIN WasteLog 
ON FoodItem.ItemID = WasteLog.ItemID;

SELECT RecipientOrg.OrgName, Donation.DonationID 
FROM RecipientOrg 
LEFT JOIN Donation 
ON RecipientOrg.OrgID = Donation.OrgID;

SELECT Restaurant.Name, WasteReductionGoal.Status 
FROM Restaurant 
LEFT JOIN WasteReductionGoal 
ON Restaurant.RestaurantID = WasteReductionGoal.RestaurantID;

-- right join 
SELECT Staff.Name, Restaurant.Name 
FROM Restaurant 
RIGHT JOIN Staff 
ON Restaurant.RestaurantID = Staff.RestaurantID;

SELECT WasteLog.LogID, Restaurant.Name 
FROM Restaurant 
RIGHT JOIN WasteLog 
ON Restaurant.RestaurantID = WasteLog.RestaurantID;

SELECT Donation.DonationID, Restaurant.Name 
FROM Restaurant 
RIGHT JOIN Donation 
ON Restaurant.RestaurantID = Donation.RestaurantID;

SELECT FoodItem.ItemName, WasteCategory.CategoryName 
FROM WasteCategory 
RIGHT JOIN FoodItem 
ON WasteCategory.CategoryID = FoodItem.CategoryID;

SELECT WasteReductionGoal.GoalID, Restaurant.Name 
FROM Restaurant 
RIGHT JOIN WasteReductionGoal 
ON Restaurant.RestaurantID = WasteReductionGoal.RestaurantID;

-- full join 
SELECT Restaurant.Name, Staff.Name 
FROM Restaurant 
LEFT JOIN Staff 
ON Restaurant.RestaurantID = Staff.RestaurantID
UNION
SELECT Restaurant.Name, Staff.Name 
FROM Restaurant 
RIGHT JOIN Staff 
ON Restaurant.RestaurantID = Staff.RestaurantID;

SELECT WasteCategory.CategoryName, FoodItem.ItemName 
FROM WasteCategory 
LEFT JOIN FoodItem 
ON WasteCategory.CategoryID = FoodItem.CategoryID
UNION
SELECT WasteCategory.CategoryName, FoodItem.ItemName 
FROM WasteCategory 
RIGHT JOIN FoodItem 
ON WasteCategory.CategoryID = FoodItem.CategoryID;

SELECT Donation.DonationID, RecipientOrg.OrgName 
FROM Donation 
LEFT JOIN RecipientOrg 
ON Donation.OrgID = RecipientOrg.OrgID
UNION
SELECT Donation.DonationID, RecipientOrg.OrgName 
FROM Donation 
RIGHT JOIN RecipientOrg 
ON Donation.OrgID = RecipientOrg.OrgID;

SELECT WasteLog.LogID, FoodItem.ItemName 
FROM WasteLog 
LEFT JOIN FoodItem 
ON WasteLog.ItemID = FoodItem.ItemID
UNION
SELECT WasteLog.LogID, FoodItem.ItemName 
FROM WasteLog 
RIGHT JOIN FoodItem 
ON WasteLog.ItemID = FoodItem.ItemID;

SELECT Restaurant.Name, WasteReductionGoal.Status 
FROM Restaurant 
LEFT JOIN WasteReductionGoal 
ON Restaurant.RestaurantID = WasteReductionGoal.RestaurantID
UNION
SELECT Restaurant.Name, WasteReductionGoal.Status 
FROM Restaurant 
RIGHT JOIN WasteReductionGoal 
ON Restaurant.RestaurantID = WasteReductionGoal.RestaurantID;

-- cartesian join
SELECT Staff.Name, RecipientOrg.OrgName 
FROM Staff 
CROSS JOIN RecipientOrg;

SELECT Restaurant.Name, FoodItem.ItemName 
FROM Restaurant 
CROSS JOIN FoodItem;

SELECT WasteCategory.CategoryName, RecipientOrg.OrgName 
FROM WasteCategory 
CROSS JOIN RecipientOrg;

SELECT Restaurant.Name, WasteReductionGoal.GoalID 
FROM Restaurant 
CROSS JOIN WasteReductionGoal;

SELECT FoodItem.ItemName, Donation.Status 
FROM FoodItem 
CROSS JOIN Donation;

-- Non-Correlated Subqueries
SELECT ItemName 
FROM FoodItem 
WHERE CategoryID IN (
    SELECT CategoryID 
    FROM WasteCategory 
    WHERE CategoryName = 'Bakery'
);

SELECT Name, Location 
FROM Restaurant 
WHERE RestaurantID IN (
    SELECT DISTINCT RestaurantID 
    FROM WasteLog 
    WHERE Quantity > 15.0
);

SELECT OrgName, ContactPerson 
FROM RecipientOrg 
WHERE OrgID IN (
    SELECT DISTINCT OrgID 
    FROM Donation 
    WHERE Status = 'Completed'
);

SELECT Name, Role 
FROM Staff 
WHERE RestaurantID IN (
    SELECT RestaurantID 
    FROM Restaurant 
    WHERE Location = 'Downtown'
);

SELECT LogID, Quantity, WasteDate 
FROM WasteLog 
WHERE ItemID IN (
    SELECT ItemID 
    FROM FoodItem 
    WHERE CategoryID = 10
);

-- Correlated Subqueries
SELECT S1.Name, S1.Role, S1.RestaurantID 
FROM Staff S1
WHERE S1.StaffID > (
    SELECT AVG(S2.StaffID) 
    FROM Staff S2 
    WHERE S2.RestaurantID = S1.RestaurantID
);

SELECT W1.LogID, W1.RestaurantID, W1.Quantity 
FROM WasteLog W1
WHERE W1.Quantity > (
    SELECT AVG(W2.Quantity) 
    FROM WasteLog W2 
    WHERE W2.RestaurantID = W1.RestaurantID
);

SELECT R.Name 
FROM Restaurant R
WHERE EXISTS (
    SELECT 1 
    FROM WasteReductionGoal G 
    WHERE G.RestaurantID = R.RestaurantID 
      AND G.TargetQuantity > (
          SELECT AVG(Quantity) 
          FROM WasteLog W 
          WHERE W.RestaurantID = R.RestaurantID
      )
);

SELECT O.OrgName 
FROM RecipientOrg O
JOIN Donation D1 ON O.OrgID = D1.OrgID
WHERE D1.DonationDate = (
    SELECT MAX(D2.DonationDate) 
    FROM Donation D2 
    WHERE D2.RestaurantID = D1.RestaurantID
);

-- Queries Using Aggregate Functions
SELECT SUM(Quantity) AS TotalWaste_KG 
FROM WasteLog;

SELECT AVG(TargetQuantity) AS AverageGoalTarget 
FROM WasteReductionGoal;

SELECT MAX(Quantity) AS HighestSingleWasteLog 
FROM WasteLog;

SELECT MIN(DonationDate) AS FirstDonationDate 
FROM Donation;

SELECT COUNT(StaffID) AS TotalEmployees 
FROM Staff;

-- Queries Using GROUP BY with HAVING
SELECT RestaurantID, SUM(Quantity) AS TotalWaste
FROM WasteLog
GROUP BY RestaurantID
HAVING SUM(Quantity) > 20.0;

SELECT ItemID, COUNT(LogID) AS TimesWasted
FROM WasteLog
GROUP BY ItemID
HAVING COUNT(LogID) > 3;

SELECT RestaurantID, COUNT(StaffID) AS StaffCount
FROM Staff
GROUP BY RestaurantID
HAVING COUNT(StaffID) > 5;

SELECT F.CategoryID, AVG(W.Quantity) AS AvgWaste
FROM WasteLog W
JOIN FoodItem F ON W.ItemID = F.ItemID
GROUP BY F.CategoryID
HAVING AVG(W.Quantity) < 5.0;

SELECT OrgID, COUNT(DonationID) AS PendingCount
FROM Donation
WHERE Status = 'Pending'
GROUP BY OrgID
HAVING COUNT(DonationID) > 2;

-- Queries Using VIEWS
CREATE VIEW DailyWasteSummary AS
SELECT RestaurantID, ItemID, Quantity, WasteDate 
FROM WasteLog;
SELECT * FROM DailyWasteSummary;

CREATE VIEW ActiveGoals AS
SELECT GoalID, RestaurantID, TargetQuantity, Deadline 
FROM WasteReductionGoal 
WHERE Status = 'In Progress';
SELECT * FROM ActiveGoals;

CREATE VIEW StaffDirectory AS
SELECT S.Name AS EmployeeName, S.Role, R.Name AS RestaurantName 
FROM Staff S
JOIN Restaurant R ON S.RestaurantID = R.RestaurantID;
SELECT * FROM StaffDirectory;

CREATE VIEW UrgentDonations AS
SELECT DonationID, DonationDate, RestaurantID, OrgID 
FROM Donation 
WHERE Status = 'Pending';
SELECT * FROM UrgentDonations;

CREATE VIEW CategorizedItems AS
SELECT F.ItemID, F.ItemName, C.CategoryName AS CategoryN 
FROM FoodItem F
JOIN WasteCategory C ON F.CategoryID = C.CategoryID;
SELECT * FROM CategorizedItems;

-- FUNCTIONS
CALL display_location(1);
CALL display_restaurant_contact(1);
CALL display_staff_role(4);
CALL display_food_name(102);
CALL display_org_address(50);