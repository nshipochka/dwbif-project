-- Card Type Dimension
CREATE TABLE d_card_type
(
    c_type_id SERIAL NOT NULL, -- self generating
    c_type    VARCHAR(15)
);

ALTER TABLE d_card_type
    ADD PRIMARY KEY (c_type_id);

INSERT INTO d_card_type(c_type)
VALUES ('junior'),
       ('classic'),
       ('gold');

-- Date Dimension
CREATE TABLE d_date
(
    date         DATE,
    year         INT,
    month        INT,
    monthname    VARCHAR(15),
    day          INT,
    weekdayname  VARCHAR(15),
    calendarweek INT,
    quartal      CHAR(2),
    weekend      VARCHAR(15),
    czechholiday VARCHAR(15)
);

ALTER TABLE d_date
    ADD PRIMARY KEY (date);

INSERT INTO d_date(date, year, month, monthname, day, weekdayname, calendarweek, quartal, weekend, czechholiday)
SELECT datum as Date,
       extract(year from datum)                                                         AS Year,
       extract(month from datum)                                                        AS Month,
       -- Localized month name
       to_char(datum, 'TMMonth')                                                        AS MonthName,
       extract(day from datum)                                                          AS Day,
       -- Localized weekday
       to_char(datum, 'TMDay')                                                          AS WeekdayName,
       -- ISO calendar week
       extract(week from datum)                                                         AS CalendarWeek,
       'Q' || to_char(datum, 'Q')                                                       AS Quartal,
       -- Weekend
       CASE WHEN extract(isodow from datum) in (6, 7) THEN 'Weekend' ELSE 'Weekday'
END AS Weekend,
       -- Fixed holidays
       -- for America
       CASE
           WHEN to_char(datum, 'MMDD') IN ('0101', '0329', '0401', '0501', '0508', '0705', '0706', '0928',
                                           '1028', '1117', '1224', '1225', '1226', '1231')
               THEN 'Holiday'
           ELSE 'No holiday'
END
                                                                                        AS CzechHoliday
FROM (
         -- There are 3 leap years in this range, so calculate 365 * 10 + 3 records
         SELECT '1992-01-01'::DATE + sequence.day AS datum
         FROM generate_series(0, 1826) AS sequence(day)
         GROUP BY sequence.day) DQ
order by 1;

-- Disposition Type Dimension
CREATE TABLE d_disp_type
(
    d_type_id SERIAL NOT NULL,
    d_type    CHAR(10)
);

ALTER TABLE d_disp_type
    ADD PRIMARY KEY (d_type_id);

INSERT INTO d_disp_type(d_type)
VALUES ('OWNER'),
       ('DISPONENT');

-- Loan Status Dimension
CREATE TABLE d_loan_status
(
    l_status_id      SERIAL NOT NULL,
    l_status         CHAR(1),
    l_status_meaning VARCHAR(200)
);

ALTER TABLE d_loan_status
    ADD PRIMARY KEY (l_status_id);

INSERT INTO d_loan_status(l_status, l_status_meaning)
VALUES ('A', 'Contract finished, no problems'),
       ('B', 'Contract finished, loan not paid'),
       ('C', 'Running contract, OK so far'),
       ('D', 'Running contract, client in debt');

-- Payment Type Dimension
CREATE TABLE d_payment_type
(
    p_type_id      SERIAL NOT NULL,
    p_type         VARCHAR(45),
    p_type_meaning VARCHAR(200)
);

ALTER TABLE d_payment_type
    ADD PRIMARY KEY (p_type_id);

INSERT INTO d_payment_type(p_type, p_type_meaning)
VALUES ('POJISTNE', 'Insurance payment'),
       ('SLUZBY', 'Payment for statement'),
       ('UROK', 'Interest credited'),
       ('SANKC. UROK', 'Sanction interest if negative balance'),
       ('SIPO', 'Household payment'),
       ('DUCHOD', 'Old-age pension'),
       ('UVER', 'Loan payment'),
       ('LEASING', 'Leasing');

-- Transaction Mode Dimension
CREATE TABLE d_transaction_mode
(
    t_mode_id SERIAL NOT NULL,
    t_mode    VARCHAR(45)
);

ALTER TABLE d_transaction_mode
    ADD PRIMARY KEY (t_mode_id);

INSERT INTO d_transaction_mode(t_mode)
VALUES ('VYBER KARTOU'),
       ('VKLAD'),
       ('PREVOD Z UCTU'),
       ('VYBER'),
       ('PREVOD NA UCET');

-- Transaction Type Dimension
CREATE TABLE d_transaction_type
(
    t_type_id SERIAL NOT NULL,
    t_type    VARCHAR(15)
);

ALTER TABLE d_transaction_type
    ADD PRIMARY KEY (t_type_id);

INSERT INTO d_transaction_type(t_type)
VALUES ('PRIJEM'),
       ('VYDAJ');



