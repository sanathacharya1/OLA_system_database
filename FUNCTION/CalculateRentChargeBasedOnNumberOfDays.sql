-- 11. BASE RENTAL CHARGE FOR A NUMBER OF DAYS
--     Uses monthly (30 days) and weekly (7 days) rates where they exist;
--     leftover days cost the daily rate, but never more than a full weekly rate.
------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_rental_charge (
    p_rate_plan_id IN NUMBER,
    p_days         IN NUMBER
) RETURN NUMBER IS
    v_daily   rental_rate_plans.daily_rate%TYPE;
    v_weekly  rental_rate_plans.weekly_rate%TYPE;
    v_monthly rental_rate_plans.monthly_rate%TYPE;
    v_left    NUMBER := p_days;
    v_months  NUMBER := 0;
    v_weeks   NUMBER := 0;
    v_rest    NUMBER;
BEGIN
    SELECT daily_rate, weekly_rate, monthly_rate
      INTO v_daily, v_weekly, v_monthly
      FROM rental_rate_plans
     WHERE rate_plan_id = p_rate_plan_id;

    IF v_monthly IS NOT NULL THEN
        v_months := FLOOR(v_left / 30);
        v_left   := v_left - v_months * 30;
    END IF;

    IF v_weekly IS NOT NULL THEN
        v_weeks := FLOOR(v_left / 7);
        v_left  := v_left - v_weeks * 7;
    END IF;

    v_rest := v_left * v_daily;
    IF v_weekly IS NOT NULL THEN
        v_rest := LEAST(v_rest, v_weekly);
    END IF;

    RETURN NVL(v_months * v_monthly, 0) + NVL(v_weeks * v_weekly, 0) + v_rest;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END fn_rental_charge;
/
