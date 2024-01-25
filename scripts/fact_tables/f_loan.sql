CREATE TABLE f_loan(
    loan_id INT NOT NULL,
    account_id INT, -- FK
    account_district INT, -- FK
    begin_date DATE, -- FK
    end_date DATE, -- FK
    duration INT,
    payments INT,
    status INT -- FK
);

ALTER TABLE f_loan ADD PRIMARY KEY (loan_id);

ALTER TABLE f_loan
    ADD CONSTRAINT FK_L_ACCOUNT
        FOREIGN KEY (account_id) REFERENCES d_account(account_id),
    ADD CONSTRAINT FK_L_DISTRICT
        FOREIGN KEY (account_district) REFERENCES d_demographic(district_id),
    ADD CONSTRAINT FK_L_BEGIN_DATE
        FOREIGN KEY (begin_date) REFERENCES d_date(date),
    ADD CONSTRAINT FK_L_END_DATE
        FOREIGN KEY (end_date) REFERENCES d_date(date),
    ADD CONSTRAINT FK_L_STATUS
        FOREIGN KEY (status) REFERENCES d_loan_status(l_status_id);