CREATE TABLE d_transaction_type
(
    t_type_id SERIAL NOT NULL,
    t_type    VARCHAR(15)
);

ALTER TABLE d_transaction_type
    ADD PRIMARY KEY (t_type_id);

INSERT INTO d_transaction_type(t_type)
VALUES ('PRIJEM'),
       ('VYDAJ');
