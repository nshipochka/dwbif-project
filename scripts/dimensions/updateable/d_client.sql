CREATE TABLE d_client
(
    client_id  INT NOT NULL,
    birth_date INT,
    gender     CHAR,
    staged_at  DATE
);

ALTER TABLE d_client
    ADD PRIMARY KEY (client_id);

