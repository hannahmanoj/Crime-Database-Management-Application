drop table location cascade constraints;
drop table reporter cascade constraints;
drop table offender cascade constraints;
drop table police cascade constraints;
drop table open_crime cascade constraints;
drop table closed_crime cascade constraints;
drop table crime_info cascade constraints;
drop table crime_event cascade constraints;
drop table object cascade constraints;
drop table Suspect cascade constraints;
drop table witness cascade constraints;
drop table victim cascade constraints;
drop table crime_event_suspect cascade constraints;
drop table crime_event_witness cascade constraints;
drop table crime_event_victim cascade constraints;

CREATE TABLE Location(
Location_ID VARCHAR2(10) PRIMARY KEY, 
City VARCHAR2(20) NOT NULL, 
Region VARCHAR2(20), 
Post_Code VARCHAR2(20) NOT NULL);

CREATE TABLE Reporter(
Reporter_ID VARCHAR2(10) PRIMARY KEY, 
Reporter_Firstname VARCHAR2(20) NOT NULL, 
Reporter_Surname VARCHAR2(20) NOT NULL, 
Reporter_Mobile NUMBER(15) NOT NULL, 
Reporter_Email VARCHAR2(100) NOT NULL, 
Reporter_Address VARCHAR2(100) NOT NULL, 
Reporter_Date_Of_Birth DATE);

CREATE TABLE Offender(
Offender_ID VARCHAR2(10) PRIMARY KEY, 
Offender_Firstname VARCHAR2(20) NOT NULL, 
Offender_Surname VARCHAR2(20) NOT NULL, 
Offender_Mobile NUMBER(15) NOT NULL, 
Offender_Email VARCHAR(100) NOT NULL, 
Offender_Address VARCHAR2(100) NOT NULL, 
Offender_Date_Of_Birth DATE NOT NULL, 
Offender_History VARCHAR2(600));

CREATE TABLE Police(
Police_ID VARCHAR2(10) PRIMARY KEY, 
Police_Firstname VARCHAR2(20) NOT NULL, 
Police_Surname VARCHAR2(20) NOT NULL, 
Job_title VARCHAR2(20) NOT NULL, 
Email VARCHAR2(100) NOT NULL, 
Phone NUMBER(20) NOT NULL, 
Date_Of_Birth DATE NOT NULL, 
Payroll VARCHAR2(20) NOT NULL, 
NI_Number VARCHAR2(2) NOT NULL, 
Date_Of_Hire DATE NOT NULL, 
Shift_Type VARCHAR2(20) NOT NULL, 
Number_of_Cases_Solved NUMBER, 
Status VARCHAR2(15) NOT NULL);

CREATE TABLE Open_Crime(
Open_Crime_ID VARCHAR2(10) PRIMARY KEY, 
Date_Reported DATE NOT NULL, 
Assigned_Team VARCHAR2(30), 
Evidence CHAR(1) CHECK (Evidence IN ('Y', 'N')), 
Open_Crime_Notes VARCHAR2(500), 
Number_Of_Arrests NUMBER);

CREATE TABLE Closed_Crime(
Closed_Crime_ID VARCHAR2(10) PRIMARY KEY, 
Date_Reported DATE NOT NULL,
Date_Closed DATE NOT NULL, 
Assigned_Team VARCHAR2(30) NOT NULL, 
Closure_Type VARCHAR2(20) NOT NULL, 
Number_Of_Arrests NUMBER);

CREATE TABLE Crime_Info(
Crime_ID VARCHAR2(10) PRIMARY KEY, 
Crime_type VARCHAR2(20) CHECK (Crime_type IN ('Primary', 'Secondary')), 
Open_Crime_ID VARCHAR2(10) REFERENCES Open_Crime(Open_Crime_ID), 
Closed_Crime_ID VARCHAR2(10) REFERENCES Closed_Crime(Closed_Crime_ID), 
Police_ID VARCHAR2(10) REFERENCES Police(Police_ID), 
Location_ID VARCHAR2(10) REFERENCES Location(Location_ID), 
Reporter_ID VARCHAR2(10) REFERENCES Reporter(Reporter_ID));

CREATE TABLE Crime_Event(
Crime_Event_ID VARCHAR2(90) PRIMARY KEY, 
Event_Description VARCHAR2(1000) NOT NULL, 
Event_Type VARCHAR2(30) NOT NULL, 
Event_Date DATE NOT NULL, 
Event_Time VARCHAR2(20) NOT NULL, 
Related_Crime_Event_ID VARCHAR2(20),
Crime_ID VARCHAR2(10) REFERENCES Crime_Info(Crime_ID), 
Offender_ID VARCHAR2(10) REFERENCES Offender(Offender_ID), 
CONSTRAINT fk_related_crime_event FOREIGN KEY (Related_Crime_Event_ID) REFERENCES Crime_Event(Crime_Event_ID));

CREATE TABLE Object(
Object_ID VARCHAR2(90) PRIMARY KEY, 
Object_Type VARCHAR2(40) NOT NULL, 
Object_Material VARCHAR2(50) NOT NULL, 
Object_Description VARCHAR2(200), 
Crime_Event_ID VARCHAR2(90) REFERENCES Crime_Event(Crime_Event_ID));

CREATE TABLE Suspect(
Suspect_ID VARCHAR2(90) PRIMARY KEY, 
Suspect_Firstname VARCHAR2(20) NOT NULL, 
Suspect_Lastname VARCHAR2(20) NOT NULL, 
Suspect_Mobile NUMBER(10) NOT NULL, 
Suspect_Email VARCHAR2(30) NOT NULL, 
Suspect_Address VARCHAR2(40) NOT NULL,
Suspect_Date_Of_Birth DATE NOT NULL,
Suspect_History VARCHAR2(500) ,
Suspect_Relation VARCHAR2(200),
Suspect_Status VARCHAR2(50) NOT NULL,
Arrest_Date DATE,
Suspect_Lawyer CHAR(1) CHECK (Suspect_Lawyer IN ('Y', 'N')));

