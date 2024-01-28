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





