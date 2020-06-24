# Bivalves

## Contributors
## Overview

Based on work in freshwater and estuarine systems a bivalve module to simulate growth, production, and (optionally) population dynamics has been incorporated into the AED2+ library.

The model is originally based on an application to Oneida Lake and Lake Erie for mussels. One to several size classes of mussels are simulated based on physiological parameters assembled by @schneider1992 and modified by @bierman2005 to estimate effect of mussels on Saginaw Bay, Michigan, USA; a formulation also used by @gudimov2015 to estimate mussel effects in Lake Simcoe, Ontario, Canada.  Additionally, some model structure was taken from the @spillman2008 model of Tapes clams in the Barbamarco Lagoon, Italy, as modified by @bocaniov2014 for mussels in Lake Erie. 

The physiology of mussels are set to be size dependent, and can vary between species (e.g., Zebra vs Quagga)(Hetherington, 2016).  Three size classes of mussels can be incorporated in the model, roughly corresponding to age-0, age-1 and age>1 mussels.  Physiological parameters are calculated for the weight assigned to each age class, using equations in Table 4.  Individual mussel mass is given in mmol C or in the case of calculations of N and P budgets, in mmol N and mmol P.  The stoichiometric ratios (C:N:P) are fixed.  Group mussel biomass is calculated at each time step by calculating ingestion and subtracting pseudofeces production, standard dynamic action, respiration, excretion, egestion and mortality (expressed in mmol C/mmol C/day, mmol N/mmol N/day; mmol P/mmol P/day).  Several of these processes are also functions of temperature, algal+POC concentrations, salinity, suspended solids and mussel density.  The effect of salinity, suspended solids and mussel density is incorporated as a multiplier of filtration rate with the multipliers having values between -0 – (no filtering) and 1 (no effect). Mussel nitrogen and phosphorus concentrations are fixed ratios of mussel carbon concentrations. Since the various input and output fluxes have variable C:N:P ratios, the excretion of nutrients is dynamically adjusted each time-step to maintain this ratio at each time step.  Reproduction and larval dynamics are not simulated. There is no transfer of biomass between age groups.

## Model Description
###	Process Descriptions

#### Ingestion {-}
Ingestion is modelled as a function of filtration rate, food availability, pseudofeces production, density, suspended solids, and salinity (Equation 2) [@schneider1992; @bierman2005; @spillman2008; @gudimov2015]. Filtration rate is based on maximum ingestion, temperature, food availability, and pseudofeces production according to the following:

