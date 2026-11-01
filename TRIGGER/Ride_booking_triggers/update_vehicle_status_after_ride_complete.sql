-- ============================================================
-- TRIGGER: trg_release_vehicle
-- Frees up the vehicle to AVAILABLE when a booking completes or is cancelled.
-- ============================================================

CREATE OR REPLACE TRIGGER trg_release_vehicle
AFTER UPDATE OF booking_status ON ride_bookings
FOR EACH ROW
WHEN (NEW.booking_status IN ('COMPLETED','CANCELLED')
      AND OLD.booking_status = 'ACCEPTED'
      AND NEW.vehicle_id IS NOT NULL)
BEGIN
    UPDATE vehicles
       SET vehicle_status = 'AVAILABLE'
     WHERE vehicle_id = :NEW.vehicle_id
       AND vehicle_status IN ('BOOKED','ON_RIDE');
END;
/
