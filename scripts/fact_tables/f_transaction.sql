CREATE TABLE f_transaction
(
    transaction_id   INT NOT NULL,
    account_id       INT,  -- FK
    account_district INT,  -- FK
    amount           INT,
    balance          INT,
    date             DATE, -- FK
    trans_type       INT,  -- FK
    trans_mode       INT,  -- FK
    payment_type     INT,  -- FK
    bank_to          INT,  -- FK
    account_to       INT
);

ALTER TABLE f_transaction
    ADD PRIMARY KEY (transaction_id);

ALTER TABLE f_transaction
    ADD CONSTRAINT FK_T_ACCOUNT
        FOREIGN KEY (account_id) REFERENCES d_account (account_id),
    ADD CONSTRAINT FK_T_DISTRICT
        FOREIGN KEY (account_district) REFERENCES d_demographic (district_id),
    ADD CONSTRAINT FK_T_DATE
        FOREIGN KEY (date) REFERENCES d_date (date),
    ADD CONSTRAINT FK_T_TRANS_TYPE
        FOREIGN KEY (trans_type) REFERENCES d_transaction_type (t_type_id),
    ADD CONSTRAINT FK_T_TRANS_MODE
        FOREIGN KEY (trans_mode) REFERENCES d_transaction_mode (t_mode_id),
    ADD CONSTRAINT FK_T_PAYMENT_TYPE
        FOREIGN KEY (payment_type) REFERENCES d_payment_type (p_type_id),
    ADD CONSTRAINT FK_T_BANK_TO
        FOREIGN KEY (bank_to) REFERENCES d_partner_bank (pb_id);

-- Constraint: Payment type only urok, sipo, sankc. urok, duchod, uver, sluzby, pojistne

INSERT INTO f_transaction
(transaction_id,
 account_id,
 account_district,
 amount,
 balance,
 date,
 trans_type,
 trans_mode,
 payment_type,
 bank_to,
 account_to)
SELECT staged_transaction.trans_id,
       staged_transaction.account,
       staged_acc.district_id,
       staged_transaction.amount,
       staged_transaction.balance,
       staged_transaction.date,
       d_transaction_type.t_type_id,
       d_transaction_mode.t_mode_id,
       d_payment_type.p_type_id,
       d_partner_bank.pb_id,
       staged_transaction.account
FROM dw.staging_area.transaction AS staged_transaction
         NATURAL JOIN dw.staging_area.account AS staged_acc
         NATURAL JOIN d_account
         NATURAL JOIN d_demographic
         NATURAL JOIN d_date AS b_date
         NATURAL JOIN d_transaction_type
         NATURAL JOIN d_transaction_mode
         NATURAL JOIN d_payment_type
         NATURAL JOIN d_partner_bank
WHERE (staged_transaction.account_id = staged_acc.account_id,
       staged_transaction.account_id = d_account.account_id,
       staged_acc.district_id = d_demographic.district_id,
       staged_transaction.date = b_date.date,
       staged_transaction.type = d_transaction_type.t_type,
       staged_transaction.operation = d_transaction_mode.t_mode,
       staged_transaction.k_symbol = d_payment_type.p_type,
       staged_transaction.bank = d_partner_bank.pb_code);
