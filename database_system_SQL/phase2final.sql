-- November 2021
-- Claudia Dwortz
-- Eric Darling
-- Isabelle Du Plessis

-- ------------------------------------------------------
-- CREATE TABLE STATEMENTS AND INSERT STATEMENTS BELOW
-- ------------------------------------------------------

DROP DATABASE IF EXISTS phase2;
CREATE DATABASE IF NOT EXISTS phase2;
USE phase2;

-- TABLES

-- Table structure for table employee

DROP TABLE IF EXISTS Account;
CREATE TABLE Account (
	email char(50) NOT NULL,
    fname char(100) NOT NULL,
    lname char(100) NOT NULL,
    password char(30) NOT NULL,
    PRIMARY KEY (email)
);

INSERT INTO Account VALUES
('mmoss1@travelagency.com','Mark','Moss','password1'),
('asmith@travelagency.com','Aviva','Smith','password2'),
('mscott22@gmail.com','Michael','Scott','password3'),
('arthurread@gmail.com','Arthur','Read','password4'),
('jwayne@gmail.com','John','Wayne','password5'),
('gburdell3@gmail.com','George','Burdell','password6'),
('mj23@gmail.com','Michael','Jordan','password7'),
('lebron6@gmail.com','Lebron','James','password8'),
('msmith5@gmail.com','Michael','Smith','password9'),
('ellie2@gmail.com','Ellie','Johnson','password10'),
('scooper3@gmail.com','Sheldon','Cooper','password11'),
('mgeller5@gmail.com','Monica','Geller','password12'),
('cbing10@gmail.com','Chandler','Bing','password13'),
('hwmit@gmail.com','Howard','Wolowitz','password14'),
('swilson@gmail.com','Samantha','Wilson','password16'),
('aray@tiktok.com','Addison','Ray','password17'),
('cdemilio@tiktok.com','Charlie','Demilio','password18'),
('bshelton@gmail.com','Blake','Shelton','password19'),
('lbryan@gmail.com','Luke','Bryan','password20'),
('tswift@gmail.com','Taylor','Swift','password21'),
('jseinfeld@gmail.com','Jerry','Seinfeld','password22'),
('maddiesmith@gmail.com','Madison','Smith','password23'),
('johnthomas@gmail.com','John','Thomas','password24'),
('boblee15@gmail.com','Bob','Lee','password25');

DROP TABLE IF EXISTS Admin;
CREATE TABLE Admin (
	email char(50) NOT NULL,
    PRIMARY KEY (email),
	CONSTRAINT Account_ibfk_1 FOREIGN KEY (email) REFERENCES Account (email)
);


INSERT INTO Admin VALUES
('mmoss1@travelagency.com'),
('asmith@travelagency.com');


DROP TABLE IF EXISTS Client;
CREATE TABLE Client (
	phoneNumber char(12) NOT NULL,
	email char(50) NOT NULL,
    PRIMARY KEY (phoneNumber),
    UNIQUE KEY email (email),
	CONSTRAINT Account_ibfk_2 FOREIGN KEY (email) REFERENCES Account (email)
);


INSERT INTO Client VALUES
('555-123-4567','mscott22@gmail.com'),
('555-234-5678','arthurread@gmail.com'),
('555-345-6789','jwayne@gmail.com'),
('555-456-7890','gburdell3@gmail.com'),
('555-567-8901','mj23@gmail.com'),
('555-678-9012','lebron6@gmail.com'),
('555-789-0123','msmith5@gmail.com'),
('555-890-1234','ellie2@gmail.com'),
('678-123-4567','scooper3@gmail.com'),
('678-234-5678','mgeller5@gmail.com'),
('678-345-6789','cbing10@gmail.com'),
('678-456-7890','hwmit@gmail.com'),
('770-123-4567','swilson@gmail.com'),
('770-234-5678','aray@tiktok.com'),
('770-345-6789','cdemilio@tiktok.com'),
('770-456-7890','bshelton@gmail.com'),
('770-567-8901','lbryan@gmail.com'),
('770-678-9012','tswift@gmail.com'),
('770-789-0123','jseinfeld@gmail.com'),
('770-890-1234','maddiesmith@gmail.com'),
('404-770-5555','johnthomas@gmail.com'),
('404-678-5555','boblee15@gmail.com');

DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer (
	creditCardNum char(19) NOT NULL,
	phoneNumber char(12) NOT NULL,
    PRIMARY KEY (creditCardNum),
    UNIQUE KEY phoneNumber (phoneNumber),
	CONSTRAINT Client_ibfk_3 FOREIGN KEY (phoneNumber) REFERENCES Client (phoneNumber),
    cvv char(3) NOT NULL,
    expDate date NOT NULL,
    currentLocation char(50)
);

INSERT INTO Customer VALUES
('6518 5559 7446 1663','678-123-4567','551','2024-02-01','NULL'),
('2328 5670 4310 1965','678-234-5678','644','2024-03-01','NULL'),
('8387 9523 9827 9291','678-345-6789','201',' 023-02-01','NULL'),
('6558 8596 9852 5299','678-456-7890','102','2023-04-01','NULL'),
('9383 3212 4198 1836','770-123-4567','455','2022-08-01','NULL'),
('3110 2669 7949 5605','770-234-5678','744','2022-08-01','NULL'),
('2272 3555 4078 4744','770-345-6789','606','2025-02-01','NULL'),
('9276 7639 7883 4273','770-456-7890','862','2023-09-01','NULL'),
('4652 3726 8864 3798','770-567-8901','258','2023-05-01','NULL'),
('5478 8420 4436 7471','770-678-9012','857','2024-12-01','NULL'),
('3616 8977 1296 3372','770-789-0123','295','2022-06-01','NULL'),
('9954 5698 6355 6952','770-890-1234','794','2022-07-01','NULL'),
('7580 3274 3724 5356','404-770-5555','269','2025-10-01','NULL'),
('7907 3513 7161 4248','404-678-5555','858','2025-11-01','NULL');

DROP TABLE IF EXISTS Owner;
CREATE TABLE Owner (
	phoneNumber char(12) NOT NULL,
	email char(50) NOT NULL,
    PRIMARY KEY (phoneNumber),
    UNIQUE KEY email (email),
	CONSTRAINT Client_ibfk_23 FOREIGN KEY (phoneNumber) REFERENCES Client (phoneNumber),
	CONSTRAINT Account_ibfk_23 FOREIGN KEY (email) REFERENCES Account (email)
);

INSERT INTO Owner VALUES
('555-123-4567', 'mscott22@gmail.com'),
('555-234-5678', 'arthurread@gmail.com'),
('555-345-6789', 'jwayne@gmail.com'),
('555-456-7890', 'gburdell3@gmail.com'),
('555-567-8901', 'mj23@gmail.com'),
('555-678-9012', 'lebron6@gmail.com'),
('555-789-0123', 'msmith5@gmail.com'),
('555-890-1234', 'ellie2@gmail.com'),
('678-123-4567', 'scooper3@gmail.com'),
('678-234-5678', 'mgeller5@gmail.com'),
('678-345-6789', 'cbing10@gmail.com'),
('678-456-7890', 'hwmit@gmail.com');


DROP TABLE IF EXISTS Property;
CREATE TABLE Property (
	street char(50) NOT NULL,
	city char(50) NOT NULL,
	state char(2) NOT NULL,
	zip char(5) NOT NULL,
	PRIMARY KEY (street, city, state, zip),
	ownerEmail char(50) NOT NULL,
	CONSTRAINT Account_ibfk_4 FOREIGN KEY (ownerEmail) REFERENCES Account (email),
	name char(100) NOT NULL,
	description Text(300),
	costPerNight decimal(5,0) NOT NULL,
	capacity decimal(2,0) NOT NULL
);

