CREATE TABLE d_date (
    date DATE,
    year INT,
    month INT,
    monthname VARCHAR(15),
    day INT,
    weekdayname VARCHAR(15),
    calendarweek INT,
    quartal CHAR(2),
    weekend VARCHAR(15),
    czechholiday VARCHAR(15)
);

ALTER TABLE d_date ADD PRIMARY KEY(date);

INSERT INTO d_date(date, year, month, monthname, day, weekdayname, calendarweek, quartal, weekend, czechholiday)
SELECT
	datum as Date,
	extract(year from datum) AS Year,
	extract(month from datum) AS Month,
	-- Localized month name
	to_char(datum, 'TMMonth') AS MonthName,
	extract(day from datum) AS Day,
	-- Localized weekday
	to_char(datum, 'TMDay') AS WeekdayName,
	-- ISO calendar week
	extract(week from datum) AS CalendarWeek,
	'Q' || to_char(datum, 'Q') AS Quartal,
	-- Weekend
	CASE WHEN extract(isodow from datum) in (6, 7) THEN 'Weekend' ELSE 'Weekday' END AS Weekend,
	-- Fixed holidays
        -- for America
        CASE WHEN to_char(datum, 'MMDD') IN ('0101', '0329', '0401', '0501', '0508', '0705','0706', '0928',
                                             '1028', '1117', '1224', '1225', '1226', '1231')
		THEN 'Holiday' ELSE 'No holiday' END
		AS CzechHoliday
FROM (
	-- There are 3 leap years in this range, so calculate 365 * 10 + 3 records
	SELECT '1992-01-01'::DATE + sequence.day AS datum
	FROM generate_series(0,1826) AS sequence(day)
	GROUP BY sequence.day
     ) DQ
order by 1