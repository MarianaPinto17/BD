
--CREATE SCHEMA FLIGHTS;
--GO

--DROP SCHEMA FLIGHTS;
--GO

CREATE TABLE FLIGHTS.airport(
		Nome						VARCHAR(50) NOT NULL,
		City						VARCHAR(50) NOT NULL,
		Statee						VARCHAR(50) NOT NULL,
		Airport_code				INT NOT NULL CHECK(Airport_code >= 0)
		PRIMARY KEY (Airport_code)
);

CREATE TABLE FLIGHTS.airplane_type(
		Company						VARCHAR(50) NOT NULL,
		Typename					VARCHAR(50) PRIMARY KEY NOT NULL,
		Max_seats					INT NOT NULL CHECK(Max_seats > 0)
);

CREATE TABLE FLIGHTS.can_land(
		Typename					VARCHAR(50) NOT NULL,
		Airport_code				INT REFERENCES FLIGHTS.airport(Airport_code) NOT NULL,
		FOREIGN KEY (Typename) REFERENCES FLIGHTS.airplane_type(Typename),
		PRIMARY KEY(Airport_code,Typename)
);

CREATE TABLE FLIGHTS.airplane(
		Airplane_id					INT NOT NULL CHECK(Airplane_id >= 0),
		Total_no_seats				INT NOT NULL CHECK(Total_no_seats > 0),
		Typename					VARCHAR(50) NOT NULL,
		FOREIGN KEY (Typename) REFERENCES FLIGHTS.airplane_type(Typename),
		PRIMARY KEY(Airplane_id,Typename)
);

CREATE TABLE FLIGHTS.flight(
		Number						INT PRIMARY KEY NOT NULL CHECK(Number >= 0),
		Airline						VARCHAR(50) NOT NULL,
		Weekdays					VARCHAR(50) NOT NULL
);

CREATE TABLE FLIGHTS.fare(
		Code						INT NOT NULL CHECK(Code>=0),
		Amount						INT NOT NULL,
		Restrictions				VARCHAR(1000),
		Number						INT NOT NULL,
		FOREIGN KEY (Number) REFERENCES FLIGHTS.flight(Number),
		PRIMARY KEY(Code,Number)
);
CREATE TABLE FLIGHTS.flights_legs(
		Leg_no						INT NOT NULL,
		Number						INT REFERENCES FLIGHTS.flight(Number) NOT NULL,
		Airport_code				INT NOT NULL,
		Schedule_Time_arr			TIME,
		Schedule_Time_dep			TIME,
		FOREIGN KEY (Airport_codE) REFERENCES FLIGHTS.airport(Airport_code),
		PRIMARY KEY(Leg_no,Number)
);

CREATE TABLE FLIGHTS.leg_instance(
		Datee						DATE NOT NULL,
		No_of_avail_seats			INT NOT NULL CHECK(No_of_avail_seats>=0),
		Airplane_id					INT NOT NULL,
		Airport_code				INT NOT NULL,
		Leg_no						INT NOT NULL,
		Number						INT NOT NULL,
		Dep_Time					TIME,
		ARR_TIME					TIME,
		Typename					VARCHAR(50) NOT NULL,
		FOREIGN KEY (Airport_code) REFERENCES FLIGHTS.airport(Airport_code),
		FOREIGN KEY (Airplane_id,Typename) REFERENCES FLIGHTS.airplane(Airplane_id,Typename),
		FOREIGN KEY (Leg_no,Number) REFERENCES FLIGHTS.flights_legs(Leg_no,Number),
		PRIMARY KEY(Datee, Airplane_id, Leg_no, Airport_code)
);

CREATE TABLE FLIGHTS.seat(
		Seat_no						INT CHECK(Seat_no >=0) NOT NULL,
		Airplane_id					INT NOT NULL,
		Datee						DATE NOT NULL,
		Customer_name				VARCHAR(50) NOT NULL,
		Cphone						INT NOT NULL,
		Typename					VARCHAR(50) NOT NULL,
		Airport_code				INT NOT NULL,
		Leg_no						INT NOT NULL,
		FOREIGN KEY (Airplane_id,Typename) REFERENCES FLIGHTS.airplane(Airplane_id,Typename),
		FOREIGN KEY (Datee, Airplane_id, Leg_no, Airport_code) REFERENCES FLIGHTS.leg_instance(Datee, Airplane_id, Leg_no, Airport_code),
		PRIMARY KEY (Seat_no,Airplane_id,Datee, Leg_no)
);