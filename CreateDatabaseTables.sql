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
DROP TABLE VehicleQuotes;
DROP TABLE PrincipleDriver;
DROP TABLE Location;
DROP TABLE Vehicle;
DROP TABLE VehiclePolicy;
DROP TABLE Account;
DROP TABLE UserType;


CREATE TABLE UserType (
  UserTypeID DECIMAL(1) PRIMARY KEY,
  Description VARCHAR(20) NOT NULL 
);

CREATE TABLE Account (
  UserID DECIMAL(5) PRIMARY KEY,
  UserTypeID DECIMAL(1),
  Password VARCHAR(50),
  FOREIGN KEY (UserTypeID) REFERENCES UserType(UserTypeID)
);

CREATE TABLE Vehicle (
  VechileID DECIMAL(5) PRIMARY KEY,
  Make VARCHAR(10) NOT NULL,
  Year DECIMAL(4) NOT NULL,
  Model VARCHAR(20) NOT NULL,
  PlateDECIMAL VARCHAR(6) NOT NULL
);

CREATE TABLE Location(
  ID DECIMAL(1) PRIMARY KEY,
  Location VARCHAR(10),
  Rate DECIMAL(3,2)
);

CREATE TABLE PrincipleDriver (
  UserID DECIMAL(5) PRIMARY KEY,
  DOB DATE NOT NULL,
  FirstName VARCHAR(25) NOT NULL,
  LastName VARCHAR(20) NOT NULL,
  Address VARCHAR(70) NOT NULL,
  City VARCHAR(15) NOT NULL,
  Province VARCHAR(40) NOT NULL,
  PostalCode VARCHAR(6) NOT NULL,
  PhoneNumber VARCHAR(14) NOT NULL,
  Email VARCHAR(30),
  Gender CHAR(1),
  DriversLicenseDECIMAL VARCHAR(10) NOT NULL,
  LicenseIssueDate DATE NOT NULL,
  LocationID DECIMAL(1),
  FOREIGN KEY (LocationID) REFERENCES Locaiton(ID)
);


CREATE TABLE VehicleQuotes (
  QuoteID VARCHAR(5) PRIMARY KEY,
  VehicleID DECIMAL(5) NOT NULL,
  DateQuoted DATE NOT NULL,
  QuoteExpiredDate DATE NOT NULL,
  BasePremium DECIMAL(6,2) NOT NULL,
  Tax DECIMAL(4,2) NOT NULL,
  Total DECIMAL(7,2) NOT NULL,
  ReplacementCost DECIMAL(6,2) NOT NULL,
  FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID)
);

CREATE TABLE VehiclePolicy (
  PolicyID CHAR(5) PRIMARY KEY,
  VehicleID DECIMAL(5) NOT NULL,
  UserID DECIMAL(5) NOT NULL,
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


CREATE TABLE SecondaryDriver (
  SecondaryID DECIMAL(5) PRIMARY KEY,
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
  PolicyID CHAR(5) NOT NULL,
  SecondaryID DECIMAL(5) NOT NULL,
  DateAdded DATE,
  CONSTRAINT policySecondary PRIMARY KEY (PolicyID,SecondaryID),
  FOREIGN KEY (PolicyID) REFERENCES VehiclePolicy(PolicyID),
  FOREIGN KEY (SecondaryID) REFERENCES SecondaryDriver(SecondaryID)
);

CREATE TABLE BRIDGEQuoteSecondary (
  QuoteId CHAR(5) PRIMARY KEY,
  SecondaryID DECIMAL(6) PRIMARY KEY,
  DateAdded DATE,
  CONSTRAINT quoteSecondary PRIMARY KEY (QuoteID,SecondaryID),
  FOREIGN KEY (QuoteID) REFERENCES VehicleQuotes(QuoteID),
  FOREIGN KEY (SecondaryID) REFERENCES SecondaryDriver(SecondaryID)
);

CREATE TABLE Accidents (
  AccidentID DECIMAL(5) PRIMARY KEY,
  UserID DECIMAL(5),
  SecondaryDriverID DECIMAL(5),
  DateOfAccident DATE NOT NULL,
  Responsible BOOLEAN NOT NULL,
  FOREIGN KEY (UserID) REFERENCES PrincipleDriver(UserID),
  FOREIGN KEY (SecondaryDriverID) REFERENCES SecondaryDriver(SecondaryDriverID)
);

CREATE TABLE HomeHeating(
  ID DECIMAL(1) PRIMARY KEY,
  HeatingType VARCHAR(40) NOT NULL,
  Rate DECIMAL(3,2) NOT NULL
);

CREATE TABLE HomeType(
  ID DECIMAL(1) PRIMARY KEY,
  HomeType VARCHAR(40) NOT NULL,
  Rate DECIMAL(3,2) NOT NULL
);

CREATE TABLE Home (
  HomeID DECIMAL(5) PRIMARY KEY,
  YearBuilt DECIMAL(4) NOT NULL,
  HomeTypeID DECIMAL(1) NOT NULL,
  HeatingTypeID DECIMAL(1) NOT NULL,
  PostalCode VARCHAR(6) NOT NULL,
  Address VARCHAR(70) NOT NULL,
  City VARCHAR(15) NOT NULL,
  Province VARCHAR(40) NOT NULL,
  FOREIGN KEY (HeatingTypeID) REFERENCES HomeHeating(ID),
  FOREIGN KEY (HomeTypeID) REFERENCES HomeType(ID)
);



CREATE TABLE HomeOwner (
  UserID DECIMAL(6) PRIMARY KEY,
  FirstName VARCHAR(25) NOT NULL,
  LastName VARCHAR(20) NOT NULL,
  DOB DATE,
  Address VARCHAR(70) NOT NULL,
  City VARCHAR(15) NOT NULL,
  Province VARCHAR(40) NOT NULL,
  Email VARCHAR(30),
  Gender CHAR(1),
  PostalCode VARCHAR(6) NOT NULL
);

CREATE TABLE HomeQuotes (
  QuoteID CHAR(5) PRIMARY KEY,
  UserID DECIMAL(5) NOT NULL,
  HomeID DECIMAL(6) NOT NULL,
  DateQuoted DATE NOT NULL,
  QuoteExpired DATE NOT NULL,
  BasePremium DECIMAL(6,2),
  Tax DECIMAL(4,2),
  Total DECIMAL(7,2),
  FOREIGN KEY (UserID) REFERENCES HomeOwner(UserID),
  FOREIGN KEY (HomeID) REFERENCES Home(HomeID)
);

CREATE TABLE HomePolicy (
  PolicyID CHAR(5) PRIMARY KEY,
  UserID DECIMAL(5) NOT NULL,
  HomeID DECIMAL(5) NOT NULL,
  QuoteID CHAR(5) NOT NULL,
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL,
  BasePremium DECIMAL(7,2),
  Tax DECIMAL(4,2) NOT NULL,
  Total DECIMAL(7,2) NOT NULL,
  ReplacementCostValue DECIMAL(7,2) NOT NULL,
  LiabilityLimit DECIMAL(7,2) NOT NULL,
  ContentsLimit DECIMAL(7,2) NOT NULL,
  ContentsDeducttible DECIMAL(6,2) NOT NULL,
  FOREIGN KEY (UserID) REFERENCES HomeOwner(UserID),
  FOREIGN KEY (QuoteID) REFERENCES HomeQuotes(QuoteID),
  FOREIGN KEY (HomeID) REFERENCES Home(HomeID)
);

