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
  1, 'arthurtse', 'password', 'Arthur Tse', '7781234561', 'manager', 10.75, '2014-05-01', 1);

INSERT INTO
  Employee (
    employeeId, username, password, name, phoneNum, position, hourlyRate, startDate, locationId)
VALUES (
  2, 'laksvslakshmanan', 'password', 'Laks V.S. Lakshmanan', '7751234721', 'manager', 49.99, '2012-06-22', 3);

INSERT INTO
  Employee (
    employeeId, username, password, name, phoneNum, position, hourlyRate, startDate, locationId)
VALUES (
  3, 'johndoe', 'password123', 'John Doe', '7751234521', 'front desk', 10.50, '2016-02-16', 2);

INSERT INTO
  Employee (
    employeeId, username, password, name, phoneNum, position, hourlyRate, startDate, locationId)
VALUES (
  4, 'jackdoe', 'verysecure', 'Jack Doe', '7751223441', 'cleaning staff', 11.75, '2016-10-30', 2);

INSERT INTO
  Employee (
    employeeId, username, password, name, phoneNum, position, hourlyRate, startDate, locationId)
VALUES (
  5, 'jilldoe', 'youcantguessthis', 'Jill Doe', '7759543392', 'cleaning staff', 15.50, '2015-12-25', 3);

INSERT INTO
  Employee (
    employeeId, username, password, name, phoneNum, position, hourlyRate, startDate, locationId)
VALUES (
  6, 'papajohn', 'password123', 'Papa John', '7724403928', 'front desk', 10.50, '2016-02-16', 1);

INSERT INTO
  Employee (
    employeeId, username, password, name, phoneNum, position, hourlyRate, startDate, locationId)
VALUES (
  7, 'joeguerrero', 'password123', 'Joe Ger', '9954039284', 'front desk', 13.50, '2016-02-16', 3);

INSERT INTO
  Employee (
    employeeId, username, password, name, phoneNum, position, hourlyRate, startDate, locationId)
VALUES (
  8, 'johngreen', 'password123', 'John Green', '7752219684', 'front desk', 11.30, '2016-02-16', 4);

INSERT INTO
  Employee (
    employeeId, username, password, name, phoneNum, position, hourlyRate, startDate, locationId)
VALUES (
  9, 'dtam', 'password', 'Derek Tam', '7743029857', 'front desk', 12.25, '2016-02-16', 5);

INSERT INTO
  Employee (
    employeeId, username, password, name, phoneNum, position, hourlyRate, startDate, locationId)
VALUES (
  10, 'ashketchum', 'password123', 'Ash Ketchum', '7754842281', 'cleaning staff', 20.25, '2016-02-16', 3);

# FACILITY
INSERT INTO
  Facility (facilityId, name, factype, pricing, locationId)
VALUES (1, 'John Goodman\'s Children\'s Pool', 'swimming pool', 0, 1);

INSERT INTO
  Facility (facilityId, name, factype, pricing, locationId)
VALUES (2, 'Muscle Beach', 'weight room', 10, 2);

INSERT INTO
  Facility (facilityId, name, factype, pricing, locationId)
VALUES (3, 'Dino Park', 'gym', 0, 3);

INSERT INTO
  Facility (facilityId, name, factype, pricing, locationId)
VALUES (4, 'Oprah\'s Car Pool', 'pool', 0, 4);

INSERT INTO
  Facility (facilityId, name, factype, pricing, locationId)
VALUES (5, 'Trash Palace', 'weight room', 0, 5);

INSERT INTO
  Facility (facilityId, name, factype, pricing, locationId)
VALUES (6, 'Lifthard', 'gym', 5, 1);

INSERT INTO
  Facility (facilityId, name, factype, pricing, locationId)
VALUES (7, 'funhaus', 'game room', 0, 2);

INSERT INTO
  Facility (facilityId, name, factype, pricing, locationId)
VALUES (8, 'Nest', 'gym', 10, 2);

INSERT INTO
  Facility (facilityId, name, factype, pricing, locationId)
VALUES (9, 'SQUASH', 'squash court', 5, 2);

INSERT INTO
  Facility (facilityId, name, factype, pricing, locationId)
VALUES (10, 'Sound Like An Angel', 'karaoke', 15, 4);

# ROOMS
INSERT INTO
  Room (roomId, roomNum, amenities, isVacant, isClean, locationId)
VALUES (1, 101, 'internet, 2 bath, 1 king size bed', TRUE, TRUE, 1);

INSERT INTO
  Room (roomId, roomNum, amenities, isVacant, isClean, locationId)
VALUES (2, 101, 'internet, 1 bath, 1 queen size bed', TRUE, TRUE, 2);

INSERT INTO
  Room (roomId, roomNum, amenities, isVacant, isClean, locationId)
VALUES (3, 206, 'internet, 2 bath, 2 queen size beds', FALSE, FALSE, 3);

