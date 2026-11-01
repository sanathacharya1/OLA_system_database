
CREATE TABLE users (
    user_id            NUMBER(5),
    first_name         VARCHAR2(20) NOT NULL,
    last_name          VARCHAR2(15),
    email              VARCHAR2(30) NOT NULL,
    phone              NUMBER(10) NOT NULL,
    date_of_birth      DATE,
    gender             VARCHAR2(10) NOT NULL,
    account_status     VARCHAR2(20) DEFAULT 'ACTIVE' NOT NULL,
    registration_date  DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT pk_users PRIMARY KEY (user_id),
    CONSTRAINT uq_users_email UNIQUE (email),
    CONSTRAINT uq_users_phone UNIQUE (phone),
    CONSTRAINT len_chk CHECK (REGEXP_LIKE(phone, '^[0-9]{10}$')),
    CONSTRAINT email_check CHECK (email LIKE '%@%'),
    CONSTRAINT ck_users_gender CHECK (gender IN ('MALE','FEMALE','OTHER')),
    CONSTRAINT ck_users_status CHECK (account_status IN ('ACTIVE','BLOCKED','INACTIVE'))
);
 

CREATE TABLE pincodes (
    pincode VARCHAR2(10),
    city    VARCHAR2(60) NOT NULL,
    state   VARCHAR2(60) NOT NULL,
    CONSTRAINT pk_pincodes PRIMARY KEY (pincode)
);
 

CREATE TABLE user_addresses (
    address_id    NUMBER(5),
    user_id       NUMBER(5) NOT NULL,
    address_type  VARCHAR2(20) DEFAULT 'OTHER' NOT NULL,
    address_line  VARCHAR2(25) NOT NULL,
    pincode       VARCHAR2(10) NOT NULL,
    CONSTRAINT pk_user_addresses PRIMARY KEY (address_id),
    CONSTRAINT fk_address_user FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT fk_address_pincode FOREIGN KEY (pincode) REFERENCES pincodes(pincode),
    CONSTRAINT ck_address_type CHECK (address_type IN ('HOME','WORK','OTHER'))
);
 


CREATE TABLE emergency_contacts (
    user_id       NUMBER(5),
    contact_name  VARCHAR2(30) NOT NULL,
    relationship  VARCHAR2(20),
    phone         VARCHAR2(15),
    CONSTRAINT pk_emergency_contacts PRIMARY KEY (user_id, phone),
    CONSTRAINT fk_emergency_user FOREIGN KEY (user_id) REFERENCES users(user_id)
);
 

CREATE TABLE administrators (
    admin_id      NUMBER(5),
    admin_name    VARCHAR2(30) NOT NULL,
    email         VARCHAR2(30) NOT NULL,
    role          VARCHAR2(30) NOT NULL,
    admin_status  VARCHAR2(15) DEFAULT 'ACTIVE' NOT NULL,
    created_at    DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT pk_administrators PRIMARY KEY (admin_id),
    CONSTRAINT uq_admin_email UNIQUE (email),
    CONSTRAINT uq_admin_role UNIQUE (role),
    CONSTRAINT email_pattern CHECK (email LIKE '%@%'),
    CONSTRAINT ck_admin_role CHECK (role IN ('SUPER_ADMIN','OPERATIONS','SUPPORT','VEHICLE_MANAGER')),
    CONSTRAINT ck_admin_status CHECK (admin_status IN ('ACTIVE','INACTIVE'))
);
 

CREATE TABLE drivers (
    driver_id           NUMBER(5),
    user_id             NUMBER(5) NOT NULL,
    date_joined         DATE DEFAULT SYSDATE NOT NULL,
    driver_status       VARCHAR2(25) DEFAULT 'PENDING' NOT NULL,
    identity_verified   CHAR(1) DEFAULT 'N' NOT NULL,
    background_verified CHAR(1) DEFAULT 'N' NOT NULL,
    average_rating      NUMBER(3,2) DEFAULT 0 NOT NULL,
    total_rides         NUMBER(10) DEFAULT 0 NOT NULL,
    CONSTRAINT pk_drivers PRIMARY KEY (driver_id),
       CONSTRAINT uq_driver_user UNIQUE (user_id),
    CONSTRAINT fk_driver_user FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT ck_driver_status CHECK (driver_status IN ('PENDING','ACTIVE','INACTIVE','SUSPENDED')),
    CONSTRAINT ck_driver_identity CHECK (identity_verified IN ('Y','N')),
    CONSTRAINT ck_driver_background CHECK (background_verified IN ('Y','N')),
    CONSTRAINT ck_driver_rating CHECK (average_rating BETWEEN 0 AND 5),
    CONSTRAINT ck_driver_rides CHECK (total_rides >= 0)
);
 


CREATE TABLE driver_documents (
    driver_id           NUMBER(5) NOT NULL,
    document_type       VARCHAR2(20) NOT NULL,
    document_number     VARCHAR2(20) NOT NULL,
    issue_date          DATE NOT NULL,
    expiry_date         DATE NOT NULL,
    verification_status VARCHAR2(15) DEFAULT 'PENDING' NOT NULL,
    verified_date       DATE,
    CONSTRAINT pk_driver_documents PRIMARY KEY (driver_id, document_type),
    CONSTRAINT uq_driver_doc_number UNIQUE (document_type, document_number),
    CONSTRAINT fk_document_driver FOREIGN KEY (driver_id) REFERENCES drivers(driver_id),
    CONSTRAINT ck_driver_doc_type CHECK (document_type IN ('LICENSE','AADHAAR','PAN')),
    CONSTRAINT ck_driver_doc_status CHECK (verification_status IN ('PENDING','VERIFIED','REJECTED','EXPIRED')),
    CONSTRAINT ck_driver_doc_dates CHECK (expiry_date >= issue_date),
    CONSTRAINT ck_driver_verified_dates CHECK (verified_date >= issue_date)
);
 


