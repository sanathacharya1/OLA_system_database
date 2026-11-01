-- 6. VEHICLE AVAILABILITY CHECK
------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_vehicle_is_available (
    p_vehicle_id IN NUMBER
) RETURN VARCHAR2 IS
    v_status vehicles.vehicle_status%TYPE;
BEGIN
    SELECT vehicle_status INTO v_status
      FROM vehicles
     WHERE vehicle_id = p_vehicle_id;

    RETURN CASE WHEN v_status = 'AVAILABLE' THEN 'Y' ELSE 'N' END;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'N';
END fn_vehicle_is_available;
/