INSERT INTO Property VALUES
('2nd St', 'ATL', 'GA', '30008', 'scooper3@gmail.com', 'Atlanta Great Property', 'This is right in the middle of Atlanta near many attractions!', 600, 4), 
('North Ave', 'ATL', 'GA', '30008', 'gburdell3@gmail.com', 'House near Georgia Tech', 'Super close to bobby dodde stadium!', 275, 3),
('123 Main St', 'NYC', 'NY', '10008', 'cbing10@gmail.com', 'New York City Property', 'A view of the whole city. Great property!', 750, 2),
('1st St', 'NYC', 'NY', '10009', 'mgeller5@gmail.com', 'Statue of Liberty Property', 'You can see the statue of liberty from the porch', 1000, 5),
('10th St', 'LA', 'CA', '90008', 'arthurread@gmail.com', 'Los Angeles Property', NULL, 700, 3),
('Kings St', 'La', 'CA', '90011', 'arthurread@gmail.com', 'LA Kings House', 'This house is super close to the LA kings stadium!', 750, 4),
('Golden Bridge Pkwt', 'San Jose', 'CA', '90001', 'arthurread@gmail.com', 'Beautiful San Jose Mansion', 'Huge house that can sleep 12 people. Totally worth it!', 900, 12),
('Lebron Ave', 'LA', 'CA', '90011', 'lebron6@gmail.com', 'LA Lakers Property', 'This house is right near the LA lakers stadium. You might even meet Lebron James!', 850, 4),
('Blackhawks St', 'Chicago', 'IL', '60176', 'hwmit@gmail.com', 'Chicago Blackhawks House', 'This is a great property!', 775, 3),
('23rd Main St', 'Chicago', 'IL', '60176', 'mj23@gmail.com', 'Chicago Romantic Getaway', 'This is a great property!', 1050, 2),
('456 Beach Ave', 'Miami', 'FL', '33101', 'msmith5@gmail.com', 'Beautiful Beach Property', 'You can walk out of the house and be on the beach!', 975, 2),
('1132 Beach Ave', 'Miami', 'FL', '33101', 'ellie2@gmail.com', 'Family Beach House', 'You can literally walk onto the beach and see it from the patio!', 850, 6),
('17th Street', 'Dallas', 'TX', '75043', 'mscott22@gmail.com', 'Texas Roadhouse', 'This property is right in the center of Dallas, Texas!', 450, 3),
('1125 Longhorns Way', 'Dallas', 'TX', '75001', 'mscott22@gmail.com', 'Texas Longhorns House', 'You can walk to the longhorns stadium from here!', 600, 10);

DROP TABLE IF EXISTS Amenities;
CREATE TABLE Amenities (
	street char(50) NOT NULL,
	city char(50) NOT NULL,
	state char(2) NOT NULL,
	zip char(5) NOT NULL,
    amenity char(30),
	PRIMARY KEY (street, city, state, zip, amenity),
	CONSTRAINT Property_ibfk_5 FOREIGN KEY (street,city,state,zip) REFERENCES Property (street,city,state,zip)
);

