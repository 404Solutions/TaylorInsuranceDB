
/*
CREATE TABLE HomeType(
  ID DECIMAL(1) PRIMARY KEY,
  HomeType VARCHAR(40) NOT NULL,
  Rate DECIMAL(3,2) NOT NULL
);
*/
INSERT INTO HomeType(ID, HomeType, Rate)
VALUES(1, 'Single Dwelling', 1.00);

INSERT INTO HomeType(ID, HomeType, Rate)
VALUES(2, 'Appartment', 0.75);

INSERT INTO HomeType(ID, HomeType, Rate)
VALUES(3, 'Bungalow', 1.00);

INSERT INTO HomeType(ID, HomeType, Rate)
VALUES(4, 'Semi-attached', 1.15);

/*
CREATE TABLE HomeHeating(
  ID DECIMAL(1) PRIMARY KEY,
  HeatingType VARCHAR(40) NOT NULL,
  Rate DECIMAL(3,2) NOT NULL
);
*/
INSERT INTO HomeHeating(ID, HeatingType, Rate)
VALUES(1, 'Electric', 1.00);

INSERT INTO HomeHeating(ID, HeatingType, Rate)
VALUES(2, 'Oil', 1.75);

INSERT INTO HomeHeating(ID, HeatingType, Rate)
VALUES(3, 'Wood', 1.30);

INSERT INTO HomeHeating(ID, HeatingType, Rate)
VALUES(4, 'Gas', 1.40);

INSERT INTO HomeHeating(ID, HeatingType, Rate)
VALUES(5, 'Other', 1.25);

/*
CREATE TABLE Account (
  UserID INT PRIMARY KEY auto_increment,
  Email VARCHAR(30),
  Password VARCHAR(50)
);
*/
INSERT INTO Account(Email, Password)
VALUES('jondoe@gmail.com', 'jondoe123');

/*
CREATE TABLE Vehicle(
  VehicleID DECIMAL(5) PRIMARY KEY auto_increment,
  Make VARCHAR(10) NOT NULL,
  Year DECIMAL(4) NOT NULL,
  Model VARCHAR(20) NOT NULL,
  PlateNumber VARCHAR(6) NOT NULL
);
*/
INSERT INTO Vehicle(Make, Year, Model, PlateNumber)
VALUES('Toyota', 2013, 'Corolla', 'HXL246')

/*
CREATE TABLE Location(
  ID DECIMAL(1) PRIMARY KEY,
  Location VARCHAR(10),
  Rate DECIMAL(3,2)
);
*/
INSERT INTO Location(ID, Location, Rate)
VALUES(1, 'Dense Urban', 1.50);

INSERT INTO Location(ID, Location, Rate)
VALUES(2, 'Urban', 1.25);

INSERT INTO Location(ID, Location, Rate)
VALUES(3, 'Rural', 1.00);

/*
CREATE TABLE PrincipleDriver (
  UserID INT PRIMARY KEY,
  FirstName VARCHAR(25) NOT NULL,
  LastName VARCHAR(20) NOT NULL,
  DOB DATE NOT NULL,
  Address VARCHAR(70) NOT NULL,
  City VARCHAR(15) NOT NULL,
  Province VARCHAR(40) NOT NULL,
  PostalCode VARCHAR(6) NOT NULL,
  PhoneNumber VARCHAR(14) NOT NULL,
  Email VARCHAR(30),
  Gender CHAR(1),
  DriversLicenseNumber VARCHAR(10) NOT NULL,
  LicenseIssueDate DATE NOT NULL,
  LocationID DECIMAL(1),
  FOREIGN KEY (LocationID) REFERENCES Location(ID)
);
*/

INSERT INTO PrincipleDriver(UserID, FirstName, LastName, DOB, Address, City, Province, PostalCode, PhoneNumber, Email, Gender, DriversLicenseNumber, LicenseIssuedDate, LocationID)
VALUES(1, 'Jon,', 'Doe', '1990-08-25', '1 Fake Street', 'St.Johns', 'NL', 'A1B6H7', '709-763-5576','jondoe@gmail.com', 'M', 'SAMPLE1234', '2009-01-20', 2);

/*  NOTE: GENERATE THIS WITH CODE.
CREATE TABLE VehicleQuotes (
  QuoteID CHAR(5) PRIMARY KEY,
  VehicleID DECIMAL(5) NOT NULL,
  DateQuoted DATE NOT NULL,
  QuoteExpiredDate DATE NOT NULL,
  BasePremium DECIMAL(6,2) NOT NULL,
  Tax DECIMAL(4,2) NOT NULL,
  Total DECIMAL(7,2) NOT NULL,
  ReplacementCost DECIMAL(6,2) NOT NULL,
  FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID)
);
*/


