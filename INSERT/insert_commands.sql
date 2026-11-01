
INSERT INTO pincodes (pincode, city, state) VALUES ('560001', 'Bangalore', 'Karnataka');
INSERT INTO pincodes (pincode, city, state) VALUES ('560034', 'Bangalore', 'Karnataka');
INSERT INTO pincodes (pincode, city, state) VALUES ('560068', 'Bangalore', 'Karnataka');
INSERT INTO pincodes (pincode, city, state) VALUES ('570001', 'Mysore', 'Karnataka');
INSERT INTO pincodes (pincode, city, state) VALUES ('575001', 'Mangalore', 'Karnataka');





INSERT INTO cab_categories (category_id, category_name, description, minimum_seats, maximum_seats, luggage_capacity, category_status)
VALUES (1, 'BIKE', 'Two wheeler bike ride for solo commuters', 1, 1, 10, 'ACTIVE');

INSERT INTO cab_categories (category_id, category_name, description, minimum_seats, maximum_seats, luggage_capacity, category_status)
VALUES (2, 'AUTO', 'Three wheeler auto rickshaw for quick city trips', 1, 3, 30, 'ACTIVE');

INSERT INTO cab_categories (category_id, category_name, description, minimum_seats, maximum_seats, luggage_capacity, category_status)
VALUES (3, 'MINI', 'Compact hatchback for budget-friendly city travel', 1, 4, 50, 'ACTIVE');

INSERT INTO cab_categories (category_id, category_name, description, minimum_seats, maximum_seats, luggage_capacity, category_status)
VALUES (4, 'SEDAN', 'Comfortable sedan for business and leisure', 1, 4, 80, 'ACTIVE');

INSERT INTO cab_categories (category_id, category_name, description, minimum_seats, maximum_seats, luggage_capacity, category_status)
VALUES (5, 'SUV', 'Spacious SUV for family trips and luggage', 1, 7, 150, 'ACTIVE');

INSERT INTO cab_categories (category_id, category_name, description, minimum_seats, maximum_seats, luggage_capacity, category_status)
VALUES (6, 'COUPE', 'Premium stylish coupe for luxury rental experiences', 1, 2, 40, 'ACTIVE');




INSERT INTO maintenance_types (maintenance_type_id, type_name, description, default_interval_km, default_interval_days)
VALUES (1, 'OIL_CHANGE', 'Engine oil and filter change', 10000, 180);

INSERT INTO maintenance_types (maintenance_type_id, type_name, description, default_interval_km, default_interval_days)
VALUES (2, 'TIRE_ROTATION', 'Tire rotation & alignment check', 15000, 180);

INSERT INTO maintenance_types (maintenance_type_id, type_name, description, default_interval_km, default_interval_days)
VALUES (3, 'BRAKE_SERVICE', 'Brake pad inspection & fluid', 20000, 365);

INSERT INTO maintenance_types (maintenance_type_id, type_name, description, default_interval_km, default_interval_days)
VALUES (4, 'BATTERY_CHECK', 'Battery health test', 25000, 365);

INSERT INTO maintenance_types (maintenance_type_id, type_name, description, default_interval_km, default_interval_days)
VALUES (5, 'ANNUAL_INSPECTION', 'Comprehensive annual service', 30000, 365);




INSERT INTO badges (badge_name, description, points_awarded)
VALUES ('EARLY_BIRD', 'Completed 5 morning rides before 8 AM', 50);

INSERT INTO badges (badge_name, description, points_awarded)
VALUES ('TOP_RIDER', 'Completed more than 20 rides in a month', 100);

INSERT INTO badges (badge_name, description, points_awarded)
VALUES ('ECO_WARRIOR', 'Opted for electric or shared rides 10 times', 150);

INSERT INTO badges (badge_name, description, points_awarded)
VALUES ('ROAD_WARRIOR', 'Rented vehicles for more than 7 days total', 200);

INSERT INTO badges (badge_name, description, points_awarded)
VALUES ('STAR_DRIVER', 'Maintained an average rating of 4.8 or above', 250);




INSERT INTO promo_codes (promo_id, promo_code, description, discount_type, discount_amount, valid_from, valid_to, promo_status)
VALUES (1, 'WELCOME50', '50 Flat Discount', 'FIXED', 50, DATE '2024-01-01', DATE '2030-12-31', 'ACTIVE');

INSERT INTO promo_codes (promo_id, promo_code, description, discount_type, discount_amount, valid_from, valid_to, promo_status)
VALUES (2, 'SAVE10', '10 Percent Discount', 'PERCENTAGE', 10, DATE '2024-01-01', DATE '2030-12-31', 'ACTIVE');

INSERT INTO promo_codes (promo_id, promo_code, description, discount_type, discount_amount, valid_from, valid_to, promo_status)
VALUES (3, 'RENTAL100', '100 Off On Rental', 'FIXED', 100, DATE '2024-01-01', DATE '2030-12-31', 'ACTIVE');

INSERT INTO promo_codes (promo_id, promo_code, description, discount_type, discount_amount, valid_from, valid_to, promo_status)
VALUES (4, 'SUPER20', '20 Percent Off', 'PERCENTAGE', 20, DATE '2024-01-01', DATE '2030-12-31', 'ACTIVE');





INSERT INTO administrators (admin_id, admin_name, email, role, admin_status, created_at)
VALUES (1, 'Rajesh Kumar', 'rajesh.admin@cabrent.com', 'SUPER_ADMIN', 'ACTIVE', DATE '2024-01-10');

INSERT INTO administrators (admin_id, admin_name, email, role, admin_status, created_at)
VALUES (2, 'Priya Sharma', 'priya.ops@cabrent.com', 'OPERATIONS', 'ACTIVE', DATE '2024-01-15');

INSERT INTO administrators (admin_id, admin_name, email, role, admin_status, created_at)
VALUES (3, 'Anand Verma', 'anand.support@cabrent.com', 'SUPPORT', 'ACTIVE', DATE '2024-02-01');

