-- ============================================================
-- TRIGGER: trg_driver_avg_rating
-- Updated for 4NF schema: ratings joins ride_bookings to find driver_id.
-- ============================================================

CREATE OR REPLACE TRIGGER trg_driver_avg_rating
AFTER INSERT OR UPDATE OR DELETE ON ratings
BEGIN
    UPDATE drivers d
       SET average_rating = NVL((
           SELECT ROUND(AVG(r.driver_rating), 2)
             FROM ratings r
             JOIN ride_bookings b ON b.booking_id = r.booking_id
            WHERE b.driver_id = d.driver_id
       ), 0);
END;
/
