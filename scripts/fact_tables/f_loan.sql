CREATE TABLE f_loan
(
    loan_id          INT NOT NULL,
    account_id       INT,  -- FK
    account_district INT,  -- FK
    amount           INT,
    begin_date       DATE, -- FK
    duration         INT,
    payments         INT,
    status           INT   -- FK
);

ALTER TABLE f_loan
    ADD PRIMARY KEY (loan_id);

ALTER TABLE f_loan
    ADD CONSTRAINT FK_L_ACCOUNT
        FOREIGN KEY (account_id) REFERENCES d_account (account_id),
    ADD CONSTRAINT FK_L_DISTRICT
        FOREIGN KEY (account_district) REFERENCES d_demographic (district_id),
    ADD CONSTRAINT FK_L_BEGIN_DATE
        FOREIGN KEY (begin_date) REFERENCES d_date (date),
    ADD CONSTRAINT FK_L_STATUS
        FOREIGN KEY (status) REFERENCES d_loan_status (l_status_id);

INSERT INTO f_loan
(loan_id,
 account_id,
 account_district,
 amount,
 begin_date,
 duration,
 payments,
 status)
SELECT staged_loan.loan_id,
       staged_loan.account_id,
       staged_acc.district_id,
       staged_loan.amount,
       staged_loan.date,
       staged_loan.duration,
       d_loan_status.l_status_id
FROM dw.staging_area.loan AS staged_loan
         NATURAL JOIN dw.staging_area.account AS staged_acc
         NATURAL JOIN d_account
         NATURAL JOIN d_demographic
         NATURAL JOIN d_date AS b_date
         NATURAL JOIN d_loan_status
WHERE (staged_loan.account_id = staged_acc.account_id,
       staged_loan.account_id = d_account.account_id,
       staged_acc.district_id = d_demographic.district_id,
       staged_loan.date = b_date.date,
       staged_loan.status = d_loan_status.l_status);