CREATE TABLE driver_availability (
    availability_id     NUMBER(5),
    driver_id           NUMBER(5) NOT NULL,
    start_time          TIMESTAMP NOT NULL,
    end_time            TIMESTAMP NOT NULL,
    availability_status VARCHAR2(15) DEFAULT 'AVAILABLE' NOT NULL,
    availability_date   DATE GENERATED ALWAYS AS (TRUNC(start_time)) VIRTUAL,
    CONSTRAINT pk_driver_availability PRIMARY KEY (availability_id),
    CONSTRAINT fk_availability_driver FOREIGN KEY (driver_id) REFERENCES drivers(driver_id),
    CONSTRAINT ck_availability_status CHECK (availability_status IN ('AVAILABLE','OFFLINE','ON_RIDE','ON_BREAK','SUSPENDED')),
    CONSTRAINT ck_availability_times CHECK (end_time > start_time)
);
 


CREATE TABLE cab_categories (
    category_id      NUMBER(5),
    category_name    VARCHAR2(30) NOT NULL,
    description      VARCHAR2(200),
    minimum_seats    NUMBER(2) NOT NULL,
    maximum_seats    NUMBER(2) NOT NULL,
    luggage_capacity NUMBER(5) NOT NULL,
    category_status  VARCHAR2(15) DEFAULT 'ACTIVE' NOT NULL,
    CONSTRAINT pk_cab_categories PRIMARY KEY (category_id),
    CONSTRAINT uq_category_name UNIQUE (category_name),
    CONSTRAINT ck_category_name CHECK (category_name IN ('BIKE','AUTO','SEDAN','SUV','COUPE','MINI')),
    CONSTRAINT ck_category_seats CHECK (minimum_seats > 0 AND maximum_seats >= minimum_seats),
    CONSTRAINT ck_category_luggage CHECK (luggage_capacity >= 0),
    CONSTRAINT ck_category_status CHECK (category_status IN ('ACTIVE','INACTIVE'))
);
 


CREATE TABLE vehicles (
    vehicle_id          NUMBER(5),
    category_id         NUMBER(5) NOT NULL,
    fuel_type           VARCHAR2(20) NOT NULL,
    transmission_type   VARCHAR2(20) NOT NULL,
    seating_capacity    NUMBER(2) NOT NULL,
    vehicle_number      VARCHAR2(20) NOT NULL,
    manufacturing_year  NUMBER(4) NOT NULL,
    odometer_reading    NUMBER(10) DEFAULT 0 NOT NULL,
    vehicle_status      VARCHAR2(25) DEFAULT 'AVAILABLE' NOT NULL,
    registration_date   DATE,
    CONSTRAINT pk_vehicles PRIMARY KEY (vehicle_id),
    CONSTRAINT uq_vehicle_registration UNIQUE (vehicle_number),
    CONSTRAINT fk_vehicle_category FOREIGN KEY (category_id) REFERENCES cab_categories(category_id),
    CONSTRAINT ck_vehicle_fuel CHECK (fuel_type IN ('PETROL','DIESEL','CNG','ELECTRIC','HYBRID')),
    CONSTRAINT ck_vehicle_transmission CHECK (transmission_type IN ('MANUAL','AUTOMATIC')),
    CONSTRAINT ck_vehicle_seats CHECK (seating_capacity BETWEEN 1 AND 10),
    CONSTRAINT ck_vehicle_status CHECK (vehicle_status IN ('AVAILABLE','BOOKED','ON_RIDE','RENTED','IN_SERVICE','IN_INSPECTION','INACTIVE')),
    CONSTRAINT ck_vehicle_year CHECK (manufacturing_year BETWEEN 2000 AND 2026),
    CONSTRAINT ck_vehicle_odometer CHECK (odometer_reading >= 0)
);
 


CREATE TABLE vehicle_documents (
    vehicle_id           NUMBER(5) NOT NULL,
    document_type        VARCHAR2(30) NOT NULL,
    document_number      VARCHAR2(30) NOT NULL,
    issue_date           DATE NOT NULL,
    expiry_date          DATE NOT NULL,
    verification_status  VARCHAR2(20) DEFAULT 'PENDING' NOT NULL,
    CONSTRAINT pk_vehicle_documents PRIMARY KEY (vehicle_id, document_type),
   CONSTRAINT uq_vehicle_type_num UNIQUE (document_type, document_number),
    CONSTRAINT fk_vehicle_document_vehicle FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
    CONSTRAINT ck_vehicle_doc_type CHECK (document_type IN ('RC','INSURANCE')),
    CONSTRAINT ck_vehicle_doc_status CHECK (verification_status IN ('PENDING','VERIFIED','EXPIRED','REJECTED')),
    CONSTRAINT ck_vehicle_doc_dates CHECK (expiry_date > issue_date)
);
 


CREATE TABLE cab_category_rates (
    rate_id            NUMBER(5),
    category_id        NUMBER(5) NOT NULL,
    base_fare          NUMBER(10) NOT NULL,
    rate_per_km        NUMBER(10) NOT NULL,
    waiting_per_minute NUMBER(10) DEFAULT 0 NOT NULL,
    cancellation_fee   NUMBER(10) DEFAULT 0 NOT NULL,
    rate_status        VARCHAR2(15) DEFAULT 'ACTIVE' NOT NULL,
    CONSTRAINT pk_category_rates PRIMARY KEY (rate_id),
    CONSTRAINT fk_rate_category FOREIGN KEY (category_id) REFERENCES cab_categories(category_id),
    CONSTRAINT ck_rate_values CHECK (base_fare >= 0 AND rate_per_km >= 0 AND waiting_per_minute >= 0 AND cancellation_fee >= 0),
    CONSTRAINT ck_rate_status CHECK (rate_status IN ('ACTIVE','INACTIVE'))
);
 


