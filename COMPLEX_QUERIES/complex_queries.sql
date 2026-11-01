
SET LINESIZE 200;
SET PAGESIZE 100;
SET FEEDBACK ON;

-- -----------------------------------------------------------------------------
-- 1. Top Earning Active Drivers with Completed Ride Count and Average Rating
-- Concepts: Multi-table JOIN (4 tables), Aggregate Functions (COUNT, SUM, AVG), GROUP BY, HAVING, ORDER BY
-- -----------------------------------------------------------------------------
SELECT d.driver_id,
       u.first_name || ' ' || u.last_name AS driver_name,
       COUNT(rb.booking_id) AS completed_rides,
       ROUND(AVG(r.driver_rating), 2) AS calculated_rating,
       SUM(de.gross_fare) AS total_gross_fare,
       SUM(de.net_earning) AS total_net_earned
  FROM drivers d
  JOIN users u ON u.user_id = d.user_id
  JOIN ride_bookings rb ON rb.driver_id = d.driver_id
  JOIN driver_earnings de ON de.booking_id = rb.booking_id
  LEFT JOIN ratings r ON r.booking_id = rb.booking_id
 WHERE rb.booking_status = 'COMPLETED'
 GROUP BY d.driver_id, u.first_name, u.last_name
HAVING COUNT(rb.booking_id) >= 1
 ORDER BY total_net_earned DESC;


-- -----------------------------------------------------------------------------
-- 2. Fleet Utilization & Maintenance Health Status
-- Concepts: Outer JOINs, NVL, Conditional CASE Expressions, Date Arithmetic
-- -----------------------------------------------------------------------------
SELECT v.vehicle_id,
       v.vehicle_number,
       cc.category_name,
       v.vehicle_status,
       v.odometer_reading AS current_odometer,
       NVL(TO_CHAR(MAX(vm.service_date), 'YYYY-MM-DD'), 'No Service') AS last_service_date,
       CASE 
           WHEN v.odometer_reading >= MAX(vm.next_service_odometer) THEN 'CRITICAL: ODO EXCEEDED'
           WHEN MAX(vm.next_service_date) <= TRUNC(SYSDATE) THEN 'URGENT: DATE OVERDUE'
           ELSE 'HEALTHY'
       END AS maintenance_alert
  FROM vehicles v
  JOIN cab_categories cc ON cc.category_id = v.category_id
  LEFT JOIN vehicle_maintenance vm ON vm.vehicle_id = v.vehicle_id AND vm.maintenance_status = 'COMPLETED'
 GROUP BY v.vehicle_id, v.vehicle_number, cc.category_name, v.vehicle_status, v.odometer_reading
 ORDER BY v.vehicle_id;


-- -----------------------------------------------------------------------------
-- 3. Monthly Financial Revenue Comparison: Cab Rides vs Vehicle Rentals
-- Concepts: UNION ALL, In-line Aggregation Subqueries, Currency Formatting
-- -----------------------------------------------------------------------------
SELECT 'Cab Bookings' AS business_vertical,
       COUNT(p.payment_id) AS total_transactions,
       SUM(p.amount) AS gross_revenue_inr,
       ROUND(AVG(p.amount), 2) AS avg_ticket_size
  FROM payments p
 WHERE p.payment_type = 'RIDE'
   AND p.payment_status = 'SUCCESS'
UNION ALL
SELECT 'Vehicle Rentals' AS business_vertical,
       COUNT(p.payment_id) AS total_transactions,
       SUM(p.amount) AS gross_revenue_inr,
       ROUND(AVG(p.amount), 2) AS avg_ticket_size
  FROM payments p
 WHERE p.payment_type = 'RENTAL'
   AND p.payment_status = 'SUCCESS';


-- -----------------------------------------------------------------------------
-- 4. Promo Code Financial Impact & Discount Leakage Analysis
-- Concepts: JOIN with Subquery, Arithmetic Calculations, Group Aggregation
-- -----------------------------------------------------------------------------
SELECT pc.promo_code,
       pc.discount_type,
       pc.discount_amount AS configured_discount,
       COUNT(fe.fare_estimate_id) AS times_applied,
       SUM(fe.discount_amount) AS total_discount_given,
       SUM(fe.estimated_total) AS net_discounted_sales
  FROM promo_codes pc
  JOIN fare_estimates fe ON fe.promo_id = pc.promo_id
 GROUP BY pc.promo_code, pc.discount_type, pc.discount_amount
 ORDER BY total_discount_given DESC;


