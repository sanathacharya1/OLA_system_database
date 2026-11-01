-- ============================================================
-- TRIGGER: trg_rating_completed_only
-- Validates that ratings can only be submitted for COMPLETED rides.
-- ============================================================

CREATE OR REPLACE TRIGGER trg_rating_completed_only
BEFORE INSERT ON ratings
FOR EACH ROW
DECLARE
    v_status ride_bookings.booking_status%TYPE;
BEGIN
    SELECT booking_status INTO v_status
      FROM ride_bookings
     WHERE booking_id = :NEW.booking_id;

    IF v_status <> 'COMPLETED' THEN
        RAISE_APPLICATION_ERROR(-20050, 'Only completed rides can be rated.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20051, 'Booking not found.');
END;
/
