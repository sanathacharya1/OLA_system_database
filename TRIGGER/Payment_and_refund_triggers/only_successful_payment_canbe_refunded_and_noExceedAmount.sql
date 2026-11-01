-- ============================================================
-- TRIGGER: trg_refund_check
-- Validates that only successful, non-refunded payments can be refunded,
-- and refund amount does not exceed payment amount.
-- ============================================================

CREATE OR REPLACE TRIGGER trg_refund_check
BEFORE INSERT ON refunds
FOR EACH ROW
DECLARE
    v_amount payments.amount%TYPE;
    v_status payments.payment_status%TYPE;
BEGIN
    SELECT amount, payment_status INTO v_amount, v_status
      FROM payments
     WHERE payment_id = :NEW.payment_id;

    IF v_status = 'REFUNDED' THEN
        RAISE_APPLICATION_ERROR(-20060, 'Payment has already been refunded.');
    ELSIF v_status <> 'SUCCESS' THEN
        RAISE_APPLICATION_ERROR(-20061, 'Only a successful payment can be refunded.');
    END IF;

    IF :NEW.refund_amount > v_amount THEN
        RAISE_APPLICATION_ERROR(-20061, 'Refund cannot be more than the payment.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20062, 'Payment not found.');
END;
/
