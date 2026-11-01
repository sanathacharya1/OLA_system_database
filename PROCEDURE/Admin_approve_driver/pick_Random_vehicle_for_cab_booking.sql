-- ============================================================
-- ASSIGN RANDOM DRIVER TO RIDE BOOKING
-- Updated for 4NF schema: ensures driver has no current active accepted ride and links vehicle assignment.
-- ============================================================

CREATE OR REPLACE PROCEDURE assign_random_driver (p_booking_id IN NUMBER) AS
    v_user      ride_bookings.user_id%TYPE;
    v_category  ride_bookings.category_id%TYPE;
    v_status    ride_bookings.booking_status%TYPE;
    v_driver    NUMBER;
    v_vehicle   NUMBER;
    v_from      DATE;
    v_assigned  BOOLEAN := FALSE;
BEGIN
    SELECT user_id, category_id, booking_status
      INTO v_user, v_category, v_status
      FROM ride_bookings
     WHERE booking_id = p_booking_id
       AND driver_id IS NULL
       FOR UPDATE;

    IF v_status <> 'REQUESTED' THEN
        RAISE_APPLICATION_ERROR(-20020, 'Booking is not waiting for a driver.');
    END IF;

    FOR attempt IN 1 .. 5 LOOP
        BEGIN
            SELECT driver_id, vehicle_id, assigned_from
              INTO v_driver, v_vehicle, v_from
              FROM (
                    SELECT a.driver_id, a.vehicle_id, a.assigned_from
                      FROM driver_vehicle_assignments a
                      JOIN vehicles v ON v.vehicle_id = a.vehicle_id
                      JOIN drivers  d ON d.driver_id  = a.driver_id
                     WHERE a.assigned_to IS NULL
                       AND v.category_id    = v_category
                       AND v.vehicle_status = 'AVAILABLE'
                       AND d.driver_status  = 'ACTIVE'
                       AND d.user_id       <> v_user          -- a driver cannot drive their own booking
                       AND NOT EXISTS (
                           SELECT 1 FROM ride_bookings rb
                            WHERE rb.driver_id = d.driver_id
                              AND rb.booking_status = 'ACCEPTED'
                       )
                       AND EXISTS (
                           SELECT 1
                             FROM driver_availability av
                            WHERE av.driver_id = d.driver_id
                              AND av.availability_status = 'AVAILABLE'
                              AND LOCALTIMESTAMP BETWEEN av.start_time AND av.end_time
                       )
                     ORDER BY DBMS_RANDOM.VALUE
                    )
             WHERE ROWNUM = 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20021, 'No driver available for this cab category.');
        END;

        -- claim the vehicle; 0 rows updated means another booking took it first
        UPDATE vehicles
           SET vehicle_status = 'BOOKED'
         WHERE vehicle_id = v_vehicle
           AND vehicle_status = 'AVAILABLE';

        IF SQL%ROWCOUNT = 1 THEN
            v_assigned := TRUE;
            EXIT;
        END IF;
    END LOOP;

    IF NOT v_assigned THEN
        RAISE_APPLICATION_ERROR(-20022, 'Could not assign a driver, please try again.');
    END IF;

    UPDATE ride_bookings
       SET driver_id      = v_driver,
           vehicle_id     = v_vehicle,
           assigned_from  = v_from,
           booking_status = 'ACCEPTED'
     WHERE booking_id = p_booking_id;

    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20023, 'Booking not found or already has a driver.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END assign_random_driver;
/
