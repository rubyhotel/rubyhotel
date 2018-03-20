CREATE TABLE Location(
  locationId INT(11),
  address CHAR(100) NOT NULL,
  phoneNum CHAR(10),
  PRIMARY KEY (locationId)
);

CREATE TABLE Employee(
  employeeId INT(11),
  name CHAR(100) NOT NULL,
  phoneNum CHAR(10) NOT NULL,
  position CHAR(100) NOT NULL,
  hourlyRate DECIMAL(9,2) NOT NULL,
  startDate DATETIME NOT NULL,
  locationId INT(11) NOT NULL,
  PRIMARY KEY (employeeId),
  FOREIGN KEY (locationId) REFERENCES Location(locationId)
);

CREATE TABLE Facility(
  facilityId INT(11),
  name CHAR(30),
  type CHAR(30) NOT NULL,
  pricing DECIMAL(9,2),
  locationId INT(11) NOT NULL,
  PRIMARY KEY (facilityId),
  FOREIGN KEY (locationId) REFERENCES Location(locationId)
);

CREATE TABLE Room(
  roomNum INT(11),
  amenities CHAR(100),
  isVacant BOOLEAN NOT NULL,
  isClean BOOLEAN NOT NULL,
  locationId INT(11) NOT NULL,
  PRIMARY KEY (roomNum, locationId),
  FOREIGN KEY (locationId) REFERENCES Location(locationId)
);

CREATE TABLE Booking(
  bookingId INT(11),
  cost DECIMAL(9,2) NOT NULL,
  inDate DATETIME NOT NULL,
  outDate DATETIME NOT NULL,
  numOfGuests INT(11) NOT NULL,
  PRIMARY KEY (bookingId)
);

CREATE TABLE Guest(
  guestId INT(11),
  name CHAR(100) NOT NULL,
  phoneNum CHAR(10) NOT NULL,
  creditCardNum CHAR(16) NOT NULL,
  PRIMARY KEY (guestId)
);

CREATE TABLE Reserves(
  bookingId INT(11),
  roomNum INT(11),
  locationId INT(11),
  guestId INT(11),
  PRIMARY KEY (bookingId, roomNum, locationId, guestId),
  FOREIGN KEY (bookingId) REFERENCES Booking(bookingId),
  FOREIGN KEY (roomNum) REFERENCES Room(roomNum),
  FOREIGN KEY (locationId) REFERENCES Location(locationId),
  FOREIGN KEY (guestId) REFERENCES Guest(guestId)
);

# GENERATE DUMMY DATA

# LOCATIONS
INSERT INTO Location(locationId, address, phoneNum)
VALUES(1, "1234 Street St", "7781235465");

INSERT INTO Location(locationId, address, phoneNum)
VALUES(2, "4321 Alley St", "7781235475");

INSERT INTO Location(locationId, address, phoneNum)
VALUES(3, "1579 Road St", "7781235485");

INSERT INTO Location(locationId, address, phoneNum)
VALUES(4, "1579 Sidewalk St", "7783235475");

INSERT INTO Location(locationId, address, phoneNum)
VALUES(5, "1579 Port St", "7783435475");


# EMPLOYEE
INSERT INTO
  Employee(
    employeeId, name, phoneNum, position, hourlyRate, startDate, locationId)
VALUES(
  1, "Arthur Tse", "7781234561", "Bellboy", 10.75, '2018-02-15', 1);

INSERT INTO
  Employee(
    employeeId, name, phoneNum, position, hourlyRate, startDate, locationId)
VALUES(
  2, "Laks V.S. Lakshmanan", "7751234721", "Bellboy Manager", 15.25, '2018-02-16', 1);

INSERT INTO
  Employee(
    employeeId, name, phoneNum, position, hourlyRate, startDate, locationId)
VALUES(
  3, "John Doe", "7751234521", "Janitor", 10.50, '2018-02-16', 2);

INSERT INTO
  Employee(
    employeeId, name, phoneNum, position, hourlyRate, startDate, locationId)
