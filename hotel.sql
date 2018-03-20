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