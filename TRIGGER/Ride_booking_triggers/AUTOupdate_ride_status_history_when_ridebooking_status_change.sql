-- ============================================================
-- TRIGGER: trg_booking_status_history
-- Records ride status progression in ride_status_history automatically.
-- ============================================================

CREATE OR REPLACE TRIGGER trg_booking_status_history
AFTER INSERT OR UPDATE OF booking_status ON ride_bookings
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO ride_status_history (status_history_id, booking_id, old_status, new_status, changed_by, remarks)
        VALUES (seq_status_history.NEXTVAL, :NEW.booking_id, NULL, :NEW.booking_status, 'USER', 'Booking created');
    ELSIF :OLD.booking_status <> :NEW.booking_status THEN
        INSERT INTO ride_status_history (status_history_id, booking_id, old_status, new_status, changed_by)
        VALUES (seq_status_history.NEXTVAL, :NEW.booking_id, :OLD.booking_status, :NEW.booking_status,
                CASE :NEW.booking_status
                    WHEN 'ACCEPTED'  THEN 'SYSTEM'
                    WHEN 'COMPLETED' THEN 'DRIVER'
                    ELSE 'USER'
                END);
    END IF;
END;
/
