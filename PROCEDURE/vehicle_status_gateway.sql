-- ============================================================
-- VEHICLE STATUS GATEWAY / RENT VEHICLE PROCEDURE
-- Updated for 4NF schema: inserts starting_fuel_level (NOT NULL) and starting_odometer.
-- ============================================================

CREATE OR REPLACE PROCEDURE rent_vehicle (
    p_rental_id          IN NUMBER,
    p_user_id            IN NUMBER,
    p_vehicle_id         IN NUMBER,
    p_rate_plan          IN NUMBER,
    p_pickup_loc         IN VARCHAR2,
    p_return_loc         IN VARCHAR2,
    p_pickup             IN TIMESTAMP,
    p_expected_return    IN TIMESTAMP,
    p_starting_fuel      IN NUMBER DEFAULT 10
) AS
    v_odo NUMBER;
BEGIN
    SELECT odometer_reading INTO v_odo
      FROM vehicles
     WHERE vehicle_id = p_vehicle_id;

    UPDATE vehicles
       SET vehicle_status = 'RENTED'
     WHERE vehicle_id = p_vehicle_id
       AND vehicle_status = 'AVAILABLE';

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20050, 'Vehicle is not available for rent.');
    END IF;

    INSERT INTO rental_bookings (
        rental_id, user_id, vehicle_id, rate_plan_id,
        pickup_location, return_location, pickup_date, expected_return_date,
        starting_odometer, starting_fuel_level, booking_status
    ) VALUES (
        p_rental_id, p_user_id, p_vehicle_id, p_rate_plan,
        p_pickup_loc, p_return_loc, p_pickup, p_expected_return,
        v_odo, NVL(p_starting_fuel, 10), 'ACTIVE'
    );

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END rent_vehicle;
/
