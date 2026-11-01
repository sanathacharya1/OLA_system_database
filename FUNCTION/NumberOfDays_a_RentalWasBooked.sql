-- 10. NUMBER OF DAYS A RENTAL WAS BOOKED
------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_rental_days (
    p_rental_id IN NUMBER
) RETURN NUMBER IS
    v_pickup   rental_bookings.pickup_date%TYPE;
    v_expected rental_bookings.expected_return_date%TYPE;
BEGIN
    SELECT pickup_date, expected_return_date
      INTO v_pickup, v_expected
      FROM rental_bookings
     WHERE rental_id = p_rental_id;

    RETURN GREATEST(1, CEIL(CAST(v_expected AS DATE) - CAST(v_pickup AS DATE)));
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END fn_rental_days;
/