CREATE TABLE Witness(
Witness_ID VARCHAR2(90) PRIMARY KEY, 
Witness_Firstname VARCHAR2(20) NOT NULL, 
Witness_Lastname VARCHAR2(20) NOT NULL, 
Witness_Mobile NUMBER(10) NOT NULL, 
Witness_Email VARCHAR2(30) NOT NULL, 
Witness_Address VARCHAR2(40) NOT NULL,
Witness_Date_Of_Birth DATE NOT NULL,
Witness_Statement VARCHAR2(3000),
Witness_Statement_date DATE,
Testimony_Type VARCHAR2(200),
Location_During_Crime VARCHAR2(100),
Witness_Relation_To_Case VARCHAR2(200));

CREATE TABLE Victim(
Victim_ID VARCHAR2(90) PRIMARY KEY, 
Victim_Firstname VARCHAR2(20) NOT NULL, 
Victim_Lastname VARCHAR2(20) NOT NULL, 
Victim_Mobile NUMBER(10) NOT NULL, 
Victim_Email VARCHAR2(30) NOT NULL, 
Victim_Address VARCHAR2(40) NOT NULL,
Victim_Date_Of_Birth DATE NOT NULL,
Victim_Statement VARCHAR2(500),
Victim_Statement_date DATE,
Testimony_Type VARCHAR2(200),
Location_During_Crime VARCHAR2(100),
Hospital_Status VARCHAR2(100),
Victim_Injury_Description VARCHAR(200),
Victim_Report_date DATE NOT NULL,
Protection_Status VARCHAR2(200),
Victim_Relation_To_Case VARCHAR2(200));

CREATE TABLE Crime_Event_Suspect(
Crime_Event_Suspect_ID VARCHAR2(90) PRIMARY KEY, 
Suspect_ID VARCHAR2(90) REFERENCES Suspect(Suspect_ID) NOT NULL, 
Crime_Event_ID VARCHAR2(90) REFERENCES Crime_Event(Crime_Event_ID),
Date_Suspect_Req DATE NOT NULL,
Interrogation_Status VARCHAR2(40) CHECK (Interrogation_Status IN ('Pending', 'Completed')));

CREATE TABLE Crime_Event_Witness(
Crime_Event_Witness_ID VARCHAR2(90) PRIMARY KEY, 
Witness_ID VARCHAR2(90) REFERENCES Witness(Witness_ID), 
Crime_Event_ID VARCHAR2(90) REFERENCES Crime_Event(Crime_Event_ID),
Date_Witness_Req DATE NOT NULL,
Interview_Location VARCHAR2(100),
Response_to_Subpoena CHAR(1) CHECK (Response_to_Subpoena IN ('Y', 'N')));

CREATE TABLE Crime_Event_Victim(
Crime_Event_Victim_ID VARCHAR2(90) PRIMARY KEY, 
Victim_ID VARCHAR2(90) REFERENCES Victim(Victim_ID), 
Crime_Event_ID VARCHAR2(90) REFERENCES Crime_Event(Crime_Event_ID), 
Date_Victimised DATE NOT NULL, 
Compensation_Eligibility VARCHAR2(100),
Immediate_Assistance_Provided VARCHAR2(100));

--INSERT LOCATION
INSERT INTO Location(Location_ID, City, Region, Post_Code)
VALUES ('L001', 'Wakefield', 'West Yorkshire', 'WF2 10KA');

INSERT INTO Location(Location_ID, City, Region, Post_Code)
VALUES ('L002', 'London', 'South East', 'WC2N');

INSERT INTO Location(Location_ID, City, Region, Post_Code)
VALUES ('L003', 'Greendale', 'South Region', 'GR10 2GH');

INSERT INTO Location(Location_ID, City, Region, Post_Code)
VALUES ('L004', 'Stars Hollow', 'New England Region', 'SH17 8JK');

INSERT INTO Location(Location_ID, City, Region, Post_Code)
VALUES ('L005', 'Mystic Falls', 'Southeast Region', 'MF40 2GH');

INSERT INTO Location(Location_ID, City, Region, Post_Code)
VALUES ('L006', 'Sunnydale', 'West Coast Region', 'SD21 9KL');

INSERT INTO Location(Location_ID, City, Region, Post_Code)
VALUES ('L007', 'Gotham', 'Northeast Region', 'GT45 1MN');

INSERT INTO Location(Location_ID, City, Region, Post_Code)
VALUES ('L008', 'Beacon Hills', 'Southwest Region', 'BH33 7CD');


--INSERT REPORTER
INSERT INTO Reporter(Reporter_ID, Reporter_Firstname, Reporter_Surname, Reporter_Mobile, Reporter_Email, Reporter_Address, Reporter_Date_Of_Birth)
VALUES ('R001', 'Alice', 'Johnson', 0700123456, 'alice.johnson@icloud.com', '55 Elm St', '09/03/2000');

INSERT INTO Reporter(Reporter_ID, Reporter_Firstname, Reporter_Surname, Reporter_Mobile, Reporter_Email, Reporter_Address, Reporter_Date_Of_Birth)
VALUES ('R002', 'David', 'Wilson', 0700345678, 'david.wilson@gmail.com', '101 Oak St', '10/04/1989');

INSERT INTO Reporter(Reporter_ID, Reporter_Firstname, Reporter_Surname, Reporter_Mobile, Reporter_Email, Reporter_Address, Reporter_Date_Of_Birth)
VALUES ('R003', 'Emma', 'Taylor', 0700876543, 'emma.taylor@yahoo.co.uk', '202 Birch Ln', '02/21/1999');

INSERT INTO Reporter(Reporter_ID, Reporter_Firstname, Reporter_Surname, Reporter_Mobile, Reporter_Email, Reporter_Address, Reporter_Date_Of_Birth)
VALUES ('R004', 'Daniel', 'Garcia', 0700456789, 'daniel.garcia@outlook.co.uk', '505 Spruce Pl', '03/19/2001');

INSERT INTO Reporter(Reporter_ID, Reporter_Firstname, Reporter_Surname, Reporter_Mobile, Reporter_Email, Reporter_Address, Reporter_Date_Of_Birth)
VALUES ('R005', 'Sophia', 'Anderson', 0700987123, 'sophia.anderson@gmail.com', '606 Aspen Way', '12/12/1991');

