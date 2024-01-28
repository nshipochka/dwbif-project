CREATE TABLE d_card_type
(
    c_type_id SERIAL NOT NULL, -- self generating
    c_type    VARCHAR(15)
);

ALTER TABLE d_card_type
    ADD PRIMARY KEY (c_type_id);

INSERT INTO d_card_type(c_type)
VALUES ('junior'),
       ('classic'),
       ('gold');