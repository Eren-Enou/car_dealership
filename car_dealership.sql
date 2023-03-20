CREATE TABLE "invoice" (
	"invoice_id" SERIAL PRIMARY KEY,
	"amount" NUMERIC(9,2),
	"date" DATE,
	"sales_id" INTEGER,
	"service_id" INTEGER,
	"customer_id" INTEGER,
	FOREIGN KEY ("sales_id") REFERENCES "sales"("sales_id"),
	FOREIGN KEY ("service_id") REFERENCES "service"("service_id"),
	FOREIGN KEY ("customer_id") REFERENCES "customer"("customer_id")
);

CREATE TABLE "sales" (
	"sales_id" SERIAL PRIMARY KEY,
	"amount" NUMERIC(9,2),
	"date" DATE,
	"car_id" INTEGER,
	"salesperson_id" INTEGER,
	FOREIGN KEY ("car_id") REFERENCES "car"("car_id"),
	FOREIGN KEY ("salesperson_id") REFERENCES "salesperson"("salesperson_id")
);

CREATE TABLE "service" (
	"service_id" SERIAL PRIMARY KEY,
	"amount" NUMERIC(9,2),
	"date" DATE,
	"service_description" VARCHAR(100),
	"car_id" INTEGER,
	"mechanic_id" INTEGER,
	FOREIGN KEY ("car_id") REFERENCES "car"("car_id"),
	FOREIGN KEY ("mechanic_id") REFERENCES "mechanic"("mechanic_id")
);

CREATE TABLE "customer" (
	"customer_id" SERIAL PRIMARY KEY,
	"first_name" VARCHAR(50),
	"last_name" VARCHAR(50),
	"address" VARCHAR(100),
	"email" VARCHAR(100)
);

CREATE TABLE "car" (
	"car_id" SERIAL PRIMARY KEY,
	"make" VARCHAR(50),
	"model" VARCHAR(50),
	"year" INTEGER,
	"customer_id" INTEGER,
	FOREIGN KEY ("customer_id") REFERENCES "customer"("customer_id")
);

CREATE TABLE "salesperson" (
	"salesperson_id" SERIAL PRIMARY KEY,
	"first_name" VARCHAR(50),
	"last_name" VARCHAR(50)
);

CREATE TABLE "mechanic" (
	"mechanic_id" SERIAL PRIMARY KEY,
	"first_name" VARCHAR(50),
	"last_name" VARCHAR(50)
);

--FUNCTIONS

CREATE FUNCTION add_customer (
	"first_name" VARCHAR(50),
	"last_name" VARCHAR(50),
	"address" VARCHAR(100),
	"email" VARCHAR(100)
)
RETURNS VOID
LANGUAGE plpgsql
AS
$$
BEGIN
	INSERT INTO customer(first_name, last_name, address, email)
	VALUES(first_name, last_name, address, email);
END;
$$;

CREATE FUNCTION add_car(
	"customer_id" INTEGER,
	"make" VARCHAR(50),
	"model" VARCHAR(50),
	"year" INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
AS
$$
BEGIN
	INSERT INTO car(customer_id, make, model, "year")
	VALUES(customer_id, make, model, "year");
END;
$$;

CREATE FUNCTION add_salesperson (
	"first_name" VARCHAR(50),
	"last_name" VARCHAR(50)
)
RETURNS VOID
LANGUAGE plpgsql
AS
$$
BEGIN
	INSERT INTO salesperson(first_name, last_name)
	VALUES(first_name, last_name);
END;
$$;

CREATE FUNCTION add_sale(
	"amount" NUMERIC(9,2),
	"date" DATE,
	"salesperson_id" INTEGER,
	"car_id" INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
AS
$$
BEGIN
	INSERT INTO sales(amount, "date", salesperson_id, car_id)
	VALUES(amount, "date", salesperson_id, car_id);
END;
$$;

CREATE FUNCTION add_mechanic (
	"first_name" VARCHAR(50),
	"last_name" VARCHAR(50)
)
RETURNS VOID
LANGUAGE plpgsql
AS
$$
BEGIN
	INSERT INTO mechanic(first_name, last_name)
	VALUES(first_name, last_name);
END;
$$;

CREATE FUNCTION add_service(
	"amount" NUMERIC(9,2),
	"date" DATE,
	"service_description" VARCHAR(100),
	"car_id" INTEGER,
	"mechanic_id" INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
AS
$$
BEGIN
	INSERT INTO service(amount, "date", service_description, car_id, mechanic_id)
	VALUES(amount, "date", service_description, car_id, mechanic_id);
END;
$$;

CREATE FUNCTION add_invoice(
	"amount" NUMERIC(9,2),
	"date" DATE,
	"sales_id" INTEGER,
	"service_id" INTEGER,
	"customer_id" INTEGER
)
RETURNS VOID 
LANGUAGE plpgsql
AS
$$
BEGIN
	INSERT INTO invoice(amount, "date", sales_id, service_id, customer_id)
	VALUES(amount, "date", sales_id, service_id, customer_id);
END;
$$;

SELECT *
FROM service  ;

SELECT add_customer('Eren','Enou','123 Real St','erenenou@email.com');
SELECT add_customer('Aaron','Molnar','123 Fake St','aaronmolnar@email.com');

SELECT add_car(1, 'Toyota', 'Corolla', 2015);
SELECT add_car(2, 'Honda', 'Civic', 2012);

SELECT add_salesperson('Daniel','Craig');
SELECT add_salesperson('Laura','Gomez');

SELECT add_mechanic('Emilia', 'Green');
SELECT add_mechanic('Pedro', 'Pascal');

SELECT add_service(300.00, CURRENT_DATE, 'Replaced battery',1,1);
SELECT add_service(1000.00, CURRENT_DATE, 'Replaced catalytic converter',2,2);

SELECT add_sale(25000, CURRENT_DATE, 1, 1);
SELECT add_sale(27500, CURRENT_DATE, 2, 2);

SELECT add_invoice(25000, CURRENT_DATE, 1, 1, 1);
SELECT add_invoice(27500, CURRENT_DATE, 2,2,2);