# Organisation of the Library & Module Structure

## Library Design


## Model Structure
<!-- Previously from 'Modelling within the AED framework'-->

The AED2 Model has ability to simulate a range of physical, chemical and biological processes, that can be generally described based as:

-	Feedback of chemical or biological attributes to physical properties of water (light extinction, drag, density)
-	Water column kinetic (time-varying) chemical / biological transformations (e.g., denitrification or algal growth)
-	Water column equilibrium (instantaneous) chemical transformations (e.g., PO~4~ adsorption)
-	Biogeochemical transformations in the sediment or biological changes in the benthos
-	Vertical sedimentation or migration
-	Fluxes across the air-water interface
-	Fluxes across the sediment-water interface
-	Fluxes across the terrestrial-water interface (riparian interactions)
-	Ecohydrological dynamics and biogeochemical transformations in the exposed (dry) cells
-	Feedbacks of soil and vegetation dynamics onto lake hydrodynamics and water balance

The model is organised as a series of “modules” that can be connected or “linked” through specific variable dependencies. Relevant variables (Table 3) are described in the following sections, along with the science basis relevant to the Lower Lakes model setup. For the initial phase of the CLLMM RWQM model, only the core variables are configured, and future proposed variables are also indicated in the Table 3, denoted with an asterisk.

## Module Summary