CREATE TABLE driver_vehicle_assignments (
    driver_id      NUMBER(5) NOT NULL,
    vehicle_id     NUMBER(5) NOT NULL,
    assigned_from  DATE DEFAULT SYSDATE NOT NULL,
    assigned_to    DATE,                          -- NULL = still assigned
    CONSTRAINT pk_dva PRIMARY KEY (driver_id, vehicle_id, assigned_from),
    CONSTRAINT fk_dva_driver  FOREIGN KEY (driver_id)  REFERENCES drivers(driver_id),
    CONSTRAINT fk_dva_vehicle FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
    CONSTRAINT ck_dva_dates CHECK (assigned_to IS NULL OR assigned_to >= assigned_from)
);
 



CREATE TABLE ride_bookings (
    booking_id          NUMBER(5),
    user_id             NUMBER(5) NOT NULL,
    category_id         NUMBER(5) NOT NULL,
    driver_id           NUMBER(5),
    vehicle_id          NUMBER(5),
    assigned_from       DATE,
    pickup_address      VARCHAR2(50) NOT NULL,
    drop_address        VARCHAR2(50) NOT NULL,
    booking_time        TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    ride_start_time     TIMESTAMP,
    ride_end_time       TIMESTAMP,
    estimated_distance  NUMBER(10),
    actual_distance     NUMBER(10),
    booking_status      VARCHAR2(25) DEFAULT 'REQUESTED' NOT NULL,
    cancellation_reason VARCHAR2(50),
    CONSTRAINT pk_ride_bookings PRIMARY KEY (booking_id),
    CONSTRAINT fk_booking_user FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT fk_booking_category FOREIGN KEY (category_id) REFERENCES cab_categories(category_id),
    CONSTRAINT fk_booking_assignment FOREIGN KEY (driver_id, vehicle_id, assigned_from)
        REFERENCES driver_vehicle_assignments (driver_id, vehicle_id, assigned_from),
    CONSTRAINT ck_booking_status CHECK (booking_status IN ('REQUESTED','ACCEPTED','COMPLETED','CANCELLED')),
    CONSTRAINT ck_booking_distance CHECK ((estimated_distance IS NULL OR estimated_distance >= 0) AND (actual_distance IS NULL OR actual_distance >= 0)),
    CONSTRAINT ck_booking_times CHECK (ride_end_time IS NULL OR ride_start_time IS NULL OR ride_end_time > ride_start_time),
    CONSTRAINT ck_booking_assignment CHECK (
        (driver_id IS NULL AND vehicle_id IS NULL AND assigned_from IS NULL)
        OR
        (driver_id IS NOT NULL AND vehicle_id IS NOT NULL AND assigned_from IS NOT NULL))
);
 


CREATE TABLE ride_status_history (
    status_history_id NUMBER(5),
    booking_id        NUMBER(5) NOT NULL,
    old_status        VARCHAR2(25),
    new_status        VARCHAR2(25) NOT NULL,
    changed_at        TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    changed_by        VARCHAR2(50),
    remarks           VARCHAR2(250),
    CONSTRAINT pk_ride_status_history PRIMARY KEY (status_history_id),
    CONSTRAINT fk_status_booking FOREIGN KEY (booking_id) REFERENCES ride_bookings(booking_id)
);
 


CREATE TABLE promo_codes (
    promo_id        NUMBER(5),
    promo_code      VARCHAR2(15) NOT NULL,
    description     VARCHAR2(20),
    discount_type   VARCHAR2(15) NOT NULL,
    discount_amount NUMBER(10) NOT NULL,
    valid_from      DATE NOT NULL,
    valid_to        DATE NOT NULL,
    promo_status    VARCHAR2(15) DEFAULT 'ACTIVE' NOT NULL,
    CONSTRAINT pk_promo_codes PRIMARY KEY (promo_id),
    CONSTRAINT uq_promo_code UNIQUE (promo_code),
    CONSTRAINT ck_discount_type CHECK (discount_type IN ('PERCENTAGE','FIXED')),
    CONSTRAINT ck_discount_value CHECK (discount_amount >= 0),
CONSTRAINT ck_promo_percentage CHECK (discount_type <> 'PERCENTAGE' OR discount_amount <= 100),
    CONSTRAINT ck_promo_status CHECK (promo_status IN ('ACTIVE','INACTIVE','EXPIRED')),
    CONSTRAINT ck_promo_dates CHECK (valid_to >= valid_from)
);
 



CREATE TABLE fare_estimates (
    fare_estimate_id NUMBER(5),
    booking_id       NUMBER(5) NOT NULL,
    promo_id         NUMBER(5),
    base_fare        NUMBER(10) DEFAULT 0 NOT NULL,
    kilometer_charge NUMBER(10) DEFAULT 0 NOT NULL,
    waiting_charge   NUMBER(10) DEFAULT 0 NOT NULL,
    toll_charge      NUMBER(10) DEFAULT 0 NOT NULL,
    discount_amount  NUMBER(10) DEFAULT 0 NOT NULL,
    tax_amount       NUMBER(10) DEFAULT 0 NOT NULL,
    estimated_total  NUMBER(10) GENERATED ALWAYS AS
        (base_fare + kilometer_charge + waiting_charge + toll_charge - discount_amount + tax_amount) VIRTUAL,
    calculated_at    TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT pk_fare_estimates PRIMARY KEY (fare_estimate_id),
    CONSTRAINT fk_fare_promo FOREIGN KEY (promo_id) REFERENCES promo_codes(promo_id),
    CONSTRAINT fk_fare_booking FOREIGN KEY (booking_id) REFERENCES ride_bookings(booking_id),
    CONSTRAINT uq_fare_booking UNIQUE (booking_id),
    CONSTRAINT ck_fare_amounts CHECK (base_fare >= 0 AND kilometer_charge >= 0 AND waiting_charge >= 0
                                      AND toll_charge >= 0 AND discount_amount >= 0 AND tax_amount >= 0),
    CONSTRAINT ck_fare_total CHECK (base_fare + kilometer_charge + waiting_charge + toll_charge
                                    - discount_amount + tax_amount >= 0),
    CONSTRAINT ck_fare_promo CHECK (
        (promo_id IS NOT NULL AND discount_amount > 0)
        OR
        (promo_id IS NULL AND discount_amount = 0))
);
 