INSERT INTO administrators (admin_id, admin_name, email, role, admin_status, created_at)
VALUES (4, 'Vikram Hegde', 'vikram.fleet@cabrent.com', 'VEHICLE_MANAGER', 'ACTIVE', DATE '2024-02-10');





INSERT INTO users (user_id, first_name, last_name, email, phone, date_of_birth, gender, account_status, registration_date)
VALUES (1, 'Ramesh', 'Gowda', 'ramesh.gowda@gmail.com', 9845011111, DATE '1988-05-12', 'MALE', 'ACTIVE', DATE '2024-01-15');

INSERT INTO users (user_id, first_name, last_name, email, phone, date_of_birth, gender, account_status, registration_date)
VALUES (2, 'Suresh', 'Reddy', 'suresh.reddy@gmail.com', 9845022222, DATE '1992-08-22', 'MALE', 'ACTIVE', DATE '2024-01-20');

INSERT INTO users (user_id, first_name, last_name, email, phone, date_of_birth, gender, account_status, registration_date)
VALUES (3, 'Kavitha', 'Nair', 'kavitha.nair@gmail.com', 9845033333, DATE '1990-11-05', 'FEMALE', 'ACTIVE', DATE '2024-02-01');

INSERT INTO users (user_id, first_name, last_name, email, phone, date_of_birth, gender, account_status, registration_date)
VALUES (4, 'Mahesh', 'Patil', 'mahesh.patil@gmail.com', 9845044444, DATE '1985-03-30', 'MALE', 'ACTIVE', DATE '2024-02-05');

INSERT INTO users (user_id, first_name, last_name, email, phone, date_of_birth, gender, account_status, registration_date)
VALUES (5, 'Arjun', 'Mehta', 'arjun.mehta@gmail.com', 9845055555, DATE '1995-07-14', 'MALE', 'ACTIVE', DATE '2024-02-15');

INSERT INTO users (user_id, first_name, last_name, email, phone, date_of_birth, gender, account_status, registration_date)
VALUES (6, 'Deepa', 'Rao', 'deepa.rao@gmail.com', 9845066666, DATE '1998-09-18', 'FEMALE', 'ACTIVE', DATE '2024-02-20');

INSERT INTO users (user_id, first_name, last_name, email, phone, date_of_birth, gender, account_status, registration_date)
VALUES (7, 'Rohit', 'Shetty', 'rohit.shetty@gmail.com', 9845077777, DATE '1993-12-01', 'MALE', 'ACTIVE', DATE '2024-03-01');

INSERT INTO users (user_id, first_name, last_name, email, phone, date_of_birth, gender, account_status, registration_date)
VALUES (8, 'Sneha', 'Kulkarni', 'sneha.k@gmail.com', 9845088888, DATE '1997-04-25', 'FEMALE', 'ACTIVE', DATE '2024-03-05');




INSERT INTO user_addresses (address_id, user_id, address_type, address_line, pincode)
VALUES (1, 1, 'HOME', '12 MG Road, Brigade Cross', '560001');

INSERT INTO user_addresses (address_id, user_id, address_type, address_line, pincode)
VALUES (2, 2, 'HOME', '45 Koramangala 4th Block', '560034');

INSERT INTO user_addresses (address_id, user_id, address_type, address_line, pincode)
VALUES (3, 3, 'HOME', '78 Electronic City', '560068');

INSERT INTO user_addresses (address_id, user_id, address_type, address_line, pincode)
VALUES (4, 4, 'HOME', '23 Gokulam 3rd Stage', '570001');

INSERT INTO user_addresses (address_id, user_id, address_type, address_line, pincode)
VALUES (5, 5, 'HOME', '88 Indiranagar 100ft Rd', '560001');

INSERT INTO user_addresses (address_id, user_id, address_type, address_line, pincode)
VALUES (6, 5, 'WORK', 'RMZ Infinity, Old Madras', '560034');

INSERT INTO user_addresses (address_id, user_id, address_type, address_line, pincode)
VALUES (7, 6, 'HOME', '19 Hampankatta Main Rd', '575001');

INSERT INTO user_addresses (address_id, user_id, address_type, address_line, pincode)
VALUES (8, 7, 'HOME', '55 HSR Layout Sector 2', '560068');





INSERT INTO emergency_contacts (user_id, contact_name, relationship, phone)
VALUES (5, 'Sunita Mehta', 'MOTHER', '9845099901');

INSERT INTO emergency_contacts (user_id, contact_name, relationship, phone)
VALUES (5, 'Rohan Mehta', 'BROTHER', '9845099902');

INSERT INTO emergency_contacts (user_id, contact_name, relationship, phone)
VALUES (6, 'Raghavendra Rao', 'FATHER', '9845099903');

INSERT INTO emergency_contacts (user_id, contact_name, relationship, phone)
VALUES (7, 'Pooja Shetty', 'SPOUSE', '9845099904');

INSERT INTO emergency_contacts (user_id, contact_name, relationship, phone)
VALUES (8, 'Amit Kulkarni', 'SPOUSE', '9845099905');





INSERT INTO user_badges (user_id, badge_name, earned_date)
VALUES (5, 'EARLY_BIRD', DATE '2024-02-25');

INSERT INTO user_badges (user_id, badge_name, earned_date)
VALUES (5, 'TOP_RIDER', DATE '2024-03-10');

INSERT INTO user_badges (user_id, badge_name, earned_date)
VALUES (6, 'ECO_WARRIOR', DATE '2024-03-01');

INSERT INTO user_badges (user_id, badge_name, earned_date)
VALUES (7, 'ROAD_WARRIOR', DATE '2024-03-15');

INSERT INTO user_badges (user_id, badge_name, earned_date)
VALUES (1, 'STAR_DRIVER', DATE '2024-03-20');





INSERT INTO drivers (driver_id, user_id, date_joined, driver_status, identity_verified, background_verified)
VALUES (1, 1, DATE '2024-01-16', 'ACTIVE', 'Y', 'Y');

