USE Hotel;

INSERT INTO `Type`(Name, Price, PriceExtraPerson, StandardOccupancy, MaxOccupancy)
Values ('Single', 149.99, NULL, 2, 2),
('Double', 174.99, 10.00, 2, 4),
('Suite', 399.99, 20.00, 3, 8);

INSERT INTO Amenities(Name, Price)
VALUES ('Microwave', NULL),
('Refrigerator', NULL),
('Jacuzzi', 25.00),
('Oven', NULL);

INSERT INTO Room(RoomNumber, TypeID, ADAAccessible)
VALUES (201, 2, false),
(202, 2, true),
(203, 2, false),
(204, 2, true),
(205, 1, false),
(206, 1, true),
(207, 1, false),
(208, 1, true),
(301, 2, false),
(302, 2, true),
(303, 2, false),
(304, 2, true),
(305, 1, false),
(306, 1, true),
(307, 1, false),
(308, 1, true),
(401, 3, true),
(402, 3, true);

INSERT INTO RoomAmenities(RoomNumber, AmenitiesID)
VALUES (201, 1),
(201, 3),

(202, 2),

(203, 1),
(203, 3),

(204, 2),

(205, 1),
(205, 2),
(205, 3),

(206, 1),
(206, 2),

(207, 1),
(207, 2),
(207, 3),

(208, 1),
(208, 2),

(301, 1),
(301, 3),

(302, 2),

(303, 1),
(303, 3),

(304, 2),

(305, 1),
(305, 2),
(305, 3),

(306, 1),
(306, 2),

(307, 1),
(307, 2),
(307, 3),

(308, 1),
(308, 2),

(401, 1),
(401, 2),
(401, 4),

(402, 1),
(402, 2),
(402, 4);

INSERT INTO City(ZipCode, City, State)
VALUES('51501', 'Council Bluffs', 'IA'),
('99654', 'Wasilla', 'AK'),
('78552','Harlingen' , 'TX'),
('08096', 'West Deptford', 'NJ'),
('48601', 'Saginaw', 'MI'),
('80003', 'Arvada', 'CO'),
('60099', 'Zion', 'IL'),
('02864', 'Cumberland', 'RI'),
('13126', 'Oswego', 'NY'),
('22015', 'Burke', 'VA'),
('19026', 'Drexel Hill', 'PA');

INSERT INTO Guest(FirstName, LastName, Address, ZipCode, Phone)
VALUES('Mack', 'Simmer', '379 Old Shore Street', '51501', '(291) 553-0508'), 
('Bettyann', 'Seery', '750 Wintergreen Dr.', '99654', '(478) 277-9632'),
('Duane', 'Cullison', '9662 Foxrun Lane', '78552', '(308) 494-0198'),
('Karie', 'Yang', '9378 W. Augusta Ave.', '08096', '(214) 730-0298'),
('Aurore', 'Lipton', '762 Wild Rose Street', '48601', '(377) 507-0974'),
('Zachery', 'Luechtefeld', '7 Poplar Dr.', '80003', '(814) 485-2615'),
('Jeremiah', 'Pendergrass', '70 Oakwood St.', '60099', '(279) 491-0960'),
('Walter', 'Holaway', '7556 Arrowhead St.', '02864', '(446) 396-6785'),
('Wilfred', 'Vise', '77 West Surrey Street', '13126', '(834) 727-1001'),
('Maritza', 'Tilton', '939 Linda Rd.', '22015', '(446) 351-6860'),
('Joleen', 'Tison', '87 Queen St.', '19026', '(231) 893-2755');

INSERT INTO Reservation(StartDate, EndDate, GuestID)
VALUES ('2023-2-4', '2023-2-4', 1),
('2023-2-5', '2023-2-10', 2),
('2023-2-22', '2023-2-24', 3),
('2023-3-6', '2023-3-7', 4),
('2023-3-18', '2023-3-23', 5),
('2023-3-29', '2023-3-31', 6),
('2023-3-31', '2023-4-5', 7),
('2023-4-9', '2023-4-13', 8),
('2023-4-23', '2023-4-24', 9),
('2023-5-30', '2023-6-2', 10),
('2023-6-10', '2023-6-14', 11),
('2023-6-17', '2023-6-18', 5),
('2023-7-13', '2023-7-14', 8),
('2023-7-18', '2023-7-21', 9),
('2023-7-28', '2023-7-29', 2),
('2023-8-30', '2023-9-1', 2),
('2023-9-16', '2023-9-17', 1),
('2023-9-13', '2023-9-15', 4),
('2023-11-22', '2023-11-25', 3),
('2023-11-22', '2023-11-25', 1),
('2023-12-24', '2023-12-28', 10);

INSERT INTO RoomReservation(RoomNumber, ReservationID, Adults, Children)
VALUES (308, 1, 1, 0),
(203, 2, 2, 1),
(305, 3, 2, 0),
(201, 4, 2, 2),
(302, 5, 3, 0),
(202, 6, 2, 2),
(304, 7, 2, 0),
(301, 8, 1, 0),
(207, 9, 1, 1),
(401, 10, 2, 4),
(206, 11, 2, 0),
(208, 11, 1, 0),
(304, 12, 3, 0),
(204, 13, 3, 1),
(401, 14, 4, 2),
(303, 15, 2, 1),
(305, 16, 1, 0),
(208, 17, 2, 0),
(203, 18, 2, 2),
(401, 19, 2, 2),
(206, 20, 2, 0),
(301, 20, 2, 2),
(302, 21, 2, 0);

DELETE FROM RoomReservation
WHERE ReservationID = (
	SELECT r.ReservationID
    FROM Reservation r
    JOIN Guest g ON r.GuestID = g.GuestID
    WHERE g.FirstName='Jeremiah'
);

DELETE FROM Reservation
WHERE GuestID = (
	SELECT GuestID
    FROM Guest
    WHERE FirstName='Jeremiah'
);

SET SQL_SAFE_UPDATES = 0;

DELETE FROM Guest
WHERE FirstName='Jeremiah';

SET SQL_SAFE_UPDATES = 1;