INSERT INTO Amenities VALUES
('2nd St', 'ATL', 'GA', '30008', 'A/C & Heating'),
('2nd St', 'ATL', 'GA', '30008', 'Pets allowed'),
('2nd St', 'ATL', 'GA', '30008', 'Wifi & TV'),
('2nd St', 'ATL', 'GA', '30008', 'Washer and Dryer'),
('North Ave', 'ATL', 'GA', '30008', 'Wifi & TV'),
('North Ave', 'ATL', 'GA', '30008', 'Washer and Dryer'),
('North Ave', 'ATL', 'GA', '30008', 'Full Kitchen'),
('123 Main St', 'NYC', 'NY', '10008', 'A/C & Heating'),
('123 Main St', 'NYC', 'NY', '10008', 'Wifi & TV'),
('1st St', 'NYC', 'NY', '10009', 'A/C & Heating'),
('1st St', 'NYC', 'NY', '10009', 'Wifi & TV'),
('10th St', 'LA', 'CA', '90008', 'A/C & Heating'),
('10th St', 'LA', 'CA', '90008', 'Pets allowed'),
('10th St', 'LA', 'CA', '90008', 'Wifi & TV'),
('Kings St', 'La', 'CA', '90011', 'A/C & Heating'),
('Kings St', 'La', 'CA', '90011', 'Wifi & TV'),
('Kings St', 'La', 'CA', '90011', 'Washer and Dryer'),
('Kings St', 'La', 'CA', '90011', 'Full Kitchen'),
('Golden Bridge Pkwt', 'San Jose', 'CA', '90001', 'A/C & Heating'),
('Golden Bridge Pkwt', 'San Jose', 'CA', '90001', 'Pets allowed'),
('Golden Bridge Pkwt', 'San Jose', 'CA', '90001', 'Wifi & TV'),
('Golden Bridge Pkwt', 'San Jose', 'CA', '90001', 'Washer and Dryer'),
('Golden Bridge Pkwt', 'San Jose', 'CA', '90001', 'Full Kitchen'),
('Lebron Ave', 'LA', 'CA', '90011', 'A/C & Heating'),
('Lebron Ave', 'LA', 'CA', '90011', 'Wifi & TV'),
('Lebron Ave', 'LA', 'CA', '90011', 'Washer and Dryer'),
('Lebron Ave', 'LA', 'CA', '90011', 'Full Kitchen'),
('Blackhawks St', 'Chicago', 'IL', '60176', 'A/C & Heating'),
('Blackhawks St', 'Chicago', 'IL', '60176', 'Wifi & TV'),
('Blackhawks St', 'Chicago', 'IL', '60176', 'Washer and Dryer'),
('Blackhawks St', 'Chicago', 'IL', '60176', 'Full Kitchen'),
('23rd Main St', 'Chicago', 'IL', '60176', 'A/C & Heating'),
('23rd Main St', 'Chicago', 'IL', '60176', 'Wifi & TV'),
('456 Beach Ave', 'Miami', 'FL', '33101', 'A/C & Heating'),
('456 Beach Ave', 'Miami', 'FL', '33101', 'Wifi & TV'),
('456 Beach Ave', 'Miami', 'FL', '33101', 'Washer and Dryer'),
('1132 Beach Ave', 'Miami', 'FL', '33101', 'A/C & Heating'),
('1132 Beach Ave', 'Miami', 'FL', '33101', 'Pets allowed'),
('1132 Beach Ave', 'Miami', 'FL', '33101', 'Wifi & TV'),
('1132 Beach Ave', 'Miami', 'FL', '33101', 'Washer and Dryer'),
('1132 Beach Ave', 'Miami', 'FL', '33101', 'Full Kitchen'),
('17th Street', 'Dallas', 'TX', '75043', 'A/C & Heating'),
('17th Street', 'Dallas', 'TX', '75043', 'Pets allowed'),
('17th Street', 'Dallas', 'TX', '75043', 'Wifi & TV'),
('17th Street', 'Dallas', 'TX', '75043', 'Washer and Dryer'),
('1125 Longhorns Way', 'Dallas', 'TX', '75001', 'A/C & Heating'),
('1125 Longhorns Way', 'Dallas', 'TX', '75001', 'Pets allowed'),
('1125 Longhorns Way', 'Dallas', 'TX', '75001', 'Wifi & TV'),
('1125 Longhorns Way', 'Dallas', 'TX', '75001', 'Washer and Dryer'),
('1125 Longhorns Way', 'Dallas', 'TX', '75001', 'Full Kitchen');

DROP TABLE IF EXISTS OwnerRates;
CREATE TABLE OwnerRates (
	email1 char(50) NOT NULL,
    email char(50) NOT NULL,
    PRIMARY KEY (email1, email),
    CONSTRAINT Account_ibfk_19 FOREIGN KEY (email1) REFERENCES Account (email),
    CONSTRAINT Owner_ibfk_1 FOREIGN KEY (email) REFERENCES Owner (email),
    score decimal(1,0)
);

