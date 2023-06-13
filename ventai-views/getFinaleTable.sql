DROP MATERIALIZED VIEW IF EXISTS getFinalTable;
CREATE MATERIALIZED VIEW getFinalTable AS

SELECT 
* 
FROM  sampled_all_withventparams

-- Only select rows where there is mechanical ventilation
WHERE mechvent = 1;