CREATE TABLE f_order(
    order_id INT NOT NULL,
    account_id INT, -- FK
    account_district INT, -- FK
    amount INT,
    payment_type INT,
    bank_to INT, -- FK
    account_to INT
);

ALTER TABLE f_order ADD PRIMARY KEY (order_id);

ALTER TABLE f_order
    ADD CONSTRAINT FK_O_ACCOUNT
        FOREIGN KEY (account_id) REFERENCES d_account(account_id),
    ADD CONSTRAINT FK_O_DISTRICT
        FOREIGN KEY (account_district) REFERENCES d_demographic(district_id),
    ADD CONSTRAINT FK_O_BANK_TO
        FOREIGN KEY (bank_to) REFERENCES d_partner_bank(pb_id);