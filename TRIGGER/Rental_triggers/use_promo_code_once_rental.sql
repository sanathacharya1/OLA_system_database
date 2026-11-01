-- ============================================================
-- TRIGGER: trg_rental_promo_once
-- Updated for 4NF schema: promo_usage stores (promo_id, user_id, used_at).
-- ============================================================

CREATE OR REPLACE TRIGGER trg_rental_promo_once
AFTER INSERT OR UPDATE OF promo_id ON rental_bills
FOR EACH ROW
WHEN (NEW.promo_id IS NOT NULL
      AND (OLD.promo_id IS NULL OR NEW.promo_id <> OLD.promo_id))
DECLARE
    v_user rental_bookings.user_id%TYPE;
BEGIN
    SELECT user_id INTO v_user
      FROM rental_bookings
     WHERE rental_id = :NEW.rental_id;

    INSERT INTO promo_usage (promo_id, user_id, used_at)
    VALUES (:NEW.promo_id, v_user, SYSTIMESTAMP);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(-20041, 'You have already used this promo code.');
END;
/
