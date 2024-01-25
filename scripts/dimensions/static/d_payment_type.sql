CREATE TABLE d_payment_type
(
    p_type_id      SERIAL NOT NULL,
    p_type         VARCHAR(45),
    p_type_meaning VARCHAR(200)
);

ALTER TABLE d_payment_type
    ADD PRIMARY KEY (p_type_id);

INSERT INTO d_payment_type(p_type, p_type_meaning)
VALUES ('POJISTNE', 'Insurance payment'),
       ('SLUZBY', 'Payment for statement'),
       ('UROK', 'Interest credited'),
       ('SANKC. UROK', 'Sanction interest if negative balance'),
       ('SIPO', 'Household payment'),
       ('DUCHOD', 'Old-age pension'),
       ('UVER', 'Loan payment'),
       ('LEASING', 'Leasing');

