-- Load updateable dimensions
-- Insert into d_account from staging
INSERT INTO d_account
(account_id,
 frequency,
 date,
 stage_at)
SELECT account_id,
       frequency,
       date,
       stage_at
FROM dw.staging_area.account
ON CONFLICT(account_id) DO NOTHING;

-- Client
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

-- Insert into partner bank from transactions when encountered
INSERT INTO d_partner_bank
(pb_code)
SELECT bank_to
FROM dw.staging_area.permanent_order
ON CONFLICT(pb_code) DO NOTHING;

INSERT INTO d_partner_bank
(pb_code)
SELECT bank
FROM dw.staging_area.transaction
ON CONFLICT(pb_code) DO NOTHING;

-- Demographic
INSERT INTO d_demographic
SELECT *
FROM dw.business_op.demographic_data;

-- Load into fact tables
INSERT INTO f_card
(card_id,
 account_id,
 client_id,
 card_type,
 client_district,
 account_district,
 disp_type)
SELECT staged_card.card_id,
       d_account.account_id,
       d_client.client_id,
       d_card_type.c_type_id,
       d2.district_id,
       d1.district_id,
       d_disp_type.d_type_id
FROM dw.staging_area.credit_card AS staged_card
         JOIN d_account ON staged_card.account_id = d_account.account_id
         JOIN d_client ON staged_card.client_id = d_client.client_id
         JOIN d_card_type ON staged_card.type = d_card_type.c_type
         JOIN d_demographic AS d1 ON staged_card.account_district = d1.district_id
         JOIN d_demographic AS d2 ON staged_card.client_district = d2.district_id
         JOIN d_disp_type ON staged_card.disp_type = d_disp_type.d_type;

-- loan
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
       staged_loan.payments,
       d_loan_status.l_status_id
FROM dw.staging_area.loan AS staged_loan
         NATURAL JOIN dw.staging_area.account AS staged_acc
         NATURAL JOIN d_account
         NATURAL JOIN d_demographic
         NATURAL JOIN d_date AS b_date
         NATURAL JOIN d_loan_status
WHERE (staged_loan.account_id = staged_acc.account_id AND
       staged_loan.account_id = d_account.account_id AND
       staged_acc.district_id = d_demographic.district_id AND
       staged_loan.date = b_date.date AND
       staged_loan.status = d_loan_status.l_status);

-- order
INSERT INTO f_order
(order_id,
 account_id,
 account_district,
 amount,
 payment_type,
 bank_to,
 account_to)
SELECT staged_order.order_id,
       staged_order.account_id,
       staged_acc.district_id,
       staged_order.amount,
       d_payment_type.p_type_id,
       d_partner_bank.pb_id,
       staged_order.account_to
FROM dw.staging_area.permanent_order AS staged_order
         NATURAL JOIN dw.staging_area.account AS staged_acc
         NATURAL JOIN d_account
         NATURAL JOIN d_demographic
         NATURAL JOIN d_payment_type
         NATURAL JOIN d_partner_bank
WHERE (staged_order.account_id = staged_acc.account_id AND
       staged_order.account_id = d_account.account_id AND
       staged_acc.district_id = d_demographic.district_id AND
       staged_order.k_symbol = d_payment_type.p_type AND
       staged_order.bank_to = d_partner_bank.pb_code);

-- transaction

INSERT INTO f_transaction
(transaction_id,
 account_id,
 account_district,
 amount,
 balance,
 date,
 trans_type,
 trans_mode,
 payment_type,
 bank_to,
 account_to)
SELECT staged_transaction.trans_id,
       staged_transaction.account,
       staged_acc.district_id,
       staged_transaction.amount,
       staged_transaction.balance,
       staged_transaction.date,
       d_transaction_type.t_type_id,
       d_transaction_mode.t_mode_id,
       d_payment_type.p_type_id,
       d_partner_bank.pb_id,
       staged_transaction.account
FROM dw.staging_area.transaction AS staged_transaction
         NATURAL JOIN dw.staging_area.account AS staged_acc
         NATURAL JOIN d_account
         NATURAL JOIN d_demographic
         NATURAL JOIN d_date AS b_date
         NATURAL JOIN d_transaction_type
         NATURAL JOIN d_transaction_mode
         NATURAL JOIN d_payment_type
         NATURAL JOIN d_partner_bank
WHERE (staged_transaction.account_id = staged_acc.account_id AND
       staged_transaction.account_id = d_account.account_id AND
       staged_acc.district_id = d_demographic.district_id AND
       staged_transaction.date = b_date.date AND
       staged_transaction.type = d_transaction_type.t_type AND
       staged_transaction.operation = d_transaction_mode.t_mode AND
       staged_transaction.k_symbol = d_payment_type.p_type AND
       staged_transaction.bank = d_partner_bank.pb_code);

