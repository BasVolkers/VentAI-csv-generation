-- Stage 1
\i ventai-views/getGCS.sql
\i ventai-views/getVitalSigns.sql
\i ventai-views/getLabValues.sql
\i ventai-views/getLabValues.sql
\i ventai-views/getOthers.sql
\i ventai-views/getVentilationParams.sql
\i ventai-views/vent_parameters.sql
\i ventai-views/getIntravenous.sql
\i ventai-views/dopamine-dose.sql
\i ventai-views/weight_durations.sql
\i ventai-views/vasopressin-dose.sql
\i ventai-views/phenylephrine_dose.sql
\i ventai-views/norepinephrine_dose.sql
\i ventai-views/epinephrine_dose.sql
\i ventai-views/getVasopressors.sql
\i ventai-views/getUrineOutput.sql
\i ventai-views/getCumFluid.sql
\i ventai-views/getElixhauser_score.sql
\i ventai-views/getWeight.sql
\i ventai-views/getMainDemographics.sql
\i ventai-views/getIdealBodyWeight.sql

-- Stage 2
\i ventai-views/overalltable_Lab_withventparams.sql
\i ventai-views/overalltable_withoutLab_withventparams.sql

-- Stage 3
\i ventai-views/sampling_lab_withventparams.sql
\i ventai-views/sampling_withoutlab_withventparams.sql
\i ventai-views/sampling_all_withventparams.sql

-- Stage 4
\i ventai-views/getSIRS_withventparams.sql
\i ventai-views/getSOFA_withventparams.sql

-- Stage 5
\i ventai-views/sampled_data_with_scdem_withventparams.sql
\i ventai-views/icustays-filtered.sql
\i ventai-views/getFinalTable.sql