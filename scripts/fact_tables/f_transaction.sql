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

ALTER TABLE f_transaction
    ADD CONSTRAINT FK_T_ACCOUNT
        FOREIGN KEY (account_id) REFERENCES d_account(account_id),
    ADD CONSTRAINT FK_T_DISTRICT
        FOREIGN KEY (account_district) REFERENCES d_demographic(district_id),
    ADD CONSTRAINT FK_T_DATE
        FOREIGN KEY (date) REFERENCES d_date(date),
    ADD CONSTRAINT FK_T_TRANS_TYPE
        FOREIGN KEY (trans_type) REFERENCES d_transaction_type(t_type_id),
    ADD CONSTRAINT FK_T_TRANS_MODE
        FOREIGN KEY (trans_mode) REFERENCES d_transaction_mode(t_mode_id),
    ADD CONSTRAINT FK_T_PAYMENT_TYPE
        FOREIGN KEY (payment_type) REFERENCES d_payment_type(p_type_id),
    ADD CONSTRAINT FK_T_BANK_TO
        FOREIGN KEY (bank_to) REFERENCES d_partner_bank(pb_id);
