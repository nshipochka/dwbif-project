CREATE TABLE d_characterization(
    ch_id SERIAL NOT NULL,
    ch_type VARCHAR(45)
);

ALTER TABLE d_characterization ADD PRIMARY KEY (ch_id);

INSERT INTO d_characterization(ch_type)
VALUES
    ('POJISTNE'),
    ('SLUZBY'),
    ('UROK'),
    ('SANKC. UROK'),
    ('SIPO'),
    ('DUCHOD'),
    ('UVER'),
    ('LEASING');

