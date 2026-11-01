-- 7. LICENSE STATUS OF A DRIVER (expired or expiring soon)
--    Updated for 4NF schema: license expiry date is located in driver_documents (document_type = 'LICENSE').
------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_license_status (
    p_driver_id IN NUMBER
) RETURN VARCHAR2 IS
    v_expiry driver_documents.expiry_date%TYPE;
BEGIN
    SELECT expiry_date INTO v_expiry
      FROM driver_documents
     WHERE driver_id = p_driver_id
       AND document_type = 'LICENSE';

    IF v_expiry < TRUNC(SYSDATE) THEN
        RETURN 'EXPIRED';
    ELSIF v_expiry <= TRUNC(SYSDATE) + 30 THEN
        RETURN 'EXPIRING_SOON';
    ELSE
        RETURN 'VALID';
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'NOT_FOUND';
END fn_license_status;
/
