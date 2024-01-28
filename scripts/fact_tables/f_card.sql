CREATE TABLE f_card
(
    card_id          INT NOT NULL,
    account_id       INT, -- FK
    client_id        INT, -- FK
    card_type        INT, -- FK
    client_district  INT, -- FK
    account_district INT, -- FK
    disp_type        INT  -- FK
);

ALTER TABLE f_card
    ADD PRIMARY KEY (card_id);

ALTER TABLE f_card
    ADD CONSTRAINT FK_C_ACCOUNT
        FOREIGN KEY (account_id) REFERENCES d_account (account_id),
    ADD CONSTRAINT FK_C_ACC_DISTRICT
        FOREIGN KEY (account_district) REFERENCES d_demographic (district_id),
    ADD CONSTRAINT FK_C_CLIENT
        FOREIGN KEY (client_id) REFERENCES d_client (client_id),
    ADD CONSTRAINT FK_C_CLIENT_DISTRICT
        FOREIGN KEY (client_district) REFERENCES d_demographic (district_id),
    ADD CONSTRAINT FK_C_CARD_TYPE
        FOREIGN KEY (card_type) REFERENCES d_card_type (c_type_id),
    ADD CONSTRAINT FK_C_DISP_TYPE
        FOREIGN KEY (disp_type) REFERENCES d_disp_type (d_type_id);

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