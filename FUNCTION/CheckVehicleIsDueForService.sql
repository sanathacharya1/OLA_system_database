-- 5. CHECK VEHICLE IS DUE FOR SERVICE
------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_vehicle_service_due (
    p_vehicle_id IN NUMBER
) RETURN VARCHAR2 IS
    v_next_date vehicle_maintenance.next_service_date%TYPE;
    v_next_odo  vehicle_maintenance.next_service_odometer%TYPE;
    v_current   vehicles.odometer_reading%TYPE;
BEGIN
    SELECT next_service_date, next_service_odometer
      INTO v_next_date, v_next_odo
      FROM (SELECT next_service_date, next_service_odometer
              FROM vehicle_maintenance
             WHERE vehicle_id = p_vehicle_id
               AND maintenance_status = 'COMPLETED'
             ORDER BY service_date DESC)
     WHERE ROWNUM = 1;

    SELECT odometer_reading INTO v_current
      FROM vehicles
     WHERE vehicle_id = p_vehicle_id;

    IF v_next_date <= TRUNC(SYSDATE) OR v_current >= v_next_odo THEN
        RETURN 'Y';
    END IF;
    RETURN 'N';
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Y';   -- no completed service on record
END fn_vehicle_service_due;
/
