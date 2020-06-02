# Phytoplankton

## Contributors
## Overview

The approach to simulate algal biomass is to adopt several plankton functional types (PFTs) that are typically defined based on specific groups such as diatoms, dinoflagellates and cyanobacteria. Whilst each group that is simulated is unique, they share a common mathematical approach and each simulate growth, death and sedimentation processes, and customisable internal nitrogen, phosphorus and/or silica stores if desired. Distinction between groups is made by adoption of groups specific parameters for environmental dependencies, and/or enabling options such as vertical migration or N fixation.

For each phytoplankton group, the maximum potential growth rate at 20°C is multiplied by the minimum value of expressions for limitation by light, phosphorus, nitrogen and silica (when configured). While there may be some interaction between limiting factors, a minimum expression is likely to provide a realistic representation of growth limitation (Rhee and Gotham, 1981).



## Model Description
###	Process Descriptions

#### Photosynthesis & Nutrient Uptake {-}

For each phytoplankton group, the maximum potential growth rate at 20˚C is multiplied by the minimum value of expressions for limitation by light, phosphorus, nitrogen and silica (when configured). While there may be some interaction between limiting factors, a minimum expression is likely to provide a realistic representation of growth limitation (Rhee and Gotham, 1981). 
Therefore, photosynthesis is parameterized as the uptake of carbon, and depends on the temperature, light and nutrient dimensionless functions (adopted from Hipsey & Hamilton, 2008; Li et al., 2013).
<center>
<br>
\begin{align}
{f_{uptake}^{PHY_{Ca}}} &=  \underbrace{{R_{growth}^{PHY_{a}}}}_{\text{Max growth rate at 20˚C}}*\underbrace{(1-{k_{pr}^{PHY_{a}}})}_{\text{Photorespiratory loss}}*\underbrace{{\Phi_{tem}^{PHY_{a}}}(T)}_{\text{Temperature scaling}}*\underbrace{{\Phi_{str}^{PHY_{a}}}(T)}_{\text{Metabolic stress}}*\\
&{\text{min}}\begin{Bmatrix}\underbrace{\Phi_{light}^{PHY_{a}}(I)}_{\text{Light limitation}},\underbrace{\Phi_{N}^{PHY_{a}}(NO_{3},NH_{4},PHY_{N_{a}})}_{\text{N limitation}},\underbrace{\Phi_{P}^{PHY_{a}}(PO_{4},PHY_{P_{a}})}_{\text{P limitation}},\underbrace{\Phi_{Si}^{PHY_{a}}(RSi)}_{\text{Si limitation}}\end{Bmatrix}[PHY_{C_{a}}]
(\#eq:phyto1)
\end{align}
<br>
</center>
To allow for reduced growth at non-optimal temperatures, a temperature function is used where the maximum productivity occurs at a temperature $T_{OPT}$; above this productivity decreases to zero at the maximum allowable temperature, $T_{MAX}$. Below the standard temperature, $T_{STD}$ the productivity follows a simple Arrenhius scaling formulation. In order to fit a function with these restrictions the following conditions are assumed: at $T=T_{STD}$,$\ {\ \Phi}_{tem}\left(T\right)=1$ and at  $T=T_{OPT},\ \ \frac{d\Phi_{tem}\left(T\right)}{dT}=0$, and at $T=T_{MAX}$,$\ \Phi_{tem}\left(T\right)=0$. This can be numerically solved using Newton’s iterative method and can be specific for each phytoplankton group. The temperature function is calculated according to (Griffin et al. 2001):
<center>
<br>
\begin{equation}
\Phi_{tem}^{{PHY}_a}\left(T\right)=\vartheta_a^{T-20}-\vartheta_a^{k\left[T-{c1}_a\right]}+{c0}_a
(\#eq:phyto2)
\end{equation}
<br>
</center>
Where ${c1}_a$  and ${c0}_a$  are solved numerically given input values of:  $T_a^{std}$, $T_a^{opt}$ and $T_a^{max}$.

The level of light limitation on phytoplankton growth can be modelled as photoinhibition or non-photoinhibition. In the absence of significant photoinhibition, Webb et al. (1974) suggested a relationship for the fractional limitation of the maximum potential rate of carbon fixation for the case where light saturation behavior was absent (Talling, 1957), and the equations can be analytically integrated with respect to depth (Hipsey and Hamilton, 2008). For the case of photoinhibition, the light saturation value of maximum production (IS) is used and the net level effect can be averaged over the cell by integrating over depth. 
The `aed_phytoplankton` module contains several light functions, including those from a recent review by Baklouti et al. (2006). The user must select the sensitivity to light according to a photosynthesis-irradiance (P-I curve) formulation and each species must be set to be either non-photoinhibited or photoinhibited according to the options in Table 9.

**Table**

Limitation of the photosynthetic rate may be dampened according to nitrogen or phosphorus availability, and this is either approximated using a Monod expression of the static model is chosen, or based on the internal nutrient stoichiometry if the dynamic (Droop uptake) model is selected:
For advanced users, an optional metabolic scaling factor can be included to reduce the photosynthetic capacity of the simulated organisms, for example due to metabolic stress due to undertaking N~2~ fixation: 
<center>
<br>
\begin{equation}
\Phi_{str}^{{PHY}_a}=\underbrace{f_{NF}^{{PHY}_a}+\left[{1-f}_{NF}^{{PHY}_a}\right]\Phi_N^{{PHY}_a}\left({NO}_3,{NH}_4,{PHY_N}_a\right)}_{N_{2}\text{ fixation growth scaling}}
(\#eq:phyto3)
\end{equation}
<br>
</center>
The above discussion relates to photosynthesis and carbon uptake by the phytoplankton community. In addition users must choose one of two options to model the P, N uptake dynamics for each algal group: a constant nutrient to carbon ratio, or dynamic intracellular stores. For the first model a simple Michaelis-Menten equation is used to model nutrient limitation with a half-saturation constant for the effect of external nutrient concentrations on the growth rate.  
The internal phosphorus and nitrogen dynamics within the phytoplankton groups can be modelled using dynamic intracellular stores that are able to regulate growth based on the model of Droop (1974). This model allows for the phytoplankton to have dynamic nutrient uptake rates with variable internal nutrient concentrations bounded by user-defined minimum and maximum values (e.g., see Li et al., 2013). 

**Table**

The uptake of nitrogen must be partitioned into uptake of NO~3~, NH~4~ and potentially labile DON. In the present version, distinction between uptake of NO~3~ and NH~4~ is calculated automatically via a preference factor:
<center>
<br>
\begin{equation}
{\ p}_{NH4}^{{PHY}_a}=\frac{{NO}_3\ {NH}_4}{\left({NH}_4+K_N^{{PHY}_a}\right)\left({NO}_3+K_N^{{PHY}_a}\right)}\frac{{NH}_4{\ K}_N^{{PHY}_a}}{\left({NH}_4+{NO}_3\right)\left({NO}_3+K_N^{{PHY}_a}\right)}
(\#eq:phyto4)
\end{equation}
<br>
\begin{equation}
p_{NO3}^{{PHY}_a}=1-{\ p}_{NH4}^{{PHY}_a}
(\#eq:phyto5)
\end{equation}
<br>
</center>
For diatom groups, silica processes are simulated that include uptake of dissolved silica. The silica limitation function for diatoms is similar to the constant cases for nitrogen and phosphorus which assumes a fixed C:Si ratio.

#### Respiration, Excretion & Mortality {-}

Metabolic loss of nutrients from mortality and excretion is proportional to the internal nitrogen to chla ratio multiplied by the loss rate and the fraction of excretion and mortality that returns to the detrital pool. Loss terms for respiration, natural mortality and excretion are modelled with a single ‘respiration’ rate coefficient. This loss rate is then divided into the pure respiratory fraction and losses due to mortality and excretion. The constant $f_{DOM}$ is the fraction of mortality and excretion to the dissolved organic pool with the remainder into the particulate organic pool.
Nutrient losses through mortality and excretion for the internal nutrient model are similar to the simple model described above, except that dynamically calculated internal nutrient concentrations are used. 

<center>
<br>
\begin{align*}
\hat{R}&=R_{resp}^{{PHY}_a}\ \ \Phi_{sal}^{{PHY}_a}\left(S\right)\ \ \left(\vartheta_{resp}^{{PHY}_a}\right)^{T-20}
(\#eq:phyto6)\\
f_{resp}^{{PHY_C}_a}&=k_{fres}^{{PHY}_a}\ \hat{R}\ \left[{PHY_C}_a\right]
(\#eq:phyto7)\\
f_{excr}^{{PHY_C}_a}&=\left(1-k_{fres}^{{PHY}_a}\right)\ k_{fdom}^{{PHY}_a}\ \hat{R}\ \ \left[{PHY_C}_a\right]
(\#eq:phyto8)\\
f_{mort}^{{PHY_C}_a}&=\left(1-k_{fres}^{{PHY}_a}\right)\ \left({1-k}_{fdom}^{{PHY}_a}\right)\ \hat{R}\ \left[{PHY_C}_a\right]
(\#eq:phyto9)\\
f_{excr}^{{PHY_N}_a}&=k_{fdom}^{{PHY}_a}\ \hat{R}\ \left[{PHY_N}_a\right]
(\#eq:phyto10)\\
f_{mort}^{{PHY_N}_a}&=\left(1-k_{fdom}^{{PHY}_a}\right)\ \hat{R}\ \left[{PHY_N}_a\right]
(\#eq:phyto11)\\
f_{excr}^{{PHY_P}_a}&=k_{fdom}^{{PHY}_a}\ \hat{R}\ \left[{PHY_P}_a\right]
(\#eq:phyto12)\\
f_{mort}^{{PHY_P}_a}&=\left(1-k_{fdom}^{{PHY}_a}\right)\ \hat{R}\ \ \left[{PHY_P}_a\right]
(\#eq:phyto13)\\
f_{excr}^{{PHY_{Si}}_a}&=\hat{R}\ \left[{PHY_{Si}}_a\right]
(\#eq:phyto14)
\end{align*}
<br>
</center>

The salinity effect on mortality is given by various quadratic formulations, depending on the groups sensitivity to salinity (Griffin et al 2001; Robson and Hamilton, 2004). An example of the use of various salinity limitation options is shown in Figure 3.
















###	Variable Summary

#### State Variables {-}

<center>
<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:725px; "><table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:16-statevariables)State variables</caption>
 <thead>
  <tr>
   <th style="text-align:center;"> Variable Name </th>
   <th style="text-align:center;"> Description </th>
   <th style="text-align:center;"> Units </th>
   <th style="text-align:center;"> Variable Type </th>
   <th style="text-align:center;"> Core/Optional </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `PHY_{Group}` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Phytoplanton group </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> $mmol\,m^{-3}$ </td>
   <td style="text-align:center;min-width: 10em; background-color: white !important;"> Pelagic </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Core </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `PHY_{Group}_IN` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Internal nitrogen of phytoplakton group x </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 10em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Optional </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `PHY_{Group}_IP` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Internal phosphorus of phytoplakton group x </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 10em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Optional </td>
  </tr>
</tbody>
</table></div>
</center>

#### Diagnostics {-}

<center>
<div style="border: 1px solid #ddd; padding: 5px; overflow-y: scroll; height:500px; overflow-x: scroll; width:725px; "><table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:16-diagnostics)Diagnostics</caption>
 <thead>
  <tr>
   <th style="text-align:center;"> Variable Name </th>
   <th style="text-align:center;"> Description </th>
   <th style="text-align:center;"> Units </th>
   <th style="text-align:center;"> Variable Type </th>
   <th style="text-align:center;"> Core/Optional </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `PHY_tchla` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Total chlorophyll-a </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> $ug\,L^{-1}$ </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> Pelagic diagnostic </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Core </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `PHY_GPP` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Gross primary production </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> $mmol C\,m^{-3}\,day^{-1}$ </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> Pelagic diagnostic </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Core </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `PHY_{group}_f(I/T/S/N/P/Si)` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Phytoplankton growth limitation of light/nutrients </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> Pelagic diagnostic </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Core </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `PSED_PHY` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Phytoplankton sedimentation </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> $mmol\,m^{-2}\,s^{-1}$ </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `PHY_NCP` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Net community production </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> $mmol\,m^{-3}\,day^{-1}$ </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `PHY_NUP` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Nitrogen uptake </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> $mmol\,m^{-3}\,day^{-1}$ </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `PHY_PUP` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Phosphorus uptake </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> $mmol\,m^{-3}\,day^{-1}$ </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `PHY_CUP` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Carbon uptake </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> $mmol\,m^{-3}\,day^{-1}$ </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `PHY_PAR` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Photosynthetically active radiation </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> $W\,m^{-2}$ </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `PHY_IN` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Phytoplankton nitrogen </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> $mmol\,m^{-3}$ </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `PHY_IP` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Phytoplankton phosphorus </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> $mmol\,m^{-3}$ </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `PHY_MBP` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Microphytobenthos </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> $mmol\,m^{-2}$ </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `PHY_BPP` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Benthic productivity </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> $mmol\,m^{-2}\,day^{-1}$ </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `PHY_MPBV` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Microphytobenthos vertical ewxchange </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> $mmol\,m^{-2}\,day^{-1}$ </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `PHY_PPR` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Gross phytoplankton p/r ratio </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `PHY_NPR` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Net phytoplankton p/r ratio </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `PHY_{Group}_NtoP` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> NA </td>
  </tr>
</tbody>
</table></div>
</center>


###	Parameter Summary
###	Optional Module Links
###	Feedbacks to the Host Model
## Setup & Configuration

### Setup Example

<div style="border: 1px solid #ddd; padding: 5px; overflow-y: scroll; height:500px; overflow-x: scroll; width:725px; "><table class="table table-hover" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:16-parameterconfig)Parameters and configuration</caption>
 <thead>
  <tr>
   <th style="text-align:center;"> Parameter Name </th>
   <th style="text-align:center;"> Description </th>
   <th style="text-align:center;"> Units </th>
   <th style="text-align:center;"> Parameter Type </th>
   <th style="text-align:center;"> Default </th>
   <th style="text-align:center;"> Typical Range </th>
   <th style="text-align:center;"> Comment </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `num_phytos` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Number of phytoplankton groups </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> Integer </td>
   <td style="text-align:center;min-width: 10em; background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> 0-7 </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `the_phytos` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> List of ID's of groups in aed_phyto_pars.nml (len=num_phyto) </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> Integer </td>
   <td style="text-align:center;min-width: 10em; background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> 1/7/17 </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `X_excretion_target_variable` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> State variable to receive C, N or P from excretion </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> String </td>
   <td style="text-align:center;min-width: 10em; background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `X_mortality_target_variable` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> State variable to receive C, N or P from mortality </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> String </td>
   <td style="text-align:center;min-width: 10em; background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `X_uptake_target_variable` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> State variable to be linked C, N, P, Si or O2 uptake </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> String </td>
   <td style="text-align:center;min-width: 10em; background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `settling` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Settling calculation method </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> Integer </td>
   <td style="text-align:center;min-width: 10em; background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> 1/3/17 </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `do_mpb` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Switch to enable microphytobenthos calculations </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> float </td>
   <td style="text-align:center;min-width: 10em; background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `R_mpbg` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Maximum rate of MPB growth </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> $mmol C\,m^{-3}\,day^{-1}$ </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> Float </td>
   <td style="text-align:center;min-width: 10em; background-color: white !important;"> 5.00E-01 </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `R_mpbr` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Maximum rate of MPB respiration </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> $mmol C\,m^{-3}\,day^{-1}$ </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> Float </td>
   <td style="text-align:center;min-width: 10em; background-color: white !important;"> 5.00E-02 </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `I_Kmpb` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Half saturation constant for light limitation of MPB growth </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> $microE\,m^{-2}\,s^{-1}$ </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> Float </td>
   <td style="text-align:center;min-width: 10em; background-color: white !important;"> 100 </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `mpb_max` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Maximum MPB biomass </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> Float </td>
   <td style="text-align:center;min-width: 10em; background-color: white !important;"> 2000 </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `resuspension` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Resuspension rate of phytoplankton group x </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> Float </td>
   <td style="text-align:center;min-width: 10em; background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `resus_link` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Resuspension link variable </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> String </td>
   <td style="text-align:center;min-width: 10em; background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `n_zones` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Total number of active material zones </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> Integer </td>
   <td style="text-align:center;min-width: 10em; background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `active_zones` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> AActive material Zone ID's </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> Array </td>
   <td style="text-align:center;min-width: 10em; background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `dbase` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Link to phy database </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> String </td>
   <td style="text-align:center;min-width: 10em; background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `extra_diag` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Include extra diags in nc output </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> Boolean </td>
   <td style="text-align:center;min-width: 10em; background-color: white !important;"> .false. </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `min_rho` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Minimum phytoplankton density </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> $kg\,m^{-3}$ </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> Float </td>
   <td style="text-align:center;min-width: 10em; background-color: white !important;"> 900 </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `max_rho` </td>
   <td style="text-align:center;min-width: 15em; background-color: white !important;"> Maximum phytoplankton density </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> $kg\,m^{-3}$ </td>
   <td style="text-align:center;min-width: 13em; background-color: white !important;"> Float </td>
   <td style="text-align:center;min-width: 10em; background-color: white !important;"> 1200 </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
   <td style="text-align:center;background-color: white !important;"> NA </td>
  </tr>
</tbody>
</table></div>

<br>

An example `nml` block for the phytoplankton module is shown below:

\BeginKnitrBlock{rmdnote}<div class="rmdnote">Users must supply a valid "aed_phyto_pars.nml" file.</div>\EndKnitrBlock{rmdnote}

```{style="max-height: 500px;"}
&aed2_phytoplankton
!-- Configure phytoplankton groups to simulate
  num_phytos = 1
  the_phytos = 1
  settling =   1
!-- Benthic phytoplankton group (microphytobenthos)
  do_mpb = 1
  R_mpbg = 0.5
  R_mpbr = 0.05
  I_Kmpb = 100.
  mpb_max = 2000.
  resuspension = 0.45
  resus_link   = 'TRC_resus'
  n_zones = 4
  active_zones = 2,3,4,5
!-- Set link variables to other modules
  p_excretion_target_variable='OGM_dop'
  n_excretion_target_variable='OGM_don'
  c_excretion_target_variable='OGM_doc'
  si_excretion_target_variable=''
  p_mortality_target_variable='OGM_pop'
  n_mortality_target_variable='OGM_pon'
  c_mortality_target_variable='OGM_poc'
  si_mortality_target_variable=''
  p1_uptake_target_variable='PHS_frp'
  n1_uptake_target_variable='NIT_nit'
  n2_uptake_target_variable='NIT_amm'
  si_uptake_target_variable='SIL_rsi'
  do_uptake_target_variable='OXY_oxy'
  c_uptake_target_variable=''
!-- General options
  dbase = '../External/AED2/aed2_phyto_pars.nml'
  extra_diag = .false.
 !zerolimitfudgefactor = ??
  min_rho = 900.
  max_rho = 1200.
 /
```

## Case Studies & Examples
###	Case Study
###	Publications
