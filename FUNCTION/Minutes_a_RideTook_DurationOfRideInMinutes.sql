-- 9. DURATION OF A RIDE IN MINUTES
------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_ride_duration_min (
    p_booking_id IN NUMBER
) RETURN NUMBER IS
    v_start ride_bookings.ride_start_time%TYPE;
    v_end   ride_bookings.ride_end_time%TYPE;
BEGIN
    SELECT ride_start_time, ride_end_time
      INTO v_start, v_end
      FROM ride_bookings
     WHERE booking_id = p_booking_id;

    IF v_start IS NULL OR v_end IS NULL THEN
        RETURN NULL;
    END IF;

    RETURN ROUND((CAST(v_end AS DATE) - CAST(v_start AS DATE)) * 24 * 60, 1);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END fn_ride_duration_min;
/
