-- Guest
CREATE TABLE Guest (
  GuestID       INT PRIMARY KEY AUTO_INCREMENT,
  Name          VARCHAR(200) NOT NULL,
  Phone         VARCHAR(20),
  Email         VARCHAR(200),
  Address       VARCHAR(300),
  CreatedAt     DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- RoomType
CREATE TABLE RoomType (
  TypeID        INT PRIMARY KEY AUTO_INCREMENT,
  Name          VARCHAR(100) NOT NULL,
  Price         DECIMAL(12,2) NOT NULL,
  Capacity      INT NOT NULL,
  Description   TEXT
);

-- Room
CREATE TABLE Room (
  RoomID        INT PRIMARY KEY AUTO_INCREMENT,
  TypeID        INT NOT NULL,
  Status        VARCHAR(50) NOT NULL, -- e.g., Available, Occupied, Maintenance
  Floor         VARCHAR(50),
  FOREIGN KEY (TypeID) REFERENCES RoomType(TypeID)
);

-- Staff
CREATE TABLE Staff (
  StaffID       INT PRIMARY KEY AUTO_INCREMENT,
  Name          VARCHAR(200) NOT NULL,
  Role          VARCHAR(100), -- e.g., Receptionist, Manager, Housekeeping
  Username      VARCHAR(100) UNIQUE,
  PasswordHash  VARCHAR(512)
);

-- Reservation
CREATE TABLE Reservation (
  ResvID        INT PRIMARY KEY AUTO_INCREMENT,
  GuestID       INT NOT NULL,
  RoomID        INT, -- nullable until assigned at check-in
  StaffID       INT, -- staff who handled booking/checkin (nullable)
  CheckInDate   DATE NOT NULL,
  CheckOutDate  DATE NOT NULL,
  Status        VARCHAR(50) NOT NULL, -- e.g., Pending, Confirmed, CheckedIn, CheckedOut, Cancelled
  CreatedAt     DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (GuestID) REFERENCES Guest(GuestID),
  FOREIGN KEY (RoomID) REFERENCES Room(RoomID),
  FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

-- Payment
CREATE TABLE Payment (
  PaymentID     INT PRIMARY KEY AUTO_INCREMENT,
  ResvID        INT NOT NULL,
  Amount        DECIMAL(12,2) NOT NULL,
  Method        VARCHAR(50), -- e.g., Card, Cash, BankTransfer
  Status        VARCHAR(50), -- e.g., Pending, Success, Failed, Refunded
  PaymentDate   DATETIME DEFAULT CURRENT_TIMESTAMP,
  TransactionRef VARCHAR(200),
  FOREIGN KEY (ResvID) REFERENCES Reservation(ResvID)
);
