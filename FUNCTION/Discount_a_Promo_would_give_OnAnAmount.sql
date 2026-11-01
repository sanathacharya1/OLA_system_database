-- 2. DISCOUNT A PROMO WOULD GIVE ON AN AMOUNT
--    Returns 0 if the promo is missing, inactive or outside its dates.
------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_promo_discount (
    p_promo_id IN NUMBER,
    p_amount   IN NUMBER
) RETURN NUMBER IS
    v_type   promo_codes.discount_type%TYPE;
    v_value  promo_codes.discount_amount%TYPE;
    v_status promo_codes.promo_status%TYPE;
    v_from   promo_codes.valid_from%TYPE;
    v_to     promo_codes.valid_to%TYPE;
BEGIN
    IF p_promo_id IS NULL THEN
        RETURN 0;
    END IF;

    SELECT discount_type, discount_amount, promo_status, valid_from, valid_to
      INTO v_type, v_value, v_status, v_from, v_to
      FROM promo_codes
     WHERE promo_id = p_promo_id;

    IF v_status <> 'ACTIVE' OR TRUNC(SYSDATE) NOT BETWEEN v_from AND v_to THEN
        RETURN 0;
    END IF;

    IF v_type = 'PERCENTAGE' THEN
        RETURN LEAST(ROUND(p_amount * v_value / 100), p_amount);
    ELSE
        RETURN LEAST(v_value, p_amount);
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END fn_promo_discount;
/