CREATE TABLE rental_rate_plans (
    rate_plan_id        NUMBER(5),
    category_id         NUMBER(5) NOT NULL,
    daily_rate          NUMBER(10) NOT NULL,
    weekly_rate         NUMBER(10),
    monthly_rate        NUMBER(10),
    security_deposit    NUMBER(12) NOT NULL,
    included_km_per_day NUMBER(10) NOT NULL,
    extra_km_rate       NUMBER(10) NOT NULL,
    late_fee_per_hour   NUMBER(10) DEFAULT 0 NOT NULL,
    rate_status         VARCHAR2(15) DEFAULT 'ACTIVE' NOT NULL,
    CONSTRAINT pk_rental_rate_plans PRIMARY KEY (rate_plan_id),
    CONSTRAINT fk_rental_rate_category FOREIGN KEY (category_id) REFERENCES cab_categories(category_id),
    CONSTRAINT ck_rental_rates CHECK (daily_rate > 0 AND (weekly_rate IS NULL OR weekly_rate > 0)
                                      AND (monthly_rate IS NULL OR monthly_rate > 0) AND security_deposit > 1000
                                      AND included_km_per_day > 0 AND extra_km_rate > 0 AND late_fee_per_hour >= 0),
    CONSTRAINT ck_rental_rate_status CHECK (rate_status IN ('ACTIVE','INACTIVE'))
);
 


CREATE TABLE rental_bookings (
    rental_id            NUMBER(5),
    user_id              NUMBER(5) NOT NULL,
    vehicle_id           NUMBER(5) NOT NULL,
    rate_plan_id         NUMBER(5) NOT NULL,
    pickup_location      VARCHAR2(20) NOT NULL,
    return_location      VARCHAR2(20) NOT NULL,
    pickup_date          TIMESTAMP NOT NULL,
    expected_return_date TIMESTAMP NOT NULL,
    actual_return_date   TIMESTAMP,
    booking_status       VARCHAR2(25) DEFAULT 'RESERVED' NOT NULL,
    starting_odometer    NUMBER(10),
    ending_odometer      NUMBER(10),
    starting_fuel_level  NUMBER(5) NOT NULL,
    ending_fuel_level    NUMBER(5),
    CONSTRAINT pk_rental_bookings PRIMARY KEY (rental_id),
    CONSTRAINT fk_rental_user FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT fk_rental_vehicle FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
    CONSTRAINT fk_rental_rate_plan FOREIGN KEY (rate_plan_id) REFERENCES rental_rate_plans(rate_plan_id),
    CONSTRAINT ck_rental_status CHECK (booking_status IN ('RESERVED','ACTIVE','COMPLETED','CANCELLED','OVERDUE')),
    CONSTRAINT ck_rental_dates CHECK (expected_return_date > pickup_date
                                      AND (actual_return_date IS NULL OR actual_return_date >= pickup_date)),
    CONSTRAINT ck_rental_odometer CHECK (
        (starting_odometer IS NULL OR starting_odometer >= 0)
        AND (ending_odometer IS NULL OR ending_odometer >= 0)
        AND (starting_odometer IS NULL OR ending_odometer IS NULL OR ending_odometer > starting_odometer)),
    CONSTRAINT ck_rental_fuel CHECK ((starting_fuel_level BETWEEN 1 AND 10)
                                     AND (ending_fuel_level IS NULL OR ending_fuel_level BETWEEN 0 AND 10))
);
 


CREATE TABLE rental_agreements (
    agreement_id     NUMBER(5),
    rental_id        NUMBER(5) NOT NULL,
    agreement_number VARCHAR2(50) NOT NULL,
    agreement_date   DATE DEFAULT SYSDATE NOT NULL,
    terms_accepted   CHAR(1) DEFAULT 'N' NOT NULL,
    agreement_status VARCHAR2(20) DEFAULT 'ACTIVE' NOT NULL,
    CONSTRAINT pk_rental_agreements PRIMARY KEY (agreement_id),
    CONSTRAINT uq_agreement_number UNIQUE (agreement_number),
    CONSTRAINT uq_rental_agreement UNIQUE (rental_id),
    CONSTRAINT fk_agreement_rental FOREIGN KEY (rental_id) REFERENCES rental_bookings(rental_id),
    CONSTRAINT ck_terms_accepted CHECK (terms_accepted IN ('Y','N')),
    CONSTRAINT ck_agreement_status CHECK (agreement_status IN ('ACTIVE','CLOSED','CANCELLED'))
);
 


