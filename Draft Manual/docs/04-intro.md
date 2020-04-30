# Introduction{-}

## Modelling within the AED framework{-}
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

## A Note on Notation{-}
The remainder of this section presents the range of equations and parameterisations adopted by the various model approaches. For consistency, a standard mathematical notation is used.

- $N$ = number of groups (integer)
- $a, om, z$ = indices of various sub-groups of algae/phytoplankton, organic matter and zooplankton (integer)
- $\chi_{C:Y}^{group}$ = the stoichiometric ratio of “$group$” between $C$ and element “$Y$”  (mmol C/mmol Y)
- $f_{process}^{var}$ = function that returns the mass flux of “$process$” on “$var$”  (mmol var/time)
- $R_{process}^{var}$ = the rate of “$process$” influencing the variable “$var$”  (/time)
- $F_{process}^{var}$ = the maximum benthic areal flux of variable “var” (mmol var/area/time)
- $p_{source}^{group}$ = the preference of “$group$” for “$source$”  (0-1)
- $\Phi_{lim}^{group}(var)$ = dimensionless limitation or scaling function to account for the effect of “$lim$” on “$group$” (-)
- $k^{var}$	= generic fraction related to “$var$”  (0-1)
- $\Theta_{config}^{group}$	= switch to configure selectable model component “$config$” for “$group$” (0,1,2,…)
- $c,\theta,\gamma…$ 		= coefficient  (various units)
