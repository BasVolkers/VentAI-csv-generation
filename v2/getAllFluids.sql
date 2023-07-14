DROP table IF EXISTS ws_getAllFluids;
CREATE table ws_getAllFluids AS

WITH base as ( 
	SELECT subject_id, hadm_id, icustay_id, charttime
			, urineoutput
			, CAST(null AS DOUBLE PRECISION) as rate_norepinephrine , CAST(null AS DOUBLE PRECISION) as rate_epinephrine 
		, CAST(null AS DOUBLE PRECISION) as rate_phenylephrine , CAST(null AS DOUBLE PRECISION) as rate_vasopressin 
		, CAST(null AS DOUBLE PRECISION) as rate_dopamine , CAST(null AS DOUBLE PRECISION) as vaso_total
		, CAST(null AS DOUBLE PRECISION) as iv_total
		, CAST(null AS DOUBLE PRECISION) as cum_fluid_balance
	FROM getUrineOutput
	UNION ALL
	( SELECT ic.subject_id, ic.hadm_id, ic.icustay_id, starttime as charttime
			, CAST(null AS DOUBLE PRECISION) as urineoutput
			, rate_norepinephrine , rate_epinephrine 
		, rate_phenylephrine , rate_vasopressin 
		, rate_dopamine , vaso_total
		, CAST(null AS DOUBLE PRECISION) as iv_total
		, CAST(null AS DOUBLE PRECISION) as cum_fluid_balance
	FROM getVasopressors vp INNER JOIN icustays ic
	ON vp.icustay_id=ic.icustay_id
	)
	UNION ALL
	( SELECT subject_id, hadm_id, icustay_id, charttime
			, CAST(null AS DOUBLE PRECISION) as urineoutput
			, CAST(null AS DOUBLE PRECISION) as rate_norepinephrine , CAST(null AS DOUBLE PRECISION) as rate_epinephrine 
		, CAST(null AS DOUBLE PRECISION) as rate_phenylephrine , CAST(null AS DOUBLE PRECISION) as rate_vasopressin 
		, CAST(null AS DOUBLE PRECISION) as rate_dopamine , CAST(null AS DOUBLE PRECISION) as vaso_total
		, amount as iv_total
		, CAST(null AS DOUBLE PRECISION) as cum_fluid_balance
	FROM getIntravenous)
	UNION ALL
	( SELECT subject_id, hadm_id, icustay_id, charttime
			, CAST(null AS DOUBLE PRECISION) as urineoutput
			, CAST(null AS DOUBLE PRECISION) as rate_norepinephrine , CAST(null AS DOUBLE PRECISION) as rate_epinephrine 
		, CAST(null AS DOUBLE PRECISION) as rate_phenylephrine , CAST(null AS DOUBLE PRECISION) as rate_vasopressin 
		, CAST(null AS DOUBLE PRECISION) as rate_dopamine , CAST(null AS DOUBLE PRECISION) as vaso_total
		, CAST(null AS DOUBLE PRECISION) as iv_total
		, cum_fluid_balance
	FROM getCumFluid)
)


SELECT subject_id, hadm_id, icustay_id, charttime,
	 --urine output
       avg(urineoutput) as urineoutput
	 -- vasopressors
	 , avg(rate_norepinephrine) as rate_norepinephrine , avg(rate_epinephrine) as rate_epinephrine 
	 , avg(rate_phenylephrine) as rate_phenylephrine , avg(rate_vasopressin) as rate_vasopressin 
	 , avg(rate_dopamine) as rate_dopamine , avg(vaso_total) as vaso_total
	 -- intravenous fluids
	 , avg(iv_total) as iv_total
	 -- cumulated fluid balance
	 , avg(cum_fluid_balance) as cum_fluid_balance
FROM base

group by subject_id, hadm_id, icustay_id, charttime	
order by subject_id, hadm_id, icustay_id, charttime;
