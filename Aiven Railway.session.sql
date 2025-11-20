
-- Passengers Table
CREATE TABLE Passengers (
    passenger_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(200) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trains Table
CREATE TABLE Trains (
    train_id INT AUTO_INCREMENT PRIMARY KEY,
    train_number VARCHAR(20) UNIQUE NOT NULL,
    train_name VARCHAR(100) NOT NULL,
    source VARCHAR(100),
    destination VARCHAR(100),
    total_seats INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Train Schedules Table

CREATE TABLE TrainSchedules (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    train_id INT,
    travel_date DATE,
    departure_time TIME,
    arrival_time TIME,
    available_seats INT,
    FOREIGN KEY (train_id) REFERENCES Trains(train_id)
);

-- Booking Table
CREATE TABLE Booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    passenger_id INT,
    schedule_id INT,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    booking_status VARCHAR(20) DEFAULT 'BOOKED',
    FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id),
    FOREIGN KEY (schedule_id) REFERENCES TrainSchedules(schedule_id)
);


-- Booking Details Table
CREATE TABLE BookingDetails (
    detail_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    seat_no INT,
    coach VARCHAR(20),
    class VARCHAR(20),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);


-- Payment Table
CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT UNIQUE,
    amount DECIMAL(10,2),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'PAID',
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);


-- insert the sample data 5 rows in each tables

INSERT INTO Passengers (name, email, password, phone, address) VALUES
('Aman Kumar', 'aman@gmail.com', 'pass123', '9876543210', 'Patna, Bihar'),
('Riya Sharma', 'riya@gmail.com', 'pass456', '9998887776', 'Delhi, India'),
('Rohan Verma', 'rohan@gmail.com', 'rohan789', '9988776655', 'Mumbai, India'),
('Simran Kaur', 'simran@gmail.com', 'simran321', '9090808070', 'Chandigarh, India'),
('Vikram Singh', 'vikram@gmail.com', 'vikram654', '9123456780', 'Jaipur, Rajasthan');

select * from Passengers;


-- insert into trains table

INSERT INTO Trains (train_number, train_name, source, destination, total_seats) VALUES
('12301', 'Rajdhani Express', 'Delhi', 'Mumbai', 100),
('12951', 'Mumbai Superfast', 'Mumbai', 'New Delhi', 120),
('12296', 'Sanghamitra Express', 'Patna', 'Bangalore', 150),
('12046', 'Dehradun Shatabdi', 'Dehradun', 'New Delhi', 110),
('22120', 'Mumbai Express', 'Mumbai', 'Chennai', 140);

select * from Trains;

-- insert into trainSchedule

INSERT INTO TrainSchedules (train_id, travel_date, departure_time, arrival_time, available_seats) VALUES
(1, '2025-12-05', '18:00:00', '10:00:00', 100),
(2, '2025-12-08', '06:30:00', '14:20:00', 120),
(3, '2025-12-09', '05:45:00', '20:00:00', 150),
(4, '2025-12-11', '07:00:00', '11:45:00', 110),
(5, '2025-12-12', '16:15:00', '09:30:00', 140);

select * from TrainSchedules;

-- check befor inserting in bookings 
SELECT schedule_id, train_id FROM TrainSchedules;

-- create a view for BookingSummary

CREATE OR REPLACE VIEW BookingSummary AS
SELECT 
    b.booking_id,
    p.name AS passenger_name,
    t.train_name,
    ts.travel_date,
    ts.departure_time,
    bd.seat_no,
    bd.coach,
    pay.amount,
    b.booking_status
FROM Booking b
JOIN Passengers p ON b.passenger_id = p.passenger_id
JOIN TrainSchedules ts ON b.schedule_id = ts.schedule_id
JOIN Trains t ON ts.train_id = t.train_id
LEFT JOIN BookingDetails bd ON b.booking_id = bd.booking_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id;


SELECT * FROM BookingSummary;



-- use of the triggers to automatically decrease the seats while booking

CREATE TRIGGER trg_reduce_seats_after_booking
AFTER INSERT ON Booking
FOR EACH ROW
UPDATE TrainSchedules
SET available_seats = available_seats - 1
WHERE schedule_id = NEW.schedule_id;


-- auto update on cancellation

-- triggers

CREATE TRIGGER trg_restore_seats_after_cancel
AFTER UPDATE ON Booking
FOR EACH ROW
BEGIN
    IF NEW.booking_status = 'CANCELLED' AND OLD.booking_status <> 'CANCELLED' THEN
        UPDATE TrainSchedules
        SET available_seats = available_seats + 1
        WHERE schedule_id = NEW.schedule_id;
    END IF;
END;


