DROP DATABASE Hotel;

CREATE DATABASE IF NOT EXISTS Hotel;

USE Hotel;

-- Creating the Tables In the database

CREATE TABLE IF NOT EXISTS `Type`(
	TypeID INT PRIMARY KEY AUTO_INCREMENT,
    `Name` VARCHAR(20) NOT NULL,
	Price DECIMAL(5,2) NOT NULL,
    PriceExtraPerson DECIMAL(4,2) NULL,
    StandardOccupancy INT NOT NULL,
    MaxOccupancy INT NOT NULL
);


CREATE TABLE IF NOT EXISTS Amenities(
	AmenitiesID INT PRIMARY KEY AUTO_INCREMENT,
    `Name` VARCHAR(20)	NOT NULL,
    Price DECIMAL(4,2) NULL
);

CREATE TABLE IF	NOT EXISTS Room(
	RoomNumber INT PRIMARY KEY,
    -- ForeignKEY
    TypeID INT NOT NULL,
    ADAAccessible BOOL NOT NULL,
    
    FOREIGN KEY fk_room_type (TypeID)
		REFERENCES `Type`(TypeID)
	

);

CREATE TABLE IF NOT EXISTS RoomAmenities(
-- Join Table
	RoomNumber INT NOT NULL,
    AmenitiesID INT NOT NULL,
    -- Composite Primary Key
    PRIMARY KEY pk_roomamenities (RoomNumber, AmenitiesID),
    
    FOREIGN KEY fk_roomamenities_room (RoomNumber)
		REFERENCES Room(RoomNumber),
        
	FOREIGN KEY fk_roomamenities_amenities (AmenitiesID)
		REFERENCES Amenities(AmenitiesID)
);

CREATE TABLE IF NOT EXISTS City(
	ZipCode VARCHAR(5) PRIMARY KEY,
    City VARCHAR(20) NOT NULL,
    State VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS Guest(
	GuestID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(15) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    Address VARCHAR(50) NOT NULL,
    -- FOREIGN KEY
    ZipCode VARCHAR(5) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    
    FOREIGN KEY fk_guest_city (ZipCode)
		REFERENCES City(ZipCode)
);

CREATE TABLE IF NOT EXISTS Reservation(
	ReservationID INT PRIMARY KEY AUTO_INCREMENT,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    -- Foreign Key
    GuestID INT NOT NULL,
    
    FOREIGN KEY fk_reservation_guest (GuestID)
		REFERENCES Guest(GuestID)
);

CREATE TABLE IF NOT EXISTS RoomReservation(
-- Join Table
	RoomNumber INT NOT NULL,
    ReservationID INT NOT NULL,
    Adults INT NOT NULL,
    Children INT NOT NULL,
    
    -- Composite Primary Key
    PRIMARY KEY pk_roomreservation (RoomNumber, ReservationID),
    
    FOREIGN KEY fk_roomreservation_room (RoomNumber)
		REFERENCES Room(RoomNumber),
        
	FOREIGN KEY fk_roomreservation_reservation (ReservationID)
		REFERENCES Reservation(ReservationID)
);

USE Hotel;

DROP VIEW IF EXISTS get_price;

CREATE VIEW get_price AS
SELECT 
	r.RoomNumber,
    IFNULL(t.PriceExtraPerson, 0) as PriceExtraPerson,
	t.Price + SUM(IFNULL(a.Price, 0)) Price
FROM `Type` t
JOIN Room r ON t.TypeID = r.TypeID
JOIN RoomAmenities ra ON ra.RoomNumber = r.RoomNumber
JOIN Amenities a ON ra.AmenitiesID = a.AmenitiesID
GROUP BY r.RoomNumber
ORDER BY r.RoomNumber;