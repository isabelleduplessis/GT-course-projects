-- CS4400: Introduction to Database Systems (Fall 2021)
-- Phase III: Stored Procedures & Views [v0] Tuesday, November 9, 2021 @ 12:00am EDT
-- Team 78
-- Eric Darling
-- Claudia Dwortz
-- Isabelle Du Plessis
-- Directions:
-- Please follow all instructions for Phase III as listed on Canvas.
-- Fill in the team number and names and GT usernames for all members above.

-- ID: 1a
-- Name: register_customer
drop procedure if exists register_customer;
delimiter //
create procedure register_customer (
    in i_email varchar(50),
    in i_first_name varchar(100),
    in i_last_name varchar(100),
    in i_password varchar(50),
    in i_phone_number char(12),
    in i_cc_number varchar(19),
    in i_cvv char(3),
    in i_exp_date date,
    in i_location varchar(50)
) 
sp_main: begin

	IF i_email IN (SELECT Email FROM Owners)
    AND i_email NOT IN (SELECT Email FROM Customer)
    THEN INSERT INTO Customer(Email, CcNumber, Cvv, Exp_Date, Location)
		VALUES (i_email, i_cc_number, i_cvv, i_exp_date, i_location);
    ELSE
		IF i_email IN (SELECT Email FROM Customer) 
        THEN leave sp_main; END IF;
        IF i_phone_number IN (SELECT Phone_Number FROM Clients)
        THEN leave sp_main; END IF;
        IF i_cc_number IN (SELECT CcNumber FROM Customer) 
        THEN leave sp_main; END IF;
        INSERT INTO Accounts(Email, First_Name, Last_Name, Pass)
			VALUES (i_email, i_first_name, i_last_name, i_password);
		INSERT INTO Clients(Email, Phone_Number)
			VALUES (i_email, i_phone_number);
		INSERT INTO Customer(Email, CcNumber, Cvv, Exp_Date, Location)
			VALUES (i_email, i_cc_number, i_cvv, i_exp_date, i_location);
	END IF;
    
-- End of solution    
end //
delimiter ;

-- ID: 1b
-- Name: register_owner
drop procedure if exists register_owner;
delimiter //
create procedure register_owner (
    in i_email varchar(50),
    in i_first_name varchar(100),
    in i_last_name varchar(100),
    in i_password varchar(50),
    in i_phone_number char(12)
) 
sp_main: begin

	IF i_email IN (SELECT Email FROM Clients)
    AND i_email NOT IN (SELECT Email FROM Owners)
    THEN INSERT INTO Owners(Email)
		VALUES (i_email);
    ELSE
		IF i_email IN (SELECT Email FROM Owners) 
        THEN leave sp_main; END IF;
        IF i_phone_number IN (SELECT Phone_Number FROM Clients)
        THEN leave sp_main; END IF;
        INSERT INTO Accounts(Email, First_Name, Last_Name, Pass)
			VALUES (i_email, i_first_name, i_last_name, i_password);
		INSERT INTO Clients(Email, Phone_Number)
			VALUES (i_email, i_phone_number);
		INSERT INTO Owners(Email)
			VALUES (i_email);
	END IF;

end //
delimiter ;

-- ID: 1c
-- Name: remove_owner
drop procedure if exists remove_owner;
delimiter //
create procedure remove_owner ( 
    in i_owner_email varchar(50)
)
sp_main: begin
	-- If an owner has no listed properties --
	IF i_owner_email IN (SELECT Owner_Email FROM Property)
    THEN leave sp_main; END IF;
    
    -- If an owner is deleted, their reviews of customers should be deleted as well --
    DELETE FROM Owners_Rate_Customers WHERE Owner_Email = i_owner_email;
    
    -- If an owner is deleted, customer reviews of the owner should be deleted as well --
    DELETE FROM Review WHERE Owner_Email = i_owner_email;
    
    -- Only the owner should be removed from the system – if the owner is also a customer -- 
    DELETE FROM Owners WHERE Email = i_owner_email;
    
    IF i_owner_email IN (SELECT Email FROM Customer) 
    THEN leave sp_main; END IF;
    
    -- Then the customer should remain in the system. If the owner is not also a customer, then the client and account associated with this owner should be removed as well --
    DELETE FROM Clients WHERE Email = i_owner_email;
    DELETE FROM Accounts WHERE Email = i_owner_email;
end //
delimiter ;

