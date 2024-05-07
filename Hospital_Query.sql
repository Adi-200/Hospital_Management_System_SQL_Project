#SQL QUERIES

#1. Write a query in SQL to obtain the name of the physician in alphabetical order. 

SELECT NAME AS PHYSICIAN_NAME
FROM PHYSICIAN
ORDER BY NAME;

#2. Write a query in SQL to obtain the fullname of the patients whose gender is male.

SELECT CONCAT(NAME,' ',SURNAME) AS Patients_Fullname,GENDER
FROM PATIENT
WHERE GENDER = 'MALE';

#3. Write a query in SQL to find the name of the nurse who are the head of their department and are registered.

SELECT * FROM NURSE
WHERE POSITION ='Head Nurse' AND REGISTERED = "YES";

#4. Write a query in SQL to find the name of the nurse who are Team Leader or not registered.

SELECT NAME,POSITION,REGISTERED
FROM NURSE
WHERE Position = 'Team Leader' OR REGISTERED = "NO";

#5. Write a query to obtain the avg cost of all the medical procedures.

SELECT AVG(COST) as Average_cost
FROM PROCEDURES;

#6 Write a query to obtain name and cost of the procedure whose cost is greater than 2000.

SELECT NAME as Procedure_Name,COST as Procedure_Cost 
FROM PROCEDURES
WHERE NOT COST < 2000;

#7. Write a query to update the name of the patient to Robert Fernandez having patientid as 5.

UPDATE PATIENT
SET NAME = 'Robert',SURNAME = 'Fernandez'
WHERE PATIENT_ID = 5;

SELECT * FROM PATIENT;

#8. Write a query to drop phone column from patient table.

ALTER TABLE Patient
DROP phone;

SELECT * FROM PATIENT;

#9. Second maximum cost of medical procedure

SELECT NAME,MAX(COST) as Procedure_cost
FROM PROCEDURES 
GROUP BY name
ORDER BY Procedure_cost DESC
LIMIT 1,1;

#Like Operator

#10. Write a query in SQL to obtain the name of the patients starting with letter A.

SELECT CONCAT(NAME,' ',SURNAME) AS FULL_NAME,GENDER
FROM PATIENT
WHERE CONCAT(NAME,' ',SURNAME) LIKE 'A%';

#11. Write a query in SQL to obtain the name of the patients whose third letter is M.

SELECT CONCAT(NAME,' ',SURNAME) AS FULL_NAME,GENDER
FROM PATIENT
WHERE CONCAT(NAME,' ',SURNAME) LIKE '__M%';

#12. Write a query in SQL to obtain the name of the patients whose name start with letter J and ends with Z.

SELECT CONCAT(NAME,' ',SURNAME) AS FULL_NAME,GENDER
FROM PATIENT
WHERE CONCAT(NAME,' ',SURNAME) LIKE 'J%Z';

#13. Write a query to obtain patient details having patient_id 11 to 20.

SELECT * 
FROM PATIENT
LIMIT 10,10;

#JOINS

#14.  Write a query in SQL to obtain the name of the physicians who are the head of each department

select p.name as Doctor_name,d.dept_name
from physician p
inner join department d
on p.employeeid = d.head;

#15. Write a query in SQL to obtain the name of the patients with their physicians by whom they got their preliminary treatement

select CONCAT(p.name,' ',p.SURNAME) as PATIENT_NAME,ph.NAME as PHY_WHO_DID_PRI_TREATMENT
FROM PATIENT p
LEFT JOIN PHYSICIAN ph
ON p.PRIMARY_CHECK = ph.EMPLOYEEID;

#16. Write a query in SQL to obtain the name of the physician with the department who are done with affiliation.

select p.name as physician_name,d.dept_name as department_name
from physician p
inner join affiliated_with aw
on p.employeeid = aw.physicianid
inner join department d
on aw.departmentid = d.department_id
where primaryaffiliation='t';

#17. Write a query to obtain physician name,position and department they are affiliated with.

SELECT p.name AS physician_name, p.position AS physician_position, d.dept_name AS department_name
FROM Physician p
JOIN affiliated_with a 
ON p.employeeid = a.physicianid
JOIN department d
ON a.departmentid = d.department_id;

#18. Write a query in SQL to obtain the patient name from which physician they get primary_checkup and also mention the patient diagnosis with prescription.

SELECT PH.EMPLOYEEID,PH.NAME AS Physician_Name,PH.POSITION AS Designation,P.PATIENT_ID,CONCAT(P.NAME,' ',P.SURNAME) AS Patient_treated,P.GENDER,PD.DIAGNOSIS,PD.PRESCRIPTION
FROM PATIENT_DIAGNOSIS pd
LEFT JOIN Physician ph
ON pd.Physician_id = ph.employeeid
LEFT JOIN PATIENT P
ON P.PATIENT_ID = PD.PATIENT_ID;

#SUBQUERY

#19. Write a query in SQL to obtain the maximum cost of the medical procedure.

SELECT NAME,COST FROM PROCEDURES
WHERE COST IN (SELECT MAX(COST) FROM PROCEDURES);

#20. Write a query in SQL to obtain the details of patient who has diagnosed with chronic pain.

SELECT * FROM Patient
WHERE patient_id IN (SELECT Patient_ID FROM PATIENT_DIAGNOSIS WHERE Diagnosis = 'Chronic Pain');

#21. Write a query in SQL to obtain the procedure name and cost whose cost is greater than the avg cost of all the procedure.

SELECT name as Procedure_name,cost as Procedure_cost
FROM procedures
WHERE cost > (SELECT AVG(cost) FROM procedures);

#22. Write a query in SQL to obtain the procedure name and cost whose cost is less than the avg cost of all the procedure.

SELECT name as Procedure_name,cost as Procedure_cost
FROM procedures
WHERE cost < (SELECT AVG(cost) FROM procedures);

#23. Write a query in SQL to obtain the physician name who are either head chief or senior in their respective department.

SELECT * 
FROM Physician 
WHERE position IN (SELECT position FROM Physician
                   WHERE position
                   LIKE '%Senior%' OR position LIKE '%Head Chief%'
                   );

#24.  Write a query in SQL to obtain the employeeid, physician name and position whose primary affiliation has not been done. 

SELECT * 
FROM Physician 
WHERE employeeid IN (SELECT physicianid 
                     FROM affiliated_with 
                     WHERE primaryaffiliation = 'f'
                     );
