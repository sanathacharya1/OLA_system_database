-- 12. EXTRA KILOMETRE CHARGE OF A RENTAL
--     kilometres driven beyond (included km per day * booked days), times the extra km rate
------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_extra_km_charge (
    p_rental_id IN NUMBER
) RETURN NUMBER IS
    v_start rental_bookings.starting_odometer%TYPE;
    v_end   rental_bookings.ending_odometer%TYPE;
    v_incl  rental_rate_plans.included_km_per_day%TYPE;
    v_rate  rental_rate_plans.extra_km_rate%TYPE;
BEGIN
    SELECT r.starting_odometer, r.ending_odometer, p.included_km_per_day, p.extra_km_rate
      INTO v_start, v_end, v_incl, v_rate
      FROM rental_bookings r
      JOIN rental_rate_plans p ON p.rate_plan_id = r.rate_plan_id
     WHERE r.rental_id = p_rental_id;

    IF v_start IS NULL OR v_end IS NULL THEN
        RETURN 0;
    END IF;

    RETURN GREATEST(0, (v_end - v_start) - v_incl * fn_rental_days(p_rental_id)) * v_rate;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END fn_extra_km_charge;
/
