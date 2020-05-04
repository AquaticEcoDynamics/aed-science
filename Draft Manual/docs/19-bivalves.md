# Bivalves

## Overview 
Based on work in freshwater and estuarine systems a bivalve module to simulate growth, production, and (optionally) population dynamics has been incorporated into the AED2+ library.

The model is originally based on an application to Oneida Lake and Lake Erie for mussels. One to several size classes of mussels are simulated based on physiological parameters assembled by Schneider et al. (1992) and modified by Bierman et al. (2005) to estimate effect of mussels on Saginaw Bay, Michigan, USA; a formulation also used by Gudimov et al. (2015) to estimate mussel effects in Lake Simcoe, Ontario, Canada.  Additionally, some model structure was taken from the Spillman et al. (2008) model of Tapes clams in the Barbamarco Lagoon, Italy, as modified by Bocaniov et al. (2013) for mussels in Lake Erie. 

The physiology of mussels are set to be size dependent, and can vary between species (e.g., Zebra vs Quagga)(Hetherington, 2016).  Three size classes of mussels can be incorporated in the model, roughly corresponding to age-0, age-1 and age>1 mussels.  Physiological parameters are calculated for the weight assigned to each age class, using equations in Table 4.  Individual mussel mass is given in mmol C or in the case of calculations of N and P budgets, in mmol N and mmol P.  The stoichiometric ratios (C:N:P) are fixed.  Group mussel biomass is calculated at each time step by calculating ingestion and subtracting pseudofeces production, standard dynamic action, respiration, excretion, egestion and mortality (expressed in mmol C/mmol C/day, mmol N/mmol N/day; mmol P/mmol P/day).  Several of these processes are also functions of temperature, algal+POC concentrations, salinity, suspended solids and mussel density.  The effect of salinity, suspended solids and mussel density is incorporated as a multiplier of filtration rate with the multipliers having values between -0 – (no filtering) and 1 (no effect). Mussel nitrogen and phosphorus concentrations are fixed ratios of mussel carbon concentrations. Since the various input and output fluxes have variable C:N:P ratios, the excretion of nutrients is dynamically adjusted each time-step to maintain this ratio at each time step.  Reproduction and larval dynamics are not simulated.  There is no transfer of biomass between age groups.

## Process Description

<table>
<caption>**Table 4. Mussel mass balance equations and process parameterisations.**</caption>
<tr>
</tr>
<tr>
<td>
**State Variable Mass Balance Equation**
<center>
<br>
$\frac{\mathrm{dB_{i}} }{\mathrm{dt}}= [I-(R+Ex+Eg+M)]*B$ for $[A] < KA$
</center>
<br>
where $B$ is biomass, $i$ is the size class, gains are ingestion ($I$) (C,N,P), and losses are respiration ($R$) ($C$), excretion ($Ex$) (C,N,P), egestion ($Eg$) (C,N,P), and mortality ($M$) (C,N,P).
</td>
</tr>
<tr>
<td>
**Process Parameterisations**

***Ingestion***
<center>
<br>
$I = I_{max}*F(T)*FR*[A]$
</center>
<br>
where $I$ is ingestion (mmol/mmol/d), $FR$ is filtration rate (m3/mmol/d), $[A]$ is algal + POC concentration (mmol/m3).  
<center>
<br>
$FR = FR_{max}*g(A)*f(D)*f(SS)*f(S)$
</center>
<br>
$FR$ is filtration rate (see below,  m3/mmol/d), $[A]$ is algal + POC concentration (mmol/m3), $f(D)$ is a function of density (D, mmol/m2) with values between 0 and 1 that account for decrease filtering rates at high densities, $f(SS)$ is a function of suspended solids ($SS$, mg/L) with values between 0 and 1 that decrease filtering rates at high suspended solid concentrations and $f(S)$ is a function of salinity ($S$, ppt) with values between 0 and 1 that decrease filtering rates at high salinities.
<center>
<br>
$FR_{max} = aW^{b}$
</center>
<br>
This is the maximum filtration rate at optimal temperature for a given individual mussel weight (mmol C). 

***Respiration***

</td>
</tr>
</table>