INSERT INTO
  Room (roomId, roomNum, amenities, isVacant, isClean, locationId)
VALUES (4, 208, 'internet, 2 bath, 2 twin size beds', FALSE, TRUE, 4);

INSERT INTO
  Room (roomId, roomNum, amenities, isVacant, isClean, locationId)
VALUES (5, 115, '1 bath, 1 single size bed', TRUE, FALSE, 5);

INSERT INTO
  Room (roomId, roomNum, amenities, isVacant, isClean, locationId)
VALUES (6, 102, 'internet, 2 bath, 1 queen size bed', FALSE, TRUE, 1);

INSERT INTO
  Room (roomId, roomNum, amenities, isVacant, isClean, locationId)
VALUES (7, 103, 'internet, 2 bath, 1 queen size bed', FALSE, TRUE, 1);

INSERT INTO
  Room (roomId, roomNum, amenities, isVacant, isClean, locationId)
VALUES (8, 102, 'internet, 2 bath, 2 queen size beds', FALSE, TRUE, 2);

INSERT INTO
  Room (roomId, roomNum, amenities, isVacant, isClean, locationId)
VALUES (9, 103, 'internet, 1 bath, 2 queen size beds', FALSE, TRUE, 2);

INSERT INTO
  Room (roomId, roomNum, amenities, isVacant, isClean, locationId)
VALUES (10, 207, 'internet, 1 bath, 1 king size bed', FALSE, TRUE, 3);

INSERT INTO
  Room (roomId, roomNum, amenities, isVacant, isClean, locationId)
VALUES (11, 208, 'internet, 1 bath, 2 twin size beds', FALSE, TRUE, 3);

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

INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (6, 200, '2017-02-11', '2018-02-15', 2);

INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (7, 1000, '2018-09-02', '2018-09-06', 1);

INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (8, 150, '2017-05-20', '2017-05-30', 4);

INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (9, 660, '2018-08-17', '2018-09-03', 3);

INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (10, 945, '2018-03-03', '2018-03-26', 2);

INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (11, 120, '2018-11-25', '2019-01-02', 5);

INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (12, 220, '2017-10-18', '2017-10-22', 6);

INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (13, 300, '2018-09-05', '2018-09-09', 1);

INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (14, 650, '2018-06-14', '2018-06-26', 2);

INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (15, 800, '2018-09-10', '2018-09-11', 10);

#start of VIP guest bookings
INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (16, 350, '2018-05-18', '2018-05-20', 3);

INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (17, 300, '2018-05-18', '2018-05-20', 2);

INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (18, 700, '2018-05-18', '2018-05-20', 2);

INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (19, 1200, '2018-05-18', '2018-05-20', 1);

INSERT INTO Booking (bookingId, cost, inDate, outDate, numOfGuests)
VALUES (20, 1010, '2018-05-18', '2018-05-20', 3);

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
VALUES (6, 'Charles Slone', 'cslone', 'secureboi', '9079877378', '5261887962369529');

INSERT INTO Guest (guestId, name, username, password, phoneNum, creditCardNum)
VALUES (7, 'Scott Johnson', 'sjo', 'passpass', '9098960407', '4539913294615832');

INSERT INTO Guest (guestId, name, username, password, phoneNum, creditCardNum)
VALUES (8, 'Richard Acuna', 'racoon', 'bandit', '8608762667', '4539998176687678');

INSERT INTO Guest (guestId, name, username, password, phoneNum, creditCardNum)
VALUES (9, 'Cameron Frantz', 'cfrantz', 'shhh', '3346370763', '4716425176918247');

INSERT INTO Guest (guestId, name, username, password, phoneNum, creditCardNum)
VALUES (10, 'Marie Guzman', 'theguz', 'goooooz', '8015397314', '5115823764800351');

INSERT INTO Guest (guestId, name, username, password, phoneNum, creditCardNum)
VALUES (11, 'Michelle Menchaa', 'menchies', 'muhmuhmencha', '3012338266', '4716142918116077');

INSERT INTO Guest (guestId, name, username, password, phoneNum, creditCardNum)
VALUES (12, 'Howard Hatcher', 'hathat', 'howhow', '6463574987', '4916940894053976');

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

INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (6, 103, 2, 6);

INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (7, 102, 2, 2);

INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (8, 101, 1, 7);

INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (9, 206, 3, 8);

INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (10, 206, 3, 11);

INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (11, 207, 3, 5);

INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (12, 208, 4, 3);

INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (13, 207, 3, 1);

INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (14, 102, 2, 1);

INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (15, 103, 1, 5);

#start of VIP guest reserves
INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (16, 101, 1, 6);

INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (17, 101, 2, 6);

INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (18, 206, 3, 6);

INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (19, 208, 4, 6);

INSERT INTO Reserve (
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES (20, 115, 5, 6);