-- ID: 2a
-- Name: schedule_flight
drop procedure if exists schedule_flight;
delimiter //
create procedure schedule_flight (
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_from_airport char(3),
    in i_to_airport char(3),
    in i_departure_time time,
    in i_arrival_time time,
    in i_flight_date date,
    in i_cost decimal(6, 2),
    in i_capacity int,
    in i_current_date date
)
sp_main: begin
	IF i_flight_num IN (SELECT Flight_Num FROM Flight)
    AND i_airline_name IN (SELECT Airline_Name FROM Flight)
    THEN leave sp_main; END IF;
    
    IF i_to_airport = i_from_airport
    THEN leave sp_main; END IF;
    
    IF i_current_date > i_flight_date
    THEN leave sp_main; END IF;
    
    INSERT INTO Flight(Flight_Num, Airline_Name, From_Airport, To_Airport, Departure_Time, Arrival_Time, Flight_Date, Cost, Capacity)
		VALUES (i_flight_num, i_airline_name, i_from_airport, i_to_airport, i_departure_time, i_arrival_time, i_flight_date, i_cost, i_capacity);
end //
delimiter ;


-- ID: 2b
-- Name: remove_flight
drop procedure if exists remove_flight;
delimiter //
create procedure remove_flight ( 
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_current_date date
) 
sp_main: begin
	IF i_current_date > (SELECT Flight_Date FROM Flight WHERE i_flight_num = Flight_Num AND i_airline_name = Airline_Name)
    THEN leave sp_main; END IF;
    
    DELETE FROM Book WHERE Flight_Num = i_flight_num AND Airline_Name = i_airline_name;
    DELETE FROM Flight WHERE Flight_Num = i_flight_num AND Airline_Name = i_airline_name;
end //
delimiter ;

-- ID: 3a
-- Name: book_flight
drop procedure if exists book_flight;
delimiter //
create procedure book_flight (
    in i_customer_email varchar(50),
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_num_seats int,
    in i_current_date date
)
sp_main: begin
IF (SELECT Capacity FROM Flight WHERE Flight_Num = i_flight_num AND Airline_Name = i_airline_name) - i_num_seats - (SELECT SUM(Num_Seats) FROM Book WHERE Flight_Num = i_flight_num AND Airline_Name = i_airline_name) < 0 
THEN leave sp_main; END IF;

IF (SELECT Flight_Date FROM Flight WHERE Flight_Num = i_flight_num and Airline_Name = i_airline_name) < i_current_date 
THEN leave sp_main; END IF;

IF i_customer_email IN (SELECT Customer FROM Book WHERE Flight_Num = i_flight_num AND Airline_Name = i_airline_name and Was_Cancelled = 1) 
THEN leave sp_main; END IF;
IF i_customer_email IN (SELECT Customer FROM Book WHERE Flight_Num = i_flight_num AND Airline_Name = i_airline_name AND Was_Cancelled = 0) THEN UPDATE Book SET Num_Seats = Num_Seats + i_num_seats WHERE Customer = i_customer_email AND Flight_Num = i_flight_num AND Airline_Name = i_airline_name;
leave sp_main; END IF;

IF EXISTS (SELECT * FROM Book WHERE Customer = i_customer_email AND Was_Cancelled = 0 AND 
(SELECT Flight_Date FROM Flight WHERE Flight_Num = i_flight_num AND Airline_Name = i_airline_name) IN 
(SELECT Flight_Date FROM Flight WHERE Flight_Num IN 
(SELECT Flight_Num FROM Book WHERE Customer = i_customer_email AND Flight_Num != i_flight_num) AND 
Airline_Name IN (SELECT Airline_Name FROM Book WHERE Customer = i_customer_email AND Airline_Name != i_airline_name))) 
THEN leave sp_main; END IF;

INSERT INTO Book VALUES (i_customer_email, i_flight_num, i_airline_name, i_num_seats, 0);

end //
delimiter ;

-- ID: 3b
-- Name: cancel_flight_booking
drop procedure if exists cancel_flight_booking;
delimiter //
create procedure cancel_flight_booking ( 
    in i_customer_email varchar(50),
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_current_date date
)
sp_main: begin
	IF i_flight_num IN (SELECT Flight_Num FROM Book)
    AND i_airline_name IN (SELECT Airline_Name FROM Book)
    AND i_current_date > (SELECT Flight_Date FROM Flight WHERE (Flight_Num = i_flight_num AND Airline_Name = i_airline_name))
    THEN leave sp_main; END IF;
    
    UPDATE Book SET Was_Cancelled = True WHERE (Flight_Num = i_flight_num AND Airline_Name = i_airline_name);