### Ingestion
Ingestion is modelled as a function of filtration rate, food availability, pseudofeces production, density, suspended solids, and salinity (Equation 2) (Schneider 1992; Bierman et al. 2005; Spillman et al. 2008; Gudimov et al. 2015). Filtration rate is based on maximum ingestion, temperature, food availability, and pseudofeces production according to the following:
<center>
<br>
$FR = \frac{\frac{I_{max}*f(T)_{I}}{K_{A}}}{PF_{min}}$ for $[A] < KA$
</center>
<br>
<center>
$FR = \frac{\frac{I_{max}*f(T)_{I}}{[A]}}{PF_{min}}$ for $[A] > KA$
</center>
<br>
where $FR$ is filtration rate (mmol/mmol/d), $I_{max}$ is maximum ingestion rate (mmol/mmol/d), $f(T)_{I}$ is filtration temperature function, $K_{A}$ is optimum algal concentration (mmol/m3), $[A]$ is algal concentration + particulate organic carbon (POC) concentration (mmol/m3), and $PF_{min}$ is minimum pseudofeces production (-).
The maximum ingestion rate is based on weight from length according to the following:
<center>
<br>
$I_{max} = (a_{I} * W^{bI})$
</center>
<br>
<center>
$W = \frac{0.071}{1000} * L^{2.8}$
</center>
<br>
where $I_{max}$ is maximum ingestion rate (mmol/mmol/d), $a_{I}$ is maximum standard ingestion rate (mmol/mmol/d), $W$ is weight (g), $bI$ is exponent for weight effect on ingestion, $L$ in length (mm) (Schneider et al. 1992; Bierman et al. 2005).
The temperature dependence function (Thornton and Lessem 1978) was fit to zebra and quagga mussel data (Hetherington et al. Submitted) with optimal ingestion from 17°C to 20°C according to the following:
<center>
<br>
$f(T)_{I} = 1$ for $T_{min_{I}} < T < T_{max_{I}}$
</center>
<br>
<center>
$f(T)_{I} = (2*\frac{T_{min_{TI}}}{T_{min_{I}}} - \frac{(T_{min_{TI}})^2}{(T_{min_{I}})^2}) / (2*\frac{T_{min_{I}}-min_{T_{I}}}{T_{min_{I}}}-\frac{(T_{min_{I}}-min_{T_{I}})^2}{(T_{min_{I}})^2})$ for $min_{T_{I}} < T < T_{min_{I}}$
</center>
<br>
f(T)I = -(T2 + 2*TmaxI*T – 2*TmaxI*maxTI + maxTI2)/(TmaxI-maxTI)2		for TmaxI<T<maxTI
f(T)I = 0 							             		for T > maxTI or T < minTI
where T is temperature (°C), minTI is lower temperature for no ingestion (°C), TminI is lower temperature for optimum ingestion (°C), TmaxI is upper temperature for optimum ingestion, maxTI is upper temperature for no ingestion (°C).
Filtration rate is related to food concentration (Walz 1978, Sprung and Rose 1988, Schneider 1992; Bierman et al. 2005). The filtration rate is maintained at a maximum value for all food values less than saturation food concentration. The filtration rate decreases as food concentrations increase above this value.
Pseudofeces production is implicit as the difference between the mass filtered and consumed. According to Walz (1978), pseudofeces production (66%) was approximately double the ingestion rate (34%) at high food concentrations (Bierman et al. 2005).
 
Mussel density limits ingestion above some maximum density according to the following: 
f(D) = 1 								     	     	for D<Dmax
f(D) = -(D2 + 2*Dmax*D – 2*Dmax*maxD + maxD2)/(Dmax – maxD)2 	     		for D>Dmax
f(D) = 0 								    		for D>maxD
where D is density (mmol/m2), Dmax is upper density for optimum ingestion (mmol/m2), and maxD is upper density for no ingestion (mmol/m2).
An additional function to reduce ingestion is the suspended solids function which decreases ingestion with high inorganic loads according to the following:
f(SS) = 1									  	for SS<SSmax
f(SS) = -(SS2 + 2*SSmax*SS – 2*SSmax*maxSS + maxSS2)/(SSmax – maxSS)2 		for SS>SSmax
f(SS) = 0									  	for SS>maxSS
where SS is suspended solids (mg/L), SSmax is upper suspended solids for optimum ingestion (mg/L), and maxSS is upper suspended solids for no ingestion (mg/L) (Spillman et al. 2008).
Along with suspended solids, salinity limits ingestion according to the following: 
f(S) = 1 									         	for Smin < S < Smax
f(S) = ((2*(S-minS)/Smin)–(S-minS)2/Smin2)) / ((2*(Smin-minS)/Smin)–(Smin-minS)2/Smin2))	for minS< S < Smin 
f(S) = -(S2 + 2*Smax*S – 2*Smax*maxS + maxS2)/(Smax-maxS)2		            		for Smax<S<maxS
f(S) = 0 									 	for S > maxS or S < minS
where S is salinity (psu), minS is lower salinity for no ingestion (psu), Smin is lower salinity for optimum ingestion (psu), Smax is upper salinity for optimum ingestion (psu), maxS is upper salinity for no ingestion (psu) (Spillman et al. 2008).

