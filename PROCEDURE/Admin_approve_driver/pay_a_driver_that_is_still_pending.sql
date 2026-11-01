-- ============================================================
-- PAY DRIVER PROCEDURE
-- Updated for 4NF schema: driver_earnings links to ride_bookings on booking_id.
-- ============================================================

CREATE OR REPLACE PROCEDURE pay_driver (
    p_driver_id IN NUMBER,
    p_admin_id  IN NUMBER,
    p_method    IN VARCHAR2 DEFAULT 'UPI',
    p_reference IN VARCHAR2 DEFAULT NULL
) AS
    v_total    NUMBER;
    v_start    DATE;
    v_end      DATE;
    v_payout   NUMBER;
    v_admin_ok NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_admin_ok
      FROM administrators
     WHERE admin_id = p_admin_id
       AND admin_status = 'ACTIVE'
       AND role IN ('SUPER_ADMIN','OPERATIONS');

    IF v_admin_ok = 0 THEN
        RAISE_APPLICATION_ERROR(-20070, 'Admin not found, inactive, or not allowed to pay drivers.');
    END IF;

    SELECT NVL(SUM(e.net_earning), 0), MIN(TRUNC(e.earned_at)), MAX(TRUNC(e.earned_at))
      INTO v_total, v_start, v_end
      FROM driver_earnings e
      JOIN ride_bookings b ON b.booking_id = e.booking_id
     WHERE b.driver_id = p_driver_id
       AND e.earning_status = 'PENDING';

    IF v_total = 0 THEN
        RAISE_APPLICATION_ERROR(-20071, 'This driver has no pending earnings.');
    END IF;

    v_payout := seq_payout.NEXTVAL;

    INSERT INTO driver_payouts (
        payout_id, driver_id, period_start, period_end, total_amount,
        payout_method, payout_status, payout_date,
        transaction_reference, processed_by_admin
    ) VALUES (
        v_payout, p_driver_id, v_start, v_end, v_total,
        p_method, 'PAID', SYSTIMESTAMP,
        p_reference, p_admin_id
    );

    UPDATE driver_earnings
       SET payout_id      = v_payout,
           earning_status = 'PAID'
     WHERE earning_status = 'PENDING'
       AND booking_id IN (
           SELECT booking_id FROM ride_bookings WHERE driver_id = p_driver_id
       );

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END pay_driver;
/