-- -----------------------------------------------------------------------------
-- 5. Cross-Service Power Customers (Used both Cab Rides and Vehicle Rentals)
-- Concepts: SET Operator INTERSECT with Customer Information
-- -----------------------------------------------------------------------------
SELECT u.user_id, u.first_name || ' ' || u.last_name AS customer_name, u.phone
  FROM users u
 WHERE u.user_id IN (
       SELECT rb.user_id FROM ride_bookings rb
       INTERSECT
       SELECT rnt.user_id FROM rental_bookings rnt
 );


-- -----------------------------------------------------------------------------
-- 6. Exclusive Cab Riders Who Have Never Rented a Self-Drive Vehicle
-- Concepts: SET Operator MINUS, Subquery Filtering
-- -----------------------------------------------------------------------------
SELECT u.user_id, u.first_name || ' ' || u.last_name AS customer_name, u.email
  FROM users u
 WHERE u.user_id IN (
       SELECT rb.user_id FROM ride_bookings rb
       MINUS
       SELECT rnt.user_id FROM rental_bookings rnt
 );


-- -----------------------------------------------------------------------------
-- 7. Drivers Outperforming Platform-Wide Average Rating (Scalar Subquery)
-- Concepts: Correlated/Scalar Subquery in WHERE clause, String Formatting
-- -----------------------------------------------------------------------------
SELECT d.driver_id,
       u.first_name || ' ' || u.last_name AS driver_name,
       d.average_rating,
       d.total_rides
  FROM drivers d
  JOIN users u ON u.user_id = d.user_id
 WHERE d.average_rating > (
       SELECT AVG(average_rating)
         FROM drivers
        WHERE driver_status = 'ACTIVE'
 )
 ORDER BY d.average_rating DESC;


-- -----------------------------------------------------------------------------
-- 8. Rentals Incurring Penalty Fees (Late Returns or Excess Kilometres)
-- Concepts: Multi-table JOIN, Filtering on Calculated Columns, String Concatenation
-- -----------------------------------------------------------------------------
SELECT rb.rental_id,
       u.first_name || ' ' || u.last_name AS customer_name,
       v.vehicle_number,
       rbl.extra_km_charge,
       rbl.late_fee,
       rbl.damage_charge,
       rbl.total_amount AS final_billed_amount
  FROM rental_bills rbl
  JOIN rental_bookings rb ON rb.rental_id = rbl.rental_id
  JOIN users u ON u.user_id = rb.user_id
  JOIN vehicles v ON v.vehicle_id = rb.vehicle_id
 WHERE rbl.extra_km_charge > 0 
    OR rbl.late_fee > 0
    OR rbl.damage_charge > 0;


-- -----------------------------------------------------------------------------
-- 9. Eco-Impact Analysis: Carbon Offsets (CO2 Saved) by Fuel Classification
-- Concepts: Multi-table JOIN, SUM Aggregation, Grouping, Environmental Metrics
-- -----------------------------------------------------------------------------
SELECT v.fuel_type,
       COUNT(e.eco_record_id) AS green_trips_count,
       SUM(e.distance_km) AS total_green_km,
       SUM(e.baseline_co2_kg) AS baseline_emissions_kg,
       SUM(e.actual_co2_kg) AS actual_emissions_kg,
       SUM(e.co2_saved_kg) AS total_co2_offset_kg
  FROM eco_impact_records e
  LEFT JOIN ride_bookings rb ON rb.booking_id = e.booking_id
  LEFT JOIN rental_bookings rnt ON rnt.rental_id = e.rental_id
  JOIN vehicles v ON v.vehicle_id = NVL(rb.vehicle_id, rnt.vehicle_id)
 GROUP BY v.fuel_type
 ORDER BY total_co2_offset_kg DESC;


-- -----------------------------------------------------------------------------
-- 10. Operational SLA Performance: Customer Complaints Resolution Speed
-- Concepts: Timestamp Difference, Admin Join, Categorical Aggregation
-- -----------------------------------------------------------------------------
SELECT c.complaint_id,
       c.complaint_type,
       rb.booking_id,
       c.complaint_description,
       ROUND((CAST(c.resolved_at AS DATE) - CAST(c.created_at AS DATE)) * 24 * 60, 1) AS resolution_time_minutes,
       c.complaint_status,
       c.resolution_notes
  FROM complaints c
  JOIN ride_bookings rb ON rb.booking_id = c.booking_id
 WHERE c.complaint_status = 'RESOLVED'
 ORDER BY resolution_time_minutes ASC;


