# Nomenclature

## Variables and Data Types 

There is often confusion over the types of variables and data-types used within the modules. Standard terminology adopted in the AED system is described in Table \@ref(tab:vardatatypes).

<details open>
  <summary>
    Table \@ref(tab:vardatatypes)
  </summary>
<div style="border: 1px solid #ddd; padding: 5px; overflow-y: scroll; height:800px; overflow-x: scroll; width:770px; "><table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:vardatatypes)Variables and data types</caption>
<tbody>
  <tr>
   <td style="text-align:left;min-width: 10em; background-color: white !important;"> Diagnostic variable </td>
   <td style="text-align:left;min-width: 10em; background-color: white !important;"> A diagnostic variable is a property of interest defined on the computational domain, and available to be output by the host model for plotting and post-processing. Typically, diagnostic variables include derived measure of model state, integrated values, process rates or other cell-specific attributes of interest for debugging. Importantly, diagnostic variables are not subject to transport or boundary conditions as are state variables. Diagnostic variables can be “normal” in which case they exist in all water cells, or they can be “sheet” in which case they are used for surface or benthic attributes (these are typically called 3D and 2D, respectively, though are still relevant in 1D models like GLM). </td>
  </tr>
  <tr>
   <td style="text-align:left;min-width: 10em; background-color: white !important;"> Environment variable </td>
   <td style="text-align:left;min-width: 10em; background-color: white !important;"> An environment variable in AED is a variable managed by the host model but is required by AED for computation of module-specific dynamics. This typically relate to predictions of the host model such as temperature, salinity and velocity, but can also include features of the domain, including benthic material type or cell thickness. </td>
  </tr>
  <tr>
   <td style="text-align:left;min-width: 10em; background-color: white !important;"> Boundary condition </td>
   <td style="text-align:left;min-width: 10em; background-color: white !important;"> A boundary condition is a driving variable external to the simulation dynamics, such as weather or flow. In most cases in AED these are handled by the host model, and passed to AED modules as environment vars (e.g. wind, solar radiation etc). </td>
  </tr>
  <tr>
   <td style="text-align:left;min-width: 10em; background-color: white !important;"> Process rate </td>
   <td style="text-align:left;min-width: 10em; background-color: white !important;"> A process rate in AED refers to a flux pathway, ie. a mass or energy flux connecting two variables or more variables. Generally these are units of concentration per time. </td>
  </tr>
  <tr>
   <td style="text-align:left;min-width: 10em; background-color: white !important;"> Parameter - constant </td>
   <td style="text-align:left;min-width: 10em; background-color: white !important;"> A constant parameter is a fixed value over the course of the simulation associated with a process calculation, unit conversion etc. This will be in a variety of units. These values are not accessible outside of the specific module in which they are declared. </td>
  </tr>
  <tr>
   <td style="text-align:left;min-width: 10em; background-color: white !important;"> Parameter - variable </td>
   <td style="text-align:left;min-width: 10em; background-color: white !important;"> A variable parameter is a value over associated with a process calculation, or related attribute, that can vary between computational cells, and/or from time to time depending on local conditions. These values are not accessible outside of the specific module in which they are declared, unless the spatiotemporal varying parameters are also stored as “diagnostic” variables, where they can be linked to other modules and output for post-processing assessment. </td>
  </tr>
  <tr>
   <td style="text-align:left;min-width: 10em; background-color: white !important;"> Option </td>
   <td style="text-align:left;min-width: 10em; background-color: white !important;"> An option is an integer or Boolean “switch” used to enable a feature in a module, or select a specific algorithm or function </td>
  </tr>
</tbody>
</table></div>
</details>

## A Note on Notation

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


