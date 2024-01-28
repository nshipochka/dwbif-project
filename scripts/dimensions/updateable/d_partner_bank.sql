CREATE TABLE d_partner_bank
(
    pb_id   SERIAL NOT NULL,
    pb_code char(2) UNIQUE
);

ALTER TABLE d_partner_bank
    ADD PRIMARY KEY (pb_id);

