-- ============================================================
-- TRIGGER: trg_refund_mark_payment
-- Marks the payment status as REFUNDED when a refund is PROCESSED.
-- ============================================================

CREATE OR REPLACE TRIGGER trg_refund_mark_payment
AFTER INSERT OR UPDATE OF refund_status ON refunds
FOR EACH ROW
WHEN (NEW.refund_status = 'PROCESSED')
BEGIN
    UPDATE payments
       SET payment_status = 'REFUNDED'
     WHERE payment_id = :NEW.payment_id;
END;
/
