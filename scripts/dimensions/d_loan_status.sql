CREATE TABLE d_loan_status(
    l_status_id SERIAL NOT NULL,
    l_status CHAR(1),
    l_status_meaning VARCHAR(200)
);

ALTER TABLE d_loan_status ADD PRIMARY KEY (l_status_id);

INSERT INTO d_loan_status(l_status, l_status_meaning)
VALUES
    ('A', 'Contract finished, no problems'),
    ('B', 'Contract finished, loan not paid'),
    ('C', 'Running contract, OK so far'),
    ('D', 'Running contract, client in debt');
