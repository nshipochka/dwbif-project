CREATE TABLE card_staging
(
    stage_at         DATE DEFAULT CURRENT_DATE,
    card_id          INT NOT NULL PRIMARY KEY,
    client_id        INT NOT NULL,
    account_id       INT NOT NULL,
    client_district  INT NOT NULL,
    account_district INT NOT NULL,
    type             VARCHAR(10),
    issued           VARCHAR(20),
    disp_type        VARCHAR(10)
);

INSERT INTO card_staging
(card_id,
 client_id,
 account_id,
 client_district,
 account_district,
 type,
 issued,
 disp_type)
SELECT card_id,
       client.client_id,
       account.account_id,
       client.district_id,
       account.district_id,
       credit_card.type,
       issued,
       disposition.type
FROM credit_card
         JOIN disposition ON credit_card.disp_id = disposition.disp_id
         JOIN client ON disposition.client_id = client.client_id
         JOIN account ON disposition.account_id = account.account_id;
