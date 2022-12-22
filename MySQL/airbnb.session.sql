-- @block
CREATE TABLE Users(
  id INT PRIMARY KEY AUTO_INCREMENT, -- column, datatype, keytype, behavior
  email VARCHAR(255) NOT NULL UNIQUE, -- column, varchar = string, 255 = maxlength, must contain data, must be unique
  bio TEXT, -- TEXT used when a string of undisclosed length will be entered
  country VARCHAR(2) -- Country code will always be 2
);

-- @block
INSERT INTO Users (email, bio, country)
-- order matters!
VALUES (
  'hiya@yahoo.com',
  'BINGO BANGO!',
  'US'
);

-- @block
SELECT * FROM Users;

-- @block
-- This will ONLY grab id and email
SELECT id, email FROM Users 
-- This will limit your results.
LIMIT 3; 

-- @block
SELECT id, email, country FROM Users

-- Grab only Users with US as Country
WHERE country = 'US' 
-- That have an ID less than 5
AND id < 5

-- order them in descending order
ORDER BY id DESC 
-- and limit it to 5 users
LIMIT 5;

-- @block
SELECT id, email, country FROM Users

-- Grab only Users with US as Country
WHERE country = 'US' 
-- That starts with h
AND email LIKE 'h%'

-- order them in descending order
ORDER BY id DESC 
-- and limit it to 5 users
LIMIT 5;

-- @block
CREATE INDEX email_index ON Users(email);

-- @block
CREATE TABLE Rooms (
  -- UserID = Primary Key 
  id INT AUTO_INCREMENT,
  street VARCHAR(255),
  -- OwnerID = Foreign Key, because it references a key in a different table
  owner_id INT NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY(owner_id) REFERENCES Users(id)
);

-- @block
INSERT INTO Rooms (owner_id, street)
VALUES
  (1, 'A really big boat'),
  (1, 'A Mountain Castle'),
  (1, 'Tiny Chasm on the Moon'),
  (1, 'The Snow Pit');

-- @block
SELECT
  Users.id AS user_id,
  Rooms.id AS room_id,
  email,
  street  
FROM Users 
INNER JOIN Rooms 
ON Rooms.owner_id = Users.id;

-- @block
CREATE TABLE Bookings (
  id INT AUTO_INCREMENT,
  guest_id INT NOT NULL,
  room_id INT NOT NULL,
  check_in DATETIME,
  PRIMARY KEY (id),
  FOREIGN KEY (guest_id) REFERENCES Users(id),
  FOREIGN KEY (room_id) REFERENCES Rooms(id)
);

-- @block
SELECT
  guest_id,
  street,
  check_in
FROM Bookings
INNER JOIN Rooms ON Rooms.owner_id = guest_id
WHERE guest_id = 1;

-- @block
-- If you want to delete everything, run this block.
DROP TABLE Users;
DROP DATABASE airbnb;