CREATE TABLE rental_inspections (
    inspection_id      NUMBER(5),
    rental_id          NUMBER(5) NOT NULL,
    inspection_type    VARCHAR2(15) NOT NULL,
    inspection_date    TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    odometer_reading   NUMBER(10) NOT NULL,
    fuel_level         NUMBER(5) NOT NULL,
    exterior_condition VARCHAR2(50),
    interior_condition VARCHAR2(50),
    damage_found       CHAR(1) DEFAULT 'N' NOT NULL,
    inspection_status  VARCHAR2(10) DEFAULT 'COMPLETED' NOT NULL,
    inspector_notes    VARCHAR2(50),
    CONSTRAINT pk_rental_inspections PRIMARY KEY (inspection_id),
    CONSTRAINT fk_inspection_rental FOREIGN KEY (rental_id) REFERENCES rental_bookings(rental_id),
    CONSTRAINT uq_inspection_per_type UNIQUE (rental_id, inspection_type),
    CONSTRAINT ck_inspection_type CHECK (inspection_type IN ('PRE_RENTAL','POST_RENTAL')),
    CONSTRAINT ck_inspection_odometer CHECK (odometer_reading > 0),
    CONSTRAINT ck_inspection_fuel CHECK (fuel_level BETWEEN 0 AND 10),
    CONSTRAINT ck_damage_found CHECK (damage_found IN ('Y','N')),
    CONSTRAINT ck_inspection_status CHECK (inspection_status IN ('PENDING','COMPLETED','FLAGGED'))
);
 


CREATE TABLE rental_damages (
    damage_id          NUMBER(5),
    inspection_id      NUMBER(5) NOT NULL,
    damage_description VARCHAR2(20) NOT NULL,
    severity           VARCHAR2(20) DEFAULT 'MODERATE' NOT NULL,
    repair_estimate    NUMBER(12) DEFAULT 0 NOT NULL,
    deductible_amount  NUMBER(12) DEFAULT 0 NOT NULL,
    damage_status      VARCHAR2(30) DEFAULT 'REPORTED' NOT NULL,
    CONSTRAINT pk_rental_damages PRIMARY KEY (damage_id),
    CONSTRAINT fk_damage_inspection FOREIGN KEY (inspection_id) REFERENCES rental_inspections(inspection_id),
    CONSTRAINT ck_damage_severity CHECK (severity IN ('MINOR','MODERATE','MAJOR','CRITICAL')),
    CONSTRAINT ck_damage_amount CHECK (repair_estimate >= 0 AND deductible_amount >= 0),
    CONSTRAINT ck_damage_status CHECK (damage_status IN ('REPORTED','CHECKED','BILLED','NO_CHARGE'))
);
 


CREATE TABLE rental_bills (
    rental_bill_id     NUMBER(5),
    rental_id          NUMBER(5) NOT NULL,
    promo_id           NUMBER(5),
    damage_id          NUMBER(5),
    base_rental_charge NUMBER(12) DEFAULT 0 NOT NULL,
    extra_km_charge    NUMBER(12) DEFAULT 0 NOT NULL,
    late_fee           NUMBER(12) DEFAULT 0 NOT NULL,
    damage_charge      NUMBER(12) DEFAULT 0 NOT NULL,
    tax_amount         NUMBER(12) DEFAULT 0 NOT NULL,
    discount_amount    NUMBER(12) DEFAULT 0 NOT NULL,
    total_amount       NUMBER(12) GENERATED ALWAYS AS
        (base_rental_charge + extra_km_charge + late_fee + damage_charge - discount_amount + tax_amount) VIRTUAL,
    bill_date          TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT pk_rental_bills PRIMARY KEY (rental_bill_id),
    CONSTRAINT uq_rental_bill UNIQUE (rental_id),
    CONSTRAINT fk_rental_bill_rental FOREIGN KEY (rental_id) REFERENCES rental_bookings(rental_id),
    CONSTRAINT fk_rental_bill_damage FOREIGN KEY (damage_id) REFERENCES rental_damages(damage_id),
    CONSTRAINT fk_rental_bill_promo FOREIGN KEY (promo_id) REFERENCES promo_codes(promo_id),
    CONSTRAINT ck_rental_bill_amounts CHECK (base_rental_charge >= 0 AND extra_km_charge >= 0 AND late_fee >= 0
                                             AND damage_charge >= 0 AND tax_amount >= 0 AND discount_amount >= 0),
    CONSTRAINT ck_rental_bill_total CHECK (base_rental_charge + extra_km_charge + late_fee + damage_charge
                                           - discount_amount + tax_amount >= 0),
    CONSTRAINT ck_rental_bill_promo CHECK (
        (promo_id IS NOT NULL AND discount_amount > 0)
        OR
        (promo_id IS NULL AND discount_amount = 0))
);
 


CREATE TABLE promo_usage (
    promo_id   NUMBER(5) NOT NULL,
    user_id    NUMBER(5) NOT NULL,
    used_at    TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT pk_promo_usage PRIMARY KEY (promo_id, user_id),
    CONSTRAINT fk_usage_promo FOREIGN KEY (promo_id) REFERENCES promo_codes(promo_id),
    CONSTRAINT fk_usage_user  FOREIGN KEY (user_id)  REFERENCES users(user_id)
);
 


CREATE TABLE payments (
    payment_id            NUMBER(5),
    booking_id            NUMBER(5),
    rental_id             NUMBER(5),
    user_id               NUMBER(5) NOT NULL,
    transaction_reference VARCHAR2(100),
    payment_method        VARCHAR2(20) NOT NULL,
    amount                NUMBER(12) NOT NULL,
    payment_type          VARCHAR2(20) NOT NULL,
    payment_status        VARCHAR2(20) DEFAULT 'PENDING' NOT NULL,
    payment_time          TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT pk_payments PRIMARY KEY (payment_id),
    CONSTRAINT fk_payment_user    FOREIGN KEY (user_id)    REFERENCES users(user_id),
    CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id) REFERENCES ride_bookings(booking_id),
    CONSTRAINT fk_payment_rental  FOREIGN KEY (rental_id)  REFERENCES rental_bookings(rental_id),
    CONSTRAINT ck_payment_reference CHECK (
        (booking_id IS NOT NULL AND rental_id IS NULL)
        OR
        (booking_id IS NULL AND rental_id IS NOT NULL)),
    CONSTRAINT ck_payment_type_ref CHECK (
        (payment_type = 'RIDE' AND booking_id IS NOT NULL)
        OR
        (payment_type IN ('RENTAL','DEPOSIT') AND rental_id IS NOT NULL)),
    CONSTRAINT ck_payment_method CHECK (payment_method IN ('UPI','CARD','NETBANKING','WALLET','CASH')),
    CONSTRAINT ck_payment_type CHECK (payment_type IN ('RIDE','RENTAL','DEPOSIT')),
    CONSTRAINT ck_payment_status CHECK (payment_status IN ('PENDING','SUCCESS','FAILED','REFUNDED')),
    CONSTRAINT ck_payment_amount CHECK (amount > 0)
);
 


