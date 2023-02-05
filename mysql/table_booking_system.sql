-- Task 1  populate the Bookings table
INSERT INTO Bookings (booking_id, table_number, customer_id, booking_slot, employee_id, date)
VALUES
(7, 5, 1, '10:00:00', 1, '2022-10-10'),
(8, 3, 3, '10:00:00', 1, '2022-11-12'),
(9, 2, 2, '10:00:00', 1, '2022-10-11'),
(10, 2, 1, '10:00:00', 1, '2022-10-13');


-- Task 2 create a stored procedure called CheckBooking
DELIMITER //
CREATE PROCEDURE CheckOrderExistence(IN dateInput VARCHAR(10), IN tableNumber INT)
BEGIN
  DECLARE orderExists INT DEFAULT 0;
  SELECT count(*) INTO orderExists FROM bookings WHERE date = dateInput AND table_number = tableNumber;
  IF orderExists > 0 THEN
    SELECT concat('Table ', tableNumber, ' is already booked') AS 'Booking Status';
  ELSE
    SELECT concat('Table ', tableNumber, ' is not booked') AS 'Booking Status';
  END IF;
END //
DELIMITER ;

CALL CheckOrderExistence('22-11-12', 3);


-- Task 3 verify a booking using procedure and transaction statement
DELIMITER //
CREATE PROCEDURE AddValidBooking(IN dateInput VARCHAR(10), IN tableNumber INT, IN customer_id INT)
BEGIN

  DECLARE orderExists INT DEFAULT 0;
  
  START TRANSACTION;
  insert into bookings (table_number, customer_id, booking_slot, employee_id, date)
  values (tableNumber, customer_id, '10:00:00', 1, dateInput);
  
  SELECT count(*) INTO orderExists FROM bookings WHERE date = dateInput AND table_number = tableNumber;
  IF orderExists > 1 THEN
	ROLLBACK;
    SELECT concat('Table ', tableNumber, ' is already booked - booking canceled') AS 'Booking Status';
  ELSE
	COMMIT;
    SELECT concat('Table ', tableNumber, ' is booked for you - booking approved') AS 'Booking Status';
  END IF;
END //
DELIMITER ;

CALL AddValidBooking('22-12-17', 6, 1);


-- Task 1 create a new procedure called AddBooking to add a new table booking record
DELIMITER //
CREATE PROCEDURE AddBooking (
	IN booking_id INT,
	IN customer_id INT,
	IN dateInput VARCHAR(10),
	IN tableNumber INT
	)
BEGIN
insert into bookings (booking_id, table_number, customer_id, booking_slot, employee_id, date)
  values (booking_id, tableNumber, customer_id, '10:00:00', 1, dateInput);
SELECT 'New booking added' AS 'Confirmation';
END //
DELIMITER ;

CALL AddBooking(13, 1, '2022-3-10', 5);

-- Task 2 create a new procedure called UpdateBooking that they can use to update existing bookings in the booking table
DELIMITER //
CREATE PROCEDURE UpdateBooking (
	IN booking_id INT,
	IN dateInput VARCHAR(10)
	)
BEGIN
	UPDATE bookings
	SET date = dateInput
	WHERE bookings.booking_id = booking_id;
	SELECT concat('Booking ',booking_id,' updated') AS 'Confirmation';
END //
DELIMITER ;

CALL UpdateBooking(13,'2023-3-10');

-- Task 3  create a new procedure called CancelBooking that they can use to cancel or remove a booking.
DELIMITER //
CREATE PROCEDURE CancelBooking (IN booking_id INT)
BEGIN
	DELETE FROM bookings WHERE bookings.booking_id=booking_id;
	SELECT concat('Booking ',booking_id,' cancelled') AS 'Confirmation';
END //
DELIMITER ;

CALL CancelBooking(13);




