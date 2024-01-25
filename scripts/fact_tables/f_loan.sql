CREATE TABLE f_loan(
    loan_id INT NOT NULL,
    account_id INT,
    district_id INT,
    begin_date DATE,
    end_date DATE,
    duration INT,
    payments INT,
    status INT
);

ALTER TABLE f_loan ADD PRIMARY KEY (loan_id);