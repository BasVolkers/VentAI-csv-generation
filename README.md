# VentAI .csv generation

Generation of the .csv file for the VentAI algorithm consists of a few steps:
1. Setup MIMIC-III Postgres database
2. Add derived tables
3. Add VentAI views
4. Convert final table to .csv

## Setup MIMIC-III Postgres database
Follow https://mimic.mit.edu/docs/gettingstarted/ 

## Add derived tables

Partially copied from [here](https://github.com/MIT-LCP/mimic-code/tree/main/mimic-iii/concepts).

First get the MIMIC code from the [repository](https://github.com/MIT-LCP/mimic-code/ ).

```
git clone https://github.com/MIT-LCP/mimic-code.git
```

Then navigate to the `mimic-code/mimiciii/concepts_postgres` directory, connect to the PSQL database instance, and run the following commands:

```
\i postgres-functions.sql
\i postgres-make-concepts.sql
```

If you get an error that `ccs_multi_dx.csv.gz` does not exist then copy the file to the directory from which you run the command:

`cp diagnosis/ccs_multi_dx.csv.gz .`

## Add VentAI Views

In the folder `ventai-views` you can find all the SQL views that VentAI uses, which were taken from their [github](https://github.com/arnepeine/ventai). They were modified to work out of the box, and `getMainDemographics.sql` was taken from the Supplementary Material of [Personalization of Mechanical Ventilation Treatment using Deep Conservative Reinforcement Learning ](https://openreview.net/forum?id=BHxesR1m_0F).

Add all the ventai-views by running the SQL file in this repository:

```
\i add-ventai-views.sql
```

##  Convert final table to .csv

Connect to the PSQL database and run the next command.

Replace <output_path> with the desired location:

```
\copy (SELECT * FROM getFinalTable) TO '<output_path>' DELIMITER ';' CSV HEADER
```

You should end up with a .csv file that contains all the relevant information to start with VentAI.