INSERT INTO drivers (driver_id, user_id, date_joined, driver_status, identity_verified, background_verified)
VALUES (2, 2, DATE '2024-01-21', 'ACTIVE', 'Y', 'Y');

INSERT INTO drivers (driver_id, user_id, date_joined, driver_status, identity_verified, background_verified)
VALUES (3, 3, DATE '2024-02-02', 'PENDING', 'N', 'N');

INSERT INTO drivers (driver_id, user_id, date_joined, driver_status, identity_verified, background_verified)
VALUES (4, 4, DATE '2024-02-06', 'PENDING', 'N', 'N');





INSERT INTO driver_documents (driver_id, document_type, document_number, issue_date, expiry_date, verification_status, verified_date)
VALUES (1, 'LICENSE', 'KA01-20150001234', DATE '2015-06-10', DATE '2035-06-09', 'PENDING', DATE '2024-01-16');

INSERT INTO driver_documents (driver_id, document_type, document_number, issue_date, expiry_date, verification_status, verified_date)
VALUES (1, 'AADHAAR', '987654321012', DATE '2016-01-01', DATE '2040-01-01', 'PENDING', DATE '2024-01-16');

INSERT INTO driver_documents (driver_id, document_type, document_number, issue_date, expiry_date, verification_status, verified_date)
VALUES (2, 'LICENSE', 'KA04-20160005678', DATE '2016-04-12', DATE '2036-04-11', 'VERIFIED', DATE '2024-01-21');

INSERT INTO driver_documents (driver_id, document_type, document_number, issue_date, expiry_date, verification_status, verified_date)
VALUES (2, 'PAN', 'ABCDE1234F', DATE '2015-08-20', DATE '2040-08-20', 'PENDING', DATE '2024-01-21');

INSERT INTO driver_documents (driver_id, document_type, document_number, issue_date, expiry_date, verification_status, verified_date)
VALUES (3, 'LICENSE', 'KA05-20170009876', DATE '2017-09-15', DATE '2037-09-14', 'PENDING', DATE '2024-02-02');

INSERT INTO driver_documents (driver_id, document_type, document_number, issue_date, expiry_date, verification_status, verified_date)
VALUES (3, 'AADHAAR', '876543210987', DATE '2016-05-10', DATE '2040-05-10', 'VERIFIED', DATE '2024-02-02');

INSERT INTO driver_documents (driver_id, document_type, document_number, issue_date, expiry_date, verification_status, verified_date)
VALUES (4, 'LICENSE', 'KA09-20180004321', DATE '2018-02-18', DATE '2038-02-17', 'VERIFIED', DATE '2024-02-06');

INSERT INTO driver_documents (driver_id, document_type, document_number, issue_date, expiry_date, verification_status, verified_date)
VALUES (4, 'AADHAAR', '765432109876', DATE '2017-03-22', DATE '2040-03-22', 'PENDING', NULL);





INSERT INTO driver_availability (availability_id, driver_id, start_time, end_time, availability_status)
VALUES (1, 1, TIMESTAMP '2024-03-25 08:00:00', TIMESTAMP '2024-03-25 18:00:00', 'AVAILABLE');

INSERT INTO driver_availability (availability_id, driver_id, start_time, end_time, availability_status)
VALUES (2, 2, TIMESTAMP '2024-03-25 09:00:00', TIMESTAMP '2024-03-25 17:00:00', 'AVAILABLE');

INSERT INTO driver_availability (availability_id, driver_id, start_time, end_time, availability_status)
VALUES (3, 3, TIMESTAMP '2024-03-25 10:00:00', TIMESTAMP '2024-03-25 20:00:00', 'AVAILABLE');

INSERT INTO driver_availability (availability_id, driver_id, start_time, end_time, availability_status)
VALUES (4, 4, TIMESTAMP '2024-03-25 08:00:00', TIMESTAMP '2024-03-25 14:00:00', 'OFFLINE');





INSERT INTO driver_wellness_logs (wellness_id, driver_id, assessment_date, fatigue_level, rest_required, remarks)
VALUES (1, 1, TIMESTAMP '2024-03-25 07:45:00', 1, 'N', 'Well-rested and fit for duty');

INSERT INTO driver_wellness_logs (wellness_id, driver_id, assessment_date, fatigue_level, rest_required, remarks)
VALUES (2, 2, TIMESTAMP '2024-03-25 08:45:00', 2, 'N', 'Normal condition');

INSERT INTO driver_wellness_logs (wellness_id, driver_id, assessment_date, fatigue_level, rest_required, remarks)
VALUES (3, 3, TIMESTAMP '2024-03-25 09:50:00', 1, 'N', 'Ready for shift');

INSERT INTO driver_wellness_logs (wellness_id, driver_id, assessment_date, fatigue_level, rest_required, remarks)
VALUES (4, 4, TIMESTAMP '2024-03-25 14:10:00', 4, 'Y', 'High fatigue reported after long shift');





INSERT INTO vehicles (vehicle_id, category_id, fuel_type, transmission_type, seating_capacity, vehicle_number, manufacturing_year, odometer_reading, vehicle_status, registration_date)
VALUES (1, 4, 'PETROL', 'MANUAL', 4, 'KA01AB1001', 2022, 25000, 'AVAILABLE', DATE '2022-03-10');

INSERT INTO vehicles (vehicle_id, category_id, fuel_type, transmission_type, seating_capacity, vehicle_number, manufacturing_year, odometer_reading, vehicle_status, registration_date)
VALUES (2, 3, 'CNG', 'MANUAL', 4, 'KA01CD2002', 2023, 18000, 'AVAILABLE', DATE '2023-01-15');

INSERT INTO vehicles (vehicle_id, category_id, fuel_type, transmission_type, seating_capacity, vehicle_number, manufacturing_year, odometer_reading, vehicle_status, registration_date)
VALUES (3, 2, 'ELECTRIC', 'AUTOMATIC', 3, 'KA01EF3003', 2024, 8000, 'AVAILABLE', DATE '2024-01-20');