CREATE TABLE refunds (
    refund_id     NUMBER(5),
    payment_id    NUMBER(5) NOT NULL,
    refund_amount NUMBER(12) NOT NULL,
    refund_reason VARCHAR2(50),
    refund_status VARCHAR2(20) DEFAULT 'PENDING' NOT NULL,
    refund_date   TIMESTAMP,
    CONSTRAINT pk_refunds PRIMARY KEY (refund_id),
    CONSTRAINT fk_refund_payment FOREIGN KEY (payment_id) REFERENCES payments(payment_id),
    CONSTRAINT ck_refund_amount CHECK (refund_amount >= 0),
    CONSTRAINT ck_refund_status CHECK (refund_status IN ('PENDING','PROCESSED','REJECTED'))
);
 


CREATE TABLE ratings (
    booking_id     NUMBER(5),
    driver_rating  NUMBER(2),
    vehicle_rating NUMBER(2),
    review_text    VARCHAR2(50),
    rating_date    TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT pk_ratings PRIMARY KEY (booking_id),
    CONSTRAINT fk_rating_booking FOREIGN KEY (booking_id) REFERENCES ride_bookings(booking_id),
    CONSTRAINT ck_driver_rating_value CHECK (driver_rating BETWEEN 1 AND 5),
    CONSTRAINT ck_vehicle_rating_value CHECK (vehicle_rating BETWEEN 1 AND 5)
);
 


CREATE TABLE complaints (
    complaint_id          NUMBER(5),
    booking_id            NUMBER(5) NOT NULL,
    complaint_type        VARCHAR2(20) NOT NULL,
    complaint_description VARCHAR2(30) NOT NULL,
    complaint_status      VARCHAR2(20) DEFAULT 'OPEN' NOT NULL,
    created_at            TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    resolved_at           TIMESTAMP,
    resolution_notes      VARCHAR2(30),
    CONSTRAINT pk_complaints PRIMARY KEY (complaint_id),
    CONSTRAINT fk_complaint_booking FOREIGN KEY (booking_id) REFERENCES ride_bookings(booking_id),
    CONSTRAINT ck_complaint_status CHECK (complaint_status IN ('OPEN','IN_PROGRESS','RESOLVED','REJECTED'))
);
 

CREATE TABLE maintenance_types (
    maintenance_type_id   NUMBER(5),
    type_name             VARCHAR2(20) NOT NULL,
    description           VARCHAR2(30),
    default_interval_km   NUMBER(10),
    default_interval_days NUMBER(6),
    CONSTRAINT pk_maintenance_types PRIMARY KEY (maintenance_type_id),
    CONSTRAINT uq_maintenance_type UNIQUE (type_name),
    CONSTRAINT ck_maintenance_interval_km CHECK (default_interval_km IS NULL OR default_interval_km > 0),
    CONSTRAINT ck_maintenance_interval_days CHECK (default_interval_days IS NULL OR default_interval_days > 0)
);
 


CREATE TABLE vehicle_maintenance (
    maintenance_id        NUMBER(5),
    vehicle_id            NUMBER(5) NOT NULL,
    maintenance_type_id   NUMBER(5) NOT NULL,
    service_date          DATE NOT NULL,
    next_service_date     DATE NOT NULL,
    odometer_at_service   NUMBER(10) NOT NULL,
    next_service_odometer NUMBER(10) NOT NULL,
    service_provider      VARCHAR2(20),
    maintenance_status    VARCHAR2(20) DEFAULT 'COMPLETED' NOT NULL,
    service_notes         VARCHAR2(30),
    CONSTRAINT pk_vehicle_maintenance PRIMARY KEY (maintenance_id),
    CONSTRAINT fk_maintenance_vehicle FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
    CONSTRAINT fk_maintenance_type FOREIGN KEY (maintenance_type_id) REFERENCES maintenance_types(maintenance_type_id),
    CONSTRAINT ck_maintenance_status CHECK (maintenance_status IN ('SCHEDULED','IN_PROGRESS','COMPLETED','NOT_DONE')),
    CONSTRAINT ck_maintenance_odometer CHECK ((odometer_at_service > 0) AND (next_service_odometer > odometer_at_service)),
    CONSTRAINT ck_maintenance_dates CHECK (next_service_date > service_date)
);



