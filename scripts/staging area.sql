CREATE TABLE account (
    stage_at DATE DEFAULT CURRENT_DATE NOT NULL,
    account_id INT NOT NULL,
    district_id INT NOT NULL,
    frequency VARCHAR(30),
    date INT not null,
    converted_date VARCHAR(10) null
);

--NB! Add the name of your schema before function's name
UPDATE FN45798.account
SET converted_date = ConvertToDate(date);

ALTER TABLE account
DROP COLUMN date;

ALTER TABLE account
RENAME COLUMN converted_date TO date;

--==============================================================

--SELECT FN45798.ConvertToDate(930101) FROM SYSIBM.SYSDUMMY1;

--SELECT FN45798.getGender(401009) FROM SYSIBM.SYSDUMMY1;

--SELECT FN45798.CONVERTTOISODATEOFBIRTH(931010) FROM SYSIBM.SYSDUMMY1;

--==============================================================

drop function getGender();

CREATE TABLE client (
    stage_at DATE DEFAULT CURRENT_DATE NOT NULL,
    client_id INT NOT NULL,
    birth_number INT,
    district_id INT NOT NULL,
    gender CHARACTER null,
    birthday DATE null
);

--NB! Add the name of your scheme before function's name
UPDATE FN45798.CLIENT
SET birthday = FN45798.ConvertToISODateOfBirth(BIRTH_NUMBER);

--NB! Add the name of your scheme before function's name
UPDATE FN45798.CLIENT
SET gender = FN45798.GETGENDER(BIRTH_NUMBER);

ALTER TABLE client
DROP COLUMN birth_number;

--==============================================================

--==============================================================

CREATE TABLE disposition (
    stage_at DATE DEFAULT CURRENT_DATE NOT NULL,
    disp_id INT NOT NULL,
    client_id INT NOT NULL,
    account_id INT NOT NULL,
    type VARCHAR(10)
);

--==============================================================

--==============================================================

CREATE TABLE permanent_order (
    stage_at DATE DEFAULT CURRENT_DATE NOT NULL,
    order_id INT NOT NULL,
    account_id INT NOT NULL,
    bank_to VARCHAR(2),
    account_to VARCHAR(2),
    amount DECIMAL,
    k_symbol VARCHAR(20)
);

--==============================================================

--==============================================================

CREATE TABLE transaction (
    stage_at DATE DEFAULT CURRENT_DATE NOT NULL,
    trans_id INT NOT NULL,
    account_id INT NOT NULL,
    date INT,
    type VARCHAR(10),
    operation VARCHAR(30),
    amount DECIMAL,
    balance DECIMAL,
    k_symbol VARCHAR(20),
    bank VARCHAR(2),
    account INT,
    converted_date DATE null
);


--NB! Add the name of your schema before function's name
UPDATE FN45798.TRANSACTION
SET converted_date = FN45798.ConvertToISODateOfBirth(date);

ALTER TABLE TRANSACTION
DROP COLUMN date;

--==============================================================

--==============================================================

CREATE TABLE loan(
    stage_at DATE DEFAULT CURRENT_DATE NOT NULL,
    load_id INT NOT NULL,
    account_id INT NOT NULL,
    date INT,
    amount DECIMAL,
    duration INT,
    payments DECIMAL,
    status VARCHAR(1),
    converted_date DATE null
);

--NB! Add the name of your schema before function's name
UPDATE FN45798.loan
SET converted_date = ConvertToISODateOfBirth(loan.date);

ALTER TABLE loan
DROP COLUMN date;

--==============================================================

--==============================================================
CREATE TABLE credit_card (
    stage_at DATE DEFAULT CURRENT_DATE NOT NULL,
    card_id INT NOT NULL,
    disp_id INT NOT NULL,
    type VARCHAR(10),
    issued VARCHAR(20),
    converted_issue TIMESTAMP null
);


--NB! Add the name of your schema before function's name
UPDATE FN45798.loan
SET converted_date = ConvertToISODateOfBirth(loan.date);

ALTER TABLE loan
DROP COLUMN date;

--==============================================================

--==============================================================

CREATE TABLE demographic_data (
    stage_at DATE DEFAULT CURRENT_DATE NOT NULL,
    district_id INT NOT NULL,
    district_name VARCHAR(50),
    region VARCHAR(50),
    inhabitants INT,
    muni_inhab_lt_499 INT,
    muni_inhab_500_1999 INT,
    muni_inhab_2000_9999 INT,
    muni_inhab_gt_10000 INT,
    cities INT,
    urban_population_ration FLOAT,
    avg_salary INT,
    unemploymant_95 FLOAT,
    unemploymant_96 INT,
    enterpreneurs INT,
    commited_crimes_95 INT,
    comited_criems_96 INT
);



Alter table account ADD PRIMARY KEY (stage_at, account_id);

Alter table client ADD PRIMARY KEY (stage_at, client_id);

Alter table disposition ADD PRIMARY KEY (stage_at, disp_id);

Alter table permanent_order ADD PRIMARY KEY (stage_at, order_id);

Alter table transaction ADD PRIMARY KEY (stage_at, trans_id);

Alter table loan ADD PRIMARY KEY (stage_at, load_id);

Alter table credit_card ADD PRIMARY KEY (stage_at, card_id);

Alter table demographic_data ADD PRIMARY KEY (stage_at, district_id);


-- Returns 'M' or 'W'
CREATE FUNCTION getGender(date INT)
RETURNS CHARACTER
BEGIN
    DECLARE month varchar(2);
    SET month = SUBSTR(date, 3,2);

    IF (month >= '51' AND month <= '62') THEN
        return 'W';
    END IF;

    return 'M';
end;


CREATE FUNCTION ConvertToISODateOfBirth(date INT)
RETURNS DATE
BEGIN
    DECLARE year VARCHAR(2);
    DECLARE month VARCHAR(2);
    DECLARE day VARCHAR(2);

    SET year = SUBSTR(date, 1, 2);
    SET month = SUBSTR(date, 3, 2);
    SET day = SUBSTR(date, 5, 2);

    IF (month >= '51' AND month <= '62') THEN
        SET month = (CAST(month AS INT) - 50);
    END IF;

    RETURN TO_DATE(CONCAT('19', CONCAT(year, CONCAT('-', CONCAT(month, CONCAT('-', day))))), 'YYYY-MM-DD');
END;


CREATE FUNCTION ConvertToDate(date INT)
returns DATE

BEGIN
    DECLARE year varchar(2);
    DECLARE month varchar(2);
    DECLARE day varchar(2);

    SET year = SUBSTR(date, 1, 2);
    SET month = SUBSTR(date, 3, 2);
    SET day = SUBSTR(date, 5, 2);
    RETURN TO_DATE(CONCAT('19' ,(CONCAT (year ,(CONCAT ('-' ,(CONCAT (month ,(CONCAT('-', day))))))))), 'yyyy-mm-dd');
end;

CREATE FUNCTION getTimeStamp(date varchar(20))
RETURNS varchar(20)
BEGIN
    DECLARE result TIMESTAMP;
    SET result = TO_TIMESTAMP(date, 'YYYY-MM-DD HH24:MI:SS');

    RETURN VARCHAR_FORMAT(result, 'YYYY-MM-DD HH24:MI:SS');
END;

