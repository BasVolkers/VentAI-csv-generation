### Description


Run v2.sql, which will create the views I am intereseted in. You may need to execute the SQL scripts in Preliminaries before v2.sql works/

Then for the following views copy to csv:
```
\copy (SELECT * FROM <table>) TO '<output_path>' DELIMITER ';' CSV HEADER
```

For these views:
ws_getVentilationData
ws_getVitalSigns
ws_getFilteredIcustays
ws_getLabValues
ws_getAllFluids