CREATE TABLE eco_impact_records (
    eco_record_id       NUMBER(5),
    booking_id          NUMBER(5),
    rental_id           NUMBER(5),
    distance_km         NUMBER(10) NOT NULL,
    baseline_co2_kg     NUMBER(10) NOT NULL,
    actual_co2_kg       NUMBER(10) NOT NULL,
    co2_saved_kg        NUMBER(10) GENERATED ALWAYS AS (baseline_co2_kg - actual_co2_kg) VIRTUAL,
    calculation_method  VARCHAR2(20) NOT NULL,
    recorded_at         TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT pk_eco_impact_records PRIMARY KEY (eco_record_id),
    CONSTRAINT fk_eco_booking FOREIGN KEY (booking_id) REFERENCES ride_bookings(booking_id),
    CONSTRAINT fk_eco_rental  FOREIGN KEY (rental_id)  REFERENCES rental_bookings(rental_id),
    CONSTRAINT ck_eco_reference CHECK (
        (booking_id IS NOT NULL AND rental_id IS NULL)
        OR
        (booking_id IS NULL AND rental_id IS NOT NULL)),
    CONSTRAINT ck_eco_distance CHECK (distance_km > 0),
    CONSTRAINT ck_eco_emissions CHECK (baseline_co2_kg > 0 AND actual_co2_kg > 0 AND baseline_co2_kg >= actual_co2_kg),
    CONSTRAINT ck_eco_method CHECK (calculation_method IN ('PETROL','DIESEL','CNG','ELECTRIC','HYBRID','MANUAL'))
);
 


CREATE TABLE lost_found_items (
    item_id          NUMBER(5),
    booking_id       NUMBER(5),
    rental_id        NUMBER(5),
    item_name        VARCHAR2(30) NOT NULL,
    item_description VARCHAR2(50),
    reported_date    TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    item_status      VARCHAR2(20) DEFAULT 'REPORTED' NOT NULL,
    admin_id         NUMBER(5),
    resolution_date  TIMESTAMP,
    remarks          VARCHAR2(50),
    CONSTRAINT pk_lost_found_items PRIMARY KEY (item_id),
    CONSTRAINT fk_lost_booking FOREIGN KEY (booking_id) REFERENCES ride_bookings(booking_id),
    CONSTRAINT fk_lost_rental  FOREIGN KEY (rental_id)  REFERENCES rental_bookings(rental_id),
    CONSTRAINT fk_lost_admin   FOREIGN KEY (admin_id)   REFERENCES administrators(admin_id),
    CONSTRAINT ck_lost_reference CHECK (
        (booking_id IS NOT NULL AND rental_id IS NULL)
        OR
        (booking_id IS NULL AND rental_id IS NOT NULL)),
    CONSTRAINT ck_lost_status CHECK (item_status IN ('REPORTED','FOUND','RETURNED','UNCLAIMED')),
    CONSTRAINT ck_lost_resolution CHECK (resolution_date IS NULL OR resolution_date >= reported_date)
);
 



CREATE TABLE rental_extension_requests (
    extension_request_id  NUMBER(5),
    rental_id             NUMBER(5) NOT NULL,
    requested_return_date DATE NOT NULL,
    request_reason        VARCHAR2(50),
    request_status        VARCHAR2(20) DEFAULT 'PENDING' NOT NULL,
    requested_at          TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    reviewed_by_admin     NUMBER(5),
    reviewed_at           TIMESTAMP,
    decision_notes        VARCHAR2(50),
    CONSTRAINT pk_rental_extension_requests PRIMARY KEY (extension_request_id),
    CONSTRAINT fk_extension_rental FOREIGN KEY (rental_id) REFERENCES rental_bookings(rental_id),
    CONSTRAINT fk_extension_admin  FOREIGN KEY (reviewed_by_admin) REFERENCES administrators(admin_id),
    CONSTRAINT ck_extension_status CHECK (request_status IN ('PENDING','APPROVED','REJECTED','CANCELLED')),
    CONSTRAINT ck_extension_review CHECK (
        (request_status = 'PENDING' AND reviewed_by_admin IS NULL AND reviewed_at IS NULL)
        OR
        (request_status <> 'PENDING' AND reviewed_by_admin IS NOT NULL AND reviewed_at IS NOT NULL))
);
 


CREATE TABLE admin_audit_log (
    audit_id         NUMBER(5),
    admin_id         NUMBER(5),
    table_name       VARCHAR2(50) NOT NULL,
    operation_type   VARCHAR2(20) NOT NULL,
    record_id        NUMBER(5),
    old_value        VARCHAR2(200),
    new_value        VARCHAR2(200),
    operation_time   TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT pk_admin_audit_log PRIMARY KEY (audit_id),
    CONSTRAINT fk_audit_admin FOREIGN KEY (admin_id) REFERENCES administrators(admin_id),
    CONSTRAINT ck_audit_operation CHECK (operation_type IN ('INSERT','UPDATE','DELETE'))
);
 



CREATE TABLE badges (
    badge_name     VARCHAR2(50),
    description    VARCHAR2(50),
    points_awarded NUMBER(6) DEFAULT 0 NOT NULL,
    CONSTRAINT pk_badges PRIMARY KEY (badge_name),
    CONSTRAINT ck_badges_points CHECK (points_awarded >= 0)
);
 

CREATE TABLE user_badges (
    user_id     NUMBER(5) NOT NULL,
    badge_name  VARCHAR2(50) NOT NULL,
    earned_date DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT pk_user_badges PRIMARY KEY (user_id, badge_name),
    CONSTRAINT fk_userbadge_user  FOREIGN KEY (user_id)    REFERENCES users(user_id),
    CONSTRAINT fk_userbadge_badge FOREIGN KEY (badge_name) REFERENCES badges(badge_name)
);
 


CREATE TABLE driver_wellness_logs (
    wellness_id     NUMBER(5),
    driver_id       NUMBER(5) NOT NULL,
    assessment_date TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    fatigue_level   NUMBER(1) NOT NULL,
    rest_required   CHAR(1) DEFAULT 'N' NOT NULL,
    remarks         VARCHAR2(50),
    CONSTRAINT pk_driver_wellness PRIMARY KEY (wellness_id),
    CONSTRAINT fk_wellness_driver FOREIGN KEY (driver_id) REFERENCES drivers(driver_id),
    CONSTRAINT ck_fatigue_level CHECK (fatigue_level BETWEEN 1 AND 5),
    CONSTRAINT ck_rest_required CHECK (rest_required IN ('Y','N'))
);
 


