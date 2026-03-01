CREATE DATABASE healthcare_analytics;
USE healthcare_analytics;
CREATE TABLE patients(
patient_id INT PRIMARY KEY,
patient_name VARCHAR (100),
city VARCHAR (100),
gender VARCHAR (100),
age INT
);
CREATE TABLE doctors(
doctor_id INT PRIMARY KEY,
doctor_name VARCHAR (100),
department VARCHAR (100)
);

CREATE TABLE appointments(
appointment_id INT PRIMARY KEY,
patient_id INT,
doctor_id INT,
treatment_cost INT,
appointment_date DATE,
FOREIGN KEY(patient_id) REFERENCES patients(patient_id),
FOREIGN KEY(doctor_id) REFERENCES doctors(doctor_id)
);

INSERT INTO patients
(patient_id, patient_name, gender, age, city)
VALUES
(1, 'RAHUL SHARMA', 'MALE', 25, 'DELHI'),
(2, 'NEHA VERMA' , 'FEMALE', 32,'INDORE'),
(3, 'AMIT PATEL', 'MALE', 50, 'AHMEDABAD'),
(4, 'POOJA SINGH', 'FEMALE', 28, 'BHOPAL'),
(5, 'RAMESH KUMAR', 'MALE', 60, 'DELHI'),
(6, 'SUNITA JAIN', 'FEMALE', 40, 'INDORE');

INSERT INTO doctors
(doctor_id, doctor_name, department)
VALUES
(101, 'DR.MEHTA', 'CARDIOLOGY'),
(102, 'DR.SHARMA', 'ORTHOPEDICS'),
(103, 'DR.KHAN', 'NEUROLOGY'),
(104, 'DR.GUPTA', 'GENERAL MEDICINE');

INSERT INTO appointments
(appointment_id, patient_id, doctor_id, appointment_date, treatment_cost)
VALUES
(1001, 1, 101, '2024-01-05', 15000),
(1002, 2, 104, '2024-01-10', 4000),
(1003, 3, 101, '2024-02-02', 20000),
(1004, 4, 102, '2024-02-12', 8000),
(1005, 5, 103, '2024-03-05', 18000),
(1006, 6, 104, '2024-03-18', 5000),
(1007, 1, 102, '2024-04-01', 9000),
(1008, 3, 101, '2024-04-15', 22000);

---1. TOTAL HOSPITAL REVENUE---
SELECT SUM(treatment_cost)AS total_revenue
FROM appointments;

---2. DEPARTMENT WISE REVENUE---
SELECT d.department,
SUM(a.treatment_cost)AS department_revenue
FROM appointments a
INNER JOIN doctors d
ON a.doctor_id= d.doctor_id
GROUP BY d.department
ORDER BY department_revenue DESC;

---3.CITY WISE PATIENT COUNT---
SELECT city,
COUNT(patient_id)AS total_patients
FROM patients
GROUP BY city
ORDER BY total_patients DESC;

---4. MOST REVENUE GENERATING DOCTOR---
SELECT d.doctor_name,
SUM(a.treatment_cost)AS doctor_revenue
FROM appointments a 
INNER JOIN doctors d
ON a.doctor_id= d.doctor_id
GROUP BY d.doctor_name
ORDER BY doctor_revenue DESC
LIMIT 1;


----5. MONTHLY REVENUE----
SELECT MONTH(appointment_date)AS month,
SUM(treatment_cost)AS monthly_revenue
FROM appointments 
GROUP BY MONTH(appointment_date)
ORDER BY month;