end //
delimiter ;


-- ID: 3c
-- Name: view_flight
create or replace view view_flight (
    flight_id,
    flight_date,
    airline,
    destination,
    seat_cost,
    num_empty_seats,
    total_spent
) as
select Flight.Flight_Num AS flight_id,
Flight_Date AS flight_date, 
Flight.Airline_Name AS airline, 
To_Airport AS destination, 
Cost AS seat_cost, 
ifnull(Capacity + sum(if(Was_Cancelled = 1, 0, -Num_Seats)), Capacity) AS num_empty_seats,
ifnull(sum(if(Was_Cancelled = 1, Num_Seats*Cost*0.2, Num_Seats*Cost)), 0) AS total_spent
FROM Flight LEFT OUTER JOIN Book ON Flight.Flight_Num = Book.Flight_Num
GROUP BY Flight.Flight_Num, Flight.Airline_Name;

-- ID: 4a
-- Name: add_property
drop procedure if exists add_property;
delimiter //
create procedure add_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_description varchar(500),
    in i_capacity int,
    in i_cost decimal(6, 2),
    in i_street varchar(50),
    in i_city varchar(50),
    in i_state char(2),
    in i_zip char(5),
    in i_nearest_airport_id char(3),
    in i_dist_to_airport int
) 
sp_main: begin
-- address must be unique
if i_street IN (SELECT Street from Property)
AND i_city IN (SELECT City from Property)
AND i_state IN (SELECT State from Property)
AND i_zip IN (SELECT Zip from Property)
then leave sp_main; end if;

-- property name and owner's email have to be unique combined
if i_property_name in (select Property_Name from Property)
AND i_owner_email in (select Owner_Email from Property)
then leave sp_main; end if;

-- if nearest airport and dist to nearest airport given, create entry in isCloseTo table
if (i_nearest_airport_id is null or i_dist_to_airport is null)
then INSERT INTO Property(Property_Name,Owner_Email,Descr,Capacity,Cost,Street,City,State,Zip)
VALUES (i_property_name, i_owner_email, i_description, i_capacity, i_cost, i_street, i_city, i_state, i_zip);
end if;

if (i_nearest_airport_id is not null and i_dist_to_airport is not null)
then INSERT INTO Property(Property_Name,Owner_Email,Descr,Capacity,Cost,Street,City,State,Zip)
	VALUES (i_property_name, i_owner_email, i_description, i_capacity, i_cost, i_street, i_city, i_state, i_zip);
INSERT INTO Is_Close_To(Property_Name,Owner_Email,Airport, Distance)
	VALUES (i_property_name, i_owner_email, i_nearest_airport_id, i_dist_to_airport);
end if;
end //
delimiter ;

-- ID: 4b
-- Name: remove_property
drop procedure if exists remove_property;
delimiter //
create procedure remove_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_current_date date
)
sp_main: begin
-- the property is not reserved for the current date (unless the reservation is cancelled: if 
	-- the current reservation was cancelled, proceed with removal)
    if i_current_date <= (select End_Date from Reserve where Property_Name = i_property_name)
    AND i_current_date >= (select Start_Date from Reserve where Property_Name = i_property_name)
    AND 0 = (select Was_Cancelled from Reserve where Property_Name = i_property_name and i_current_date <= End_Date and i_current_date >= Start_Date)
    then leave sp_main; end if;
    
    -- all past and future reservations of this property should also be deleted
	DELETE FROM Reserve WHERE Property_Name = i_property_name;
    
    -- the reviews for the property must be removed when the property is unlisted
    DELETE FROM Property WHERE Property_Name = i_property_name;
    
    -- the amenities of the property must be removed when the property is unlisted
    delete from Amenities where Property_Name = i_property_name;
    
    -- the property must be unlisted from being in proximity to nearby airports
    delete from Is_Close_To where Property_Name = i_property_name;
end //
delimiter ;


