------------------------------------------------------------
-- QUICK TESTS FOR FUNCTIONS (with sample data)
------------------------------------------------------------
-- 1. Fare calculation test:
-- SELECT fn_calculate_fare(4, 10, 3) FROM dual;

-- 2. Promo discount test:
-- SELECT fn_promo_discount(2, 200) FROM dual;

-- 3. Driver rating and earnings test:
-- SELECT driver_id, fn_driver_avg_rating(driver_id), fn_driver_total_earnings(driver_id, 'PENDING') FROM drivers;

-- 4. Vehicle availability and service check test:
-- SELECT vehicle_id, fn_vehicle_is_available(vehicle_id), fn_vehicle_service_due(vehicle_id) FROM vehicles;

-- 5. Driver license status test:
-- SELECT driver_id, fn_license_status(driver_id) FROM drivers;

-- 6. User age and loyalty points test:
-- SELECT user_id, fn_user_age(user_id), fn_user_points(user_id) FROM users;

-- 7. Rental booking metrics test:
-- SELECT rental_id, fn_rental_days(rental_id), fn_extra_km_charge(rental_id), fn_late_fee(rental_id)
--   FROM rental_bookings;

-- 8. Rental rate charge tier test:
-- SELECT fn_rental_charge(1, 5), fn_rental_charge(1, 9), fn_rental_charge(1, 35) FROM dual;
