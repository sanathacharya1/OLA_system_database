-- 4. DRIVER EARNINGS TOTAL
--    Updated for 4NF schema: driver_earnings links to ride_bookings via booking_id.
--    p_status = 'PENDING' / 'PAID' / 'CANCELLED', or NULL for all.
------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_driver_total_earnings (
    p_driver_id IN NUMBER,
    p_status    IN VARCHAR2 DEFAULT NULL
) RETURN NUMBER IS
    v_total NUMBER;
BEGIN
    SELECT NVL(SUM(e.net_earning), 0)
      INTO v_total
      FROM driver_earnings e
      JOIN ride_bookings b ON b.booking_id = e.booking_id
     WHERE b.driver_id = p_driver_id
       AND (p_status IS NULL OR e.earning_status = p_status);

    RETURN v_total;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END fn_driver_total_earnings;
/