INSERT INTO OwnerRates VALUES
('swilson@gmail.com', 'gburdell3@gmail.com', 5),
('aray@tiktok.com', 'cbing10@gmail.com', 5),
('bshelton@gmail.com', 'mgeller5@gmail.com', 3),
('lbryan@gmail.com', 'arthurread@gmail.com', 4),
('tswift@gmail.com', 'arthurread@gmail.com', 3),
('jseinfeld@gmail.com', 'lebron6@gmail.com', 1),
('maddiesmith@gmail.com', 'hwmit@gmail.com', 2);

DROP TABLE IF EXISTS CustomerRates;
CREATE TABLE CustomerRates (
    creditCardNum char(19) NOT NULL,
    email char(50) NOT NULL,
    PRIMARY KEY (creditCardNum, email),
    CONSTRAINT Account_ibfk_15 FOREIGN KEY (email) REFERENCES Account (email),
    CONSTRAINT Customer_ibfk_1 FOREIGN KEY (creditCardNum) REFERENCES Customer (CreditCardNum),
    score decimal(1,0)
);

INSERT INTO CustomerRates VALUES 
('6518 5559 7446 1663', 'scooper3@gmail.com', NULL),
('2328 5670 4310 1965', 'mgeller5@gmail.com', NULL),
('8387 9523 9827 9291', 'cbing10@gmail.com', NULL),
('6558 8596 9852 5299', 'hwmit@gmail.com', NULL),
('9383 3212 4198 1836', 'swilson@gmail.com', 5),
('3110 2669 7949 5605', 'aray@tiktok.com', 5),
('2272 3555 4078 4744', 'cdemilio@tiktok.com', NULL),
('9276 7639 7883 4273', 'bshelton@gmail.com', 4),
('4652 3726 8864 3798', 'lbryan@gmail.com', 4),
('5478 8420 4436 7471', 'tswift@gmail.com', 3),
('3616 8977 1296 3372', 'jseinfeld@gmail.com', 2),
('9954 5698 6355 6952', 'maddiesmith@gmail.com', 5);

DROP TABLE IF EXISTS Reservations;
CREATE TABLE Reservations (
	email2 char(50),
	PRIMARY KEY (email2),
	CONSTRAINT Account_ibfk_18 FOREIGN KEY (email2) REFERENCES Account (email),
    startDate date NOT NULL,
    endDate date NOT NULL,
    numGuests decimal(2,0) NOT NULL
);

INSERT INTO Reservations VALUES
('swilson@gmail.com', "2021-10-19", "2021-10-25", 3),
('aray@tiktok.com', "2021-10-18", "2021-10-23", 2),
('cdemilio@tiktok.com', "2021-10-24", "2021-10-30", 2),
('bshelton@gmail.com', "2021-10-18", "2021-10-22", 4),
('lbryan@gmail.com', "2021-10-19", "2021-10-25", 2),
('tswift@gmail.com', "2021-10-19", "2021-10-22", 10),
('jseinfeld@gmail.com', "2021-10-19", "2021-10-24", 4),
('hwmit@gmail.com', "2021-10-19", "2021-10-23", 2),
('mj23@gmail.com', "2021-11-01", "2021-11-07", 2),
('msmith5@gmail.com', "2021-10-18", "2021-10-25", 2),
('ellie2@gmail.com', "2021-10-18", "2021-10-28", 5);

DROP TABLE IF EXISTS Reviews;
CREATE TABLE Reviews (
	street char(50) NOT NULL,
	city char(50) NOT NULL,
	state char(2) NOT NULL,
	zip char(5) NOT NULL,
    email char(50) NOT NULL,
    content text(500),
    score char(1),
	PRIMARY KEY (street, city, state, zip, email),
	CONSTRAINT Property_ibfk_21 FOREIGN KEY (street,city,state,zip) REFERENCES Property (street,city,state,zip),
	CONSTRAINT Account_ibfk_22 FOREIGN KEY (email) REFERENCES Account (email)
);

