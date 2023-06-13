-- Select only the rows that are in the filtered icustays
DROP MATERIALIZED VIEW IF EXISTS getFinalTable;
CREATE MATERIALIZED VIEW getFinalTable AS
SELECT 
    sam.*, gfi.starttime as vent_starttime, gfi.endtime as vent_endtime, gfi.duration_hours as vent_duration_hours
FROM sampled_with_scdem_withventparams sam
JOIN getFilteredIcustays gfi ON sam.icustay_id = gfi.icustay_id;