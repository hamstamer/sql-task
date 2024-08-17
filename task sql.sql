CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender CHAR(1)
);
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Credits INT
);
INSERT INTO Students (StudentID, FirstName, LastName, DateOfBirth, Gender)
VALUES 
(1, 'John', 'Doe', '2000-01-15', 'M'),
(2, 'Jane', 'Smith', '1999-05-23', 'F'),
(3, 'Michael', 'Johnson', '2001-11-10', 'M'),
(4, 'Emily', 'Davis', '2000-08-30', 'F');
INSERT INTO Courses (CourseID, CourseName, Credits)
VALUES 
(101, 'Introduction to Computer Science', 4),
(102, 'Database Systems', 3),
(103, 'Data Structures and Algorithms', 4),
(104, 'Operating Systems', 3);

SELECT * FROM Students;

SELECT * FROM Courses;

UPDATE Courses
SET Credits = 4
WHERE CourseName = 'Physics';

SELECT * FROM Courses WHERE CourseName = 'Physics';

DELETE FROM Students
WHERE FirstName = 'John' AND LastName = 'Doe';

SELECT * FROM Students
WHERE EnrollmentDate > '2023-09-01';

ALTER TABLE Students
ADD EnrollmentDate DATE;

UPDATE Students
SET EnrollmentDate = '2023-09-05'
WHERE FirstName = 'John' AND LastName = 'Doe';

UPDATE Students
SET EnrollmentDate = '2023-08-15'
WHERE FirstName = 'Jane' AND LastName = 'Smith';

UPDATE Students
SET EnrollmentDate = '2023-10-01'
WHERE FirstName = 'Michael' AND LastName = 'Johnson';

UPDATE Students
SET EnrollmentDate = '2023-07-20'
WHERE FirstName = 'Emily' AND LastName = 'Davis';

SELECT * FROM Students
WHERE EnrollmentDate > '2023-09-01';

SELECT * FROM Courses
WHERE Credits > 3;

SELECT COUNT(*) AS TotalStudents
FROM Students;

SELECT AVG(Credits) AS AverageCredits
FROM Courses;

ALTER TABLE Courses
ADD CONSTRAINT chk_Credits_NonNegative CHECK (Credits >= 0);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
INSERT INTO Enrollments (EnrollmentID, CourseID)
VALUES 
(1,  101),
(2,  103),
(3,  102),
(4,  101),
(5,  104);

SELECT 
    s.StudentID,
    s.FirstName,
    s.LastName,
    c.CourseID,
    c.CourseName,
    c.Credits
FROM 
    Enrollments e
JOIN 
    Students s ON e.StudentID = s.StudentID
JOIN 
    Courses c ON e.CourseID = c.CourseID;

SELECT 
    CourseID,
    CourseName,
    LENGTH(CourseName) AS CourseNameLength
FROM 
    Courses;

SELECT 
    StudentID,
    FirstName,
    LastName
FROM 
    Students
WHERE 
    StudentID IN (
        SELECT 
            e.StudentID
        FROM 
            Enrollments e
        JOIN 
            Courses c ON e.CourseID = c.CourseID
        WHERE 
            c.Credits > 3
    );

CREATE VIEW StudentCourseView AS
SELECT 
    s.StudentID,
    s.FirstName,
    s.LastName,
    c.CourseName
FROM 
    Students s
JOIN 
    Enrollments e ON s.StudentID = e.StudentID
JOIN 
    Courses c ON e.CourseID = c.CourseID;

CREATE INDEX idx_LastName
ON Students (LastName);

BEGIN;

INSERT INTO Students (StudentID, FirstName, LastName, DateOfBirth, Gender)
VALUES (5, 'Alice', 'Williams', '2002-03-22', 'F');

INSERT INTO Courses (CourseID, CourseName, Credits)
VALUES (105, 'Web Development', 4);

COMMIT;

CREATE TABLE MixedData (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    BirthDate DATE,
    Salary DECIMAL(10, 2),
    IsActive BOOLEAN
);

INSERT INTO MixedData (ID, Name, BirthDate, Salary, IsActive)
VALUES 
(1, 'Alice', '1990-06-15', 55000.00, TRUE),
(2, 'Bob', '1985-09-25', 60000.00, FALSE),
(3, 'Charlie', '1992-12-05', 45000.00, TRUE);

SELECT 
    Name,
    BirthDate,
    Salary,
    CASE 
        WHEN IsActive THEN 'Active'
        ELSE 'Inactive'
    END AS Status
FROM 
    MixedData;