INSERT INTO Reviews VALUES
('2nd St', 'ATL', 'GA', '30008', 'scooper3@gmail.com', NULL, NULL),
('North Ave', 'ATL', 'GA', '30008', 'mgeller5@gmail.com', 'This was so much fun. I went and saw the coke factory, the falcons play, GT play, and the Georgia aquarium. Great time! Would highly recommend!', '5'),
('123 Main St', 'NYC', 'NY', '10008', 'cbing10@gmail.com', 'This was the best 5 days ever! I saw so much of NYC!', '5'),
('1st St', 'NYC', 'NY', '10009', 'hwmit@gmail.com', 'This was truly an excellent experience. I really could see the Statue of Liberty from the property!', '4'),
('10th St', 'LA', 'CA', '90008', 'swilson@gmail.com', 'I had an excellent time!', '4'),
('Kings St', 'La', 'CA', '90011', 'aray@tiktok.com', NULL, NULL),
('Golden Bridge Pkwt', 'San Jose', 'CA', '90001', 'cdemilio@tiktok.com', "We had a great time, but the house wasn't fully cleaned when we arrived'", '3'),
('Lebron Ave', 'LA', 'CA', '90011', 'bshelton@gmail.com', 'I was disappointed that I did not meet lebron james', '2'),
('Blackhawks St', 'Chicago', 'IL', '60176', 'lbryan@gmail.com', 'This was awesome! I met one player on the chicago blackhawks!', '5'),
('23rd Main St', 'Chicago', 'IL', '60176', 'tswift@gmail.com', NULL, NULL),
('456 Beach Ave', 'Miami', 'FL', '33101', 'jseinfeld@gmail.com', NULL, NULL),
('1132 Beach Ave', 'Miami', 'FL', '33101', 'maddiesmith@gmail.com', NULL, NULL),
('17th Street', 'Dallas', 'TX', '75043', 'johnthomas@gmail.com', NULL, NULL),
('1125 Longhorns Way', 'Dallas', 'TX', '75001', 'boblee15@gmail.com', NULL, NULL);

DROP TABLE IF EXISTS Airline;
CREATE TABLE Airline (
    airlineName char(50) NOT NULL,
    rating decimal(2,1) NOT NULL,
    PRIMARY KEY (airlineName)
);

INSERT INTO Airline VALUES
('Delta Airlines', 4.7),
('Southwest Airlines', 4.4),
('American Airlines', 4.6),
('United Airlines', 4.2),
('JetBlue Airways', 3.6),
('Spirit Airlines', 3.3),
('WestJet', 3.9),
('Interjet', 3.7);

DROP TABLE IF EXISTS Airport;
CREATE TABLE Airport (
	airportID char(3) NOT NULL,
    airportName char(50) NOT NULL,
    timeZone char(3) NOT NULL,
    street char(50) NOT NULL,
    city char(50) NOT NULL,
    state char(2) NOT NULL,
    zip char(5) NOT NULL,
    PRIMARY KEY(airportID),
    UNIQUE KEY (street, city, state, zip),
    UNIQUE KEY airportName (airportName)
);

INSERT INTO Airport VALUES
('ATL', 'Atlanta Hartsfield Jackson Airport', 'EST', '6000 N Terminal Pkwy', 'Atlanta', 'GA', '30320'),
('JFK', 'John F Kennedy International Airport', 'EST', '455 Airport Ave', 'Queens', 'NY', '11430'),
('LGA', 'Laguardia Airport', 'EST', '790 Airport St', 'Queens', 'NY', '11371'),
('LAX', 'Lost Angeles International Airport', 'PST', '1 World Way', 'Los Angeles', 'CA', '90045'),
('SJC', 'Norman Y. Mineta San Jose International Airport', 'PST', '1702 Airport Blvd', 'San Jose', 'CA', '95110'),
('ORD', "O'Hare International Airport'", 'CST', "10000 W O'Hare Ave'", 'Chicago', 'IL', '60666'),
('MIA', 'Miami International Airport', 'EST', '2100 NW 42nd Ave', 'Miami', 'FL', '33126'),
('DFW', 'Dallas International Airport', 'CST', '2400 Aviation DR', 'Dallas', 'TX', '75261');

