-- ============================================================
-- TRIGGER: trg_driver_ride_count
-- Increments total_rides for the driver whenever a booking is COMPLETED.
-- ============================================================

CREATE OR REPLACE TRIGGER trg_driver_ride_count
AFTER INSERT OR UPDATE OF booking_status ON ride_bookings
FOR EACH ROW
WHEN (NEW.booking_status = 'COMPLETED' AND NEW.driver_id IS NOT NULL)
BEGIN
    IF INSERTING OR :OLD.booking_status <> 'COMPLETED' THEN
        UPDATE drivers
           SET total_rides = total_rides + 1
         WHERE driver_id = :NEW.driver_id;
    END IF;
END;
/
