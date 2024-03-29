-- Account
INSERT INTO dw.staging_area.account
(account_id,
 district_id,
 frequency,
 date)
SELECT account_id,
       district_id,
       frequency,
       converttodate(date)
FROM dw.business_op.account;

-- Client
INSERT INTO dw.staging_area.client
(client_id,
 district_id,
 gender,
 birthday)
SELECT client_id,
       district_id,
       getgender(birth_number),
       converttoisodateofbirth(birth_number)
FROM dw.business_op.client;

-- Disposition
INSERT INTO dw.staging_area.disposition
(disp_id,
 client_id,
 account_id,
 type)
SELECT *
FROM dw.business_op.disposition;

-- Credit Card
INSERT INTO dw.staging_area.credit_card
(card_id,
 client_id,
 account_id,
 client_district,
 account_district,
 type,
 issued,
 disp_type)
SELECT credit_card.card_id,
       disposition.client_id,
       disposition.account_id,
       client.district_id,
       account.district_id,
       credit_card.type,
       credit_card.issued,
       disposition.type
FROM dw.business_op.credit_card
         JOIN disposition ON credit_card.disp_id = disposition.disp_id
         JOIN client ON disposition.client_id = client.client_id
         JOIN account ON disposition.account_id = account.account_id;

-- Demographic Data
INSERT INTO dw.staging_area.demographic_data
(district_id,
 district_name,
 region,
 inhabitants,
 muni_inhab_lt_499,
 muni_inhab_500_1999,
 muni_inhab_2000_9999,
 muni_inhab_gt_10000,
 cities,
 urban_population_ration,
 avg_salary,
 unemploymant_95,
 unemploymant_96,
 enterpreneurs,
 commited_crimes_95,
 comited_criems_96)
SELECT *
FROM dw.business_op.demographic_data;

-- Loan
INSERT INTO dw.staging_area.loan
(loan_id,
 account_id,
 amount,
 duration,
 payments,
 status,
 date)
SELECT loan_id,
       account_id,
       amount,
       duration,
       payments,
       status,
       converttodate(date)
FROM dw.business_op.loan;

-- Permanent Order
INSERT INTO dw.staging_area.permanent_order
    (order_id,
     account_id,
     bank_to,
     account_to,
     amount,
     k_symbol)
SELECT *
FROM dw.business_op.permanent_order;

-- Transaction
INSERT INTO dw.staging_area.transaction
    (trans_id,
     account_id,
     type,
     operation,
     amount,
     balance,
     k_symbol,
     bank,
     account,
     date)
SELECT
    trans_id,
    account_id,
    type,
    operation,
    amount,
    balance,
    k_symbol,
    bank,
    account,
    converttodate(date)
FROM dw.business_op.transaction;



