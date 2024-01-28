-- Credit Cards
CREATE TABLE f_card
(
    card_id          INT NOT NULL,
    account_id       INT, -- FK
    client_id        INT, -- FK
    card_type        INT, -- FK
    client_district  INT, -- FK
    account_district INT, -- FK
    disp_type        INT  -- FK
);

ALTER TABLE f_card
    ADD PRIMARY KEY (card_id);

ALTER TABLE f_card
    ADD CONSTRAINT FK_C_ACCOUNT
        FOREIGN KEY (account_id) REFERENCES d_account (account_id),
    ADD CONSTRAINT FK_C_ACC_DISTRICT
        FOREIGN KEY (account_district) REFERENCES d_demographic (district_id),
    ADD CONSTRAINT FK_C_CLIENT
        FOREIGN KEY (client_id) REFERENCES d_client (client_id),
    ADD CONSTRAINT FK_C_CLIENT_DISTRICT
        FOREIGN KEY (client_district) REFERENCES d_demographic (district_id),
    ADD CONSTRAINT FK_C_CARD_TYPE
        FOREIGN KEY (card_type) REFERENCES d_card_type (c_type_id),
    ADD CONSTRAINT FK_C_DISP_TYPE
        FOREIGN KEY (disp_type) REFERENCES d_disp_type (d_type_id);

-- Loans
CREATE TABLE f_loan
(
    loan_id          INT NOT NULL,
    account_id       INT,  -- FK
    account_district INT,  -- FK
    amount           INT,
    begin_date       DATE, -- FK
    duration         INT,
    payments         INT,
    status           INT   -- FK
);

ALTER TABLE f_loan
    ADD PRIMARY KEY (loan_id);

ALTER TABLE f_loan
    ADD CONSTRAINT FK_L_ACCOUNT
        FOREIGN KEY (account_id) REFERENCES d_account (account_id),
    ADD CONSTRAINT FK_L_DISTRICT
        FOREIGN KEY (account_district) REFERENCES d_demographic (district_id),
    ADD CONSTRAINT FK_L_BEGIN_DATE
        FOREIGN KEY (begin_date) REFERENCES d_date (date),
    ADD CONSTRAINT FK_L_STATUS
        FOREIGN KEY (status) REFERENCES d_loan_status (l_status_id);

-- Orders
CREATE TABLE f_order
(
    order_id         INT NOT NULL, -- Да се генерира само евентуално? To do: Read lecture notes.
    account_id       INT,          -- FK
    account_district INT,          -- FK
    amount           INT,
    payment_type     INT,          -- FK
    bank_to          INT,          -- FK
    account_to       VARCHAR(2)
);

ALTER TABLE f_order
    ADD PRIMARY KEY (order_id);

ALTER TABLE f_order
    ADD CONSTRAINT FK_O_ACCOUNT
        FOREIGN KEY (account_id) REFERENCES d_account (account_id),
    ADD CONSTRAINT FK_O_DISTRICT
        FOREIGN KEY (account_district) REFERENCES d_demographic (district_id),
    ADD CONSTRAINT FK_O_PAYMENT_TYPE
        FOREIGN KEY (payment_type) REFERENCES d_payment_type (p_type_id),
    ADD CONSTRAINT FK_O_BANK_TO
        FOREIGN KEY (bank_to) REFERENCES d_partner_bank (pb_id);

-- Add constraint: p_type only pojistne, sipo, leasing, uver
-- Transactions

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
