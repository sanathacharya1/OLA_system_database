-- 3. DRIVER AVERAGE RATING
--    Updated for 4NF schema: ratings links to ride_bookings via booking_id.
------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_driver_avg_rating (
    p_driver_id IN NUMBER
) RETURN NUMBER IS
    v_avg NUMBER;
BEGIN
    SELECT ROUND(AVG(r.driver_rating), 2)
      INTO v_avg
      FROM ratings r
      JOIN ride_bookings b ON b.booking_id = r.booking_id
     WHERE b.driver_id = p_driver_id;

    RETURN NVL(v_avg, 0);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END fn_driver_avg_rating;
/