CREATE TABLE driver_payouts (
    payout_id             NUMBER(5),
    driver_id             NUMBER(5) NOT NULL,
    period_start          DATE NOT NULL,
    period_end            DATE NOT NULL,
    total_amount          NUMBER(10) NOT NULL,
    payout_method         VARCHAR2(20) NOT NULL,
    payout_status         VARCHAR2(15) DEFAULT 'PENDING' NOT NULL,
    payout_date           TIMESTAMP,
    transaction_reference VARCHAR2(50),
    processed_by_admin    NUMBER(5),
    CONSTRAINT pk_driver_payouts PRIMARY KEY (payout_id),
    CONSTRAINT fk_payout_driver FOREIGN KEY (driver_id) REFERENCES drivers(driver_id),
    CONSTRAINT fk_payout_admin  FOREIGN KEY (processed_by_admin) REFERENCES administrators(admin_id),
    CONSTRAINT ck_payout_period CHECK (period_end >= period_start),
    CONSTRAINT ck_payout_amount CHECK (total_amount >= 0),
    CONSTRAINT ck_payout_method CHECK (payout_method IN ('BANK_TRANSFER','UPI','CASH')),
    CONSTRAINT ck_payout_status CHECK (payout_status IN ('PENDING','PAID','FAILED')),
    CONSTRAINT ck_payout_paid CHECK (
        (payout_status = 'PAID' AND payout_date IS NOT NULL AND processed_by_admin IS NOT NULL)
        OR
        (payout_status <> 'PAID'))
);
 

 

CREATE TABLE driver_earnings (
    earning_id        NUMBER(5),
    booking_id        NUMBER(5) NOT NULL,
    payout_id         NUMBER(5),
    gross_fare        NUMBER(10) NOT NULL,
    commission_amount NUMBER(10) DEFAULT 0 NOT NULL,
    net_earning       NUMBER(10) GENERATED ALWAYS AS (gross_fare - commission_amount) VIRTUAL,
    earning_status    VARCHAR2(15) DEFAULT 'PENDING' NOT NULL,
    earned_at         TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT pk_driver_earnings PRIMARY KEY (earning_id),
    -- a ride earns the driver money only once
    CONSTRAINT uq_earning_booking UNIQUE (booking_id),
    CONSTRAINT fk_earning_booking FOREIGN KEY (booking_id) REFERENCES ride_bookings(booking_id),
    CONSTRAINT fk_earning_payout  FOREIGN KEY (payout_id)  REFERENCES driver_payouts(payout_id),
    CONSTRAINT ck_earning_amounts CHECK (gross_fare >= 0 AND commission_amount >= 0 AND commission_amount <= gross_fare),
    CONSTRAINT ck_earning_status CHECK (earning_status IN ('PENDING','PAID','CANCELLED')),
    -- PAID means it is included in a payout; PENDING / CANCELLED means it is not
    CONSTRAINT ck_earning_payout CHECK (
        (earning_status = 'PAID' AND payout_id IS NOT NULL)
        OR
        (earning_status <> 'PAID' AND payout_id IS NULL))
);
 

 

CREATE TABLE vehicle_incidents (
    incident_id          NUMBER(5),
    booking_id           NUMBER(5),
    rental_id            NUMBER(5),
    reported_by          NUMBER(5) NOT NULL,
    incident_type        VARCHAR2(20) NOT NULL,
    incident_location    VARCHAR2(50),
    severity             VARCHAR2(20) NOT NULL,
    injuries_reported    CHAR(1) DEFAULT 'N' NOT NULL,
    estimated_loss       NUMBER(10) DEFAULT 0 NOT NULL,
    incident_status      VARCHAR2(20) DEFAULT 'REPORTED' NOT NULL,
    handled_by_admin     NUMBER(5),
    reported_at          TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    resolved_at          TIMESTAMP,
    CONSTRAINT pk_vehicle_incidents PRIMARY KEY (incident_id),
    CONSTRAINT fk_incident_booking  FOREIGN KEY (booking_id) REFERENCES ride_bookings(booking_id),
    CONSTRAINT fk_incident_rental   FOREIGN KEY (rental_id)  REFERENCES rental_bookings(rental_id),
    CONSTRAINT fk_incident_reporter FOREIGN KEY (reported_by) REFERENCES users(user_id),
    CONSTRAINT fk_incident_admin    FOREIGN KEY (handled_by_admin) REFERENCES administrators(admin_id),
        CONSTRAINT ck_incident_reference CHECK (
        (booking_id IS NOT NULL AND rental_id IS NULL)
        OR
        (booking_id IS NULL AND rental_id IS NOT NULL)),
    CONSTRAINT ck_incident_type CHECK (incident_type IN ('ACCIDENT','BREAKDOWN','TRAFFIC_VIOLATION','OTHER')),
    CONSTRAINT ck_incident_severity CHECK (severity IN ('MINOR','MODERATE','MAJOR','CRITICAL')),
    CONSTRAINT ck_incident_injuries CHECK (injuries_reported IN ('Y','N')),
    CONSTRAINT ck_incident_loss CHECK (estimated_loss >= 0),
    CONSTRAINT ck_incident_status CHECK (incident_status IN ('REPORTED','UNDER_REVIEW','RESOLVED','CLOSED')),
    -- resolved_at is filled exactly when the incident is RESOLVED or CLOSED
    CONSTRAINT ck_incident_resolved CHECK (
        (incident_status IN ('RESOLVED','CLOSED') AND resolved_at IS NOT NULL)
        OR
        (incident_status IN ('REPORTED','UNDER_REVIEW') AND resolved_at IS NULL)),
    CONSTRAINT ck_incident_resolved_time CHECK (resolved_at IS NULL OR resolved_at >= reported_at)
);
 
COMMIT;
 