INSERT INTO vehicles (vehicle_id, category_id, fuel_type, transmission_type, seating_capacity, vehicle_number, manufacturing_year, odometer_reading, vehicle_status, registration_date)
VALUES (4, 4, 'DIESEL', 'AUTOMATIC', 4, 'KA04GH4004', 2022, 32000, 'AVAILABLE', DATE '2022-06-12');

INSERT INTO vehicles (vehicle_id, category_id, fuel_type, transmission_type, seating_capacity, vehicle_number, manufacturing_year, odometer_reading, vehicle_status, registration_date)
VALUES (5, 5, 'DIESEL', 'AUTOMATIC', 7, 'KA04IJ5005', 2023, 22000, 'AVAILABLE', DATE '2023-08-20');

INSERT INTO vehicles (vehicle_id, category_id, fuel_type, transmission_type, seating_capacity, vehicle_number, manufacturing_year, odometer_reading, vehicle_status, registration_date)
VALUES (6, 6, 'PETROL', 'AUTOMATIC', 2, 'KA05KL6006', 2024, 5000, 'AVAILABLE', DATE '2024-02-14');

INSERT INTO vehicles (vehicle_id, category_id, fuel_type, transmission_type, seating_capacity, vehicle_number, manufacturing_year, odometer_reading, vehicle_status, registration_date)
VALUES (7, 1, 'ELECTRIC', 'AUTOMATIC', 1, 'KA05MN7007', 2024, 3000, 'AVAILABLE', DATE '2024-03-01');

INSERT INTO vehicles (vehicle_id, category_id, fuel_type, transmission_type, seating_capacity, vehicle_number, manufacturing_year, odometer_reading, vehicle_status, registration_date)
VALUES (8, 5, 'HYBRID', 'AUTOMATIC', 7, 'KA01OP8008', 2024, 12000, 'AVAILABLE', DATE '2024-01-10');





INSERT INTO vehicle_documents (vehicle_id, document_type, document_number, issue_date, expiry_date, verification_status)
VALUES (1, 'RC', 'RC-KA01AB1001', DATE '2022-03-10', DATE '2037-03-09', 'VERIFIED');

INSERT INTO vehicle_documents (vehicle_id, document_type, document_number, issue_date, expiry_date, verification_status)
VALUES (1, 'INSURANCE', 'INS-990011', DATE '2024-01-01', DATE '2025-01-01', 'VERIFIED');

INSERT INTO vehicle_documents (vehicle_id, document_type, document_number, issue_date, expiry_date, verification_status)
VALUES (2, 'RC', 'RC-KA01CD2002', DATE '2023-01-15', DATE '2038-01-14', 'VERIFIED');

INSERT INTO vehicle_documents (vehicle_id, document_type, document_number, issue_date, expiry_date, verification_status)
VALUES (2, 'INSURANCE', 'INS-990022', DATE '2024-01-15', DATE '2025-01-15', 'VERIFIED');

INSERT INTO vehicle_documents (vehicle_id, document_type, document_number, issue_date, expiry_date, verification_status)
VALUES (3, 'RC', 'RC-KA01EF3003', DATE '2024-01-20', DATE '2039-01-19', 'VERIFIED');

INSERT INTO vehicle_documents (vehicle_id, document_type, document_number, issue_date, expiry_date, verification_status)
VALUES (4, 'RC', 'RC-KA04GH4004', DATE '2022-06-12', DATE '2037-06-11', 'VERIFIED');

INSERT INTO vehicle_documents (vehicle_id, document_type, document_number, issue_date, expiry_date, verification_status)
VALUES (4, 'INSURANCE', 'INS-990044', DATE '2024-02-01', DATE '2025-02-01', 'VERIFIED');

INSERT INTO vehicle_documents (vehicle_id, document_type, document_number, issue_date, expiry_date, verification_status)
VALUES (5, 'RC', 'RC-KA04IJ5005', DATE '2023-08-20', DATE '2038-08-19', 'VERIFIED');






INSERT INTO cab_category_rates (rate_id, category_id, base_fare, rate_per_km, waiting_per_minute, cancellation_fee, rate_status)
VALUES (1, 1, 200, 18, 80, 15, 'ACTIVE');

INSERT INTO cab_category_rates (rate_id, category_id, base_fare, rate_per_km, waiting_per_minute, cancellation_fee, rate_status)
VALUES (2, 2, 300, 50, 20, 100, 'ACTIVE');

INSERT INTO cab_category_rates (rate_id, category_id, base_fare, rate_per_km, waiting_per_minute, cancellation_fee, rate_status)
VALUES (3, 3, 500, 78, 20, 300, 'ACTIVE');

INSERT INTO cab_category_rates (rate_id, category_id, base_fare, rate_per_km, waiting_per_minute, cancellation_fee, rate_status)
VALUES (4, 4, 180, 18, 3, 150, 'ACTIVE');

INSERT INTO cab_category_rates (rate_id, category_id, base_fare, rate_per_km, waiting_per_minute, cancellation_fee, rate_status)
VALUES (5, 5, 200, 24, 4, 175, 'ACTIVE');

INSERT INTO cab_category_rates (rate_id, category_id, base_fare, rate_per_km, waiting_per_minute, cancellation_fee, rate_status)
VALUES (6, 6, 200, 35, 5, 100, 'ACTIVE');






INSERT INTO rental_rate_plans (rate_plan_id, category_id, daily_rate, weekly_rate, monthly_rate, security_deposit, included_km_per_day, extra_km_rate, late_fee_per_hour, rate_status)
VALUES (1, 4, 2500, 15000, 50000, 5000, 200, 12, 100, 'ACTIVE');