DROP TABLE IF EXISTS AirportAttractions;
CREATE TABLE AirportAttractions (
    airportID char(3) NOT NULL,
    attraction char(100) NOT NULL,
    PRIMARY KEY (airportID, attraction),
    CONSTRAINT AirportAttractions_ibfk_1 FOREIGN KEY (airportID) REFERENCES Airport (airportID)
);

INSERT INTO AirportAttractions VALUES
('ATL', 'The Coke Factory'),
('ATL', 'The Georgia Aquarium'),
('JFK', 'The Statue of Liberty'),
('JFK', 'The Empire State Building'),
('LGA', 'The Statue of Liberty'),
('LGA', 'The Empire State Building'),
('LAX', 'Lost Angeles Lakers Stadium'),
('LAX', 'Los Angeles Kings Stadium'),
('SJC', 'Winchester Mystery House'),
('SJC', 'San Jose Earthquakes Soccer Team'),
('ORD', 'Chicago Blackhawks Stadium'),
('ORD', 'Chicago Bulls Stadium'),
('MIA', 'Crandon Park Beach'),
('MIA', 'Miami Heat Basketball Stadium'),
('DFW', 'Texas Longhorns Stadium'),
('DFW', 'The Original Texas Roadhouse');
    
DROP TABLE IF EXISTS Flight;
CREATE TABLE Flight (
	flightNum char(2) NOT NULL,
	airlineName char(50) NOT NULL,
    fromAirportID char(3) NOT NULL,
    toAirportID char(3) NOT NULL,
	departureTime char(8) NOT NULL,
    arrivalTime char(8) NOT NULL,
    departingDate date NOT NULL,
    costPerSeat char(4) NOT NULL,
    capacity decimal(3,0) NOT NULL,
    PRIMARY KEY(flightNum, airlineName),
    CONSTRAINT Flight_ibfk_1 FOREIGN KEY (airlineName) REFERENCES Airline (airlineName),
    CONSTRAINT Flight_ibfk_8 FOREIGN KEY (fromAirportID) REFERENCES Airport (airportID),
    CONSTRAINT Flight_ibfk_9 FOREIGN KEY (toAirportID) REFERENCES Airport (airportID)
);

INSERT INTO Flight VALUES
('1', 'Delta Airlines', 'ATL', 'JFK', '10:00 AM', '12:00 PM', "2021-10-18", '400', '150'),
('2', 'Southwest Airlines', 'ORD', 'MIA', '10:30 AM', '2:30 PM', "2021-10-18", '350', '125'),
('3', 'American Airlines', 'MIA', 'DFW', '1:00 PM', '4:00 PM', "2021-10-18", '350', '125'),
('4', 'United Airlines', 'ATL', 'LGA', '4:30 PM', '6:30 PM', "2021-10-18", '400', '100'),
('5', 'JetBlue Airways', 'LGA', 'ATL', '11:00 AM', '1:00 PM', "2021-10-19", '400', '130'),
('6', 'Spirit Airlines', 'SJC', 'ATL', '12:30 PM', '9:30 PM', "2021-10-19", '650', '140'),
('7', 'WestJet', 'LGA', 'SJC', '1:00 PM', '4:00 PM', "2021-10-19", '700', '100'),
('8', 'Interjet', 'MIA', 'ORD', '7:30 PM', '9:30 PM', "2021-10-19", '350', '125'),
('9', 'Delta Airlines', 'JFK', 'ATL', '8:00 AM', '10:00 AM', "2021-10-20", '375', '150'),
('10', 'Delta Airlines', 'LAX', 'ATL', '9:15 AM', '6:15 PM', "2021-10-20", '700', '110'),
('11', 'Southwest Airlines', 'LAX', 'ORD', '12:07 PM', '7:07 PM', "2021-10-20", '600', '95'),
('12', 'United Airlines', 'MIA', 'ATL', '3:35 PM', '5:35 PM', "2021-10-20", '275', '115');

