-- Account dimension
CREATE TABLE d_account
(
    account_id INT NOT NULL,
    frequency  VARCHAR(30),
    date       DATE,
    stage_at   DATE
);

ALTER TABLE d_account
    ADD PRIMARY KEY (account_id);

-- Client dimension
CREATE TABLE d_client
(
    client_id  INT NOT NULL,
    birth_date INT,
    gender     CHAR,
    staged_at  DATE
);

ALTER TABLE d_client
    ADD PRIMARY KEY (client_id);

-- Demographic data dimension
CREATE TABLE d_demographic
(
    district_id             INT NOT NULL,
    district_name           VARCHAR(50),
    region                  VARCHAR(50),
    inhabitants             INT,
    muni_inhab_lt_499       INT,
    muni_inhab_500_1999     INT,
    muni_inhab_2000_9999    INT,
    muni_inhab_gt_10000     INT,
    cities                  INT,
    urban_population_ration FLOAT,
    avg_salary              INT,
    unemploymant_95         FLOAT,
    unemploymant_96         INT,
    enterpreneurs           INT,
    commited_crimes_95      INT,
    comited_criems_96       INT
);

ALTER TABLE d_demographic
    ADD PRIMARY KEY (district_id);

-- Partner banks dimension
CREATE TABLE d_partner_bank
(
    pb_id   SERIAL NOT NULL,
    pb_code char(2) UNIQUE
);

ALTER TABLE d_partner_bank
    ADD PRIMARY KEY (pb_id);




