-- 13. LATE FEE OF A RENTAL
--     hours past the expected return (rounded up) * late fee per hour.
--     If the car is not back yet, it uses the current time.
------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_late_fee (
    p_rental_id IN NUMBER
) RETURN NUMBER IS
    v_expected TIMESTAMP;
    v_actual   TIMESTAMP;
    v_rate     rental_rate_plans.late_fee_per_hour%TYPE;
    v_hours    NUMBER;
BEGIN
    SELECT r.expected_return_date, NVL(r.actual_return_date, LOCALTIMESTAMP), p.late_fee_per_hour
      INTO v_expected, v_actual, v_rate
      FROM rental_bookings r
      JOIN rental_rate_plans p ON p.rate_plan_id = r.rate_plan_id
     WHERE r.rental_id = p_rental_id;

    v_hours := CEIL((CAST(v_actual AS DATE) - CAST(v_expected AS DATE)) * 24);

    IF v_hours <= 0 THEN
        RETURN 0;
    END IF;

    RETURN v_hours * v_rate;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END fn_late_fee;
/