### Respiration
Respiration is modelled as a base or standard respiration rate based on weight and temperature  (Spillman et al. 2008). Respiration rate coefficient at 20°C is based on weight from length according to the following:
R20 = (aR * WbR)
W = (0.071/1000) * L2.8
where R20 is respiration rate coefficient at 20°C (mmol/mmol/d), aR is standard respiration rate (mmol/mmol/d), W is weight (g), bR is exponent for weight effect of respiration, and L is length (mm) (Schneider 1992).
The respiration rate coefficient is adjusted for temperature according to the following:
f(T)RSpillman = ϴRSpillmanT-20
where f(T)RSpillman is respiration temperature function, ϴRSpillman is temperature multiplier for bivalve respiration (-), and T is temperature (°C) (Spillman et al. 2008).
Alternatively, respiration is modelled as a base or standard respiration rate based on weight and temperature in addition to the energetic cost of feeding. Respiration rate coefficient at 30°C is based on weight from length according to the following:
R30 = (aR * WbR)
W = (0.071/1000) * L2.8
where R30 is respiration rate coefficient at 30°C (mmol/mmol/d), aR is standard respiration rate (mmol/mmol/d), W is weight (g), bR is exponent for weight effect of respiration, and L is length (mm) (Schneider 1992).
The temperature function follows Schneider’s (1992) application of the model of Kitchell et al. (1977) to the data of Alexander and McMahon (2004) according to the following:
f(T)RSchneider = VX * eX * (1-V)
V = ((TmaxR – T)/(TmaxR – maxTR))
X = ((W * (1 + SQRT(1 + (40 / Y))) / 20)2
W = (lnQR*(TmaxR – maxTR)
Y = lnQR*(TmaxR – maxTR + 2)
where T is temperature (°C), TmaxR is upper temperature for optimum respiration (°C), maxTR is upper temperature for no respiration (°C), and QR is respiration curve slope estimate (-). The maximum respiration occurs at 30°C with 43°C as the upper lethal temperature.
The energetic cost of feeding or specific dynamic action is applied only to the portion of ingestion that is not egested (Schneider 1992; Bierman et al. 2005; Gudimov et al. 2015).

### Excretion
Excretion is modelled as a constant fraction of assimilated food (Schneider 1992; Bierman et al. 2005; Gudimov et al. 2015). Excretion data for zebra and quagga mussels are limited; therefore, the excretion formulation for Mytilus edulis derived by Bayne and Newell (1983) was used (Schneider 1992; Bierman et al. 2005; Gudimov et al. 2015).

### Egestion
Egestion is modeled as a function of ingestion (Schneider 1992; Bierman et al. 2005; Gudimov et al. 2015). The model follows the assumption that ingestion is directly proportional to the food content of the water for all food concentrations less than the maximum which can be ingested. For all food concentrations above this saturation value, ingestion remains constant at a maximum value (Imax) (Walz 1978).

### Mortality
Mortality is a function of dissolved oxygen and predation (Equation 7). Mortality increases with low dissolved oxygen concentrations according to the following:
f(DO) = 1 + KBDO * (KDO / (KDO + DO)) 
where DO is dissolved oxygen (mmol/m3), KBDO is basal respiration rate (mmol/m3), and KDO is half saturation constant for metabolic response to dissolved oxygen (mmol/m3) (Spillman et al. 2008). A mortality rate coefficient (KMORT) further influences the dissolved oxygen function. Additionally, mortality from predation is a constant rate added to the effect from dissolved oxygen.


## Parameter Summary


## Setup & Configuration

## References

<div id="refs"></div> 
