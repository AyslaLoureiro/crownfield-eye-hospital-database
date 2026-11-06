-- INDIVIDUAL QUERIES

---------------------------------------------------------------------
-- ROBSON GERMINARA QUERIES

-- FIRST QUERY // INNER JOIN

SELECT
    p.prescription_id,
    pi.prescription_itemId,
    m.medicine_name,
    pi.dosage,
    pi.route,
    pi.frequency,
    pi.duration

FROM prescriptions p

INNER JOIN prescription_item pi
    ON p.prescription_id = pi.prescription_prescriptionId

INNER JOIN medicines m
    ON pi.medicine_medicineId = m.medicine_id;

  

-- SECOND QUERY // LEFT JOIN

SELECT

    p.patient_id,

    p.patient_name,

    a.appoiment_id

FROM patients p

LEFT JOIN appointments a

    ON p.patient_id = a.patients_patientId

WHERE a.appoiment_id IS NULL;


-- THIRD QUERY // GROUP BY + HAVING

SELECT

    c.clinician_id,

    c.clinician_name,

    COUNT(a.appoiment_id) AS total_appointments

FROM clinicians c

INNER JOIN appointments a

    ON c.clinician_id = a.clinician_clinicianId

GROUP BY

    c.clinician_id,

    c.clinician_name

HAVING COUNT(a.appoiment_id) > 1;



-- FOURTH QUERY // SUBQUERY

SELECT

    patient_id,

    patient_name

FROM patients

WHERE patient_id IN (

    SELECT patients_patientId

    FROM appointments

    WHERE appoiment_id IN (

        SELECT appoiment_id

        FROM diagnosis

    )

);


-- FIFTH QUERY // STORE PROCEDURE

BEGIN

    SELECT patient_id, patient_name

    FROM patients

    WHERE patient_id = p_id;

END //



DELIMITER ;



CALL SearchPatient(1);

-- SIXTH QUERY // TRIGGER

DELIMITER //



CREATE TRIGGER check_followup_priority

BEFORE INSERT ON followUp

FOR EACH ROW

BEGIN

    IF NEW.priority NOT IN ('Low', 'Medium', 'High') THEN

        SIGNAL SQLSTATE '45000'

        SET MESSAGE_TEXT = 'Invalid follow-up priority';

    END IF;

END //



DELIMITER ;



SHOW TRIGGERS;



------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

-- AYSLA LOUREIRO QUERIES 

-- FIRST QUERY // INNER JOIN 

SELECT
    p.patient_name,
    a.appointment_date,
    d.diagnosis_description
FROM patients p
INNER JOIN appointments a
    ON p.patient_id = a.patients_patientId
INNER JOIN diagnosis d
    ON a.appointment_id = d.appointment_appoimentId;


-- SECOND QUERY // LEFT JOIN

SELECT

    a.appointment_id,

    p.patient_name,

    a.appointment_date,

    d.diagnosis_id

FROM appointments a

INNER JOIN patients p

    ON a.patients_patientId = p.patient_id

LEFT JOIN diagnosis d

    ON a.appointment_id = d.appointment_appoimentId

WHERE d.diagnosis_id IS NULL; 

-- THIRD QUERY // GROUP BY + HAVING

 m.medicine_id,

    m.medicine_name,

    COUNT(pi.prescription_itemId) AS total_prescriptions

FROM medicines m

INNER JOIN prescription_item pi

    ON m.medicine_id = pi.medicine_medicineId

GROUP BY

    m.medicine_id,

    m.medicine_name

HAVING COUNT(pi.prescription_itemId) >= 1;

-- FOURTH QUERY // SUBQUERY

    p.patient_id,

    p.patient_name

FROM patients p

WHERE p.patient_id IN (

    SELECT a.patients_patientId

    FROM appointments a

    WHERE a.appointment_id IN (

        SELECT pr.appointment_appoimentId

        FROM prescriptions pr

    )

);



-- FIFTH QUERY // STORE PROCEDURE

DELIMITER //



CREATE PROCEDURE SearchAppointmentsByPatient(

    IN p_patient_id INT

)

BEGIN

    SELECT

        appointment_id,

        appointment_date,

        appointment_time

    FROM appointments

    WHERE patients_patientId = p_patient_id;

END //



DELIMITER ;



CALL SearchAppointmentsByPatient(1);

-- SIXTH QUERY // TRIGGER

DELIMITER //



CREATE TRIGGER check_followup_date

BEFORE INSERT ON followUp

FOR EACH ROW

BEGIN

    IF NEW.due_date < CURDATE() THEN

        SIGNAL SQLSTATE '45000'

        SET MESSAGE_TEXT = 'Follow-up date cannot be in the past';

    END IF;

END //



DELIMITER ;



SHOW TRIGGERS;

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------