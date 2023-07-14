-- Filter icu stays according to the criteria in the paper
DROP MATERIALIZED VIEW IF EXISTS ws_getFilteredIcustays;
CREATE MATERIALIZED VIEW ws_getFilteredIcustays AS
SELECT v1.icustay_id, v1.starttime, v1.endtime, v1.duration_hours
FROM (
    SELECT icustay_id, starttime, endtime, duration_hours,
        ROW_NUMBER() over (partition by icustay_id order by ventnum) as ventnum_24hours
    FROM ventilation_durations
    WHERE duration_hours >= 24
) AS v1
JOIN getMainDemographics dem on v1.icustay_id = dem.icustay_id
-- Only select first ventilation that lasted at least 24 hours
WHERE v1.ventnum_24hours = 1  
-- Select only patients that are at least 18 years old
AND dem.first_admit_age >= 18
ORDER BY v1.icustay_id;