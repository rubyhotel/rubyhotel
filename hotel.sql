DROP TABLE Reserve;
DROP TABLE Booking;
DROP TABLE Employee;
DROP TABLE Facility;
DROP TABLE Guest;
DROP TABLE Room;
DROP TABLE Location;

CREATE TABLE Location (
  locationId INT(11) AUTO_INCREMENT,
  locationName CHAR(100),
  address    CHAR(100)     NOT NULL,
  phoneNum   CHAR(10),
  PRIMARY KEY (locationId)
);

CREATE TABLE Employee (
  employeeId INT(11) AUTO_INCREMENT,
  username   CHAR(100)     NOT NULL UNIQUE,
  password   CHAR(255)     NOT NULL,
  name       CHAR(100)     NOT NULL,
  phoneNum   CHAR(10)      NOT NULL,
  position   CHAR(100)     NOT NULL,
  hourlyRate DECIMAL(9, 2) NOT NULL,
  startDate  DATETIME      NOT NULL,
  locationId INT(11)       NOT NULL,
  PRIMARY KEY (employeeId),
  FOREIGN KEY (locationId) REFERENCES Location (locationId) ON DELETE CASCADE
);

CREATE TABLE Facility (
  facilityId INT(11) AUTO_INCREMENT,
  name       CHAR(30),
  factype    CHAR(30) NOT NULL,
  pricing    DECIMAL(9, 2),
  locationId INT(11)  NOT NULL,
  PRIMARY KEY (facilityId),
  FOREIGN KEY (locationId) REFERENCES Location (locationId) ON DELETE CASCADE
);

CREATE TABLE Room (
  roomId     INT(11) AUTO_INCREMENT,
  roomNum    INT(11),
  amenities  CHAR(100),
  isVacant   BOOLEAN NOT NULL,
  isClean    BOOLEAN NOT NULL,
  locationId INT(11) NOT NULL,
  PRIMARY KEY (roomId),
  UNIQUE (roomNum, locationId),
  FOREIGN KEY (locationId) REFERENCES Location (locationId) ON DELETE CASCADE
);

CREATE TABLE Booking (
  bookingId   INT(11) AUTO_INCREMENT,
  cost        DECIMAL(9, 2) NOT NULL,
  inDate      DATETIME      NOT NULL,
  outDate     DATETIME      NOT NULL,
  numOfGuests INT(11)       NOT NULL,
  PRIMARY KEY (bookingId)
);

CREATE TABLE Guest (
  guestId       INT(11) AUTO_INCREMENT,
  name          CHAR(100) NOT NULL,
  username   CHAR(100)     NOT NULL UNIQUE,
  password   CHAR(255)     NOT NULL,
  phoneNum      CHAR(10)  NOT NULL,
  creditCardNum CHAR(16)  NOT NULL,
  PRIMARY KEY (guestId)
);

CREATE TABLE Reserve (
  bookingId  INT(11),
  roomNum    INT(11),
  locationId INT(11),
  guestId    INT(11),
  PRIMARY KEY (bookingId, roomNum, locationId, guestId),
  FOREIGN KEY (bookingId) REFERENCES Booking (bookingId) ON DELETE CASCADE,
  FOREIGN KEY (roomNum) REFERENCES Room (roomNum) ON DELETE CASCADE,
  FOREIGN KEY (locationId) REFERENCES Location (locationId) ON DELETE CASCADE,
  FOREIGN KEY (guestId) REFERENCES Guest (guestId) ON DELETE CASCADE
);

# GENERATE DUMMY DATA

# LOCATIONS
INSERT INTO Location (locationId, locationName, address, phoneNum)
VALUES (1, 'Holiday Inn','1234 Street St', '7781235465');

INSERT INTO Location (locationId, locationName, address, phoneNum)
VALUES (2, 'Pan Pacific Hotel','4321 Alley St', '7781235475');

INSERT INTO Location (locationId, locationName, address, phoneNum)
VALUES (3, 'Motel 21','1579 Road St', '7781235485');

INSERT INTO Location (locationId, locationName, address, phoneNum)
VALUES (4, 'Best Western','1579 Sidewalk St', '7783235475');

INSERT INTO Location (locationId, locationName, address, phoneNum)
VALUES (5, 'Hilton','1579 Port St', '7783435475');

# EMPLOYEE
INSERT INTO
  Employee (
    employeeId, username, password, name, phoneNum, position, hourlyRate, startDate, locationId)
VALUES (
  1, 'arthurtse', 'password', 'Arthur Tse', '7781234561', 'manager', 10.75, '2018-02-15', 1);

INSERT INTO
  Employee (
    employeeId, username, password, name, phoneNum, position, hourlyRate, startDate, locationId)
VALUES (
  2, 'laksvslakshmanan', 'password', 'Laks V.S. Lakshmanan', '7751234721', 'Bellboy Manager', 15.25, '2018-02-16', 1);

INSERT INTO
  Employee (
    employeeId, username, password, name, phoneNum, position, hourlyRate, startDate, locationId)
VALUES (
  3, 'johndoe', 'password', 'John Doe', '7751234521', 'Janitor', 10.50, '2018-02-16', 2);

INSERT INTO
  Employee (
    employeeId, username, password, name, phoneNum, position, hourlyRate, startDate, locationId)
VALUES (
  4, 'jackdoe', 'password', 'Jack Doe', '7751284521', 'Janitor', 10.50, '2018-02-16', 2);

