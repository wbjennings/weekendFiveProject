CREATE TABLE customers(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(50),
	phone VARCHAR(10)
);

CREATE TABLE sales_team(
	staff_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	title VARCHAR(50)
);

CREATE TABLE inventory(
	car_id SERIAL PRIMARY KEY,
	make VARCHAR(50),
	model VARCHAR(50),
	model_year INTEGER,
	price DECIMAL(8,2),
	sold BOOLEAN,
	vin UNIQUE
);


CREATE TABLE repairs(
	repair_id SERIAL PRIMARY KEY,
	oilchange BOOLEAN,
	recall BOOLEAN,
	service_cost DECIMAL(8,2),
	customer_id INTEGER,
	FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
 	car_id INTEGER,
 	FOREIGN KEY(car_id) REFERENCES inventory(car_id),
	vin UNIQUE
);

CREATE TABLE mechanics(
	mech_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	title VARCHAR(50)
);

CREATE TABLE car_sales(
	invoice_id SERIAL PRIMARY KEY,
	sale_price DECIMAL(8,2),
	staff_id INTEGER,
	FOREIGN KEY(staff_id) REFERENCES sales_team(staff_id),
	customer_id INTEGER,
	FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
	date_sold DATE,
	car_id INTEGER,
	FOREIGN KEY(car_id) REFERENCES inventory(car_id)
);

CREATE TABLE repairs_mechanics(
	dummy_id SERIAL PRIMARY KEY,
	repair_id INTEGER,
	FOREIGN KEY(repair_id) REFERENCES repairs(repair_id),
	mech_id INTEGER,
	FOREIGN KEY(mech_id) REFERENCES mechanics(mech_id)
);

--#################### INSERT ###################

INSERT INTO customers(
	first_name,
	last_name,
	email,
	phone
)VALUES(
	'Will',
	'Jennings',
	'will@mail.mail',
	'1233214321'
);

INSERT INTO mechanics(
	first_name,
	last_name,
	title
)VALUES(
	'Guy',
	'Person',
	'Mechanic'
);

INSERT INTO sales_team(
	first_name,
	last_name,
	title
)VALUES(
	'Richie',
	'Rich',
	'Salesman'
);

INSERT INTO car_sales(
	sale_price,
	staff_id,
	customer_id,
	date_sold,
	car_id
)VALUES(
	2500.20,
	1,
	1,
	'2023-05-05',
	1
);

INSERT INTO inventory(
	make,
	model,
	model_year,
	price,
	sold,
	vin
)VALUES(
	'Ford',
	'Mustang',
	2023,
	5500.50,
	FALSE,
	98568565231
);

INSERT INTO repairs(
	oilchange,
	recall,
	service_cost,
	customer_id,
	car_id,
	vin
)VALUES(
	TRUE,
	FALSE,
	101.75,
	1,
	1,
	98568565231
);

INSERT INTO repairs_mechanics(
	repair_id,
	mech_id
)VALUES(
	1,
	1
);

--################ FUNCTIONS and PROCEDURES ###############

--Procedure to add a customer to the DATABASE

CREATE OR REPLACE PROCEDURE add_customer(
	_first_name VARCHAR(50),
	_last_name VARCHAR(50),
	_email VARCHAR(50),
	_phone VARCHAR(10)
)
AS 
$$
	BEGIN
		INSERT INTO customers(
			first_name,
			last_name,
			email,
			phone
		) VALUES (
			_first_name,
			_last_name,
			_email,
			_phone
		);
		COMMIT;
	END;
$$
LANGUAGE plpgsql;

CALL add_customer('Insert', 'TestCustomer', 'testy@mail.mail', '1233214321');

SELECT * 
FROM customers 
WHERE first_name = 'Insert';



--## FUNCTION ##
--Function to update a customers email.

CREATE OR REPLACE function change_customer_email(
	_customer_id INTEGER,
	new_email VARCHAR(50)
)
RETURNS VARCHAR(50) AS 
$$
	BEGIN 
		UPDATE customers 
		SET email = new_email
		WHERE customer_id = _customer_id;
		RETURN new_email;
	END;
$$
LANGUAGE plpgsql;

SELECT change_customer_email(1, 'changedemail@mail.mail');

SELECT *
FROM customers 
WHERE email = 'changedemail@mail.mail';
	

	










