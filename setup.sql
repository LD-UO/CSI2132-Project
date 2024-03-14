DROP SCHEMA IF EXISTS hotels CASCADE;

CREATE SCHEMA hotels;
SET search_path = 'hotels';

-- Create Hotel Chain table
CREATE TABLE HotelChain
(
    Name        VARCHAR(20) NOT NULL,
    HQ          VARCHAR(30) NOT NULL,
    NumOfHotels INT         NOT NULL,
    PRIMARY KEY (Name)
);

-- Create ChainPhone table
CREATE TABLE ChainPhone
(
    Name  VARCHAR(20),
    Phone CHAR(10) NOT NULL CHECK (LENGTH(Phone) = 10 AND Phone ~ '^[0-9]+$'),
    FOREIGN KEY (Name) REFERENCES HotelChain (Name),
    PRIMARY KEY (Name, Phone)
);

-- Create Email table
CREATE TABLE Email
(
    Name  VARCHAR(20),
    Email VARCHAR(50) NOT NULL CHECK (Email ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'),
    FOREIGN KEY (Name) REFERENCES HotelChain (Name),
    PRIMARY KEY (Name, Email)
);

-- Create Employee table
CREATE TABLE Employee
(
    employee_id INT         NOT NULL,
    StreetNum   INT         NOT NULL,
    StreetName  VARCHAR(30) NOT NULL,
    PostalCode  CHAR(6)     NOT NULL CHECK (PostalCode ~ '^[A-Za-z]\d[A-Za-z]\d[A-Za-z]\d$'),
    Name        VARCHAR(20) NOT NULL CHECK (LENGTH(Name) BETWEEN 2 AND 20 AND Name ~ '^[a-zA-Z ]+$'),
    Phone       CHAR(10)    NOT NULL CHECK (LENGTH(Phone) = 10 AND Phone ~ '^[0-9]+$'),
    Position    VARCHAR(20) NOT NULL CHECK (LENGTH(Position) BETWEEN 3 AND 20 AND Position ~ '^[a-zA-Z]+$'),
    SIN         CHAR(9)     NOT NULL CHECK (LENGTH(SIN) = 9 AND SIN ~ '^[0-9]+$'),
    PRIMARY KEY (employee_id)
);

-- Create Hotel Instance table
CREATE TABLE HotelInstance
(
    StreetNum  INT         NOT NULL,
    StreetName VARCHAR(30) NOT NULL,
    PostalCode CHAR(6)     NOT NULL,
    HotelChain VARCHAR(20),
    Rating     INT         NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    NumOfRoom  INT         NOT NULL CHECK (NumOfRoom > 0),
    Email      VARCHAR(50) NOT NULL CHECK (LENGTH(Email) BETWEEN 5 AND 50 AND
                                           Email ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'),
    Manager    INT,
    FOREIGN KEY (HotelChain) REFERENCES HotelChain (Name),
    FOREIGN KEY (Manager) REFERENCES Employee (employee_id),
    PRIMARY KEY (StreetNum, StreetName, PostalCode)
);

-- Create HotelPhone table
CREATE TABLE HotelPhone
(
    StreetNum  INT,
    StreetName VARCHAR(30),
    PostalCode CHAR(6),
    Phone      CHAR(10) NOT NULL CHECK (LENGTH(Phone) = 10 AND Phone ~ '^[0-9]+$'),
    PRIMARY KEY (StreetNum, StreetName, PostalCode, Phone)
);

-- Create Room table
CREATE TABLE Room
(
    RoomNum         INT            NOT NULL,
    StreetNum       INT            NOT NULL,
    StreetName      VARCHAR(30)    NOT NULL,
    PostalCode      CHAR(6)        NOT NULL,
    Price           DECIMAL(10, 2) NOT NULL CHECK (Price > 0),
    TV              BOOLEAN        NOT NULL,
    AC              BOOLEAN        NOT NULL,
    Fridge          BOOLEAN        NOT NULL,
    Capacity        INT            NOT NULL CHECK (Capacity BETWEEN 1 AND 5),
    IsExtendable    BOOLEAN        NOT NULL,
    Defects         VARCHAR(100)   NOT NULL CHECK (LENGTH(Defects) BETWEEN 4 AND 100),
    ViewDescription VARCHAR(100)   NOT NULL CHECK (LENGTH(ViewDescription) BETWEEN 5 AND 100),
    Available       BOOLEAN        NOT NULL,
    PRIMARY KEY (RoomNum, StreetNum, StreetName, PostalCode)
);

-- Create Reservation table
CREATE TABLE Reservation
(
    employee_id    INT,
    RoomNum        INT,
    username       VARCHAR(30),
    reservation_id SERIAL,
    startDate           DATE NOT NULL,
    endDate           DATE NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES Employee (employee_id),
    PRIMARY KEY (employee_id, RoomNum, username, reservation_id)
);

-- Create Customers table
CREATE TABLE Customers
(
    username VARCHAR(30) NOT NULL,
    name     VARCHAR(20) NOT NULL CHECK (LENGTH(name) BETWEEN 2 AND 20 AND name ~ '^[a-zA-Z ]+$'),
    SIN      CHAR(9)     NOT NULL CHECK (LENGTH(SIN) = 9 AND SIN ~ '^[0-9]+$'),
    address  VARCHAR(30) NOT NULL CHECK (LENGTH(address) BETWEEN 10 AND 30),
    PRIMARY KEY (username)
);

-- Create Archive table
CREATE TABLE Archive
(
    archive_id   SERIAL,
    employee_id    INT,
    roomNum      INT         NOT NULL,
    StreetNum  INT         NOT NULL,
    StreetName VARCHAR(30) NOT NULL,
    PostalCode CHAR(6)     NOT NULL,
    hotelChain   VARCHAR(20) NOT NULL,
    customer     VARCHAR(30) NOT NULL,
    PRIMARY KEY (archive_id)
);

-- Set up foreign keys
ALTER TABLE Employee
    ADD CONSTRAINT fk_employee_hotel_instance
        FOREIGN KEY (StreetNum, StreetName, PostalCode) REFERENCES HotelInstance (StreetNum, StreetName, PostalCode);

ALTER TABLE HotelPhone
    ADD CONSTRAINT fk_hotel_instance_phone
        FOREIGN KEY (StreetNum, StreetName, PostalCode) REFERENCES HotelInstance (StreetNum, StreetName, PostalCode);

ALTER TABLE Room
    ADD CONSTRAINT fk_hotel_instance_room
        FOREIGN KEY (StreetNum, StreetName, PostalCode) REFERENCES HotelInstance (StreetNum, StreetName, PostalCode);

ALTER TABLE Reservation
    ADD CONSTRAINT fk_reservation_customers
        FOREIGN KEY (username) REFERENCES Customers (username);

INSERT INTO HotelChain (Name, HQ, NumOfHotels) VALUES
                                                   ('Marriott', 'New York', 50),
                                                   ('Hilton', 'Los Angeles', 40),
                                                   ('Hyatt', 'Chicago', 30),
                                                   ('Holiday Inn', 'Dallas', 25),
                                                   ('Sheraton', 'Miami', 20);

INSERT INTO ChainPhone (Name, Phone) VALUES
                                         ('Marriott', '1234567890'),
                                         ('Marriott', '2345678901'),
                                         ('Hilton', '3456789012'),
                                         ('Hilton', '4567890123'),
                                         ('Hyatt', '5678901234'),
                                         ('Hyatt', '6789012345'),
                                         ('Holiday Inn', '7890123456'),
                                         ('Holiday Inn', '8901234567'),
                                         ('Sheraton', '9012345678'),
                                         ('Sheraton', '0123456789');

INSERT INTO HotelInstance (StreetNum, StreetName, PostalCode, HotelChain, Rating, NumOfRoom, Email, Manager) VALUES
                                                                                                                 (100, 'Main St', 'A1A1A1', 'Marriott', 4, 200, 'marriott@example.com', NULL),
                                                                                                                 (200, 'Elm St', 'B2B2B2', 'Hilton', 4, 150, 'hilton@example.com', NULL),
                                                                                                                 (300, 'Maple Ave', 'C3C3C3', 'Hyatt', 5, 180, 'hyatt@example.com', NULL),
                                                                                                                 (400, 'Oak St', 'D4D4D4', 'Holiday Inn', 3, 120, 'holidayinn@example.com', NULL),
                                                                                                                 (500, 'Cedar Rd', 'E5E5E5', 'Sheraton', 4, 250, 'sheraton@example.com', NULL),
                                                                                                                 (101, 'Pine St', 'F6F6F6', 'Marriott', 3, 220, 'marriott2@example.com', NULL),
                                                                                                                 (201, 'Birch St', 'G7G7G7', 'Hilton', 4, 180, 'hilton2@example.com', NULL);

INSERT INTO Email (Name, Email) VALUES
                                    ('Marriott', 'marriott@example.com'),
                                    ('Hilton', 'hilton@example.com'),
                                    ('Hyatt', 'hyatt@example.com'),
                                    ('Holiday Inn', 'holidayinn@example.com'),
                                    ('Sheraton', 'sheraton@example.com');

INSERT INTO HotelPhone (StreetNum, StreetName, PostalCode, Phone) VALUES
                                                                      (100, 'Main St', 'A1A1A1', '1234567890'),
                                                                      (200, 'Elm St', 'B2B2B2', '2345678901'),
                                                                      (300, 'Maple Ave', 'C3C3C3', '3456789012'),
                                                                      (400, 'Oak St', 'D4D4D4', '4567890123'),
                                                                      (500, 'Cedar Rd', 'E5E5E5', '5678901234'),
                                                                      (101, 'Pine St', 'F6F6F6', '6789012345'),
                                                                      (201, 'Birch St', 'G7G7G7', '7890123456');

INSERT INTO Employee (employee_id, StreetNum, StreetName, PostalCode, Name, Phone, Position, SIN) VALUES
                                                                                                      (1, 100, 'Main St', 'A1A1A1', 'John Doe', '1234567890', 'Manager', '123456789'),
                                                                                                      (2, 200, 'Elm St', 'B2B2B2', 'Jane Smith', '2345678901', 'Receptionist', '234567890'),
                                                                                                      (3, 300, 'Maple Ave', 'C3C3C3', 'Michael Johnson', '3456789012', 'Housekeeping', '345678901'),
                                                                                                      (4, 400, 'Oak St', 'D4D4D4', 'Emily Williams', '4567890123', 'Chef', '456789012'),
                                                                                                      (5, 500, 'Cedar Rd', 'E5E5E5', 'David Brown', '5678901234', 'Maintenance', '567890123'),
                                                                                                      (6, 101, 'Pine St', 'F6F6F6', 'Emma Davis', '6789012345', 'Manager', '678901234'),
                                                                                                      (7, 201, 'Birch St', 'G7G7G7', 'James Wilson', '7890123456', 'Receptionist', '789012345'),
                                                                                                      (8, 100, 'Main St', 'A1A1A1', 'Olivia Anderson', '8901234567', 'Housekeeping', '890123456'),
                                                                                                      (9, 100, 'Main St', 'A1A1A1', 'Noah Taylor', '9012345678', 'Chef', '901234567'),
                                                                                                      (10, 100, 'Main St', 'A1A1A1', 'Sophia Martinez', '0123456789', 'Maintenance', '012345678'),
                                                                                                      (11, 100, 'Main St', 'A1A1A1', 'William Garcia', '1234567890', 'Manager', '123456789'),
                                                                                                      (12, 100, 'Main St', 'A1A1A1', 'Isabella Hernandez', '2345678901', 'Receptionist', '234567890'),
                                                                                                      (13, 100, 'Main St', 'A1A1A1', 'Mason Martinez', '3456789012', 'Housekeeping', '345678901'),
                                                                                                      (14, 100, 'Main St', 'A1A1A1', 'Sophia Martinez', '4567890123', 'Chef', '456789012'),
                                                                                                      (15, 100, 'Main St', 'A1A1A1', 'Jacob Brown', '5678901234', 'Maintenance', '567890123');

INSERT INTO Room (RoomNum, StreetNum, StreetName, PostalCode, Price, TV, AC, Fridge, Capacity, IsExtendable, Defects, ViewDescription, Available) VALUES
-- Marriott
(1, 100, 'Main St', 'A1A1A1', 150.00, true, true, false, 2, true, 'None', 'City View', true),
(2, 100, 'Main St', 'A1A1A1', 150.00, true, false, true, 2, true, 'Minor scratches on the wall', 'Ocean View', true),
(3, 100, 'Main St', 'A1A1A1', 180.00, true, true, true, 4, true, 'None', 'Mountain View', true),
(4, 100, 'Main St', 'A1A1A1', 180.00, false, true, true, 4, true, 'None', 'Garden View', true),
(5, 100, 'Main St', 'A1A1A1', 200.00, true, true, true, 2, true, 'None', 'Pool View', true),

-- Hilton
(101, 200, 'Elm St', 'B2B2B2', 130.00, true, false, true, 2, true, 'None', 'City View', true),
(102, 200, 'Elm St', 'B2B2B2', 130.00, true, true, false, 2, true, 'Water leakage from the ceiling', 'Ocean View', true),
(103, 200, 'Elm St', 'B2B2B2', 150.00, false, true, true, 4, true, 'None', 'Mountain View', true),
(104, 200, 'Elm St', 'B2B2B2', 150.00, true, true, true, 4, true, 'None', 'Garden View', true),
(105, 200, 'Elm St', 'B2B2B2', 180.00, true, false, true, 2, true, 'None', 'Pool View', true),
-- Hyatt
(201, 300, 'Maple Ave', 'C3C3C3', 170.00, true, false, true, 2, true, 'None', 'City View', true),
(202, 300, 'Maple Ave', 'C3C3C3', 170.00, false, true, true, 2, true, 'None', 'Ocean View', true),
(203, 300, 'Maple Ave', 'C3C3C3', 190.00, true, true, false, 4, true, 'None', 'Mountain View', true),
(204, 300, 'Maple Ave', 'C3C3C3', 190.00, true, true, true, 4, true, 'None', 'Garden View', true),
(205, 300, 'Maple Ave', 'C3C3C3', 220.00, true, true, true, 2, true, 'None', 'Pool View', true),
-- Holiday Inn
(301, 400, 'Oak St', 'D4D4D4', 120.00, true, true, false, 2, true, 'None', 'City View', true),
(302, 400, 'Oak St', 'D4D4D4', 120.00, false, true, true, 2, true, 'None', 'Ocean View', true),
(303, 400, 'Oak St', 'D4D4D4', 140.00, true, false, true, 4, true, 'None', 'Mountain View', true),
(304, 400, 'Oak St', 'D4D4D4', 140.00, true, true, true, 4, true, 'None', 'Garden View', true),
(305, 400, 'Oak St', 'D4D4D4', 160.00, true, true, false, 2, true, 'None', 'Pool View', true),

-- Sheraton
(401, 500, 'Cedar Rd', 'E5E5E5', 140.00, true, false, true, 2, true, 'None', 'City View', true),
(402, 500, 'Cedar Rd', 'E5E5E5', 140.00, false, true, true, 2, true, 'None', 'Ocean View', true),
(403, 500, 'Cedar Rd', 'E5E5E5', 160.00, true, true, false, 4, true, 'None', 'Mountain View', true),
(404, 500, 'Cedar Rd', 'E5E5E5', 160.00, true, true, true, 4, true, 'None', 'Garden View', true),
(405, 500, 'Cedar Rd', 'E5E5E5', 180.00, true, false, true, 2, true, 'None', 'Pool View', true);

INSERT INTO Customers (username, name, SIN, address) VALUES
                                                         ('john_doe', 'John Doe', '123456789', '123 Main St, City'),
                                                         ('jane_smith', 'Jane Smith', '987654321', '456 Elm St, Town'),
                                                         ('alex_jones', 'Alex Jones', '456789123', '789 Maple Ave, Village'),
                                                         ('emily_wang', 'Emily Wang', '654321987', '987 Oak St, Suburb'),
                                                         ('michael_brown', 'Michael Brown', '321987654', '654 Cedar Rd, Countryside');


INSERT INTO Reservation (employee_id, RoomNum, username, startDate, endDate) VALUES
                                                                                 (1, 1, 'john_doe', '2024-03-15', '2024-03-20'),
                                                                                 (2, 101, 'jane_smith', '2024-03-18', '2024-03-22'),
                                                                                 (3, 201, 'alex_jones', '2024-03-20', '2024-03-25'),
                                                                                 (4, 301, 'emily_wang', '2024-03-22', '2024-03-27'),
                                                                                 (5, 401, 'michael_brown', '2024-03-25', '2024-03-30');

INSERT INTO Archive (archive_id, employee_id, roomNum, StreetNum, StreetName, PostalCode, hotelChain, customer) VALUES
(1, 1, 1, 100, 'Main St', 'A1A1A1', 'Marriott', 'john_doe'),
(2, 2, 101, 200, 'Elm St', 'B2B2B2', 'Hilton', 'jane_smith'),
(3, 3, 201, 300, 'Maple Ave', 'C3C3C3', 'Hyatt', 'alex_jones'),
(4, 4, 301, 400, 'Oak St', 'D4D4D4', 'Holiday Inn', 'emily_wang'),
(5, 5, 401, 500, 'Cedar Rd', 'E5E5E5', 'Sheraton', 'michael_brown');
