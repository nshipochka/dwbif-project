CREATE TABLE f_transaction(
    transaction_id INT NOT NULL,
    account_id INT, -- FK
    account_district INT, -- FK
    amount INT,
    balance INT,
    date DATE, -- FK
    trans_type INT, -- FK
    trans_mode INT, -- FK
    payment_type INT, -- FK
    bank_to INT, -- FK
    account_to INT
);

ALTER TABLE f_transaction ADD PRIMARY KEY (transaction_id);