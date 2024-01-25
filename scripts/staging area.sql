CREATE TABLE account (
    stage_at DATE DEFAULT CURRENT_DATE,
    account_id INT NOT NULL,
    district_id INT NOT NULL,
    frequency VARCHAR(30),
    date INT
);


CREATE TABLE client (
    stage_at DATE DEFAULT CURRENT_DATE,
    client_id INT NOT NULL,
    birth_number INT,
    district_id INT NOT NULL
);

CREATE TABLE disposition (
    stage_at DATE DEFAULT CURRENT_DATE,
    disp_id INT NOT NULL,
    client_id INT NOT NULL,
    account_id INT NOT NULL,
    type VARCHAR(10)
);

CREATE TABLE permanent_order (
    stage_at DATE DEFAULT CURRENT_DATE,
    order_id INT NOT NULL,
    account_id INT NOT NULL,
    bank_to VARCHAR(2),
    account_to VARCHAR(2),
    amount DECIMAL,
    k_symbol VARCHAR(20)
);

CREATE TABLE transaction (
    stage_at DATE DEFAULT CURRENT_DATE,
    trans_id INT NOT NULL,
    account_id INT NOT NULL,
    date INT,
    type VARCHAR(10),
    operation VARCHAR(30),
    amount DECIMAL,
    balance DECIMAL,
    k_symbol VARCHAR(20),
    bank VARCHAR(2),
    account INT
);

CREATE TABLE loan(
    stage_at DATE DEFAULT CURRENT_DATE,
    load_id INT NOT NULL,
    account_id INT NOT NULL,
    date INT,
    amount DECIMAL,
    duration INT,
    payments DECIMAL,
    status VARCHAR(1)
);


CREATE TABLE credit_card (
    stage_at DATE DEFAULT CURRENT_DATE,
    card_id INT NOT NULL,
    disp_id INT NOT NULL,
    type VARCHAR(10),
    issued VARCHAR(20)
);

CREATE TABLE demographic_data (
    stage_at DATE DEFAULT CURRENT_DATE,
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



