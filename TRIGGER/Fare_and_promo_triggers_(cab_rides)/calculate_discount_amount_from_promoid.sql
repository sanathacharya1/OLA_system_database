-- ============================================================
-- TRIGGER: trg_fare_calc_discount
-- Updated for 4NF schema:
-- In fare_estimates, estimated_total is a VIRTUAL column:
--   GENERATED ALWAYS AS (base_fare + kilometer_charge + waiting_charge + toll_charge - discount_amount + tax_amount) VIRTUAL.
-- In Oracle, direct assignment to virtual columns is disallowed (ORA-54017).
-- The trigger computes and stores discount_amount; Oracle automatically computes estimated_total.
-- ============================================================

CREATE OR REPLACE TRIGGER trg_fare_calc_discount
BEFORE INSERT OR UPDATE OF promo_id, base_fare, kilometer_charge,
                           waiting_charge, toll_charge, tax_amount
ON fare_estimates
FOR EACH ROW
DECLARE
    v_type    promo_codes.discount_type%TYPE;
    v_value   promo_codes.discount_amount%TYPE;
    v_status  promo_codes.promo_status%TYPE;
    v_from    promo_codes.valid_from%TYPE;
    v_to      promo_codes.valid_to%TYPE;
    v_fare    NUMBER;
    v_disc    NUMBER;
BEGIN
    v_fare := :NEW.base_fare + :NEW.kilometer_charge
            + :NEW.waiting_charge + :NEW.toll_charge;

    IF :NEW.promo_id IS NULL THEN
        v_disc := 0;
    ELSE
        BEGIN
            SELECT discount_type, discount_amount, promo_status, valid_from, valid_to
              INTO v_type, v_value, v_status, v_from, v_to
              FROM promo_codes
             WHERE promo_id = :NEW.promo_id;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20042, 'Promo code does not exist.');
        END;

        IF v_status <> 'ACTIVE' OR TRUNC(SYSDATE) NOT BETWEEN v_from AND v_to THEN
            RAISE_APPLICATION_ERROR(-20043, 'Promo code is not active or has expired.');
        END IF;

        IF v_type = 'PERCENTAGE' THEN
            v_disc := ROUND(v_fare * v_value / 100, 0);
        ELSE
            v_disc := v_value;
        END IF;

        v_disc := LEAST(v_disc, v_fare);

        IF v_disc <= 0 THEN
            RAISE_APPLICATION_ERROR(-20044, 'This promo gives no discount on this fare.');
        END IF;
    END IF;

    :NEW.discount_amount := v_disc;
END;
/