INSERT INTO rental_rate_plans (rate_plan_id, category_id, daily_rate, weekly_rate, monthly_rate, security_deposit, included_km_per_day, extra_km_rate, late_fee_per_hour, rate_status)
VALUES (2, 5, 4000, 24000, 80000, 10000, 250, 16, 150, 'ACTIVE');

INSERT INTO rental_rate_plans (rate_plan_id, category_id, daily_rate, weekly_rate, monthly_rate, security_deposit, included_km_per_day, extra_km_rate, late_fee_per_hour, rate_status)
VALUES (3, 6, 7500, 45000, 150000, 20000, 150, 25, 300, 'ACTIVE');

INSERT INTO rental_rate_plans (rate_plan_id, category_id, daily_rate, weekly_rate, monthly_rate, security_deposit, included_km_per_day, extra_km_rate, late_fee_per_hour, rate_status)
VALUES (4, 1, 800, 4800, 16000, 2000, 120, 6, 50, 'ACTIVE');






INSERT INTO driver_vehicle_assignments (driver_id, vehicle_id, assigned_from, assigned_to)
VALUES (1, 1, DATE '2024-01-16', NULL);

INSERT INTO driver_vehicle_assignments (driver_id, vehicle_id, assigned_from, assigned_to)
VALUES (2, 2, DATE '2024-01-21', NULL);

INSERT INTO driver_vehicle_assignments (driver_id, vehicle_id, assigned_from, assigned_to)
VALUES (3, 3, DATE '2024-02-02', NULL);






INSERT INTO ride_bookings (booking_id, user_id, category_id, driver_id, vehicle_id, assigned_from, pickup_address, drop_address, booking_time, ride_start_time, ride_end_time, estimated_distance, actual_distance, booking_status, cancellation_reason)
VALUES (101, 5, 4, 1, 1, DATE '2024-01-16', 'MG Road Metro Station', 'RMZ Infinity, Benniganahalli', TIMESTAMP '2024-03-25 09:00:00', TIMESTAMP '2024-03-25 09:10:00', TIMESTAMP '2024-03-25 09:45:00', 12, 13, 'COMPLETED', NULL);

INSERT INTO ride_bookings (booking_id, user_id, category_id, driver_id, vehicle_id, assigned_from, pickup_address, drop_address, booking_time, ride_start_time, ride_end_time, estimated_distance, actual_distance, booking_status, cancellation_reason)
VALUES (102, 6, 3, 2, 2, DATE '2024-01-21', 'Koramangala Sony World', 'Indiranagar 12th Main', TIMESTAMP '2024-03-25 10:15:00', TIMESTAMP '2024-03-25 10:25:00', TIMESTAMP '2024-03-25 10:55:00', 8, 8, 'COMPLETED', NULL);

INSERT INTO ride_bookings (booking_id, user_id, category_id, driver_id, vehicle_id, assigned_from, pickup_address, drop_address, booking_time, ride_start_time, ride_end_time, estimated_distance, actual_distance, booking_status, cancellation_reason)
VALUES (103, 7, 2, 3, 3, DATE '2024-02-02', 'HSR Layout BDA Complex', 'Electronic City Phase 1', TIMESTAMP '2024-03-25 11:30:00', TIMESTAMP '2024-03-25 11:40:00', NULL, 15, NULL, 'ACCEPTED', NULL);

INSERT INTO ride_bookings (booking_id, user_id, category_id, driver_id, vehicle_id, assigned_from, pickup_address, drop_address, booking_time, ride_start_time, ride_end_time, estimated_distance, actual_distance, booking_status, cancellation_reason)
VALUES (104, 8, 4, 1, 1, DATE '2024-01-16', 'Brigade Road', 'Hebbal Flyover', TIMESTAMP '2024-03-25 12:00:00', NULL, NULL, 14, NULL, 'CANCELLED', 'Driver took too long to arrive');

INSERT INTO ride_bookings (booking_id, user_id, category_id, driver_id, vehicle_id, assigned_from, pickup_address, drop_address, booking_time, ride_start_time, ride_end_time, estimated_distance, actual_distance, booking_status, cancellation_reason)
VALUES (105, 5, 3, NULL, NULL, NULL, 'Church Street', 'Malleshwaram 8th Cross', TIMESTAMP '2024-03-25 14:00:00', NULL, NULL, 7, NULL, 'REQUESTED', NULL);

INSERT INTO ride_bookings (booking_id, user_id, category_id, driver_id, vehicle_id, assigned_from, pickup_address, drop_address, booking_time, ride_start_time, ride_end_time, estimated_distance, actual_distance, booking_status, cancellation_reason)
VALUES (106, 6, 4, 1, 1, DATE '2024-01-16', 'Koramangala 4th Block', 'Whitefield ITPL', TIMESTAMP '2024-03-26 08:30:00', TIMESTAMP '2024-03-26 08:40:00', TIMESTAMP '2024-03-26 09:30:00', 18, 19, 'COMPLETED', NULL);





INSERT INTO fare_estimates (fare_estimate_id, booking_id, promo_id, base_fare, kilometer_charge, waiting_charge, toll_charge, tax_amount, calculated_at)
VALUES (1, 101, 1, 80, 234, 15, 0, 15, TIMESTAMP '2024-03-25 09:00:00');

INSERT INTO fare_estimates (fare_estimate_id, booking_id, promo_id, base_fare, kilometer_charge, waiting_charge, toll_charge, tax_amount, calculated_at)
VALUES (2, 102, NULL, 50, 120, 0, 0, 9, TIMESTAMP '2024-03-25 10:15:00');

INSERT INTO fare_estimates (fare_estimate_id, booking_id, promo_id, base_fare, kilometer_charge, waiting_charge, toll_charge, tax_amount, calculated_at)
VALUES (3, 103, 2, 30, 180, 10, 0, 11, TIMESTAMP '2024-03-25 11:30:00');

INSERT INTO fare_estimates (fare_estimate_id, booking_id, promo_id, base_fare, kilometer_charge, waiting_charge, toll_charge, tax_amount, calculated_at)
VALUES (4, 104, NULL, 80, 252, 0, 0, 17, TIMESTAMP '2024-03-25 12:00:00');

