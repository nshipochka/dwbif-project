CREATE TABLE d_partner_bank
(
    pb_id   SERIAL NOT NULL,
    pb_code char(2) UNIQUE
);

ALTER TABLE d_partner_bank
    ADD PRIMARY KEY (pb_id);

-- Insert from transactions when encountered

INSERT INTO d_partner_bank
(pb_code)
SELECT bank_to
FROM dw.staging_area.permanent_order
ON CONFLICT(pb_code) DO NOTHING;

INSERT INTO d_partner_bank
(pb_code)
SELECT bank
FROM dw.staging_area.transaction
ON CONFLICT(pb_code) DO NOTHING;