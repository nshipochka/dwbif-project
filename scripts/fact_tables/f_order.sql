CREATE TABLE f_order
(
    order_id         INT NOT NULL, -- Да се генерира само евентуално? To do: Read lecture notes.
    account_id       INT,          -- FK
    account_district INT,          -- FK
    amount           INT,
    payment_type     INT,          -- FK
    bank_to          INT,          -- FK
    account_to       INT
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

INSERT INTO f_order
(order_id,
 account_id,
 account_district,
 amount,
 payment_type,
 bank_to,
 account_to)
SELECT staged_order.order_id,
       staged_order.account_id,
       staged_acc.district_id,
       staged_order.amount,
       d_payment_type.p_type_id,
       d_partner_bank.pb_id,
       staged_order.account_to
FROM postgres.public.permanent_order AS staged_order
         NATURAL JOIN postgres.public.account AS staged_acc
         NATURAL JOIN d_account
         NATURAL JOIN d_demographic
         NATURAL JOIN d_payment_type
         NATURAL JOIN d_partner_bank
WHERE (staged_order.account_id = staged_acc.account_id,
       staged_order.account_id = d_account.account_id,
       staged_acc.district_id = d_demographic.district_id,
       staged_order.k_symbol = d_payment_type.p_type,
       staged_order.bank_to = d_partner_bank.pb_code);



