-- ============================================================
-- TRIGGER: trg_rental_vehicle_status
-- Updates vehicles status and odometer reading as rental status changes.
-- ============================================================

CREATE OR REPLACE TRIGGER trg_rental_vehicle_status
AFTER UPDATE OF booking_status ON rental_bookings
FOR EACH ROW
BEGIN
    IF :NEW.booking_status = 'ACTIVE' AND :OLD.booking_status <> 'ACTIVE' THEN
        UPDATE vehicles
           SET vehicle_status = 'RENTED'
         WHERE vehicle_id = :NEW.vehicle_id;
    ELSIF :NEW.booking_status IN ('COMPLETED','CANCELLED')
          AND :OLD.booking_status IN ('ACTIVE','OVERDUE') THEN
        UPDATE vehicles
           SET vehicle_status   = 'AVAILABLE',
               odometer_reading = GREATEST(odometer_reading, NVL(:NEW.ending_odometer, odometer_reading))
         WHERE vehicle_id = :NEW.vehicle_id;
    END IF;
END;
/