/* NOTE: GENERATE THIS WITH CODE.
CREATE TABLE VehiclePolicy (
  PolicyID CHAR(5) PRIMARY KEY,
  VehicleID DECIMAL(5) NOT NULL,
  UserID INT NOT NULL,
  QuoteID CHAR(5) NOT NULL,
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL,
  BasePremium DECIMAL(6,2) NOT NULL,
  Tax DECIMAL(4,2) NOT NULL,
  Total DECIMAL(7,2) NOT NULL,
  ReplacementCostValue DECIMAL(6,2) NOT NULL,
  FOREIGN KEY (UserID) REFERENCES PrincipleDriver(UserID),
  FOREIGN KEY (QuoteID) REFERENCES VehicleQuotes(QuoteID),
  FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID)
);
*/

/*
CREATE TABLE SecondaryDriver (
  SecondaryID INT PRIMARY KEY auto_increment,
  FirstName VARCHAR(25) NOT NULL,
  LastName VARCHAR(20) NOT NULL,
  DOB DATE NOT NULL,
  Address VARCHAR(70) NOT NULL,
  City VARCHAR(15) NOT NULL,
  Province VARCHAR(40) NOT NULL,
  PostalCode VARCHAR(6) NOT NULL,
  PhoneNumber VARCHAR(14) NOT NULL,
  Email VARCHAR(30),
  Gender CHAR(1),
  DriversLicense DECIMAL(10) NOT NULL,
  LicenseIssueDate DATE NOT NULL
);
*/

INSERT INTO SecondaryDriver(UserID, FirstName, LastName, DOB, Address, City, Province, PostalCode, PhoneNumber, Email, Gender, DriversLicenseNumber, LicenseIssuedDate)
VALUES(1, '1990-06-20', 'Jane,', 'Doe', '1 Fake Street', 'St.Johns', 'NL', 'A1B6H7', '709-763-5576','janedoe@gmail.com', 'F', 'SAMPLE4321', '2010-05-11');

/* GENERATE IN CODE
CREATE TABLE BRIDGEPolicySecondary (
  PolicyID CHAR(5) NOT NULL,
  SecondaryID INT NOT NULL,
  DateAdded DATE,
  CONSTRAINT policySecondary PRIMARY KEY (PolicyID,SecondaryID),
  FOREIGN KEY (PolicyID) REFERENCES VehiclePolicy(PolicyID),
  FOREIGN KEY (SecondaryID) REFERENCES SecondaryDriver(SecondaryID)
);
*/

/* GENERATE IN CODE
CREATE TABLE BRIDGEQuoteSecondary (
  QuoteId CHAR(5) NOT NULL,
  SecondaryID INT NOT NULL,
  DateAdded DATE,
  CONSTRAINT quoteSecondary PRIMARY KEY (QuoteID,SecondaryID),
  FOREIGN KEY (QuoteID) REFERENCES VehicleQuotes(QuoteID),
  FOREIGN KEY (SecondaryID) REFERENCES SecondaryDriver(SecondaryID)
);
*/

/*
CREATE TABLE HomeOwner (
  UserID INT PRIMARY KEY,
  FirstName VARCHAR(25) NOT NULL,
  LastName VARCHAR(20) NOT NULL,
  DOB DATE,
  Address VARCHAR(70) NOT NULL,
  City VARCHAR(15) NOT NULL,
  Province VARCHAR(40) NOT NULL,
  Email VARCHAR(30),
  Gender CHAR(1),
  PostalCode VARCHAR(6) NOT NULL,
  PhoneNumber VARCHAR(14) NOT NULL
);
*/

INSERT INTO HomeOwner(UserID, FirstName, LastName, DOB, Address, City, Province, PostalCode,  Email, Gender, PhoneNumber) 
VALUES(1, 'Meghan', 'Snow', '1993-09-30', '102312 street', 'gander', 'nl', 'a1e5m2', 'meghan.snow@g3.coem','F','709-777-7777')





INSERT INTO Home(YearBuit, HomeTypeID, HeatingTypeID, Value, Address, City, Province, PostalCode)
Values(1994,2,3,200000,"1 fake street","st.John's","NL","a1y7d4")



INSERT INTO Vehicle(VehicleID, Make, Year, Model, PlateNumber)
VALUES(?,?,?,?,?);  