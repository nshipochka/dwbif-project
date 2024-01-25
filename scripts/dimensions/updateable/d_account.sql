CREATE TABLE d_account (
    account_id INT NOT NULL,
    frequency VARCHAR(30),
    date DATE
);

ALTER TABLE d_account ADD PRIMARY KEY (account_id);

-- Insert from Staging