DROP TABLE IF EXISTS Book;
CREATE TABLE Book (
	email char(50) NOT NULL,
    flightNum char(2) NOT NULL,
    airlineName char(50) NOT NULL,
	numSeats decimal(1,0) NOT NULL,
    PRIMARY KEY(email, airlineName, flightNum),
    CONSTRAINT Book_ibfk_1 FOREIGN KEY (airlineName) REFERENCES Airline (airlineName),
    CONSTRAINT Book_ibfk_2 FOREIGN KEY (flightNum) REFERENCES Flight (flightNum),
    CONSTRAINT Book_ibfk_3 FOREIGN KEY (email) REFERENCES Account (email)
);

INSERT INTO Book VALUES
('swilson@gmail.com', '5', 'JetBlue Airways', 3),
('aray@tiktok.com', '1', 'Delta Airlines', 2),
('bshelton@gmail.com', '4', 'United Airlines', 4),
('lbryan@gmail.com', '7', 'WestJet', 2),
('tswift@gmail.com', '7', 'WestJet', 2),
('jseinfeld@gmail.com', '7', 'WestJet', 4),
('maddiesmith@gmail.com', '8', 'Interjet', 2),
('cbing10@gmail.com', '2', 'Southwest Airlines', 2),
('hwmit@gmail.com', '2', 'Southwest Airlines', 5);

DROP TABLE IF EXISTS IsCloseTo;
CREATE TABLE IsCloseTo (
	airportID char(3) NOT NULL,
    street char(50) NOT NULL,
	city char(50) NOT NULL,
	state char(2) NOT NULL,
	zip char(5) NOT NULL,
    distance char(2) NOT NULL,
    PRIMARY KEY(airportID, street, city, state, zip),
    CONSTRAINT IsCloseTo_ibfk_1 FOREIGN KEY (street, city, state, zip) REFERENCES Property (street, city, state, zip),
    CONSTRAINT IsCloseTo_ibfk_2 FOREIGN KEY (airportID) REFERENCES Airport (airportID)
);

INSERT INTO IsCloseTo VALUES
('ATL', '2nd St', 'ATL', 'GA', '30008', '12'),
('ATL', 'North Ave', 'ATL', 'GA', '30008', '7'),
('JFK', '123 Main St', 'NYC', 'NY', '10008', '10'),
('JFK', '1st St', 'NYC', 'NY', '10009', '8'),
('LGA', '123 Main St', 'NYC', 'NY', '10008', '25'),
('LGA', '1st St', 'NYC', 'NY', '10009', '19'),
('LAX', '10th St', 'LA', 'CA', '90008', '9'),
('LAX', 'Kings St', 'La', 'CA', '90011', '12'),
('SJC', 'Golden Bridge Pkwt', 'San Jose', 'CA', '90001', '8'),
('LAX', 'Golden Bridge Pkwt', 'San Jose', 'CA', '90001', '30'),
('LAX', 'Lebron Ave', 'LA', 'CA', '90011', '6'),
('ORD', 'Blackhawks St', 'Chicago', 'IL', '60176', '11'),
('ORD', '23rd Main St', 'Chicago', 'IL', '60176', '13'),
('MIA', '456 Beach Ave', 'Miami', 'FL', '33101', '21'),
('MIA', '1132 Beach Ave', 'Miami', 'FL', '33101', '19'),
('DFW', '17th Street', 'Dallas', 'TX', '75043', '8'),
('DFW', '1125 Longhorns Way', 'Dallas', 'TX', '75001', '17');


