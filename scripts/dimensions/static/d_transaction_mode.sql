CREATE TABLE d_transaction_mode
(
    t_mode_id SERIAL NOT NULL,
    t_mode    VARCHAR(45)
);

ALTER TABLE d_transaction_mode
    ADD PRIMARY KEY (t_mode_id);

INSERT INTO d_transaction_mode(t_mode)
VALUES ('VYBER KARTOU'),
       ('VKLAD'),
       ('PREVOD Z UCTU'),
       ('VYBER'),
       ('PREVOD NA UCET');
