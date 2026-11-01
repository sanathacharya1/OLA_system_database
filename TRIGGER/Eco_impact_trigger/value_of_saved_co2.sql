-- ============================================================
-- TRIGGER: trg_eco_saved
-- Note: In the 4NF schema, co2_saved_kg is a VIRTUAL column:
--       GENERATED ALWAYS AS (baseline_co2_kg - actual_co2_kg) VIRTUAL.
-- In Oracle, direct assignment to virtual columns is disallowed (ORA-54017).
-- Oracle automatically calculates co2_saved_kg on insert/update.
-- This trigger enforces the emission integrity rule: actual <= baseline.
-- ============================================================

CREATE OR REPLACE TRIGGER trg_eco_saved
BEFORE INSERT OR UPDATE OF baseline_co2_kg, actual_co2_kg ON eco_impact_records
FOR EACH ROW
BEGIN
    IF :NEW.actual_co2_kg > :NEW.baseline_co2_kg THEN
        RAISE_APPLICATION_ERROR(-20080, 'Actual CO2 emissions cannot exceed baseline CO2.');
    END IF;
END;
/
