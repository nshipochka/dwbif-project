-- Top 10 transactions by amount
SELECT
    t.transaction_id,
    t.amount,
    tt.trans_type,
    a.account_id
FROM f_transaction t
JOIN d_account a ON t.account_id = a.account_id
JOIN d_transaction_type tt ON t.trans_type = tt.t_type_id
ORDER BY t.amount DESC
LIMIT 10;


-- Monthly Expense Report
SELECT
    d.month,
    a.account_id,
    tt.trans_type,
    SUM(t.amount) AS total_expense
FROM f_transaction t
JOIN d_account a ON t.account_id = a.account_id
JOIN d_date d ON t.date = d.date
JOIN d_transaction_type tt ON t.trans_type = tt.t_type_id
GROUP BY
    month,
    a.account_id
ORDER BY
    month,
    a.account_id;


-- Numbers of people with credit cards by region
SELECT
    d.region,
    COUNT(DISTINCT c.card_id) AS num_people_with_credit_cards
FROM f_card c
JOIN d_demographic d ON c.client_district = d.district_id
GROUP BY d.region;


-- Account with the longest loan duration
SELECT
    a.account_id,
    l.loan_id,
    d.date,
    l.payment
    l.duration
FROM f_loan l
JOIN d_account a ON a.account_id = l.account_id
JOIN d_date d ON a.date = d.date
ORDER BY l.duration DESC
LIMIT 1;

-- Top 10 regions with highest loan amount
SELECT
    d.region,
    SUM(l.loan_amount) AS total_loan_amount,
    ls.l_status
FROM f_loan l
JOIN d_account a ON l.account_id = a.account_id
JOIN d_demographic d ON l.account_district = d.district_id
JOIN d_loan_status ls ON l.status = ls.l_status_id
GROUP BY d.region
ORDER BY total_loan_amount DESC
LIMIT 10;

-- Orders with Insurance payment
SELECT
    o.order_id,
    o.amount,
    d.region,
    d.district_name,
    p.p_type
FROM f_order o
JOIN d_payment_type p ON o.payment_type = p.p_type_id
JOIN d_demographic d ON o.account_district = d.district_id
WHERE p.p_type = 'POJISTNE'

