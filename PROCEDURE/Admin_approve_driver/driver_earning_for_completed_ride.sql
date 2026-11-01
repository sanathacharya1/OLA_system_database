-- ============================================================
-- GENERATE DRIVER EARNINGS FOR COMPLETED RIDES
-- Updated for 4NF schema: 
-- 1. driver_earnings does not have a driver_id column (obtained via booking_id).
-- 2. net_earning is a VIRTUAL column (generated always), so it cannot be inserted.
-- ============================================================

CREATE OR REPLACE PROCEDURE generate_driver_earnings (
    p_commission_percent IN NUMBER DEFAULT 20
) AS
BEGIN
    INSERT INTO driver_earnings (earning_id, booking_id, gross_fare, commission_amount, earning_status)
    SELECT seq_earning.NEXTVAL, x.booking_id, x.fare, x.comm, 'PENDING'
      FROM (
            SELECT b.booking_id,
                   f.estimated_total AS fare,
                   ROUND(f.estimated_total * p_commission_percent / 100) AS comm
              FROM ride_bookings b
              JOIN fare_estimates f ON f.booking_id = b.booking_id
             WHERE b.booking_status = 'COMPLETED'
               AND b.driver_id IS NOT NULL
               AND NOT EXISTS (SELECT 1 FROM driver_earnings e WHERE e.booking_id = b.booking_id)
           ) x;
    COMMIT;
END generate_driver_earnings;
/