INSERT INTO
  Employee (
    employeeId, username, password, name, phoneNum, position, hourlyRate, startDate, locationId)
VALUES (
  5, 'jilldoe', 'password', 'Jill Doe', '7751294521', 'Janitor', 10.50, '2018-02-16', 3);

# FACILITY
INSERT INTO
  Facility (facilityId, name, factype, pricing, locationId)
VALUES (1, 'John Goodman\'s Children\'s Pool', 'swimming pool', 0, 1);

INSERT INTO
  Facility (facilityId, name, factype, pricing, locationId)
VALUES (2, 'Muscle Beach', 'weight room', 10, 2);

INSERT INTO
  Facility (facilityId, name, factype, pricing, locationId)
VALUES (3, 'Dino Park', 'jungle gym', 0, 3);

INSERT INTO
  Facility (facilityId, name, factype, pricing, locationId)
VALUES (4, 'Oprah\'s Car', 'car pool', 0, 4);

INSERT INTO
  Facility (facilityId, name, factype, pricing, locationId)
VALUES (5, 'Trash Palace', 'weight room', 0, 5);

# ROOMS
INSERT INTO
  Room (roomId, roomNum, amenities, isVacant, isClean, locationId)
VALUES (1, 101, 'internet, 2 bath, 1 king size bed', TRUE, TRUE, 1);

# Start of Sam's rooms
INSERT INTO
  Room (roomId, roomNum, amenities, isVacant, isClean, locationId)
VALUES (6, 102, 'internet, 2 bath, 1 king size bed', TRUE, TRUE, 1);

INSERT INTO
  Room (roomId, roomNum, amenities, isVacant, isClean, locationId)
VALUES (7, 103, 'internet, 2 bath, 1 king size bed', TRUE, TRUE, 1);

INSERT INTO
  Room (roomId, roomNum, amenities, isVacant, isClean, locationId)
VALUES (8, 104, 'internet, 2 bath, 1 king size bed', TRUE, TRUE, 1);

INSERT INTO
  Room (roomId, roomNum, amenities, isVacant, isClean, locationId)
VALUES (9, 105, 'internet, 2 bath, 1 king size bed', TRUE, TRUE, 1);
#End of Sam's rooms

INSERT INTO
  Room (roomId, roomNum, amenities, isVacant, isClean, locationId)
VALUES (2, 101, 'internet, 1 bath, 1 queen size bed', TRUE, TRUE, 2);

INSERT INTO
  Room (roomId, roomNum, amenities, isVacant, isClean, locationId)
VALUES (3, 206, 'internet, 2 bath, 2 queen size bed', FALSE, FALSE, 3);

INSERT INTO
  Room (roomId, roomNum, amenities, isVacant, isClean, locationId)
VALUES (4, 208, 'internet, 2 bath, 2 twin size bed', FALSE, TRUE, 4);

INSERT INTO
  Room (roomId, roomNum, amenities, isVacant, isClean, locationId)
VALUES (5, 115, '1 bath, 1 single size bed', TRUE, FALSE, 5);

# BOOKINGS
INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (1, 100, '2018-01-01', '2018-01-05', 1);

INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (2, 400, '2018-01-01', '2018-01-05', 4);

INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (3, 1000, '2018-01-02', '2018-01-08', 3);

INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (4, 250, '2018-03-01', '2018-03-05', 2);

INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (5, 350, '2018-01-18', '2018-01-20', 3);

#start of VIP guest bookings
INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (6, 350, '2018-05-18', '2018-05-20', 3);

INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (7, 350, '2018-05-18', '2018-05-20', 3);

INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (8, 350, '2018-05-18', '2018-05-20', 3);

INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (9, 350, '2018-05-18', '2018-05-20', 3);

INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (10, 350, '2018-05-18', '2018-05-20', 3);

# GUESTS
INSERT INTO Guest (guestId, name, username, password, phoneNum, creditCardNum)
VALUES (1, 'Oprah Winfrey', 'oprahwinfrey', 'password', '7783435475', '4550123456789012');

INSERT INTO Guest (guestId, name, username, password, phoneNum, creditCardNum)
VALUES (2, 'Will Smith', 'willsmith', 'password', '7834921933', '4550123456789012');

INSERT INTO Guest (guestId, name, username, password, phoneNum, creditCardNum)
VALUES (3, 'Barack Obama', 'barackobama', 'password', '7781245365', '4550123456789012');

INSERT INTO Guest (guestId, name, username, password, phoneNum, creditCardNum)
VALUES (4, 'Donald Trump', 'donaldtrump', 'password', '8849392023', '4550123456789012');

INSERT INTO Guest (guestId, name, username, password, phoneNum, creditCardNum)
VALUES (5, 'Arthur Tse', 'arthurtse', 'password', '9913324434', '8849392023034500');

INSERT INTO Guest (guestId, name, username, password, phoneNum, creditCardNum)
VALUES (6, 'VIP', 'vip', 'password', '9913324430', '8849392023034501');

# Reserve
INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (1, 101, 1, 1);

INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (2, 102, 1, 1);

INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (3, 206, 3, 3);

INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (4, 208, 4, 4);

INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (5, 115, 5, 5);

#start of VIP guest reserves
INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (6, 101, 1, 6);

INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (7, 101, 2, 6);

INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (8, 206, 3, 6);

INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (9, 208, 4, 6);

INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (10, 115, 5, 6);


