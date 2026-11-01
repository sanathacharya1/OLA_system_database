-- ============================================================
-- TRIGGER: trg_rental_validate
-- Validates that a rented vehicle is AVAILABLE, category matches rate plan,
-- and vehicle does not have an active driver assignment.
-- ============================================================

CREATE OR REPLACE TRIGGER trg_rental_validate
BEFORE INSERT ON rental_bookings
FOR EACH ROW
DECLARE
    v_status    vehicles.vehicle_status%TYPE;
    v_veh_cat   vehicles.category_id%TYPE;
    v_plan_cat  rental_rate_plans.category_id%TYPE;
    v_assigned  NUMBER;
BEGIN
    SELECT vehicle_status, category_id INTO v_status, v_veh_cat
      FROM vehicles WHERE vehicle_id = :NEW.vehicle_id;

    SELECT category_id INTO v_plan_cat
      FROM rental_rate_plans WHERE rate_plan_id = :NEW.rate_plan_id;

    IF v_status <> 'AVAILABLE' THEN
        RAISE_APPLICATION_ERROR(-20052, 'Vehicle is not available for rental.');
    END IF;

    IF v_veh_cat <> v_plan_cat THEN
        RAISE_APPLICATION_ERROR(-20053, 'Vehicle category does not match the rate plan.');
    END IF;

    SELECT COUNT(*) INTO v_assigned
      FROM driver_vehicle_assignments
     WHERE vehicle_id = :NEW.vehicle_id AND assigned_to IS NULL;

    IF v_assigned > 0 THEN
        RAISE_APPLICATION_ERROR(-20054, 'This vehicle is a cab with an assigned driver.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20055, 'Vehicle or rate plan not found.');
END;
/
