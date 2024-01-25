CREATE TABLE d_client
(
    client_id    INT NOT NULL,
    birth_number INT
);

ALTER TABLE d_client
    ADD PRIMARY KEY (client_id);

-- TO BE LOADED FROM STAGING