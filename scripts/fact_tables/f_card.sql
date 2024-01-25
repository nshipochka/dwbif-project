CREATE TABLE f_card(
    card_id INT NOT NULL,
    account_id INT, --FK
    owner_id INT, -- FK
    user_id INT, -- FK
    card_type INT, -- FK
    owner_district INT, -- FK
    user_district INT, --FK
    account_district INT -- FK
);

ALTER TABLE f_card ADD PRIMARY KEY (card_id);

ALTER TABLE f_card
    ADD CONSTRAINT FK_C_ACCOUNT
        FOREIGN KEY (account_id) REFERENCES d_account(account_id),
    ADD CONSTRAINT FK_C_ACC_DISTRICT
        FOREIGN KEY (account_district) REFERENCES d_demographic(district_id),
    ADD CONSTRAINT FK_C_OWNER
        FOREIGN KEY (owner_id) REFERENCES d_client(client_id),
    ADD CONSTRAINT FK_C_OWNER_DISTRICT
        FOREIGN KEY (owner_district) REFERENCES d_demographic(district_id),
    ADD CONSTRAINT FK_C_USER
        FOREIGN KEY (user_id) REFERENCES d_client(client_id),
    ADD CONSTRAINT FK_C_USER_DISTRICT
        FOREIGN KEY (user_district) REFERENCES d_demographic(district_id),
    ADD CONSTRAINT FK_C_CARD_TYPE
        FOREIGN KEY (card_type) REFERENCES d_card_type(c_type_id);

