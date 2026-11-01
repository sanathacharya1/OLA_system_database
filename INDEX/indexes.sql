CREATE UNIQUE INDEX uq_dva_active_driver
    ON driver_vehicle_assignments (CASE WHEN assigned_to IS NULL THEN driver_id END);
 

CREATE UNIQUE INDEX uq_dva_active_vehicle
    ON driver_vehicle_assignments (CASE WHEN assigned_to IS NULL THEN vehicle_id END);


 
CREATE UNIQUE INDEX uq_driver_active_ride ON ride_bookings (
    CASE WHEN booking_status = 'ACCEPTED' THEN driver_id END
);
 


CREATE UNIQUE INDEX uq_maintenance_same_day
    ON vehicle_maintenance (vehicle_id, maintenance_type_id, TRUNC(service_date));



This stops two SCHEDULED or IN_PROGRESS oil changes for the same vehicle at once. Finished jobs (COMPLETED, NOT_DONE) are ignored, so history is unlimited.


CREATE UNIQUE INDEX uq_maintenance_open_job
    ON vehicle_maintenance (
        CASE WHEN maintenance_status IN ('SCHEDULED','IN_PROGRESS') THEN vehicle_id END,
        CASE WHEN maintenance_status IN ('SCHEDULED','IN_PROGRESS') THEN maintenance_type_id END
    );


-- one payout per driver per period
CREATE UNIQUE INDEX uq_payout_period ON driver_payouts (driver_id, period_start, period_end);


CREATE INDEX idx_earning_status ON driver_earnings (earning_status);


CREATE INDEX idx_incident_booking ON vehicle_incidents (booking_id);
CREATE INDEX idx_incident_rental  ON vehicle_incidents (rental_id);
 


