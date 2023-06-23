DROP MATERIALIZED VIEW IF EXISTS getIdealBodyWeight;
CREATE MATERIALIZED VIEW getIdealBodyWeight AS

-- Calculate ideal body weight for each patient
-- According to the formula described by Peine
SELECT ibw.*, ibw.ideal_body_weight / ibw.weight as weight_ratio FROM 
(SELECT hw.icustay_id, hw.weight_first as weight, hw.height_first as height, p.gender,
   (CASE 
    when gender='M' then 50 + (0.91 * (height_first - 152.4))
    when gender='F' then 45.5 + (0.91 * (height_first - 152.4))
    end) as ideal_body_weight
FROM heightweight hw
JOIN icustays i ON i.icustay_id = hw.icustay_id
JOIN patients p ON i.subject_id = p.subject_id
) As ibw;

-- From DeepVent/getIdealBodyWeight.sql: "0.82 was found to be the mean ratio ideal_body_weight_kg/weight_first"
