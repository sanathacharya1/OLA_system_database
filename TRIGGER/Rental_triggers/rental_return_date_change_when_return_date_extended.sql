-- ============================================================
-- TRIGGER: trg_extension_approved
-- Updates expected_return_date on rental_bookings when an extension request is APPROVED.
-- ============================================================

CREATE OR REPLACE TRIGGER trg_extension_approved
AFTER UPDATE OF request_status ON rental_extension_requests
FOR EACH ROW
WHEN (NEW.request_status = 'APPROVED' AND OLD.request_status = 'PENDING')
BEGIN
    UPDATE rental_bookings
       SET expected_return_date = CAST(:NEW.requested_return_date AS TIMESTAMP)
     WHERE rental_id = :NEW.rental_id;
END;
/
