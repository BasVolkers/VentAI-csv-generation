DROP MATERIALIZED VIEW IF EXISTS ventparameters;
CREATE MATERIALIZED VIEW ventparameters AS

with ce as (
select
  ce.icustay_id, ce.subject_id, ce.hadm_id, ce.charttime
    , (case when itemid in (60,437,505,506,686,220339,224700) THEN valuenum else null end) as PEEP -- PEEP
	, (case when itemid in (639, 654, 681, 682, 683, 684,224685,224684,224686) THEN valuenum else null end) as tidal_volume -- tidal volume
	, (case when itemid in (543) THEN valuenum else null end) as plateau_pressure -- PlateauPressure  
	
FROM mimiciii.chartevents ce
	
WHERE ce.value is not null
-- exclude rows marked as error
AND ce.error IS DISTINCT FROM 1
AND ce.itemid in
	(60,437,505,506,686,220339,224700, -- PEEP
	 639, 654, 681, 682, 683, 684,224685,224684,224686, -- tidal volume
	 543 -- PlateauPressure
	)
	)
      
SELECT icustay_id, subject_id, hadm_id, charttime,
	avg(PEEP) as PEEP,
	avg(tidal_volume) as tidal_volume,
	avg(plateau_pressure) as plateau_pressure
FROM ce

GROUP BY icustay_id, subject_id,hadm_id, charttime
ORDER BY icustay_id, charttime

-- PEEP:
--  itemid |      label       
-- --------+------------------
--      60 | Auto-PEEP Level
--     437 | Low Peep
--     505 | PEEP
--     506 | PEEP Set
--     686 | Total PEEP Level
--  220339 | PEEP set
--  224700 | Total PEEP Level

-- Tidal volume: 
--  itemid |           label            
-- --------+----------------------------
--     639 | Sigh Tidal Volume
--     654 | Spont. Tidal Volume
--     681 | Tidal Volume
--     682 | Tidal Volume (Obser)
--     683 | Tidal Volume (Set)
--     684 | Tidal Volume (Spont)
--  224684 | Tidal Volume (set)
--  224685 | Tidal Volume (observed)
--  224686 | Tidal Volume (spontaneous)