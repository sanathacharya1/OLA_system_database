-- 1. FARE FOR A CAB RIDE (before discount and tax)
--    base fare + distance * rate per km + waiting minutes * waiting rate
--    Returns NULL if the category has no active rate.
------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_calculate_fare (
    p_category_id IN NUMBER,
    p_distance_km IN NUMBER,
    p_waiting_min IN NUMBER DEFAULT 0
) RETURN NUMBER IS
    v_base  cab_category_rates.base_fare%TYPE;
    v_km    cab_category_rates.rate_per_km%TYPE;
    v_wait  cab_category_rates.waiting_per_minute%TYPE;
BEGIN
    SELECT base_fare, rate_per_km, waiting_per_minute
      INTO v_base, v_km, v_wait
      FROM cab_category_rates
     WHERE category_id = p_category_id
       AND rate_status = 'ACTIVE'
       AND ROWNUM = 1;

    RETURN v_base + ROUND(p_distance_km * v_km) + ROUND(NVL(p_waiting_min, 0) * v_wait);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END fn_calculate_fare;
/