<center>
<br>
\begin{equation}
FR = \frac{\frac{I_{max}*f(T)_{I}}{K_{A}}}{PF_{min}} \text{ for } [A] < KA
(\#eq:bivalve1)
\end{equation}
</center>
<br>
<center>
\begin{equation}
FR = \frac{\frac{I_{max}*f(T)_{I}}{[A]}}{PF_{min}} \text{ for } [A] > KA
(\#eq:bivalve2)
\end{equation}
</center>
<br>

where $FR$ is filtration rate (mmol/mmol/d), $Imax$ is maximum ingestion rate (mmol/mmol/d), $f(T)_{I}$ is filtration temperature function, $K_{A}$ is optimum algal concentration (mmol/m3), $[A]$ is algal concentration + particulate organic carbon (POC) concentration (mmol/m3), and $PFmin$ is minimum pseudofeces production (-).
The maximum ingestion rate is based on weight from length according to the following:

<center>
<br>
\begin{equation}
I_{max} = (a_{I} * W^{bI})
(\#eq:bivalve3)
\end{equation}
</center>
<br>
<center>
\begin{equation}
W = \frac{0.071}{1000} * L^{2.8}
(\#eq:bivalve4)
\end{equation}
</center>
<br>

where $Imax$ is maximum ingestion rate (mmol/mmol/d), $a_{I}$ is maximum standard ingestion rate (mmol/mmol/d), $W$ is weight (g), $bI$ is exponent for weight effect on ingestion, $L$ in length (mm) [@schneider1992; @bierman2005].
The temperature dependence function [@thornton1978] was fit to zebra and quagga mussel data (Hetherington et al. Submitted) with optimal ingestion from 17°C to 20°C according to the following:

<center>
<br>
\begin{equation}
f(T)_{I} = 1 \text{ for } T_{min_{I}} < T < T_{max_{I}}
(\#eq:bivalve5)
\end{equation}
</center>
<br>
<center>
\begin{equation}
f(T)_{I} = (2*\frac{Tmin_{TI}}{Tmin_{I}} - \frac{(Tmin_{TI})^2}{(Tmin_{I})^2}) / (2*\frac{Tmin_{I}-minT_{I}}{Tmin_{I}}-\frac{(Tmin_{I}-minT_{I})^2}{(Tmin_{I})^2}) \text{ for } minT_{I} < T < Tmin_{I}
(\#eq:bivalve6)
\end{equation}
</center>
<br>
<center>
<br>
\begin{equation}
f(T)_{I} = -\frac{(T^{2} + 2*Tmax_{I}*T–2*Tmax_{I}*maxT_{I} + maxT_{I}^{2})}{(Tmax_{I}-maxT_{I})^{2}}	\text{ for } Tmax_{I}<T<maxT_{I}
(\#eq:bivalve7)
\end{equation}
</center>
<br>
<center>
<br>
\begin{equation}
f(T)_{I} = 0	\text{ for } T > maxT_{I} \text{ or } T < minT_{I}
(\#eq:bivalve8)
\end{equation}
</center>
<br>

where $T$ is temperature (°C), $minT_{I}$ is lower temperature for no ingestion (°C), $Tmin_{I}$ is lower temperature for optimum ingestion (°C), $Tmax_{I}$ is upper temperature for optimum ingestion, $maxT_{I}$ is upper temperature for no ingestion (°C).
Filtration rate is related to food concentration [@walz1978; @sprung1988; @schneider1992; @bierman2005). The filtration rate is maintained at a maximum value for all food values less than saturation food concentration. The filtration rate decreases as food concentrations increase above this value.
Pseudofeces production is implicit as the difference between the mass filtered and consumed. According to @walz1978, pseudofeces production (66%) was approximately double the ingestion rate (34%) at high food concentrations @bierman2005.

Mussel density limits ingestion above some maximum density according to the following: 

<center>
<br>
\begin{equation}
$f(D) = 1$ 								     	     	for $D<Dmax$
(\#eq:bivalve9)
\end{equation}
</center>
<br>
<center>
<br>
\begin{equation}
f(D) = \frac{-(D^{2} + 2*Dmax*D – 2*Dmax*maxD + maxD^{2})}{(Dmax – maxD)^{2}} \text{ for } D>Dmax
(\#eq:bivalve10)
\end{equation}
</center>
<br>
<center>
<br>
\begin{equation}
f(D) = 0 \text{ for } D>maxD
(\#eq:bivalve11)
\end{equation}
</center>
<br>

where $D$ is density (mmol/m2), $Dmax$ is upper density for optimum ingestion (mmol/m2), and $maxD$ is upper density for no ingestion (mmol/m2).
An additional function to reduce ingestion is the suspended solids function which decreases ingestion with high inorganic loads according to the following:

<center>
<br>
\begin{equation}
f(SS) = 1 \text{ for } SS<SSmax
(\#eq:bivalve12)
\end{equation}
</center>
<br>
<center>
<br>
\begin{equation}
f(SS) = \frac{-(SS^{2} + 2*SSmax*SS – 2*SSmax*maxSS + maxSS^{2})}{(SSmax – maxSS)^{2}} \text{ for } SS>SSmax
(\#eq:bivalve13)
\end{equation}
</center>
<br>
<center>
<br>
\begin{equation}
f(SS) = 0 \text{ for } SS>maxSS
(\#eq:bivalve14)
\end{equation}
</center>
<br>

where $SS$ is suspended solids (mg/L), $SSmax$ is upper suspended solids for optimum ingestion (mg/L), and $maxSS$ is upper suspended solids for no ingestion (mg/L) [@spillman2008].
Along with suspended solids, salinity limits ingestion according to the following: 

<center>
<br>
\begin{equation}
f(S) = 1 \text{ for } Smin < S < Smax
(\#eq:bivalve15)
\end{equation}
</center>
<br>
<center>
<br>
\begin{equation}
f(S) = \frac{(2*(S-minS)/Smin)–(S-minS)^{2}/Smin^{2})}{(2*(Smin-minS)/Smin)–(Smin-minS)^{2}/Smin^{2})} \text{ for } minS< S < Smin
(\#eq:bivalve16)
\end{equation}
</center>
<br>
\begin{equation}
f(S) = \frac{-(S^{2} + 2*Smax*S – 2*Smax*maxS + maxS^{2})}{(Smax-maxS)^{2}} \text{ for } Smax<S<maxS
(\#eq:bivalve17)
\end{equation}
<center>
<br>
\begin{equation}
f(S) = 0 \text{ for } S > maxS \text{ or } S < minS
(\#eq:bivalve18)
\end{equation}
</center>
<br>

where $S$ is salinity (psu), $minS$ is lower salinity for no ingestion (psu), $Smin$ is lower salinity for optimum ingestion (psu), $Smax$ is upper salinity for optimum ingestion (psu), $maxS$ is upper salinity for no ingestion (psu) [@spillman2008].

#### Respiration {-}
Respiration is modelled as a base or standard respiration rate based on weight and temperature  [@spillman2008]. Respiration rate coefficient at 20°C is based on weight from length according to the following:

<center>
<br>
\begin{equation}
R_{20} = (a_{R} * W^{b}_{R})
(\#eq:bivalve19)
\end{equation}
</center>
<br>
<center>
<br>
\begin{equation}
W = \frac{0.071}{1000} * L^{2.8}
(\#eq:bivalve20)
\end{equation}
</center>
<br>

where $R_{20}$ is respiration rate coefficient at 20°C (mmol/mmol/d), $a_{R}$ is standard respiration rate (mmol/mmol/d), $W$ is weight (g), $b_{R}$ is exponent for weight effect of respiration, and $L$ is length (mm) (Schneider 1992).
The respiration rate coefficient is adjusted for temperature according to the following:

<center>
<br>
\begin{equation}
f(T)_{RSpillman} = \Theta_{RSpillman}^{T-20}
(\#eq:bivalve21)
\end{equation}
</center>
<br>

where $f(T)_{RSpillman}$ is respiration temperature function, $\Theta_{RSpillman}$ is temperature multiplier for bivalve respiration (-), and $T$ is temperature (°C) [@spillman2008].
Alternatively, respiration is modelled as a base or standard respiration rate based on weight and temperature in addition to the energetic cost of feeding. Respiration rate coefficient at 30°C is based on weight from length according to the following:

<center>
<br>
\begin{equation}
R_{30} = (a^{R} * W^{b}_{R})
(\#eq:bivalve22)
\end{equation}
</center>
<br>
<center>
<br>
\begin{equation}
W = \frac{0.071}{1000} * L^{2.8}
(\#eq:bivalve23)
\end{equation}
</center>
<br>

where $R_{30}$ is respiration rate coefficient at 30°C (mmol/mmol/d), $a^{R}$ is standard respiration rate (mmol/mmol/d), $W$ is weight (g), $b_{R}$ is exponent for weight effect of respiration, and $L$ is length (mm) [@schneider1992].
The temperature function follows @schneider1992 application of the model of @kitchell1977 to the data of @alexander_jr2004 according to the following:

<center>
<br>
\begin{equation}
f(T)_{RSchneider} = V^{X} * e^{X * (1-V)}
(\#eq:bivalve24)
\end{equation}
</center>
<br>
<center>
<br>
\begin{equation}
V = \frac{Tmax_{R} – T}{Tmax_{R} – maxT_{R}}
(\#eq:bivalve25)
\end{equation}
</center>
<br>
<center>
<br>
\begin{equation}
X = (\frac{W*(1+\sqrt{1 + (\frac{40}{Y})})}{20})^2
(\#eq:bivalve26)
\end{equation}
</center>
<br>
<center>
<br>
\begin{equation}
W = lnQ_{R}*(Tmax_{R} – maxT_{R})
(\#eq:bivalve27)
\end{equation}
</center>
<br>
<center>
<br>
\begin{equation}
Y = lnQ_{R}*(Tmax_{R} – maxT_{R} + 2)
(\#eq:bivalve28)
\end{equation}
</center>
<br>

where $T$ is temperature (°C), $Tmax_{R}$ is upper temperature for optimum respiration (°C), $maxT_{R}$ is upper temperature for no respiration (°C), and $Q_{R}$ is respiration curve slope estimate (-). The maximum respiration occurs at 30°C with 43°C as the upper lethal temperature.
The energetic cost of feeding or specific dynamic action is applied only to the portion of ingestion that is not egested [@schneider1992; @bierman2005; @gudimov2015].

#### Excretion {-}
Excretion is modelled as a constant fraction of assimilated food [@schneider1992; @bierman2005; @gudimov2015]. Excretion data for zebra and quagga mussels are limited; therefore, the excretion formulation for Mytilus edulis derived by Bayne and Newell (1983) was used [@schneider1992; @bierman2005; @gudimov2015].

#### Egestion {-}
Egestion is modeled as a function of ingestion [@schneider1992; @bierman2005; @gudimov2015]. The model follows the assumption that ingestion is directly proportional to the food content of the water for all food concentrations less than the maximum which can be ingested. For all food concentrations above this saturation value, ingestion remains constant at a maximum value ($I_{max}$) [@walz1978].

#### Mortality {-}
Mortality is a function of dissolved oxygen and predation (Equation 7). Mortality increases with low dissolved oxygen concentrations according to the following:

<center>
<br>
\begin{equation}
f(DO) = 1 + K_{BDO} * \frac{K_{DO}}{K_{DO} + DO}
(\#eq:bivalve29)
\end{equation}
</center>
<br>

where $DO$ is dissolved oxygen (mmol/m3), $K_{BDO}$ is basal respiration rate (mmol/m3), and $K_{DO}$ is half saturation constant for metabolic response to dissolved oxygen (mmol/m3) [@spillman2008]. A mortality rate coefficient ($K_{MORT}$) further influences the dissolved oxygen function. Additionally, mortality from predation is a constant rate added to the effect from dissolved oxygen.

###	Variable Summary

#### State Variables {-}


<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:770px; "><table class="table" style="font-size: 12px; width: auto !important; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">(\#tab:26-statevariables)State variables</caption>
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
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `BIV_{group}` </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> Bivalve group </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> $mmol C\,m^{-2}\,day^{-1}$ </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> Benthic </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> Core </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> `BIV_filtfrac` </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> Filtered fraction of water </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> % </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> Pelagic </td>
   <td style="text-align:center;min-width: 12em; background-color: white !important;"> Optional : biv_tracer = .true. </td>
  </tr>
</tbody>
</table></div>


#### Diagnostics {-}


<div style="border: 1px solid #ddd; padding: 5px; overflow-y: scroll; height:500px; overflow-x: scroll; width:770px; "><table class="table table-hover" style="font-size: 12px; width: auto !important; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">(\#tab:26-diagnostics)Diagnostics</caption>
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
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `BIV_tgrz` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Total rate of food filtration/grazing in the water column </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> $mmol C\,m^{-3}\,day^{-1}$ </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Pelagic diagnostic </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Core </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `BIV_nmp` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Net mussel production </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> $mmol C\,m^{-3}\,day^{-1}$ </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Benthic diagnostic </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Core </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `BIV_tbiv` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Total bivalve density (all groups) </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> $mmol C\,m^{-3}\,day^{-1}$ </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Benthic diagnostic </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Core </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `BIV_grz` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Net bivalve filtration/grazing </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> $mmol C\,m^{-3}\,day^{-1}$ </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Benthic diagnostic </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Core </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `BIV_resp` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Net bivalve respiration </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> $mmol C\,m^{-3}\,day^{-1}$ </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Benthic diagnostic </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Core </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `BIV_mort` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Net bivalve mortality </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> $mmol C\,m^{-3}\,day^{-1}$ </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Benthic diagnostic </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Core </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `BIV_excr` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Net bivalve excretion </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> $mmol C\,m^{-3}\,day^{-1}$ </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Benthic diagnostic </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Core </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `BIV_egst` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Net bivalve egestion (faeces) </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> $mmol C\,m^{-3}\,day^{-1}$ </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Benthic diagnostic </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Core </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `BIV_fT` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Bivalve temperature limitation </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Benthic diagnostic </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Optional: `extra_diag=.true.` </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `BIV_fD` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Bivalve sediment limitation </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Benthic diagnostic </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Optional: `extra_diag=.true.` </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `BIV_fG` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Bivalve food limitation </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Benthic diagnostic </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Optional: `extra_diag=.true.` </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `BIV_fR` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Filtration rate </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> $m^{3}\, mmol C\,m^{-2}\,day^{-1}$ </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Benthic diagnostic </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Optional: `extra_diag=.true.` </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `BIV_pf` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Pseudofeaces production rate </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> $day^{-1}$ </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Benthic diagnostic </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Optional: ` extra_diag=.true.` </td>
  </tr>
</tbody>
</table></div>


###	Parameter Summary


<div style="border: 1px solid #ddd; padding: 5px; overflow-y: scroll; height:500px; overflow-x: scroll; width:770px; "><table class="table table-hover" style="font-size: 12px; width: auto !important; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">(\#tab:26-parametersummmary)Diagnostics</caption>
 <thead>
  <tr>
   <th style="text-align:center;"> name </th>
   <th style="text-align:center;"> 'zebra' </th>
   <th style="text-align:center;"> 'quagga' </th>
   <th style="text-align:center;"> string </th>
   <th style="text-align:center;"> Name of bivalve group </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;"> General Parameters </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `initial_conc` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 833 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 833 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Initial concentration of bivalve (mmolC/m2) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `min` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 8.3 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 8.3 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Minimum concentration of bivalve (mmolC/m3) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `length` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 15 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 15 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Length of bivalve (mm) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `INC` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 291.67 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 291.67 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Ratio of internal nitrogen to carbon of bivalve (-) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `IPC` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 64.58 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 64.58 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Ratio of internal phosphorus to carbon of bivalve (-) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;"> FILTRATION &amp; INGESTION Parameters </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `Rgrz` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 1.9 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0.12 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Maximum ingestion rate of bivalve (mmol/mmol/day) (Spillman et al. 2008) Calculated from Schneider 1992 based on 15 mm mussel </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `Ing` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> integer </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Type of maximum ingestion for bivalve; 0=Enter (mmol/mmol/d) or 1=Calculate based on length </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `WaI` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Maximum standard ingestion rate of bivalve (mmol/mmol/day) (Schneider 1992) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `WbI` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> -0.39 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> -0.39 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Exponent for weight effect on ingestion of bivalve (-) (Schneider 1992) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `fassim` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0.34 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0.34 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Minimum proportion of food lost as pseudofeces for bivalve (-) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `Cmin_grz` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0.05 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0.05 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Minimum prey concentration for grazing by bivalve (mmolC/m3) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `Kgrz` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 187.5 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 187.5 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Optimum algae+POC concentration for ingestion of bivalve (mmol/m3) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `minT` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 4 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 4 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Lower temperature for no ingestion of bivalve (degC) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `Tmin` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 17 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 17 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Lower temperature for optimum ingestion of bivalve (degC) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `Tmax` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 20 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 20 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Upper temperature for optimum ingestion of bivalve (degC) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `maxT` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 32 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 32 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Upper temperature for no ingestion of bivalve (degC) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `Dmax` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 6333.3 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 6333.3 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Upper density for optimum ingestion of bivalve (mmol/m2) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `maxD` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 20000 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 20000 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Upper density for no ingestion of bivalve (mmol/m2) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `Ssmax` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 20 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 20 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Upper suspended solids for optimum ingestion of bivalve (mg/L) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `maxSS` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 100 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 100 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Upper suspended solids for no ingestion of bivalve (mg/L) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;"> EXCRETION AND EGESTION Parameters </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `Rexcr` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Excretion fraction of ingestion for bivalve(-) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `Regst` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Minimum proportion egested as feces for bivalve (-) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `gegst` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Gamma coefficient for food availability dependence for bivalve </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;"> RESPIRATION Parameters </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `Rresp` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0.01 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0.01 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Respiration rate coefficient of bivalve (/day) (Calculated from Schneider 1992 based on 15 mm mussel) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `saltfunc` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> integer </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Type of salinity function for bivalve; 0=None or 1=Spillman et al. 2008 </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `minS` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Lower salinity for no ingestion of bivalve (psu) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `Smin` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Lower salinity for optimum ingestion of bivalve (psu) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `Smax` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Upper salinity for optimum ingestion of bivalve (psu) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `maxS` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Upper salinity for no ingestion of bivalve (psu) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `fR20` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> integer </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Type of maximum respiration for bivalve; 0=Enter or 1=Calculate based on length (mm) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `War` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 16.759 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 16.759 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Standard respiration rate of bivalve (mmol/mmol/d) (Schneider 1992) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `Wbr` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> -0.25 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> -0.25 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Exponent for weight effect on respiration of bivalve (-) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `fR` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 1 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 1 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> integer </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Type of respiration function for bivalve; 0=Schneider 1992 or 1=Spillman et al. 2008 </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `theta_resp` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 1.08 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 1.08 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Temperature multiplier for respiration of bivalve (-) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `TmaxR` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 30 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 30 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Upper temperature for optimum respiration of bivalve (degC) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `maxTR` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 43 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 43 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Upper temperature for no respiration of bivalve (degC) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `Qresp` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 2.3 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 2.3 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Respiration curve slope estimate for bivalve (-) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `SDA` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0.285 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0.285 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Specific dynamic action of bivalve (-) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;"> MORTALITY Parameters </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `Rmort` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Mortality rate coefficient for bivalve (/day) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `Rpred` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Mortality rate from predation of bivalve (/day) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `fDO` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> integer </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Type of dissolved oxygen function for bivalve; 0=None or 1=XXX or 2=XXX </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `K_BDO` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 160 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 160 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Basal respiration rate of bivalve (mmol/m3) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `KDO` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 8 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 8 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Half saturation constant for metabolic response to DO for bivalve (mmol/m3) </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;"> GENERAL Parameters </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;background-color: #E8EAEF !important;">  </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `num_prey` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 3 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 3 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> integer </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Number of state variables for bivalve prey </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `prey(1)%bivalve_prey` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `PHY_green` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `PHY_green` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> string </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> State variable name of bivalve prey </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `prey(1)%Pbiv_prey` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 1 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 1 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Preference factors for bivalve predators grazing on prey </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `prey(2)%bivalve_prey` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `PHY_diatom` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `PHY_diatom` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> string </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> State variable name of bivalve prey </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `prey(2)%Pbiv_prey` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 1 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 1 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Preference factors for bivalve predators grazing on prey </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `prey(3)%bivalve_prey` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `PHY_crypto` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `OGM_poc` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> string </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> State variable name of bivalve prey </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `prey(3)%Pbiv_prey` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 1 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 1 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> real </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Preference factors for bivalve predators grazing on prey </td>
  </tr>
</tbody>
</table></div>


###	Optional Module Links
###	Feedbacks to the Host Model
## Setup & Configuration

### Setup Example

<div style="border: 1px solid #ddd; padding: 5px; overflow-y: scroll; height:500px; overflow-x: scroll; width:770px; "><table class="table table-hover" style="font-size: 12px; width: auto !important; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">(\#tab:26-parameterconfig)Parameters and configuration</caption>
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
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `num_biv` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Number of zooplankton groups </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Integer </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 0-3 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `the_biv` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> List of ID's of groups in aed_zoo_pars.nml (len=num_phyto) </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Integer </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 1/3/17 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `n_zones` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Number of sediment zones where bivalves will be active </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Integer </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `active_zones` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> The vector of sediment zones to include </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Integer (vector) </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `biv_tracer` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Opton to include water column tracer tracking filtration amount </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Boolean </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> .false. </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `biv_feedback` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Switch to enable/disable feedbacks between bivalve metabolism and water column variable concentration </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Boolean </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> .false. </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `dn_target_variable` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Water column variable to receive DON excretion </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> String </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `pn_target_variable` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Water column variable to receive PON egestion/mortality </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> String </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `dp_target_variable` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Water column variable to receive DOP excretion </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> String </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `pp_target_variable` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Water column variable to receive POP egestion/mortality </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> String </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `dc_target_variable` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Water column variable to receive DOC excretion </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> String </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `pc_target_variable` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Water column variable to receive POC egestion/mortality </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> String </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `do_uptake_variable` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Water column variable providing DO concentration </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> String </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `ss_uptake_variable` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Water column variable providing SS concentration </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> String </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `dbase = 'AED2/aed2_bivalve_pars.nml'` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> String </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> aed2_bivalve_pars.nml </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> aed2/aed2_bivalve_pars.nml </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `extra_diag` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Switch to enable/disable extra diagnostics to be output </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Boolean </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> .false. </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `biv_fixedenv` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Switch to enable/disable environmental variables to be fixed (for testing) </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Boolean </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> .false. </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `fixed_temp` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Fixed temperature </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> C </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Float </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 20 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `fixed_oxy` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Fixed oxygen concentration </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> $mmol O_2\,m^{-3}$ </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Float </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 300 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> `fixed_food` </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Fixed food concentration </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> $mmol C\,m^{-3}$ </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> Float </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> 20 </td>
   <td style="text-align:center;min-width: 6em; background-color: white !important;"> NA </td>
  </tr>
</tbody>
</table></div>

<br> 

An example `nml` block for the bivalve module is shown below:

```{style="max-height: 500px;"}
&aed2_bivalve
   num_biv = 2
   the_biv = 1,2
   !
   dn_target_variable=''  ! dissolved nitrogen target variable
   pn_target_variable=''  ! particulate nitrogen target variable
   dp_target_variable=''  ! dissolved phosphorus target variable
   pp_target_variable=''  ! particulate phosphorus target variable
   dc_target_variable=''  ! dissolved carbon target variable
   pc_target_variable=''  ! particulate carbon target variable
   do_uptake_variable='OXY_oxy'  ! oxygen uptake variable
   ss_uptake_variable=''  ! oxygen uptake variable
   !FIX FROM ERIE!
   !n_zones, active_zones, extra_diag,&
   !simBivTracer, simBivFeedback, simStaticBiomass,            &
   !dbase, simFixedEnv, fixed_temp, fixed_sal, fixed_oxy, fixed_food, & initFromDensity
 /
```

## Case Studies & Examples
###	Case Study
###	Publications

