-- 8. TOTAL LOYALTY POINTS OF A USER (from badges)
--    Updated for 4NF schema: user_badges joins to badges on badge_name to retrieve points_awarded.
------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_user_points (
    p_user_id IN NUMBER
) RETURN NUMBER IS
    v_points NUMBER;
BEGIN
    SELECT NVL(SUM(b.points_awarded), 0)
      INTO v_points
      FROM user_badges ub
      JOIN badges b ON b.badge_name = ub.badge_name
     WHERE ub.user_id = p_user_id;

    RETURN v_points;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END fn_user_points;
/
