CREATE TABLE d_account
(
    account_id INT NOT NULL,
    frequency  VARCHAR(30),
    date       DATE,
    stage_at   DATE
);

ALTER TABLE d_account
    ADD PRIMARY KEY (account_id);