SELECT schedule_id, available_seats FROM TrainSchedules;


-- insert data in booking 
INSERT INTO Booking (passenger_id, schedule_id, booking_date, booking_status) VALUES
(1, 1, NOW(), 'BOOKED'),
(2, 2, NOW(), 'BOOKED'),
(3, 3, NOW(), 'BOOKED'),
(4, 4, NOW(), 'BOOKED'),
(5, 5, NOW(), 'BOOKED');



-- insert data in bookDetails
INSERT INTO BookingDetails (booking_id, seat_no, coach, `class`) VALUES
(1, 45, 'B1', '3AC'),
(2, 12, 'S2', 'Sleeper'),
(3, 7, 'A1', '2AC'),
(4, 21, 'C1', 'CC'),
(5, 30, 'B2', '3AC');

SELECT * FROM BookingDetails;



--insert data in payment table

INSERT INTO Payment (booking_id, amount, status) VALUES
(1, 1550.00, 'PAID'),
(2, 980.50, 'PAID'),
(3, 2200.00, 'PAID'),
(4, 1120.75, 'PAID'),
(5, 1750.00, 'PAID');


SELECT * FROM BookingSummary;


-- show triggers

SHOW TRIGGERS;

-- check data before any update

SELECT schedule_id, available_seats FROM TrainSchedules;

-- decrease the seats by one in schedule_id=1
INSERT INTO Booking (passenger_id, schedule_id, booking_date, booking_status)
VALUES (1, 1, NOW(), 'BOOKED');

SELECT schedule_id, available_seats FROM TrainSchedules;



INSERT INTO BookingDetails (booking_id, seat_no, coach, class)
VALUES (LAST_INSERT_ID(), 51, 'B1', '3AC');

INSERT INTO Payment (booking_id, amount, status)
VALUES (LAST_INSERT_ID(), 1550.00, 'PAID');

-- cancel the booking 

-- search last booking
SELECT * FROM Booking ORDER BY booking_id DESC LIMIT 1;

-- cancel the last booking_id given by above statement

UPDATE Booking
SET booking_status = 'CANCELLED'
WHERE booking_id = 6;

SELECT schedule_id, available_seats FROM TrainSchedules;

SELECT * FROM BookingSummary;



-- creating view for train availability

CREATE OR REPLACE VIEW TrainAvailability AS
SELECT 
    t.train_id,
    t.train_number,
    t.train_name,
    t.source,
    t.destination,
    ts.schedule_id,
    ts.travel_date,
    ts.available_seats
FROM Trains t
JOIN TrainSchedules ts ON t.train_id = ts.train_id;

select * from TrainAvailability;
--Revenue Report View

CREATE OR REPLACE VIEW RevenueReport AS
SELECT 
    t.train_name,
    ts.travel_date,
    SUM(pay.amount) AS total_revenue,
    COUNT(b.booking_id) AS total_bookings
FROM Booking b
JOIN TrainSchedules ts ON b.schedule_id = ts.schedule_id
JOIN Trains t ON ts.train_id = t.train_id
JOIN Payment pay ON pay.booking_id = b.booking_id
WHERE b.booking_status = 'BOOKED'
GROUP BY t.train_name, ts.travel_date
ORDER BY travel_date;

select * from RevenueReport;

-- now creating the stored procedure

--BookTicket()
DROP PROCEDURE IF EXISTS BookTicket;

select * from BookingDetails;

ALTER TABLE BookingDetails
CHANGE COLUMN seat_class class VARCHAR(20);

CREATE PROCEDURE BookTicket(
    IN p_passenger_id INT,
    IN p_schedule_id INT,
    IN p_seat_no INT,
    IN p_coach VARCHAR(20),
    IN p_class VARCHAR(20),
    IN p_amount DECIMAL(10,2)
)
BEGIN
    DECLARE v_bid INT DEFAULT 0;

    INSERT INTO Booking (passenger_id, schedule_id, booking_date, booking_status)
    VALUES (p_passenger_id, p_schedule_id, NOW(), 'BOOKED');

    SET v_bid = LAST_INSERT_ID();

    INSERT INTO BookingDetails (booking_id, seat_no, coach, class)
    VALUES (v_bid, p_seat_no, p_coach, p_class);

    INSERT INTO Payment (booking_id, amount, status)
    VALUES (v_bid, p_amount, 'PAID');
END;


CALL BookTicket(1, 1, 50, 'B3', '3AC', 1400.00);


SELECT * FROM Booking ORDER BY booking_id DESC LIMIT 3;
SELECT * FROM BookingDetails ORDER BY detail_id DESC LIMIT 3;
SELECT * FROM Payment ORDER BY payment_id DESC LIMIT 3;