-- ID: 5a
-- Name: reserve_property
drop procedure if exists reserve_property;
delimiter //
create procedure reserve_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_customer_email varchar(50),
    in i_start_date date,
    in i_end_date date,
    in i_num_guests int,
    in i_current_date date
)
sp_main: begin
	if i_property_name in (select Property_Name from Reserve)
    AND i_owner_email in (select Owner_Email from Reserve)
    AND i_customer_email in (select Customer from Reserve)
    then leave sp_main; end if;
    
    -- start date in the future
    if i_start_date <= i_current_date then leave sp_main; end if;
    
    -- customer doesn't have another reservation that overlaps w dates
    if i_start_date <= (select End_Date from Reserve where Customer = i_customer_email)
    AND i_start_date >= (select Start_Date from Reserve where Customer = i_customer_email)
    OR i_end_date <= (select End_Date from Reserve where Customer = i_customer_email)
    AND i_end_date >= (select Start_Date from Reserve where Customer = i_customer_email)
    then leave sp_main; end if;
    
    -- The available capacity for the property during the span of dates must be greater than or 
	-- equal to i_num_guests during the span of dates provided
	if i_num_guests >= (select 
						(select MIN(Capacity) from Property group by Property_Name having Property_Name = i_property_name) -
						(select SUM(Num_Guests) from Reserve where i_start_date <= Reserve.Start_Date AND Reserve.Start_Date >= i_end_date
						OR i_start_date <= End_Date AND End_Date <= i_end_date
						group by Property_Name having Property_Name = i_property_name))
    then leave sp_main; end if;

	insert into Reserve(Property_Name,Owner_Email,Customer,Start_Date,End_Date,Num_Guests,Was_Cancelled)
    values(i_property_name, i_owner_email, i_customer_email, i_start_date, i_end_date, i_num_guests, 0);
end //
delimiter ;


-- ID: 5b
-- Name: cancel_property_reservation
drop procedure if exists cancel_property_reservation;
delimiter //
create procedure cancel_property_reservation (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_customer_email varchar(50),
    in i_current_date date
)
sp_main: begin
	IF i_property_name NOT IN (SELECT Property_Name FROM Reserve)
	-- OR i_owner_email NOT IN (SELECT Owner_Email FROM Reserve)
    AND i_customer_email NOT IN (SELECT Customer from Reserve)
    THEN leave sp_main; END IF;
    
    if 0 = (select was_cancelled from reserve where property_name = i_property_name and owner_email = i_owner_email and customer = i_customer_email)
	and i_current_date < (select start_date from reserve where property_name = i_property_name and customer = i_customer_email and owner_email = i_owner_email)
	then update reserve set was_cancelled = 1
	where property_name = i_property_name and owner_email = i_owner_email and customer = i_customer_email; end if;
end //
delimiter ;

-- ID: 5c
-- Name: customer_review_property
drop procedure if exists customer_review_property;
delimiter //
create procedure customer_review_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_customer_email varchar(50),
    in i_content varchar(500),
    in i_score int,
    in i_current_date date
)
sp_main: begin
	if (i_property_name) in (select Property_Name from Review)
	AND (i_customer_email) in (select Customer from Review)
	AND (i_owner_email) in (select Owner_Email from Review)
    AND i_current_date < (select Start_Date from Reserve where Property_Name = i_property_name and Owner_Email = i_owner_email and Customer = i_customer_email)
    AND 1 = (select Was_Cancelled from Reserve where Property_Name = i_property_name and Owner_Email = i_owner_email and Customer = i_customer_email)
	then leave sp_main; end if;

	insert into Review(Property_Name,Owner_Email,Customer,Content,Score)
	values(i_property_name, i_owner_email, i_customer_email, i_content, i_score);

end //
delimiter ;

-- ID: 5d
-- Name: view_properties
create or replace view view_properties (
    property_name, 
    average_rating_score, 
    description, 
    address, 
    capacity, 
    cost_per_night
) as
select Property.Property_Name AS property_name,
AVG(Review.Score) AS average_rating_score, 
Property.Descr AS description, 
concat(Property.Street, ", ", Property.City, ", ", Property.State, ", ", Property.Zip) AS address, 
Property.Capacity AS capacity, 
Property.Cost AS cost_per_night
from Property LEFT OUTER JOIN Review ON Property.Property_Name = Review.Property_Name AND Property.Owner_Email = Review.Owner_Email
GROUP BY Property.Property_Name,Property.Owner_Email
HAVING Property.Property_Name = property_name;

