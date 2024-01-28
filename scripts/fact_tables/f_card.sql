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

