DELIMITER //

CREATE PROCEDURE SearchPatient(IN p_id INT)
BEGIN
    SELECT patient_id, patient_name
    FROM patients
    WHERE patient_id = p_id;
END //

DELIMITER ;

CALL SearchPatient(1);

--------------------------------------------------------------------------------

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

CALL SearchAppointmentsByPatient(1);

--------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------