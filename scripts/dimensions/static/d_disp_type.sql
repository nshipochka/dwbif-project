CREATE TABLE d_disp_type(
    d_type_id SERIAL NOT NULL,
    d_type CHAR(10)
);

ALTER TABLE d_disp_type ADD PRIMARY KEY (d_type_id);

INSERT INTO d_disp_type(d_type)
VALUES
    ('OWNER'),
    ('DISPONENT');