VALUES(
  4, "Jack Doe", "7751284521", "Janitor", 10.50, '2018-02-16', 2);

INSERT INTO
  Employee(
    employeeId, name, phoneNum, position, hourlyRate, startDate, locationId)
VALUES(
  5, "Jill Doe", "7751294521", "Janitor", 10.50, '2018-02-16', 3);


# FACILITY
INSERT INTO
  Facility(facilityId, name, type, pricing, locationId)
VALUES(1, "John Goodman's Children's Pool", "swimming pool", 0, 1);

INSERT INTO
  Facility(facilityId, name, type, pricing, locationId)
VALUES(2, "Muscle Beach", "weight room", 10, 2);

INSERT INTO
  Facility(facilityId, name, type, pricing, locationId)
VALUES(3, "Dino Park", "jungle gym", 0, 3);

INSERT INTO
  Facility(facilityId, name, type, pricing, locationId)
VALUES(4, "Oprah's Pool", "swimming pool", 0, 4);

INSERT INTO
  Facility(facilityId, name, type, pricing, locationId)
VALUES(5, "Trash Palace", "weight room", 0, 5);


# ROOMS
INSERT INTO
  Room(roomNum, amenities, isVacant, isClean, locationId)
VALUES(101, "internet, 2 bath, 1 king size bed", false, true, 1);

INSERT INTO
  Room(roomNum, amenities, isVacant, isClean, locationId)
VALUES(101, "internet, 1 bath, 1 queen size bed", true, true, 2);

INSERT INTO
  Room(roomNum, amenities, isVacant, isClean, locationId)
VALUES(206, "internet, 2 bath, 2 queen size bed", false, false, 3);

INSERT INTO
  Room(roomNum, amenities, isVacant, isClean, locationId)
VALUES(208, "internet, 2 bath, 2 twin size bed", false, true, 4);

INSERT INTO
  Room(roomNum, amenities, isVacant, isClean, locationId)
VALUES(115, "1 bath, 1 single size bed", true, false, 5);


# BOOKINGS
INSERT INTO Booking(bookingId, cost, inDate, outDate, numOfGuests)
VALUES(1, 100, '2018-01-01', '2018-01-05', 1);

INSERT INTO Booking(bookingId, cost, inDate, outDate, numOfGuests)
VALUES(2, 400, '2018-01-02', '2018-01-10', 4);

INSERT INTO Booking(bookingId, cost, inDate, outDate, numOfGuests)
VALUES(3, 1000, '2018-01-02', '2018-01-08', 3);

INSERT INTO Booking(bookingId, cost, inDate, outDate, numOfGuests)
VALUES(4, 250, '2018-03-01', '2018-03-05', 2);

INSERT INTO Booking(bookingId, cost, inDate, outDate, numOfGuests)
VALUES(5, 350, '2018-01-18', '2018-01-20', 3);


# GUESTS
INSERT INTO Guest(guestId, name, phoneNum, creditCardNum)
VALUES(1, "Oprah Winfrey", "7783435475", "4550123456789012");

INSERT INTO Guest(guestId, name, phoneNum, creditCardNum)
VALUES(2, "Will Smith", "7834921933", "4550123456789012");

INSERT INTO Guest(guestId, name, phoneNum, creditCardNum)
VALUES(3, "Barack Obama", "7781245365", "4550123456789012");

INSERT INTO Guest(guestId, name, phoneNum, creditCardNum)
VALUES(4, "Donald Trump", "8849392023", "4550123456789012");

INSERT INTO Guest(guestId, name, phoneNum, creditCardNum)
VALUES(5, "Arthur Tse", "9913324434", "8849392023034500");


# RESERVES
INSERT INTO Reserves(
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES(1, 101, 1, 1);

INSERT INTO Reserves(
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES(2, 101, 2, 2);

INSERT INTO Reserves(
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES(3, 206, 3, 3);

INSERT INTO Reserves(
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES(4, 208, 4, 4);

INSERT INTO Reserves(
  bookingId,
  roomNum,
  locationId,
  guestId)
VALUES(5, 115, 5, 5);
