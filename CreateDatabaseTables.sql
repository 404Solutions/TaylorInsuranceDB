DROP TABLE HomePolicy;
DROP TABLE HomeQuotes;
DROP TABLE HomeOwner;
DROP TABLE Home;
DROP TABLE HomeHeating;
DROP TABLE HomeType;
DROP TABLE Accidents;
DROP TABLE BRIDGEQuoteSecondary;
DROP TABLE BRIDGEPolicySecondary;
DROP TABLE SecondaryDriver;
DROP TABLE VehiclePolicy;
DROP TABLE VehicleQuotes;
DROP TABLE PrincipleDriver;
DROP TABLE Vehicle;
DROP TABLE Account;
DROP TABLE Location;
DROP TABLE homepolicy_seq;
DROP TABLE homequote_seq;
DROP TABLE vehiclepolicy_seq;
DROP TABLE vehiclequotes_seq;

CREATE TABLE Account (
  UserID INT PRIMARY KEY auto_increment,
  Email VARCHAR(30) NOT NULL UNIQUE,
  Password VARCHAR(50) NOT NULL
);

CREATE TABLE Vehicle(
  VehicleID INT PRIMARY KEY auto_increment,
  Make VARCHAR(10) NOT NULL,
  Year DECIMAL(4) NOT NULL,
  Model VARCHAR(20) NOT NULL,
  PlateNumber VARCHAR(6) NOT NULL
);

CREATE TABLE Location(
  ID DECIMAL(1) PRIMARY KEY,
  Location VARCHAR(10),
  Rate DECIMAL(3,2)
);

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


CREATE TABLE VehicleQuotes (
  QuoteID CHAR(6) PRIMARY KEY,
  VehicleID INT NOT NULL,
  DateQuoted DATE NOT NULL,
  QuoteExpiredDate DATE NOT NULL,
  BasePremium DECIMAL(6,2) NOT NULL,
  Tax DECIMAL(10,2) NOT NULL,
  Total DECIMAL(10,2) NOT NULL,
  ReplacementCost DECIMAL(6,2) NOT NULL,
  FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID)
);

CREATE TABLE VehiclePolicy (
  PolicyID CHAR(6) PRIMARY KEY,
  VehicleID INT NOT NULL,
  UserID INT NOT NULL,
  QuoteID CHAR(6) NOT NULL,
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL,
  BasePremium DECIMAL(10,2) NOT NULL,
  Tax DECIMAL(10,2) NOT NULL,
  Total DECIMAL(12,2) NOT NULL,
  ReplacementCostValue DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (UserID) REFERENCES PrincipleDriver(UserID),
  FOREIGN KEY (QuoteID) REFERENCES VehicleQuotes(QuoteID),
  FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID)
);


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

CREATE TABLE BRIDGEPolicySecondary (
  PolicyID CHAR(6) NOT NULL,
  SecondaryID INT NOT NULL,
  DateAdded DATE,
  CONSTRAINT policySecondary PRIMARY KEY (PolicyID,SecondaryID),
  FOREIGN KEY (PolicyID) REFERENCES VehiclePolicy(PolicyID),
  FOREIGN KEY (SecondaryID) REFERENCES SecondaryDriver(SecondaryID)
);

CREATE TABLE BRIDGEQuoteSecondary (
  QuoteId CHAR(6) NOT NULL,
  SecondaryID INT NOT NULL,
  DateAdded DATE,
  CONSTRAINT quoteSecondary PRIMARY KEY (QuoteID,SecondaryID),
  FOREIGN KEY (QuoteID) REFERENCES VehicleQuotes(QuoteID),
  FOREIGN KEY (SecondaryID) REFERENCES SecondaryDriver(SecondaryID)
);

CREATE TABLE Accidents (
  AccidentID INT PRIMARY KEY auto_increment,
  UserID INT NOT NULL,
  SecondaryDriverID INT,
  DateOfAccident DATE NOT NULL,
  Responsible BOOLEAN NOT NULL,
  FOREIGN KEY (UserID) REFERENCES PrincipleDriver(UserID),
  FOREIGN KEY (SecondaryDriverID) REFERENCES SecondaryDriver(SecondaryID)
);

CREATE TABLE HomeHeating(
  ID DECIMAL(1) PRIMARY KEY,
  HeatingType VARCHAR(40) NOT NULL,
  Rate DECIMAL(3,2) NOT NULL,
  FOREIGN KEY (ID) REFERENCES Home(HomeTypeID)
);

CREATE TABLE HomeType(
  ID DECIMAL(1) PRIMARY KEY,
  HomeType VARCHAR(40) NOT NULL,
  Rate DECIMAL(3,2) NOT NULL,
  FOREIGN KEY (ID) REFERENCES Home(HomeTypeID)
);

CREATE TABLE Home (
  HomeID INT   PRIMARY KEY auto_increment,
  YearBuilt DECIMAL(4) NOT NULL,
  HomeTypeID DECIMAL(1) NOT NULL,
  HeatingTypeID DECIMAL(1) NOT NULL,
  Value DECIMAL(10,2) NOT NULL,
  Address VARCHAR(70) NOT NULL,
  City VARCHAR(15) NOT NULL,
  Province VARCHAR(40) NOT NULL,
  PostalCode VARCHAR(6) NOT NULL
);


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

CREATE TABLE HomeQuotes (
  QuoteID CHAR(6) PRIMARY KEY,
  UserID INT NOT NULL,
  HomeID DECIMAL(6) NOT NULL,
  DateQuoted DATE NOT NULL,
  QuoteExpired DATE NOT NULL,
  BasePremium DECIMAL(6,2),
  Tax DECIMAL(10,2),
  Total DECIMAL(10,2),
  FOREIGN KEY (UserID) REFERENCES HomeOwner(UserID),
  FOREIGN KEY (HomeID) REFERENCES Home(HomeID)
);

CREATE TABLE HomePolicy (
  PolicyID CHAR(6) PRIMARY KEY,
  UserID INT NOT NULL,
  HomeID DECIMAL(5) NOT NULL,
  QuoteID CHAR(6) NOT NULL,
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL,
  BasePremium DECIMAL(10,2),
  Tax DECIMAL(10,2) NOT NULL,
  Total DECIMAL(12,2) NOT NULL,
  FOREIGN KEY (UserID) REFERENCES HomeOwner(UserID),
  FOREIGN KEY (QuoteID) REFERENCES HomeQuotes(QuoteID),
  FOREIGN KEY (HomeID) REFERENCES Home(HomeID)
);