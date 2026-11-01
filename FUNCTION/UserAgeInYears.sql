-- 14. USER AGE IN YEARS
------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_user_age (
    p_user_id IN NUMBER
) RETURN NUMBER IS
    v_dob users.date_of_birth%TYPE;
BEGIN
    SELECT date_of_birth INTO v_dob
      FROM users
     WHERE user_id = p_user_id;

    IF v_dob IS NULL THEN
        RETURN NULL;
    END IF;

    RETURN TRUNC(MONTHS_BETWEEN(SYSDATE, v_dob) / 12);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END fn_user_age;
/