-- ID: 5e
-- Name: view_individual_property_reservations
drop procedure if exists view_individual_property_reservations;
delimiter //
create procedure view_individual_property_reservations (
    in i_property_name varchar(50),
    in i_owner_email varchar(50)
)
sp_main: begin
    drop table if exists view_individual_property_reservations;
    create table view_individual_property_reservations (
        property_name varchar(50),
        start_date date,
        end_date date,
        customer_email varchar(50),
        customer_phone_num char(12),
        total_booking_cost decimal(6,2),
        rating_score int,
        review varchar(500)
    ) as
    -- TODO: replace this select query with your solution
    select (SELECT Property_Name FROM Reserve WHERE Property_Name = property_name AND Customer = customer_email) AS property_name,
    (SELECT Start_Date FROM Reserve WHERE Property_Name = property_name AND Customer = customer_email) AS start_date,
    (SELECT End_Date FROM Reserve WHERE Property_Name = property_name AND Customer = customer_email) AS end_date,
    (SELECT Customer FROM Reserve WHERE Property_Name = property_name AND Customer = customer_email) AS customer_email,
    (SELECT Clients.Phone_Number FROM Reserve JOIN Clients ON Reserve.Customer = Clients.Email WHERE Reserve.Property_Name = property_name AND Reserve.Customer = customer) AS customer_phone_num,
    (SELECT SUM(Cost) FROM Reserve JOIN Property ON Reserve.Owner_Email = Property.Owner_Email WHERE Reserve.Property_Name = property_name AND Reserve.Customer = customer AND Property.Was_Cancelled = 0) AS total_booking_cost,
    (SELECT Review.Score FROM Reserve JOIN Review ON Reserve.Owner_Email = Review.Owner_Email WHERE Reserve.Property_Name = property_name AND Reserve.Customer = customer) AS rating_score,
    (SELECT Review.Content FROM Reserve JOIN Review ON Reserve.Owner_Email = Review.Owner_Email WHERE Reserve.Property_Name = property_name AND Reserve.Customer = customer) AS review from Reserve;

end //
delimiter ;


-- ID: 6a
-- Name: customer_rates_owner
drop procedure if exists customer_rates_owner;
delimiter //
create procedure customer_rates_owner (
    in i_customer_email varchar(50),
    in i_owner_email varchar(50),
    in i_score int,
    in i_current_date date
)
sp_main: begin
-- customer and owner both exist
    if i_customer_email not in (select Email from Customer)
    OR i_owner_email not in (select Email from Owners)
    then leave sp_main; end if;
	
    -- combo of customer email and owner email has to be unique in customer_rates_owner table
    if i_customer_email in (select Customer from Customers_Rate_Owners)
    AND i_owner_email in (select Owner_Email from Customers_Rate_Owners)
    then leave sp_main; end if;
    
	-- The customer has stayed at a property owned by the owner at some point in the past 
	-- (use current date for comparison) and the reservation was not cancelled 
	if i_current_date < (SELECT Start_Date FROM Reserve JOIN Property ON Reserve.Owner_Email = Property.Owner_Email 
						WHERE Reserve.Owner_Email = i_owner_email AND Reserve.Customer = i_customer_email AND Was_Cancelled = 0)
	then leave sp_main; end if;
    
    insert into Customers_Rate_Owners(Customer,Owner_Email,Score)
    values (i_customer_email, i_owner_email, i_score);
end //
delimiter ;


-- ID: 6b
-- Name: owner_rates_customer
drop procedure if exists owner_rates_customer;
delimiter //
create procedure owner_rates_customer (
    in i_owner_email varchar(50),
    in i_customer_email varchar(50),
    in i_score int,
    in i_current_date date
)
sp_main: begin
-- The customer and owner must both exist in the database --
    IF i_customer_email NOT IN (SELECT Email FROM Customer)
    OR i_owner_email NOT IN (SELECT Email FROM Owners)
    THEN leave sp_main; END IF;

-- The customer has stayed at a property owned by the owner at some point in the past and the reservation was not cancelled --
	IF i_customer_email IN (SELECT Customer FROM Owners_Rate_Customers)
    AND i_owner_email IN (SELECT Owner_Email FROM Owners_Rate_Customers)
    OR i_current_date < (SELECT Start_Date FROM Reserve JOIN Property ON Reserve.Owner_Email = Property.Owner_Email WHERE Reserve.Owner_Email = i_owner_email AND Reserve.Customer = i_customer_email AND Was_Cancelled = 0)
    THEN leave sp_main; END IF;
    
	INSERT INTO Owners_Rate_Customers(Owner_Email, Customer, Score) 
		VALUES (i_owner_email, i_customer_email, i_score);

end //
delimiter ;


