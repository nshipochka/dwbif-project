CREATE TABLE d_partner_bank
(
    pb_id   SERIAL NOT NULL,
    pb_code char(2)
);

ALTER TABLE d_partner_bank
    ADD PRIMARY KEY (pb_id);

-- Insert from transactions when encountered