INSERT INTO fare_estimates (fare_estimate_id, booking_id, promo_id, base_fare, kilometer_charge, waiting_charge, toll_charge, tax_amount, calculated_at)
VALUES (5, 106, 4, 80, 342, 20, 0, 22, TIMESTAMP '2024-03-26 08:30:00');





INSERT INTO rental_bookings (rental_id, user_id, vehicle_id, rate_plan_id, pickup_location, return_location, pickup_date, expected_return_date, actual_return_date, booking_status, starting_odometer, ending_odometer, starting_fuel_level, ending_fuel_level)
VALUES (201, 5, 4, 1, 'Bangalore Airport', 'Bangalore Airport', TIMESTAMP '2024-03-20 10:00:00', TIMESTAMP '2024-03-23 10:00:00', TIMESTAMP '2024-03-23 09:30:00', 'COMPLETED', 32000, 32650, 10, 9);

INSERT INTO rental_bookings (rental_id, user_id, vehicle_id, rate_plan_id, pickup_location, return_location, pickup_date, expected_return_date, actual_return_date, booking_status, starting_odometer, ending_odometer, starting_fuel_level, ending_fuel_level)
VALUES (202, 6, 5, 2, 'Indiranagar Hub', 'Indiranagar Hub', TIMESTAMP '2024-03-24 09:00:00', TIMESTAMP '2024-03-27 18:00:00', NULL, 'ACTIVE', 22000, NULL, 10, NULL);

INSERT INTO rental_bookings (rental_id, user_id, vehicle_id, rate_plan_id, pickup_location, return_location, pickup_date, expected_return_date, actual_return_date, booking_status, starting_odometer, ending_odometer, starting_fuel_level, ending_fuel_level)
VALUES (203, 7, 6, 3, 'Koramangala Hub', 'Koramangala Hub', TIMESTAMP '2024-03-28 10:00:00', TIMESTAMP '2024-03-30 18:00:00', NULL, 'RESERVED', 5000, NULL, 10, NULL);

INSERT INTO rental_bookings (rental_id, user_id, vehicle_id, rate_plan_id, pickup_location, return_location, pickup_date, expected_return_date, actual_return_date, booking_status, starting_odometer, ending_odometer, starting_fuel_level, ending_fuel_level)
VALUES (204, 8, 7, 4, 'HSR Hub', 'HSR Hub', TIMESTAMP '2024-03-21 08:00:00', TIMESTAMP '2024-03-22 20:00:00', TIMESTAMP '2024-03-22 21:30:00', 'COMPLETED', 3000, 3180, 8, 7);




INSERT INTO rental_agreements (agreement_id, rental_id, agreement_number, agreement_date, terms_accepted, agreement_status)
VALUES (1, 201, 'AGR-20240320-001', DATE '2024-03-20', 'Y', 'CLOSED');

INSERT INTO rental_agreements (agreement_id, rental_id, agreement_number, agreement_date, terms_accepted, agreement_status)
VALUES (2, 202, 'AGR-20240324-002', DATE '2024-03-24', 'Y', 'ACTIVE');

INSERT INTO rental_agreements (agreement_id, rental_id, agreement_number, agreement_date, terms_accepted, agreement_status)
VALUES (3, 203, 'AGR-20240328-003', DATE '2024-03-28', 'Y', 'ACTIVE');

INSERT INTO rental_agreements (agreement_id, rental_id, agreement_number, agreement_date, terms_accepted, agreement_status)
VALUES (4, 204, 'AGR-20240321-004', DATE '2024-03-21', 'Y', 'CLOSED');






INSERT INTO rental_inspections (inspection_id, rental_id, inspection_type, inspection_date, odometer_reading, fuel_level, exterior_condition, interior_condition, damage_found, inspection_status, inspector_notes)
VALUES (1, 201, 'PRE_RENTAL', TIMESTAMP '2024-03-20 09:45:00', 32000, 10, 'Clean, no dents', 'Clean, intact', 'N', 'COMPLETED', 'Pre-rental check clear');

INSERT INTO rental_inspections (inspection_id, rental_id, inspection_type, inspection_date, odometer_reading, fuel_level, exterior_condition, interior_condition, damage_found, inspection_status, inspector_notes)
VALUES (2, 201, 'POST_RENTAL', TIMESTAMP '2024-03-23 09:35:00', 32650, 9, 'Good, dusty', 'Clean', 'N', 'COMPLETED', 'Returned in good shape');

INSERT INTO rental_inspections (inspection_id, rental_id, inspection_type, inspection_date, odometer_reading, fuel_level, exterior_condition, interior_condition, damage_found, inspection_status, inspector_notes)
VALUES (3, 204, 'PRE_RENTAL', TIMESTAMP '2024-03-21 07:50:00', 3000, 8, 'Clean', 'Clean', 'N', 'COMPLETED', 'Vehicle handed over');

INSERT INTO rental_inspections (inspection_id, rental_id, inspection_type, inspection_date, odometer_reading, fuel_level, exterior_condition, interior_condition, damage_found, inspection_status, inspector_notes)
VALUES (4, 204, 'POST_RENTAL', TIMESTAMP '2024-03-22 21:40:00', 3180, 7, 'Minor scratch on left mirror', 'Clean', 'Y', 'FLAGGED', 'Left mirror housing scratched');





INSERT INTO rental_damages (damage_id, inspection_id, damage_description, severity, repair_estimate, deductible_amount, damage_status)
VALUES (1, 4, 'Left mirror scratch', 'MINOR', 1500, 500, 'BILLED');





INSERT INTO rental_bills (rental_bill_id, rental_id, promo_id, damage_id, base_rental_charge, extra_km_charge, late_fee, damage_charge, tax_amount, bill_date)
VALUES (1, 201, 3, NULL, 7500, 600, 0, 0, 400, TIMESTAMP '2024-03-23 10:00:00');

