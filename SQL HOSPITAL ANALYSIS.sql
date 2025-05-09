
CREATE TABLE hospital_data_raw (
    hospital_name TEXT,
    location TEXT,
    department TEXT,
    doctors_count TEXT,
    patients_count TEXT,
    admission_date TEXT,
    discharge_date TEXT,
    medical_expenses TEXT
);


SELECT * FROM HOSPITAL_DATA_RAW;
--altered the column patients_count
ALTER TABLE hospital_data_raw
ALTER COLUMN Patients_Count TYPE INTEGER USING CAST(Patients_Count AS INTEGER);

--altered the column doctors_count
ALTER TABLE hospital_data_raw
ALTER COLUMN doctors_count TYPE INTEGER USING doctors_count::INTEGER;

--altered the column medical_expenses
ALTER TABLE hospital_data_raw
ALTER COLUMN medical_expenses TYPE NUMERIC USING medical_expenses::NUMERIC;

--altered the column Admission_Date
ALTER TABLE hospital_data_raw
ALTER COLUMN Admission_Date TYPE DATE USING TO_DATE(Admission_Date, 'DD-MM-YYYY');

--altered the column Discharge_Date
ALTER TABLE hospital_data_raw
ALTER COLUMN Discharge_Date TYPE DATE USING TO_DATE(Discharge_Date, 'DD-MM-YYYY');




--ANSWER 1
SELECT SUM(Patients_Count) AS Total_Patients
FROM hospital_data_raw;


--ANSWER 1 if the data type is not clear
SELECT SUM(CAST(Patients_Count AS INTEGER)) AS Total_Patients
FROM hospital_data_raw;


--ANSWER 2
SELECT AVG(doctors_count) AS avg_doctors_per_hospital
FROM (
    SELECT hospital_name, MAX(doctors_count) AS doctors_count
    FROM hospital_data_raw
    GROUP BY hospital_name
) AS sub;

--answer 3
SELECT department, SUM(patients_count) AS total_patients
FROM hospital_data_raw
GROUP BY department
ORDER BY total_patients DESC
LIMIT 3;

--answer 4
SELECT hospital_name, SUM(medical_expenses) AS total_expense
FROM hospital_data_raw
GROUP BY hospital_name
ORDER BY total_expense DESC
LIMIT 1;

--answer5
SELECT AVG(medical_expenses / (Discharge_Date - Admission_Date)) AS daily_avg_medical_expenses
FROM hospital_data_raw
WHERE Discharge_Date IS NOT NULL AND Admission_Date IS NOT NULL;

--answer6
SELECT hospital_name, MAX(Discharge_Date - Admission_Date) AS longest_stay
FROM hospital_data_raw
WHERE Discharge_Date IS NOT NULL AND Admission_Date IS NOT NULL
GROUP BY hospital_name
ORDER BY longest_stay DESC
LIMIT 1;

--answer7
SELECT Location, SUM(Patients_Count) AS total_patients_treated
FROM hospital_data_raw
GROUP BY Location
ORDER BY total_patients_treated DESC;

--answer8
SELECT Department, AVG(Discharge_Date - Admission_Date) AS avg_length_of_stay
FROM hospital_data_raw
WHERE Discharge_Date IS NOT NULL AND Admission_Date IS NOT NULL
GROUP BY Department
ORDER BY avg_length_of_stay DESC;

--answer9
SELECT Department, SUM(Patients_Count) AS total_patients
FROM hospital_data_raw
GROUP BY Department
ORDER BY total_patients ASC
LIMIT 1;

--answer10
SELECT 
    EXTRACT(YEAR FROM Admission_Date) AS year,
    EXTRACT(MONTH FROM Admission_Date) AS month,
    SUM(medical_expenses) AS total_medical_expenses
FROM hospital_data_raw
WHERE Admission_Date IS NOT NULL
GROUP BY year, month
ORDER BY year DESC, month DESC;






