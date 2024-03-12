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
    Name        VARCHAR(20) NOT NULL CHECK (LENGTH(Name) BETWEEN 2 AND 20 AND Name ~ '^[a-zA-Z]+$'),
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
    name     VARCHAR(20) NOT NULL CHECK (LENGTH(name) BETWEEN 2 AND 20 AND name ~ '^[a-zA-Z]+$'),
    SIN      CHAR(9)     NOT NULL CHECK (LENGTH(SIN) = 9 AND SIN ~ '^[0-9]+$'),
    address  VARCHAR(30) NOT NULL CHECK (LENGTH(address) BETWEEN 10 AND 30),
    PRIMARY KEY (username)
);

-- Create Archive table
CREATE TABLE Archive
(
    archive_id   SERIAL,
    roomNum      INT         NOT NULL,
    hotelChain   VARCHAR(20) NOT NULL CHECK (LENGTH(hotelChain) BETWEEN 5 AND 20 AND hotelChain ~ '^[a-zA-Z]+$'),
    hotelAddress VARCHAR(30) NOT NULL CHECK (LENGTH(hotelAddress) BETWEEN 10 AND 30),
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

-- TODO: Populate data base (lmk when u guys want me to do this for)
insert into customers (username, name, sin, address)
values ('meekylemondal', 'meekyle', '123456789', '123 random street');

SELECT * FROM customers