INSERT INTO rental_bills (rental_bill_id, rental_id, promo_id, damage_id, base_rental_charge, extra_km_charge, late_fee, damage_charge, tax_amount, bill_date)
VALUES (2, 204, NULL, 1, 1600, 0, 100, 500, 110, TIMESTAMP '2024-03-22 22:00:00');




INSERT INTO payments (payment_id, booking_id, rental_id, user_id, transaction_reference, payment_method, amount, payment_type, payment_status, payment_time)
VALUES (1, 101, NULL, 5, 'TXN-UPI-20240325-101', 'UPI', 294, 'RIDE', 'SUCCESS', TIMESTAMP '2024-03-25 09:46:00');

INSERT INTO payments (payment_id, booking_id, rental_id, user_id, transaction_reference, payment_method, amount, payment_type, payment_status, payment_time)
VALUES (2, 102, NULL, 6, 'TXN-CARD-20240325-102', 'CARD', 179, 'RIDE', 'SUCCESS', TIMESTAMP '2024-03-25 10:56:00');

INSERT INTO payments (payment_id, booking_id, rental_id, user_id, transaction_reference, payment_method, amount, payment_type, payment_status, payment_time)
VALUES (3, NULL, 201, 5, 'TXN-NET-20240320-201D', 'NETBANKING', 5000, 'DEPOSIT', 'SUCCESS', TIMESTAMP '2024-03-20 09:50:00');

INSERT INTO payments (payment_id, booking_id, rental_id, user_id, transaction_reference, payment_method, amount, payment_type, payment_status, payment_time)
VALUES (4, NULL, 201, 5, 'TXN-UPI-20240323-201B', 'UPI', 8400, 'RENTAL', 'SUCCESS', TIMESTAMP '2024-03-23 10:05:00');

INSERT INTO payments (payment_id, booking_id, rental_id, user_id, transaction_reference, payment_method, amount, payment_type, payment_status, payment_time)
VALUES (5, NULL, 204, 8, 'TXN-CARD-20240322-204B', 'CARD', 2310, 'RENTAL', 'SUCCESS', TIMESTAMP '2024-03-22 22:05:00');




INSERT INTO refunds (refund_id, payment_id, refund_amount, refund_reason, refund_status, refund_date)
VALUES (1, 2, 179, 'Customer complained of detour route', 'PROCESSED', TIMESTAMP '2024-03-25 14:00:00');





INSERT INTO ratings (booking_id, driver_rating, vehicle_rating, review_text, rating_date)
VALUES (101, 5, 5, 'Smooth driving and very clean car', TIMESTAMP '2024-03-25 10:00:00');

INSERT INTO ratings (booking_id, driver_rating, vehicle_rating, review_text, rating_date)
VALUES (102, 4, 4, 'Good ride though slight delay', TIMESTAMP '2024-03-25 11:10:00');

INSERT INTO ratings (booking_id, driver_rating, vehicle_rating, review_text, rating_date)
VALUES (106, 5, 4, 'Polite driver, on time', TIMESTAMP '2024-03-26 10:00:00');




INSERT INTO complaints (complaint_id, booking_id, complaint_type, complaint_description, complaint_status, created_at, resolved_at, resolution_notes)
VALUES (1, 102, 'ROUTE', 'Driver took longer route', 'RESOLVED', TIMESTAMP '2024-03-25 11:30:00', TIMESTAMP '2024-03-25 13:55:00', 'Full refund issued');

INSERT INTO complaints (complaint_id, booking_id, complaint_type, complaint_description, complaint_status, created_at, resolved_at, resolution_notes)
VALUES (2, 104, 'DELAY', 'Cab arrived 25 mins late', 'RESOLVED', TIMESTAMP '2024-03-25 12:10:00', TIMESTAMP '2024-03-25 12:40:00', 'Apology and discount promo');




INSERT INTO vehicle_maintenance (maintenance_id, vehicle_id, maintenance_type_id, service_date, next_service_date, odometer_at_service, next_service_odometer, service_provider, maintenance_status, service_notes)
VALUES (1, 1, 1, DATE '2024-01-10', DATE '2024-07-10', 20000, 30000, 'Bosch Service Centre', 'COMPLETED', 'Regular 20k service');

INSERT INTO vehicle_maintenance (maintenance_id, vehicle_id, maintenance_type_id, service_date, next_service_date, odometer_at_service, next_service_odometer, service_provider, maintenance_status, service_notes)
VALUES (2, 4, 2, DATE '2024-02-15', DATE '2024-08-15', 30000, 45000, 'Bridgestone Care', 'COMPLETED', 'Tire rotation & balance');

INSERT INTO vehicle_maintenance (maintenance_id, vehicle_id, maintenance_type_id, service_date, next_service_date, odometer_at_service, next_service_odometer, service_provider, maintenance_status, service_notes)
VALUES (3, 5, 3, DATE '2024-03-01', DATE '2024-09-01', 21000, 41000, 'Toyota Express Care', 'COMPLETED', 'Brake pads replaced');

INSERT INTO vehicle_maintenance (maintenance_id, vehicle_id, maintenance_type_id, service_date, next_service_date, odometer_at_service, next_service_odometer, service_provider, maintenance_status, service_notes)
VALUES (4, 3, 4, DATE '2024-03-10', DATE '2025-03-10', 7500, 32500, 'Ather EV Care', 'COMPLETED', 'Battery health 98 percent');





INSERT INTO eco_impact_records (eco_record_id, booking_id, rental_id, distance_km, baseline_co2_kg, actual_co2_kg, calculation_method, recorded_at)
VALUES (1, 102, NULL, 8, 3, 2, 'CNG', TIMESTAMP '2024-03-25 10:55:00');

