-- Select only the rows that are in the filtered icustays, and add IdealBodyWeight + Adjusted tidal volume
DROP MATERIALIZED VIEW IF EXISTS getFinalTable;
CREATE MATERIALIZED VIEW getFinalTable AS
SELECT 
    sam.*, 
    ibw.ideal_body_weight,
    sam.tidal_volume / ibw.ideal_body_weight as adjusted_tidal_volume,
    gfi.starttime as vent_starttime, gfi.endtime as vent_endtime, gfi.duration_hours as vent_duration_hours
FROM sampled_with_scdem_withventparams sam
JOIN getFilteredIcustays gfi ON sam.icustay_id = gfi.icustay_id
LEFT JOIN getIdealBodyWeight ibw ON gfi.icustay_id = ibw.icustay_id;