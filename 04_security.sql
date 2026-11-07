USE hospitalSystem;

-------------------------------------------------------------

-- CREATE USER ROLES

CREATE ROLE IF NOT EXISTS 'role_admin';
CREATE ROLE IF NOT EXISTS 'role_doctor';
CREATE ROLE IF NOT EXISTS 'role_receptionist';
CREATE ROLE IF NOT EXISTS 'role_patient';

-------------------------------------------------------------
-- GRANT PERMISSIONS 


GRANT ALL PRIVILEGES 
ON hospitalSystem.*
TO 'role_admin';

-- DOCTOR 

GRANT SELECT 
ON hospitalSystem.patients
TO 'role_doctor'; 

GRANT SELECT 
ON hospitalSystem.appointments
TO 'role_doctor';

GRANT SELECT, INSERT, UPDATE 
ON hospitalSystem.diagnosis
TO 'role_doctor';

GRANT SELECT, INSERT, UPDATE
ON hospitalSystem.prescriptions
TO 'role_doctor';

GRANT SELECT 
ON hospitalSystem.medicines
TO 'role_doctor'; 

GRANT SELECT, INSERT, UPDATE
ON hospitalSystem.prescription_item
TO 'role_doctor';

GRANT SELECT, INSERT, UPDATE
ON hospitalSystem.treatments
TO 'role_doctor';

GRANT SELECT, INSERT, UPDATE
ON hospitalSystem.followUp
TO 'role_doctor';



-- RECEPTIONIST

GRANT SELECT, INSERT, UPDATE
ON hospitalSystem.patients
TO 'role_receptionist';

GRANT SELECT, INSERT, UPDATE
ON hospitalSystem.appointments
TO 'role_receptionist';

GRANT SELECT
ON hospitalSystem.clinicians
TO 'role_receptionist';

GRANT SELECT
ON hospitalSystem.clinic
TO 'role_receptionist';

GRANT SELECT
ON hospitalSystem.followUp
TO 'role_receptionist';

--------------------------------------------------------------------

-- PASSWORD HASHING 
SELECT SHA2('ExamplePassword123!', 256) AS password_hash;


-- DATA ENCRYPTION 

SELECT AES_ENCRYPT('Patient Confidential Data', 'HospitalKey123')
AS encrypted_data;

SELECT CAST(
    AES_DECRYPT(
        AES_ENCRYPT('Patient Confidential Data', 'HospitalKey123'),
        'HospitalKey123'
    ) AS CHAR
) AS decrypted_data;