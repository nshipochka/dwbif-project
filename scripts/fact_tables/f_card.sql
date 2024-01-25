CREATE TABLE f_card(
    card_id INT NOT NULL,
    owner_id INT, --client
    user_id INT, --client
    c_type INT,
    client_district INT,
    account_district INT
);

ALTER TABLE f_card ADD PRIMARY KEY (card_id);