INSERT INTO eco_impact_records (eco_record_id, booking_id, rental_id, distance_km, baseline_co2_kg, actual_co2_kg, calculation_method, recorded_at)
VALUES (2, 103, NULL, 15, 5, 1, 'ELECTRIC', TIMESTAMP '2024-03-25 11:45:00');

INSERT INTO eco_impact_records (eco_record_id, booking_id, rental_id, distance_km, baseline_co2_kg, actual_co2_kg, calculation_method, recorded_at)
VALUES (3, NULL, 204, 180, 25, 5, 'ELECTRIC', TIMESTAMP '2024-03-22 21:30:00');





INSERT INTO lost_found_items (item_id, booking_id, rental_id, item_name, item_description, reported_date, item_status, admin_id, resolution_date, remarks)
VALUES (1, 101, NULL, 'Sunglasses', 'Ray-Ban black aviator case', TIMESTAMP '2024-03-25 10:30:00', 'RETURNED', 3, TIMESTAMP '2024-03-25 16:00:00', 'Returned to user at hub');

INSERT INTO lost_found_items (item_id, booking_id, rental_id, item_name, item_description, reported_date, item_status, admin_id, resolution_date, remarks)
VALUES (2, NULL, 201, 'Water Bottle', 'HydroFlask blue 1L', TIMESTAMP '2024-03-23 11:00:00', 'FOUND', 2, NULL, 'Kept safely at airport counter');




INSERT INTO rental_extension_requests (extension_request_id, rental_id, requested_return_date, request_reason, request_status, requested_at, reviewed_by_admin, reviewed_at, decision_notes)
VALUES (1, 202, DATE '2024-03-29', 'Need vehicle for 2 more days for family trip', 'APPROVED', TIMESTAMP '2024-03-26 10:00:00', 4, TIMESTAMP '2024-03-26 10:30:00', 'Extension approved. Rates standard.');

INSERT INTO rental_extension_requests (extension_request_id, rental_id, requested_return_date, request_reason, request_status, requested_at, reviewed_by_admin, reviewed_at, decision_notes)
VALUES (2, 203, DATE '2024-03-31', 'Extending weekend holiday', 'PENDING', TIMESTAMP '2024-03-27 14:00:00', NULL, NULL, NULL);




INSERT INTO vehicle_incidents (incident_id, booking_id, rental_id, reported_by, incident_type, incident_location, severity, injuries_reported, estimated_loss, incident_status, handled_by_admin, reported_at, resolved_at)
VALUES (1, 101, NULL, 5, 'OTHER', 'RMZ Infinity Gate 2', 'MINOR', 'N', 0, 'RESOLVED', 2, TIMESTAMP '2024-03-25 09:50:00', TIMESTAMP '2024-03-25 11:00:00');

INSERT INTO vehicle_incidents (incident_id, booking_id, rental_id, reported_by, incident_type, incident_location, severity, injuries_reported, estimated_loss, incident_status, handled_by_admin, reported_at, resolved_at)
VALUES (2, NULL, 204, 8, 'ACCIDENT', 'Outer Ring Road, Bellandur', 'MINOR', 'N', 1500, 'REPORTED', NULL, TIMESTAMP '2024-03-22 21:45:00', NULL);





-- 1. Populate driver_earnings (Fixes Query 1 and Query 13)
INSERT INTO driver_earnings (earning_id, booking_id, payout_id, gross_fare, commission_amount, earning_status)
VALUES (1, 101, NULL, 300, 50, 'PENDING');

INSERT INTO driver_earnings (earning_id, booking_id, payout_id, gross_fare, commission_amount, earning_status)
VALUES (2, 102, NULL, 170, 30, 'PENDING');

INSERT INTO driver_earnings (earning_id, booking_id, payout_id, gross_fare, commission_amount, earning_status)
VALUES (3, 106, NULL, 350, 50, 'PENDING');

-- 2. Insert exclusive cab riders who never rented (Fixes Query 6)
INSERT INTO users (user_id, first_name, last_name, email, phone, date_of_birth, gender, account_status, registration_date)
VALUES (9, 'Pooja', 'Hegde', 'pooja.h@gmail.com', 9845091111, DATE '1996-06-15', 'FEMALE', 'ACTIVE', DATE '2024-03-20');

INSERT INTO users (user_id, first_name, last_name, email, phone, date_of_birth, gender, account_status, registration_date)
VALUES (10, 'Kiran', 'Kumar', 'kiran.k@gmail.com', 9845092222, DATE '1994-09-10', 'MALE', 'ACTIVE', DATE '2024-03-22');

INSERT INTO ride_bookings (booking_id, user_id, category_id, driver_id, vehicle_id, assigned_from, pickup_address, drop_address, booking_time, ride_start_time, ride_end_time, estimated_distance, actual_distance, booking_status)
VALUES (107, 9, 3, 2, 2, DATE '2024-01-21', 'Jayanagar 4th Block', 'MG Road', TIMESTAMP '2024-03-27 10:00:00', TIMESTAMP '2024-03-27 10:10:00', TIMESTAMP '2024-03-27 10:45:00', 9, 9, 'COMPLETED');

INSERT INTO ride_bookings (booking_id, user_id, category_id, driver_id, vehicle_id, assigned_from, pickup_address, drop_address, booking_time, ride_start_time, ride_end_time, estimated_distance, actual_distance, booking_status)
VALUES (108, 10, 4, 1, 1, DATE '2024-01-16', 'Kalyan Nagar', 'Indiranagar', TIMESTAMP '2024-03-27 11:00:00', TIMESTAMP '2024-03-27 11:15:00', TIMESTAMP '2024-03-27 11:55:00', 11, 12, 'COMPLETED');

-- 3. Activate clean drivers with zero complaints (Fixes Query 15)
UPDATE drivers 
   SET driver_status = 'ACTIVE', average_rating = 4.90, total_rides = 5 
 WHERE driver_id = 3;

UPDATE drivers 
   SET driver_status = 'ACTIVE', average_rating = 4.75, total_rides = 3 
 WHERE driver_id = 4;

COMMIT;
