CREATE TABLE f_order(
    order_id INT NOT NULL,
    account_id INT,
    account_district INT,
    amount INT,
    payment_type INT,
    bank_to INT,
    account_to INT
);

ALTER TABLE f_order ADD PRIMARY KEY (order_id);