CREATE TABLE account (
    account_id INT PRIMARY KEY NOT NULL,
    district_id INT NOT NULL,
    frequency VARCHAR(30),
    date INT
);

CREATE TABLE client (
    client_id INT PRIMARY KEY NOT NULL,
    birth_number INT,
    district_id INT NOT NULL
);

CREATE TABLE disposition (
    disp_id INT PRIMARY KEY NOT NULL,
    client_id INT NOT NULL,
    account_id INT NOT NULL,
    type VARCHAR(10)
);

CREATE TABLE permanent_order (
    order_id INT PRIMARY KEY NOT NULL,
    account_id INT NOT NULL,
    bank_to VARCHAR(2),
    account_to VARCHAR(2),
    amount DECIMAL,
    k_symbol VARCHAR(20)
);

CREATE TABLE transaction (
    trans_id INT PRIMARY KEY NOT NULL,
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
    loan_id INT PRIMARY KEY NOT NULL,
    account_id INT NOT NULL,
    date INT,
    amount DECIMAL,
    duration INT,
    payments DECIMAL,
    status VARCHAR(1)
);

CREATE TABLE credit_card (
    card_id INT PRIMARY KEY NOT NULL,
    disp_id INT NOT NULL,
    type VARCHAR(10),
    issued VARCHAR(20)
);

CREATE TABLE demographic_data (
    district_id INT PRIMARY KEY NOT NULL,
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

ALTER TABLE account ADD CONSTRAINT FK_DEMOGRAPHIC_DATA_ACCOUNT FOREIGN KEY (district_id) REFERENCES demographic_data(district_id);

ALTER TABLE client ADD CONSTRAINT FK_DEMOGRAPHIC_DATA_CLIENT FOREIGN KEY (district_id) REFERENCES demographic_data(district_id);

ALTER TABLE disposition ADD CONSTRAINT FK_DISPOSITION_CLIENT FOREIGN KEY (client_id) REFERENCES client(client_id);

ALTER TABLE disposition ADD CONSTRAINT FK_DISPOSITION_ACCOUNT FOREIGN KEY (account_id) REFERENCES account(account_id);

ALTER TABLE permanent_order ADD CONSTRAINT FK_PERMANENT_ORDER_ACCOUNT FOREIGN KEY (account_id) references account(account_id);

ALTER TABLE transaction ADD CONSTRAINT FK_TRANSACTION_ACCOUNT FOREIGN KEY (account_id) references account(account_id);

ALTER TABLE loan ADD CONSTRAINT FK_LOAN_ACCOUNT FOREIGN KEY (account_id) references account(account_id) ON DELETE CASCADE;

ALTER TABLE credit_card ADD CONSTRAINT FK_CREDIT_CARD_DISPOSITION FOREIGN KEY (disp_id) references disposition(disp_id);

