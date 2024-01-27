CREATE TABLE d_account
(
    account_id INT NOT NULL,
    frequency  VARCHAR(30),
    date       DATE,
    stage_at   DATE
);

ALTER TABLE d_account
    ADD PRIMARY KEY (account_id);

-- Insert from Staging
INSERT INTO d_account
(account_id,
 frequency,
 date,
 stage_at)
SELECT account_id,
       frequency,
       date,
       stage_at
FROM dw.staging_area.account_staging
ON CONFLICT(account_id) DO NOTHING;