-- -----------------------------------------------------------------------------
-- 11. Customer Loyalty Gamification & Badge Milestone Report
-- Concepts: JOIN with Badge System, SUM of points awarded, Grouping
-- -----------------------------------------------------------------------------
SELECT u.user_id,
       u.first_name || ' ' || u.last_name AS customer_name,
       COUNT(ub.badge_name) AS total_badges_earned,
       LISTAGG(ub.badge_name, ', ') WITHIN GROUP (ORDER BY ub.earned_date) AS badges_list,
       SUM(b.points_awarded) AS total_accumulated_points
  FROM users u
  JOIN user_badges ub ON ub.user_id = u.user_id
  JOIN badges b ON b.badge_name = ub.badge_name
 GROUP BY u.user_id, u.first_name, u.last_name
 ORDER BY total_accumulated_points DESC;


-- -----------------------------------------------------------------------------
-- 12. Create View for Real-Time System-Wide Financial Reconciliation
-- Concepts: DDL CREATE OR REPLACE VIEW, Subqueries, Left Outer Joins
-- -----------------------------------------------------------------------------
CREATE OR REPLACE VIEW v_financial_reconciliation AS
SELECT p.payment_id,
       p.transaction_reference,
       p.payment_type,
       p.payment_method,
       p.amount AS gross_amount_paid,
       NVL(rf.refund_amount, 0) AS refunded_amount,
       p.amount - NVL(rf.refund_amount, 0) AS net_retained_revenue,
       p.payment_status,
       p.payment_time
  FROM payments p
  LEFT JOIN refunds rf ON rf.payment_id = p.payment_id;

SELECT payment_type,
       COUNT(payment_id) AS total_transactions,
       SUM(gross_amount_paid) AS total_gross_inr,
       SUM(refunded_amount) AS total_refunded_inr,
       SUM(net_retained_revenue) AS total_net_retained_inr
  FROM v_financial_reconciliation
 GROUP BY payment_type;


-- -----------------------------------------------------------------------------
-- 13. Analytic Window Function: Dense Ranking of Drivers by Earnings within Fleet
-- Concepts: DENSE_RANK() OVER (ORDER BY ...), Analytical Partitioning
-- -----------------------------------------------------------------------------
SELECT d.driver_id,
       u.first_name || ' ' || u.last_name AS driver_name,
       d.total_rides,
       SUM(de.net_earning) AS total_net_earned,
       DENSE_RANK() OVER (ORDER BY SUM(de.net_earning) DESC) AS earning_rank
  FROM drivers d
  JOIN users u ON u.user_id = d.user_id
  JOIN ride_bookings rb ON rb.driver_id = d.driver_id
  JOIN driver_earnings de ON de.booking_id = rb.booking_id
 GROUP BY d.driver_id, u.first_name, u.last_name, d.total_rides;


-- -----------------------------------------------------------------------------
-- 14. Vehicles with Incident History and Loss Assessment (EXISTS Subquery)
-- Concepts: Correlated EXISTS Subquery, Left Join with Administrators
-- -----------------------------------------------------------------------------
SELECT v.vehicle_id,
       v.vehicle_number,
       v.fuel_type,
       vi.incident_type,
       vi.severity,
       vi.estimated_loss,
       vi.incident_status
  FROM vehicles v
  JOIN vehicle_incidents vi ON vi.booking_id IN (
       SELECT booking_id FROM ride_bookings WHERE vehicle_id = v.vehicle_id
  ) OR vi.rental_id IN (
       SELECT rental_id FROM rental_bookings WHERE vehicle_id = v.vehicle_id
  )
 WHERE EXISTS (
       SELECT 1 FROM vehicle_incidents vi2 
        WHERE (vi2.booking_id IN (SELECT booking_id FROM ride_bookings WHERE vehicle_id = v.vehicle_id)
           OR vi2.rental_id IN (SELECT rental_id FROM rental_bookings WHERE vehicle_id = v.vehicle_id))
 );


-- -----------------------------------------------------------------------------
-- 15. Safe Drivers Without Any Recorded Customer Complaints or Accidents (NOT EXISTS)
-- Concepts: NOT EXISTS with Double Correlated Subquery
-- -----------------------------------------------------------------------------
SELECT d.driver_id,
       u.first_name || ' ' || u.last_name AS driver_name,
       u.phone,
       d.average_rating
  FROM drivers d
  JOIN users u ON u.user_id = d.user_id
 WHERE d.driver_status = 'ACTIVE'
   AND NOT EXISTS (
       SELECT 1 
         FROM ride_bookings rb
         JOIN complaints c ON c.booking_id = rb.booking_id
        WHERE rb.driver_id = d.driver_id
   );