INSERT INTO Reporter(Reporter_ID, Reporter_Firstname, Reporter_Surname, Reporter_Mobile, Reporter_Email, Reporter_Address, Reporter_Date_Of_Birth)
VALUES ('R006', 'Julie', 'Manoj', 0700987123, 'Julie.manoj@gmail.com', '60 flanshaw Way', '12/03/1999');

INSERT INTO Reporter(Reporter_ID, Reporter_Firstname, Reporter_Surname, Reporter_Mobile, Reporter_Email, Reporter_Address, Reporter_Date_Of_Birth)
VALUES ('R007', 'Alfin', 'Mathew', 0700987123, 'alfin.mathew@gmail.com', '808 Thornes Rd', '09/29/1989');


--INSERT OFFENDER
INSERT INTO Offender (Offender_ID, Offender_Firstname, Offender_Surname, Offender_Mobile, Offender_Email, Offender_Address, Offender_Date_Of_Birth, Offender_History) 
VALUES
('O001', 'James', 'Brown', 0707890123, 'james.brown@gmail.com', '308 Negra Arroyo Ln', '03/05/2000', 
'Convicted in 2010 for burglary, served 3 years. Re-arrested in 2015 for theft but acquitted. 
Currently under investigation for suspected involvement in recent jewelry heist.');

INSERT INTO Offender (Offender_ID, Offender_Firstname, Offender_Surname, Offender_Mobile, Offender_Email, Offender_Address, Offender_Date_Of_Birth, Offender_History) 
VALUES
('O002', 'Jane', 'Smith', 0702345678, 'jane.smith@outlook.com', '221B Baker St', '09/05/1999', 
'First offense in 2011 for shoplifting, followed by multiple arrests for petty theft and trespassing. 
Served community service. Probation violations in 2018 led to short jail term.');

INSERT INTO Offender (Offender_ID, Offender_Firstname, Offender_Surname, Offender_Mobile, Offender_Email, Offender_Address, Offender_Date_Of_Birth, Offender_History) 
VALUES
('O003', 'Mike', 'Johnson', 0703456789, 'mike.johnson@yahoo.com', '742 Evergreen Terrace', '08/07/1992', 
'Arrested in 2018 for drug possession with intent to distribute. Served 2 years. 
Known associate of drug-trafficking network, currently under monitoring. Suspected but not charged in recent case.');

INSERT INTO Offender (Offender_ID, Offender_Firstname, Offender_Surname, Offender_Mobile, Offender_Email, Offender_Address, Offender_Date_Of_Birth, Offender_History) 
VALUES
('O004', 'Emily', 'Davis', 0704567890, 'emily.davis@outlook.com', '1600 Pennsylvania Ave', '03/12/1990', 
'Arrested for drug possession in 2018; Suspected of distribution.');

INSERT INTO Offender (Offender_ID, Offender_Firstname, Offender_Surname, Offender_Mobile, Offender_Email, Offender_Address, Offender_Date_Of_Birth, Offender_History) 
VALUES
('O005', 'Robert', 'Garcia', 0705678901, 'robert.garcia@gmail.com', '101 Dalmatian St', '08/25/1980', 
'Convicted for fraud in 2012; parole in 2018.');

INSERT INTO Offender (Offender_ID, Offender_Firstname, Offender_Surname, Offender_Mobile, Offender_Email, Offender_Address, Offender_Date_Of_Birth, Offender_History) 
VALUES
('O006', 'Linda', 'Martinez', 0706789012, 'linda.martinez@yahoo.com', '13 Elm St', '05/12/1995', 
'Shoplifting convictions in 2019; Trespassing warnings.');

INSERT INTO Offender (Offender_ID, Offender_Firstname, Offender_Surname, Offender_Mobile, Offender_Email, Offender_Address, Offender_Date_Of_Birth, Offender_History) 
VALUES
('O007', 'Karen', 'Moore', 0700123456, 'karen.moore@live.co.uk', '1060 W Addison St', '09/02/1986', 
'Convicted in 2012 for large-scale fraud, served 6 years.
Linked to multiple investment scams, released on parole in 2018. Under financial monitoring; barred from holding directorial positions in companies.');


--INSERT POLICE
INSERT INTO Police (Police_ID, Police_Firstname, Police_Surname, Job_title, Email, Phone, Date_Of_Birth, Payroll, NI_Number, Date_Of_Hire, 
Shift_Type, Number_of_Cases_Solved, Status) VALUES 
('P001', 'Alice', 'Johnson', 'Officer', 'alice.johnson@policedep.com', 0701234567, '07/23/1979', 'P-001-2024', 'AB', '05/14/2005', 'Day Shift', 42, 'Active');

INSERT INTO Police (Police_ID, Police_Firstname, Police_Surname, Job_title, Email, Phone, Date_Of_Birth, Payroll, NI_Number, Date_Of_Hire, 
Shift_Type, Number_of_Cases_Solved, Status) VALUES 
('P002', 'David', 'Smith', 'Inspector', 'david.smith@policedep.com', 0702345678, '12/15/1978', 'P-002-2024', 'CD', '11/22/2004', 'Night Shift', 108, 'Active');

INSERT INTO Police (Police_ID, Police_Firstname, Police_Surname, Job_title, Email, Phone, Date_Of_Birth, Payroll, NI_Number, Date_Of_Hire, 
Shift_Type, Number_of_Cases_Solved, Status) VALUES 
('P003', 'Sarah', 'Lee', 'Detective', 'sarah.lee@policedep.com', 0703456789, '09/04/1990', 'P-003-2024', 'EF',  '02/01/2007', 'Day Shift', 67, 'Active');

INSERT INTO Police (Police_ID, Police_Firstname, Police_Surname, Job_title, Email, Phone, Date_Of_Birth, Payroll, NI_Number, Date_Of_Hire, 
Shift_Type, Number_of_Cases_Solved, Status) VALUES 
('P004', 'James', 'Brown', 'Officer', 'james.brown@policedep.com', 0704567890, '03/20/1978', 'P-004-2024', 'GH', '01/02/2015', 'Night Shift', 33, 'On Leave');

INSERT INTO Police (Police_ID, Police_Firstname, Police_Surname, Job_title, Email, Phone, Date_Of_Birth, Payroll, NI_Number, Date_Of_Hire, 
Shift_Type, Number_of_Cases_Solved, Status) VALUES 
('P005', 'Emma', 'Wilson', 'Inspector', 'emma.wilson@policedep.com', 0705678901, '06/11/1975', 'P-005-2024', 'IJ', '08/27/2003', 'Day', 145, 'Active');

INSERT INTO Police (Police_ID, Police_Firstname, Police_Surname, Job_title, Email, Phone, Date_Of_Birth, Payroll, NI_Number, Date_Of_Hire, 
Shift_Type, Number_of_Cases_Solved, Status) VALUES
('P006', 'Michael', 'Garcia', 'Detective', 'michael.garcia@policedep.com', 0706789012, '10/31/1988', 'P-006-2024', 'KL', '01/15/2011', 'Night', 85, 'Retired');

INSERT INTO Police (Police_ID, Police_Firstname, Police_Surname, Job_title, Email, Phone, Date_Of_Birth, Payroll, NI_Number, Date_Of_Hire, 
Shift_Type, Number_of_Cases_Solved, Status) VALUES
('P007', 'Linda', 'Martinez', 'Officer', 'linda.martinez@policedep.com', 0707890123, '01/28/1992', 'P-007-2024', 'MN', '06/30/2015', 'Day', 29, 'Active');

INSERT INTO Police (Police_ID, Police_Firstname, Police_Surname, Job_title, Email, Phone, Date_Of_Birth, Payroll, NI_Number, Date_Of_Hire, 
Shift_Type, Number_of_Cases_Solved, Status) VALUES
('P008', 'Robert', 'Anderson', 'Detective', 'robert.anderson@policedep.com', 0708901234, '09/22/1986', 'P-008-2024', 'OP', '03/04/2009', 'Night', 92, 'Suspended');

INSERT INTO Police (Police_ID, Police_Firstname, Police_Surname, Job_title, Email, Phone, Date_Of_Birth, Payroll, NI_Number, Date_Of_Hire, 
Shift_Type, Number_of_Cases_Solved, Status) VALUES
('P009', 'Jessica', 'Taylor', 'Inspector', 'jessica.taylor@policedep.com', 0709012345, '11/19/1979', 'P-009-2024', 'QR', '07/13/2001', 'Day', 115, 'Active');

INSERT INTO Police (Police_ID, Police_Firstname, Police_Surname, Job_title, Email, Phone, Date_Of_Birth, Payroll, NI_Number, Date_Of_Hire, 
Shift_Type, Number_of_Cases_Solved, Status) VALUES
('P010', 'William', 'Moore', 'Officer', 'william.moore@policedep.com', 0700123456, '05/30/1995', 'P-010-2024', 'ST', '12/02/2019', 'Night', 10, 'Active');



--INSERT OPEN CRIMES
INSERT INTO Open_Crime (Open_Crime_ID, Date_Reported, Assigned_Team, Evidence, Open_Crime_Notes, Number_Of_Arrests) VALUES
('OC001', '10/15/2023', 'Violent Crimes Unit', 'Y', 'Investigation ongoing; suspect identified but not apprehended.', 0);

INSERT INTO Open_Crime (Open_Crime_ID, Date_Reported, Assigned_Team, Evidence, Open_Crime_Notes, Number_Of_Arrests) VALUES
('OC002', '11/01/2023', 'Cybercrime Unit', 'N', 'Suspected ransomware attack; evidence gathering in progress.', 0);

INSERT INTO Open_Crime (Open_Crime_ID, Date_Reported, Assigned_Team, Evidence, Open_Crime_Notes, Number_Of_Arrests) VALUES
('OC003', '10/20/2023', 'Narcotics Division', 'Y', 'Seized illegal substances during operation; awaiting lab results.', 2);

INSERT INTO Open_Crime (Open_Crime_ID, Date_Reported, Assigned_Team, Evidence, Open_Crime_Notes, Number_Of_Arrests) VALUES
('OC004', '09/30/2023', 'Fraud Department', 'N', 'Initial reports indicate fraudulent transactions; suspects unknown.', 0);

INSERT INTO Open_Crime (Open_Crime_ID, Date_Reported, Assigned_Team, Evidence, Open_Crime_Notes, Number_Of_Arrests) VALUES
('OC005', '11/03/2023', 'Organized Crime', 'Y', 'Linked to larger gang activity; surveillance ongoing.', 1);


--INSERT CLOSED CRIMES
INSERT INTO Closed_Crime (Closed_Crime_ID, Date_Reported, Date_Closed, Assigned_Team, Closure_Type, Number_Of_Arrests) VALUES
('CC001', '03/12/2023', '03/28/2023', 'Homicide Unit', 'Solved', 1);

INSERT INTO Closed_Crime (Closed_Crime_ID, Date_Reported, Date_Closed, Assigned_Team, Closure_Type, Number_Of_Arrests) VALUES
('CC002', '05/05/2023', '07/15/2023', 'Cybercrime Unit', 'Unsolved', 0);

INSERT INTO Closed_Crime (Closed_Crime_ID, Date_Reported, Date_Closed, Assigned_Team, Closure_Type, Number_Of_Arrests) VALUES
('CC003', '04/10/2023', '06/20/2023', 'Narcotics Division', 'Solved', 3);

INSERT INTO Closed_Crime (Closed_Crime_ID, Date_Reported, Date_Closed, Assigned_Team, Closure_Type, Number_Of_Arrests) VALUES
('CC004', '02/08/2023', '05/22/2023', 'Fraud Department', 'Unsolved', 0);

INSERT INTO Closed_Crime (Closed_Crime_ID, Date_Reported, Date_Closed, Assigned_Team, Closure_Type, Number_Of_Arrests) VALUES
('CC005', '01/20/2023', '02/15/2023', 'Organized Crime', 'Solved', 4);


--INSERT INTO CRIME INFO
INSERT INTO Crime_Info (Crime_ID, Crime_type, Open_Crime_ID, Closed_Crime_ID, Police_ID, Location_ID, Reporter_ID) VALUES
('CR001', 'Primary', 'OC001', NULL, 'P001', 'L001', 'R001');

INSERT INTO Crime_Info (Crime_ID, Crime_type, Open_Crime_ID, Closed_Crime_ID, Police_ID, Location_ID, Reporter_ID) VALUES
('CR002', 'Secondary', NULL, 'CC001', 'P002', 'L002', 'R002');

INSERT INTO Crime_Info (Crime_ID, Crime_type, Open_Crime_ID, Closed_Crime_ID, Police_ID, Location_ID, Reporter_ID) VALUES
('CR003', 'Primary', 'OC002', NULL, 'P003', 'L003', 'R003');

INSERT INTO Crime_Info (Crime_ID, Crime_type, Open_Crime_ID, Closed_Crime_ID, Police_ID, Location_ID, Reporter_ID) VALUES
('CR004', 'Secondary', NULL, 'CC002', 'P004', 'L004', 'R004');

INSERT INTO Crime_Info (Crime_ID, Crime_type, Open_Crime_ID, Closed_Crime_ID, Police_ID, Location_ID, Reporter_ID) VALUES
('CR005', 'Primary', 'OC003', NULL, 'P005', 'L005', 'R005');

INSERT INTO Crime_Info (Crime_ID, Crime_type, Open_Crime_ID, Closed_Crime_ID, Police_ID, Location_ID, Reporter_ID) VALUES
('CR006', 'Secondary', 'OC004', NULL, 'P006', 'L006', 'R006');

INSERT INTO Crime_Info (Crime_ID, Crime_type, Open_Crime_ID, Closed_Crime_ID, Police_ID, Location_ID, Reporter_ID) VALUES
('CR007', 'Primary', NULL, 'CC003', 'P007', 'L007', 'R007');


--INSERT INTO CRIME_EVENT
INSERT INTO Crime_Event (Crime_Event_ID, Event_Description, Event_Type, Event_Date, Event_Time, Related_Crime_Event_ID, Crime_ID, Offender_ID) VALUES
('CE001', 'Witness reported a suspicious individual at the scene.', 'Witness Report', '01/15/2023', '14:30', NULL, 'CR001', 'O001');

INSERT INTO Crime_Event (Crime_Event_ID, Event_Description, Event_Type, Event_Date, Event_Time, Related_Crime_Event_ID, Crime_ID, Offender_ID) VALUES
('CE002', 'Suspect was apprehended after a brief pursuit.', 'Apprehension', '01/15/2023', '15:00', 'CE001', 'CR001', 'O001');

INSERT INTO Crime_Event (Crime_Event_ID, Event_Description, Event_Type, Event_Date, Event_Time, Related_Crime_Event_ID, Crime_ID, Offender_ID) VALUES
('CE003', 'Victim was interviewed regarding the incident.', 'Interview', '02/20/2023', '10:00', NULL, 'CR002', NULL);

INSERT INTO Crime_Event (Crime_Event_ID, Event_Description, Event_Type, Event_Date, Event_Time, Related_Crime_Event_ID, Crime_ID, Offender_ID) VALUES
('CE004', 'Physical evidence was collected from the crime scene.', 'Evidence Collection', '02/20/2023', '11:30', 'CE003', 'CR002', NULL);

INSERT INTO Crime_Event (Crime_Event_ID, Event_Description, Event_Type, Event_Date, Event_Time, Related_Crime_Event_ID, Crime_ID, Offender_ID) VALUES
('CE005', 'Suspect confessed after interrogation.', 'Interrogation', '03/05/2023', '09:00', 'CE004', 'CR002', 'O002');

INSERT INTO Crime_Event (Crime_Event_ID, Event_Description, Event_Type, Event_Date, Event_Time, Related_Crime_Event_ID, Crime_ID, Offender_ID) VALUES
('CE006', 'Police found additional evidence in suspect’s home.', 'Search', '03/10/2023', '13:00', 'CE005', 'CR003', 'O003');

INSERT INTO Crime_Event (Crime_Event_ID, Event_Description, Event_Type, Event_Date, Event_Time, Related_Crime_Event_ID, Crime_ID, Offender_ID) VALUES
('CE007', 'Case closed as suspect pleaded guilty.', 'Case Closure', '03/15/2023', '16:00', 'CE006', 'CR002', 'O002');

INSERT INTO Crime_Event (Crime_Event_ID, Event_Description, Event_Type, Event_Date, Event_Time, Related_Crime_Event_ID, Crime_ID, Offender_ID) VALUES
('CE008', 'Fire department contained the fire; suspect was detained.', 'Containment', '04/22/2023', '12:45', NULL, 'CR005', 'O004');

INSERT INTO Crime_Event (Crime_Event_ID, Event_Description, Event_Type, Event_Date, Event_Time, Related_Crime_Event_ID, Crime_ID, Offender_ID) VALUES
('CE009', 'Blood spots found by forensics team on Park Ave', 'Forensics Report', '04/22/2022', '12:40', NULL, 'CR005', 'O004');

INSERT INTO Crime_Event (Crime_Event_ID, Event_Description, Event_Type, Event_Date, Event_Time, Related_Crime_Event_ID, Crime_ID, Offender_ID) VALUES
('CE010', 'Bank Robbery', 'Evidence Collection', '04/22/2021', '8:40', NULL, 'CR004', 'O001');

INSERT INTO Crime_Event (Crime_Event_ID, Event_Description, Event_Type, Event_Date, Event_Time, Related_Crime_Event_ID, Crime_ID, Offender_ID) VALUES
('CE011', 'Money Laundering', 'Interview', '04/12/2021', '2:40', NULL, 'CR005', 'O002');

INSERT INTO Crime_Event (Crime_Event_ID, Event_Description, Event_Type, Event_Date, Event_Time, Related_Crime_Event_ID, Crime_ID, Offender_ID) VALUES
('CE012', 'School child bullied by peer', 'Interview', '04/02/2021', '2:40', NULL, 'CR005', 'O004');

INSERT INTO Crime_Event (Crime_Event_ID, Event_Description, Event_Type, Event_Date, Event_Time, Related_Crime_Event_ID, Crime_ID, Offender_ID) VALUES
('CE013', 'School shooting incident', 'Interview', '02/02/2021', '2:10', NULL, 'CR005', 'O004');

INSERT INTO Crime_Event (Crime_Event_ID, Event_Description, Event_Type, Event_Date, Event_Time, Related_Crime_Event_ID, Crime_ID, Offender_ID) VALUES
('CE014', 'Cybercrime- hacked into banks systems', 'Evidence Collection', '02/23/2020', '16:00', NULL, 'CR003', 'O002');

INSERT INTO Crime_Event (Crime_Event_ID, Event_Description, Event_Type, Event_Date, Event_Time, Related_Crime_Event_ID, Crime_ID, Offender_ID) VALUES
('CE015', 'Burglary', 'Evidence Collection', '01/24/2020', '22:00', NULL, 'CR004', 'O001');


--INSERT INTO OBJECT
INSERT INTO Object (Object_ID, Object_Type, Object_Material, Object_Description, Crime_Event_ID) VALUES
('OBJ001', 'Knife', 'Metal', 'Kitchen knife', 'CE001');

INSERT INTO Object (Object_ID, Object_Type, Object_Material, Object_Description, Crime_Event_ID) VALUES
('OBJ002', 'Glove', 'Leather', 'Black leather glove', 'CE002');

INSERT INTO Object (Object_ID, Object_Type, Object_Material, Object_Description, Crime_Event_ID) VALUES
('OBJ003', 'Bottle', 'Glass', 'Shattered glass bottle', 'CE003');

INSERT INTO Object (Object_ID, Object_Type, Object_Material, Object_Description, Crime_Event_ID) VALUES
('OBJ004', 'Phone', 'Plastic', 'Burner phone', 'CE004');

INSERT INTO Object (Object_ID, Object_Type, Object_Material, Object_Description, Crime_Event_ID) VALUES
('OBJ005', 'Wallet', 'Leather', 'Brown wallet with ID', 'CE005');

INSERT INTO Object (Object_ID, Object_Type, Object_Material, Object_Description, Crime_Event_ID) VALUES
('OBJ006', 'Gun', 'Metal', 'Handgun with scratches', 'CE006');

INSERT INTO Object (Object_ID, Object_Type, Object_Material, Object_Description, Crime_Event_ID) VALUES
('OBJ007', 'Note', 'Paper', 'Threatening note', 'CE007');

INSERT INTO Object (Object_ID, Object_Type, Object_Material, Object_Description, Crime_Event_ID) VALUES
('OBJ008', 'Rope', 'Fiber', 'Piece of nylon rope', 'CE008');



--INSERT INTO SUSPECT
INSERT INTO Suspect (Suspect_ID, Suspect_Firstname, Suspect_Lastname, Suspect_Mobile, Suspect_Email, 
Suspect_Address, Suspect_Date_Of_Birth, Suspect_History, Suspect_Relation, Suspect_Status, Arrest_Date, Suspect_Lawyer) VALUES
('S001', 'John', 'Doe', 076543210, 'john.doe@mail.com', '123 Elm St', '03/12/1985', 
'Previous assault charge in 2015', 'Neighbor of victim', 'Under Investigation', '01/15/2023', 'Y');

INSERT INTO Suspect (Suspect_ID, Suspect_Firstname, Suspect_Lastname, Suspect_Mobile, Suspect_Email, 
Suspect_Address, Suspect_Date_Of_Birth, Suspect_History, Suspect_Relation, Suspect_Status, Arrest_Date, Suspect_Lawyer) VALUES
('S002', 'Jane', 'Smith', 076543211, 'jane.smith@mail.com', '456 Maple Ave', '07/22/1990', 
'Shoplifting record in 2018', 'Friend of witness', 'Released on Bail', '02/10/2023', 'N');

INSERT INTO Suspect (Suspect_ID, Suspect_Firstname, Suspect_Lastname, Suspect_Mobile, Suspect_Email, 
Suspect_Address, Suspect_Date_Of_Birth, Suspect_History, Suspect_Relation, Suspect_Status, Arrest_Date, Suspect_Lawyer) VALUES
('S003', 'Jim', 'Brown', 076543212, 'jim.brown@mail.com', '789 Oak Rd', '11/05/1975', 
'Multiple burglary charges', 'Relative of victim', 'In Custody', '03/01/2023', 'Y');

INSERT INTO Suspect (Suspect_ID, Suspect_Firstname, Suspect_Lastname, Suspect_Mobile, Suspect_Email, 
Suspect_Address, Suspect_Date_Of_Birth, Suspect_History, Suspect_Relation, Suspect_Status, Arrest_Date, Suspect_Lawyer) VALUES
('S004', 'Alice', 'Davis', 076567893, 'alice.davis@mail.com', '321 Pine Ln', '02/18/1988', 
'Suspicion of fraud', 'Business partner of victim', 'Under Surveillance', NULL, 'N');

INSERT INTO Suspect (Suspect_ID, Suspect_Firstname, Suspect_Lastname, Suspect_Mobile, Suspect_Email, 
Suspect_Address, Suspect_Date_Of_Birth, Suspect_History, Suspect_Relation, Suspect_Status, Arrest_Date, Suspect_Lawyer) VALUES
('S005', 'Mark', 'Lee', 076580974, 'mark.lee@mail.com', '654 Cedar St', '06/30/1995', 
'No prior criminal record', 'Acquaintance', 'Under Investigation', NULL, 'Y');



--INSERT INTO WITNESS
INSERT INTO Witness (Witness_ID, Witness_Firstname, Witness_Lastname, Witness_Mobile, Witness_Email, Witness_Address, Witness_Date_Of_Birth, Witness_Statement, 
Witness_Statement_date, Testimony_Type, Location_During_Crime, Witness_Relation_To_Case) VALUES
('W001', 'Sarah', 'Connor', 9876543215, 'sarah.connor@mail.com', '567 Birch Dr', '12/14/1982', 
'Saw the suspect leaving the scene hurriedly', TO_DATE('01/15/2023', 'MM/DD/YYYY'), 'Eyewitness', 'Nearby park', 'Neighbor');

INSERT INTO Witness (Witness_ID, Witness_Firstname, Witness_Lastname, Witness_Mobile, Witness_Email, Witness_Address, Witness_Date_Of_Birth, Witness_Statement, 
Witness_Statement_date, Testimony_Type, Location_During_Crime, Witness_Relation_To_Case) VALUES
('W002', 'Michael', 'Johnson', 9876543216, 'michael.johnson@mail.com', '345 Spruce St', '04/10/1992', 
'Heard loud noises and argument', TO_DATE('02/10/2023', 'MM/DD/YYYY'), 'Aural Witness', 'Apartment next door', 'Friend');

INSERT INTO Witness (Witness_ID, Witness_Firstname, Witness_Lastname, Witness_Mobile, Witness_Email, Witness_Address, Witness_Date_Of_Birth, Witness_Statement, 
Witness_Statement_date, Testimony_Type, Location_During_Crime, Witness_Relation_To_Case) VALUES
('W003', 'Emily', 'Taylor', 9876543217, 'emily.taylor@mail.com', '789 Cedar Ave', '09/07/1986', 
'Observed unusual activity earlier in the day', TO_DATE('03/01/2023', 'MM/DD/YYYY'), 'Eyewitness', 'In her car', 'Colleague');

INSERT INTO Witness (Witness_ID, Witness_Firstname, Witness_Lastname, Witness_Mobile, Witness_Email, Witness_Address, Witness_Date_Of_Birth, Witness_Statement, 
Witness_Statement_date, Testimony_Type, Location_During_Crime, Witness_Relation_To_Case) VALUES
('W004', 'Daniel', 'Wilson', 9876543218, 'daniel.wilson@mail.com', '123 Fir Ln', '05/15/1979', 
'Did not see the suspect clearly but noticed a vehicle', TO_DATE('04/05/2023', 'MM/DD/YYYY'), 'Peripheral Witness', 'Across the street', 'Neighbor');

INSERT INTO Witness (Witness_ID, Witness_Firstname, Witness_Lastname, Witness_Mobile, Witness_Email, Witness_Address, Witness_Date_Of_Birth, Witness_Statement, 
Witness_Statement_date, Testimony_Type, Location_During_Crime, Witness_Relation_To_Case) VALUES
('W005', 'Olivia', 'Martinez', 9876543219, 'olivia.martinez@mail.com', '456 Willow Rd', '10/20/1994', 
'Saw a person leaving the building', TO_DATE('05/08/2023', 'MM/DD/YYYY'), 'Eyewitness', 'In a nearby store', 'Passerby');

INSERT INTO Witness (Witness_ID, Witness_Firstname, Witness_Lastname, Witness_Mobile, Witness_Email, Witness_Address, Witness_Date_Of_Birth, Witness_Statement, 
Witness_Statement_date, Testimony_Type, Location_During_Crime, Witness_Relation_To_Case) VALUES
('W006', 'Marshal', 'Martiin', 987424219, 'marshal.martin@mail.com', '543 Queens Rd', '10/01/1994', 
'saw the crime happen at an ATM branch', TO_DATE('01/04/2023', 'MM/DD/YYYY'), 'Eyewitness', 'In a nearby ATM', 'Passerby');



--INSERT INTO VICTIM
INSERT INTO Victim (Victim_ID, Victim_Firstname, Victim_Lastname, Victim_Mobile, Victim_Email, Victim_Address, 
Victim_Date_Of_Birth, Victim_Statement, Victim_Statement_date, Testimony_Type, Location_During_Crime, Hospital_Status, 
Victim_Injury_Description, Victim_Report_date, Protection_Status, Victim_Relation_To_Case) VALUES
('V001', 'Laura', 'King', 9876543220, 'laura.king@mail.com', '101 King St', '08/15/1987', 'Saw suspect enter home before assault', 
'01/15/2023', 'Direct Victim', 'At home', 'Admitted', 'Minor head injury', '01/15/2023', 'Under Protection', 'Homeowner');


INSERT INTO Victim (Victim_ID, Victim_Firstname, Victim_Lastname, Victim_Mobile, Victim_Email, Victim_Address, 
Victim_Date_Of_Birth, Victim_Statement, Victim_Statement_date, Testimony_Type, Location_During_Crime, Hospital_Status, 
Victim_Injury_Description, Victim_Report_date, Protection_Status, Victim_Relation_To_Case) VALUES
('V002', 'Peter', 'Wright', 9876543221, 'peter.wright@mail.com', '202 Queen Rd', '12/10/1991', 'Suspect attempted theft', 
'02/12/2023', 'Direct Victim', 'Office', 'Released', 'Bruises on arm', '02/10/2023', 'None', 'Office Worker');


INSERT INTO Victim (Victim_ID, Victim_Firstname, Victim_Lastname, Victim_Mobile, Victim_Email, Victim_Address, 
Victim_Date_Of_Birth, Victim_Statement, Victim_Statement_date, Testimony_Type, Location_During_Crime, Hospital_Status, 
Victim_Injury_Description, Victim_Report_date, Protection_Status, Victim_Relation_To_Case) VALUES
('V003', 'Rachel', 'Young', 9876543222, 'rachel.young@mail.com', '303 Prince Ave', '03/25/1989', 'Attacked by unknown person', 
'03/12/2023', 'Direct Victim', 'Walking on street', 'Admitted', 'Broken leg', '03/12/2023', 'None', 'Pedestrian');


INSERT INTO Victim (Victim_ID, Victim_Firstname, Victim_Lastname, Victim_Mobile, Victim_Email, Victim_Address, 
Victim_Date_Of_Birth, Victim_Statement, Victim_Statement_date, Testimony_Type, Location_During_Crime, Hospital_Status, 
Victim_Injury_Description, Victim_Report_date, Protection_Status, Victim_Relation_To_Case) VALUES
('V004', 'James', 'Hall', 9876543223, 'james.hall@mail.com', '404 Knight Rd', '06/28/1993', 'Robbery incident at store', 
'04/01/2023', 'Direct Victim', 'Store', 'Admitted', 'Fractured wrist', '04/01/2023', 'Under Protection', 'Store Manager');


INSERT INTO Victim (Victim_ID, Victim_Firstname, Victim_Lastname, Victim_Mobile, Victim_Email, Victim_Address, 
Victim_Date_Of_Birth, Victim_Statement, Victim_Statement_date, Testimony_Type, Location_During_Crime, Hospital_Status, 
Victim_Injury_Description, Victim_Report_date, Protection_Status, Victim_Relation_To_Case) VALUES
('V005', 'Sophia', 'Scott', 9876543224, 'sophia.scott@mail.com', '505 Castle Dr', '11/18/1984', 'Car accident caused by suspect', 
'05/15/2023', 'Indirect Victim', 'Driving car', 'Released', 'Whiplash injury', '05/15/2023', 'None', 'Driver');


--INSERT INTO Crime_event_suspect
INSERT INTO Crime_Event_Suspect (Crime_Event_Suspect_ID, Suspect_ID, Crime_Event_ID, Date_Suspect_Req, Interrogation_Status) VALUES
('CES001', 'S001', 'CE001', '01/10/2023', 'Pending');


INSERT INTO Crime_Event_Suspect (Crime_Event_Suspect_ID, Suspect_ID, Crime_Event_ID, Date_Suspect_Req, Interrogation_Status) VALUES
('CES002', 'S002', 'CE002', '02/15/2023', 'Completed');

INSERT INTO Crime_Event_Suspect (Crime_Event_Suspect_ID, Suspect_ID, Crime_Event_ID, Date_Suspect_Req, Interrogation_Status) VALUES
('CES003', 'S003', 'CE003', '03/20/2023', 'Pending');

INSERT INTO Crime_Event_Suspect (Crime_Event_Suspect_ID, Suspect_ID, Crime_Event_ID, Date_Suspect_Req, Interrogation_Status) VALUES
('CES004', 'S004', 'CE004', '04/05/2023', 'Completed');

INSERT INTO Crime_Event_Suspect (Crime_Event_Suspect_ID, Suspect_ID, Crime_Event_ID, Date_Suspect_Req, Interrogation_Status) VALUES
('CES005', 'S005', 'CE005', '05/10/2023', 'Pending');

INSERT INTO Crime_Event_Suspect (Crime_Event_Suspect_ID, Suspect_ID, Crime_Event_ID, Date_Suspect_Req, Interrogation_Status) VALUES
('CES006', 'S001', 'CE001', '01/12/2023', 'Pending');

INSERT INTO Crime_Event_Suspect (Crime_Event_Suspect_ID, Suspect_ID, Crime_Event_ID, Date_Suspect_Req, Interrogation_Status) VALUES
('CES007', 'S002', 'CE002', '01/10/2023', 'Pending');

INSERT INTO Crime_Event_Suspect (Crime_Event_Suspect_ID, Suspect_ID, Crime_Event_ID, Date_Suspect_Req, Interrogation_Status) VALUES
('CES008', 'S003', 'CE005', '01/10/2023', 'Pending');



--INSERT INTO Crime_event_witness
INSERT INTO Crime_Event_Witness (Crime_Event_Witness_ID, Witness_ID, Crime_Event_ID, Date_Witness_Req, Interview_Location, Response_to_Subpoena) VALUES
('CEW001', 'W001', 'CE001', '01/12/2023', 'Police Station', 'Y');

INSERT INTO Crime_Event_Witness (Crime_Event_Witness_ID, Witness_ID, Crime_Event_ID, Date_Witness_Req, Interview_Location, Response_to_Subpoena) VALUES
('CEW002', 'W002', 'CE002', '02/18/2023', 'Courtroom', 'N');

INSERT INTO Crime_Event_Witness (Crime_Event_Witness_ID, Witness_ID, Crime_Event_ID, Date_Witness_Req, Interview_Location, Response_to_Subpoena) VALUES
('CEW003', 'W003', 'CE003', '03/22/2023', 'Police Station', 'Y');

INSERT INTO Crime_Event_Witness (Crime_Event_Witness_ID, Witness_ID, Crime_Event_ID, Date_Witness_Req, Interview_Location, Response_to_Subpoena) VALUES
('CEW004', 'W004', 'CE004', '04/08/2023', 'Interview Room', 'N');

INSERT INTO Crime_Event_Witness (Crime_Event_Witness_ID, Witness_ID, Crime_Event_ID, Date_Witness_Req, Interview_Location, Response_to_Subpoena) VALUES
('CEW005', 'W005', 'CE005', '05/13/2023', 'Witness House', 'Y');


--INSERT INTO Crime_event_Victim
INSERT INTO Crime_Event_Victim (Crime_Event_Victim_ID, Victim_ID, Crime_Event_ID, Date_Victimised, Compensation_Eligibility, Immediate_Assistance_Provided) VALUES
('CEV001', 'V001', 'CE001', '01/05/2023', 'Eligible for full compensation', 'Medical assistance provided');

INSERT INTO Crime_Event_Victim (Crime_Event_Victim_ID, Victim_ID, Crime_Event_ID, Date_Victimised, Compensation_Eligibility, Immediate_Assistance_Provided) VALUES
('CEV002', 'V002', 'CE002', '02/10/2023', 'Eligible for partial compensation', 'Counseling offered');

INSERT INTO Crime_Event_Victim (Crime_Event_Victim_ID, Victim_ID, Crime_Event_ID, Date_Victimised, Compensation_Eligibility, Immediate_Assistance_Provided) VALUES
('CEV003', 'V003', 'CE003', '03/15/2023', 'Eligible for full compensation', 'Emergency medical care provided');

INSERT INTO Crime_Event_Victim (Crime_Event_Victim_ID, Victim_ID, Crime_Event_ID, Date_Victimised, Compensation_Eligibility, Immediate_Assistance_Provided) VALUES
('CEV004', 'V004', 'CE004', '04/01/2023', 'Not eligible', 'No immediate assistance required');

INSERT INTO Crime_Event_Victim (Crime_Event_Victim_ID, Victim_ID, Crime_Event_ID, Date_Victimised, Compensation_Eligibility, Immediate_Assistance_Provided) VALUES
('CEV005', 'V005', 'CE005', '05/20/2023', 'Eligible for partial compensation', 'Assistance from local authorities');