-- ID: 7a
-- Name: view_airports
create or replace view view_airports (
    airport_id, 
    airport_name, 
    time_zone, 
    total_arriving_flights, 
    total_departing_flights, 
    avg_departing_flight_cost
) as  
select (SELECT Airport_Id FROM Airport WHERE Airport_Id = airport_id) AS airport_id, 
(SELECT Airport_Name FROM Airport WHERE Airport_Id = airport_id) AS airport_name, 
(SELECT Time_Zone FROM Airport WHERE Airport_Id = airport_id) AS time_zone, 
(SELECT COUNT(*) FROM Airport JOIN Flight ON Airport.Airport_Name = airport_name GROUP BY Flight.Flight_Num,Flight.Airline_Name HAVING Flight.To_Airport = airport_name AND Airport.Airport_Id = airport_id) AS total_arriving_flights, 
(SELECT COUNT(*) FROM Airport JOIN Flight ON Airport.Airport_Name = airport_name GROUP BY Flight.Flight_Num,Flight.Airline_Name HAVING Flight.From_Airport = airport_name AND Airport.Airport_Id = airport_id) AS total_departing_flights, 
(SELECT AVG(Flight.Cost) FROM Airport JOIN Flight ON Airport.Airport_Name = airport_name GROUP BY Flight.Flight_Num,Flight.Airline_Name HAVING Flight.From_Airport = airport_name AND Airport.Airport_Id = airport_id) AS avg_departing_flight_cost from Airport;

-- ID: 7b
-- Name: view_airlines
create or replace view view_airlines (
    airline_name, 
    rating, 
    total_flights, 
    min_flight_cost
) as
select 
(SELECT Airline.Airline_Name, Airline.Rating, Flight.Flight_Num, Flight.Cost FROM Airline 
NATURAL JOIN Flight 
GROUP BY Airline_Name)
UNION (SELECT Airline_Name, Rating, 0, NULL FROM Airline WHERE Airline_Name NOT IN (SELECT Airline_Name FROM Flight));

-- ID: 8a
-- Name: view_customers
create or replace view view_customers (
    customer_name, 
    avg_rating, 
    location, 
    is_owner, 
    total_seats_purchased
) as
-- TODO: replace this select query with your solution
-- view customers
select concat(Accounts.first_name, " ", Accounts.last_name) AS customer_name,
AVG(Rate.score) AS avg_rating, Customer.Location as location,
CASE WHEN Owners.Email IS NOT NULL THEN 1 ELSE 0 END AS is_owner,
CASE WHEN SUM(Book.num_seats) IS NOT NULL THEN SUM(Book.num_seats) ELSE 0 END AS total_seats_purchased
FROM Customer customer NATURAL JOIN Accounts Accounts
LEFT OUTER JOIN Owners_Rate_Customers Rate ON Customer.email = Rate.customer
LEFT OUTER JOIN Book Book ON Customer.Email = Book.Customer
LEFT OUTER JOIN Owners Owners ON Customer.Email = Owners.Email
GROUP BY Customer.Email;

-- ID: 8b
-- Name: view_owners
create or replace view view_owners (
    owner_name, 
    avg_rating, 
    num_properties_owned, 
    avg_property_rating
) as
select concat(Accounts.First_Name, " ", Accounts.Last_Name) AS owner_name, AVG(c_r_o.Score) AS avg_rating, COUNT(DISTINCT props.Property_Name) as num_properties_owned, AVG(reviewing.Score) AS avg_property_rating
FROM Owners Owners NATURAL JOIN Accounts Accounts
LEFT OUTER JOIN Customers_Rate_Owners c_r_o ON c_r_o.Owner_Email = Owners.Email
LEFT OUTER JOIN Property props ON Owners.Email = props.Owner_Email
LEFT OUTER JOIN Review reviewing ON reviewing.Owner_Email = Owners.Email
GROUP BY Owners.Email;

-- ID: 9a
-- Name: process_date
drop procedure if exists process_date;
delimiter //
create procedure process_date ( 
    in i_current_date date
)
sp_main: begin
	DROP VIEW IF EXISTS book_nc;
    CREATE VIEW book_nc AS (SELECT * FROM Book NATURAL JOIN Flight);
    UPDATE Customer RIGHT JOIN book_nc ON Customer.Email = book_nc.Customer
    SET Customer.Location = (SELECT State FROM Airport WHERE Airport.Airport_Id = book_nc.To_Airport)
    WHERE (book_nc.Was_Cancelled = 0 AND book_nc.Flight_Date = i_current_date);
end //
delimiter ;
