-- ============================================================
-- APPROVE DRIVER PROCEDURE
-- Updated for 4NF schema: license expiry check reads driver_documents (type LICENSE).
-- ============================================================

CREATE OR REPLACE PROCEDURE approve_driver (
    p_driver_id IN NUMBER,
    p_admin_id  IN NUMBER
) AS
    v_old_status drivers.driver_status%TYPE;
    v_expiry     driver_documents.expiry_date%TYPE;
    v_admin_ok   NUMBER;
    v_docs       NUMBER;
BEGIN
    SELECT driver_status
      INTO v_old_status
      FROM drivers
     WHERE driver_id = p_driver_id
       FOR UPDATE;

    SELECT COUNT(*) INTO v_admin_ok
      FROM administrators
     WHERE admin_id = p_admin_id
       AND admin_status = 'ACTIVE'
       AND role IN ('SUPER_ADMIN','OPERATIONS');

    IF v_admin_ok = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Admin not found, inactive, or not allowed to approve drivers.');
    END IF;

    IF v_old_status = 'ACTIVE' THEN
        RAISE_APPLICATION_ERROR(-20002, 'Driver is already ACTIVE.');
    END IF;

    BEGIN
        SELECT expiry_date INTO v_expiry
          FROM driver_documents
         WHERE driver_id = p_driver_id
           AND document_type = 'LICENSE';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20004, 'Driver license document not found.');
    END;

    IF v_expiry <= SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20003, 'Driving license has expired.');
    END IF;

    SELECT COUNT(*) INTO v_docs
      FROM driver_documents
     WHERE driver_id = p_driver_id
       AND document_type IN ('LICENSE','AADHAAR','PAN')
       AND verification_status IN ('PENDING','VERIFIED')
       AND expiry_date > SYSDATE;

    IF v_docs < 3 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Driver needs valid LICENSE, AADHAAR and PAN documents.');
    END IF;

    UPDATE driver_documents
       SET verification_status = 'VERIFIED',
           verified_date       = SYSDATE
     WHERE driver_id = p_driver_id
       AND verification_status = 'PENDING';

    UPDATE drivers
       SET driver_status       = 'ACTIVE',
           identity_verified   = 'Y',
           background_verified = 'Y'
     WHERE driver_id = p_driver_id;

    INSERT INTO admin_audit_log (
        audit_id, admin_id, table_name, operation_type,
        record_id, old_value, new_value, operation_time
    ) VALUES (
        seq_audit_log.NEXTVAL, p_admin_id, 'DRIVERS', 'UPDATE',
        p_driver_id, 'driver_status=' || v_old_status, 'driver_status=ACTIVE', SYSTIMESTAMP
    );

    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20000, 'Driver ' || p_driver_id || ' does not exist.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END approve_driver;
/
