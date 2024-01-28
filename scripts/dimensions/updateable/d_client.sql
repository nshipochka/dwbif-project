CREATE TABLE d_client
(
    client_id  INT NOT NULL,
    birth_date INT,
    gender     CHAR,
    staged_at  DATE
);

ALTER TABLE d_client
    ADD PRIMARY KEY (client_id);

-- TO BE LOADED FROM STAGING
INSERT INTO d_client
(client_id,
 birth_date,
 gender,
 staged_at)
SELECT client_id,
       birthday,
       gender,
       stage_at
FROM dw.staging_area.client
ON CONFLICT(client_id) DO NOTHING;