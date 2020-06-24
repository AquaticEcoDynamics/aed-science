# Dissolved Oxygen 

## Contributors


## Overview 

Dissolved Oxygen (DO) dynamics respond to processes of atmospheric exchange, sediment oxygen demand, microbial use during organic matter mineralisation and nitrification, photosynthetic oxygen production and respiratory oxygen consumption, chemical oxygen demand, and respiration by other biotic components such as seagrass and bivalves (see table below).

Other processes impacting the oxygen concentration include the breakdown of DOC by aerobic heterotrophic bacteria to CO2, whereby a stoichiometrically equivalent amount of oxygen is removed. Chemical oxidation, for example processes such as nitrification or sulfide oxidation, also consume oxygen dependent on the relevant stoichiometric factor. Photosynthetic oxygen production and respiratory oxygen consumption by pelagic phytoplankton is also included and is summed over the number of simulated phytoplankton groups. Seagrass interaction with the oxygen cycle is configurable within the model.


## Model Description

### Process Descriptions

<!-- previously from 'aed2_oxygen : oxygen solubility & atmospheric exchange' on website version-->
#### Oxygen Solubility & Atmospheric Exchange {-} 
Atmospheric exchange is typically modelled based on Wanninkhof (1992) and the flux equation of Riley and Skirrow (1974) for the open water, and on Ho et al. (2011) for estuarine environments.
\begin{equation}
								F_{O_2} = k_{O_2} \left(C_{air} - C_{water}\right)
\end{equation}
Where $k_{O_2} (ms^{-1})$ is the oxygen transfer coefficient, $C_{water} (gm^{-3})$ is the oxygen concentration in the surface waters near the interface and $C_{air} (gm^{-3})$ is the concentration of oxygen in the air phase near the interface. A positive flux represents input of oxygen from the atmosphere to the water. $C_{air}$ is dependent on temperature, $T$, salinity, $S$ and atmospheric pressure, $p$, as given by:
\begin{eqnarray}
							C_{air}\left(T,S,p \right) &=& 1.42763\: f\left(p\right) \exp \left\{ -173.4292+249.6339 \left[\frac{100}{\theta_k}\right] + 143.3483 \ln \left[ \frac{\theta_k}{100}\right] \right. \nonumber \\ &-& \left. 21.8492 \left[\frac{\theta_k}{100}\right] + S\left(-0.033096 +0.014259 \left[\frac{\theta_k}{100}\right] -0.0017 \left[\frac{\theta_k}{100}\right]^2 \right) \right\}
\end{eqnarray}
Where $\theta_k$ is temperature in degrees Kelvin, salinity is expressed as parts per thousand and atmospheric pressure is in kPa. The pressure correction function, $f(p)$ varies between one and zero for the surface and high altitudes respectively: 
\begin{equation}
							f\left(p\right)=\frac{p_H}{p_{SL}}\left[1-\frac{p_{vap}}{p_H}\right]/\left[1-\frac{p_{vap}}{p_{SL}}\right].
\end{equation}


#### aed2_oxygen : sediment oxygen demand {-} 
Modelling sediment oxygen demand can take a variety of forms. The simplest form in AED2 is the $SOD$ varies as a function of the overlying water temperature and dissolved oxygen levels.
\begin{equation}
							f_{O_2}^{DSF}(T,DO)= S_{SOD}\:f_{SED}^{T2}(T)\:f_{SOD}^{DO1}(DO)
\end{equation}

Where $S_{SOD}$ is a fixed oxygen flux across the sediment-water interface and $K_{DO_{SOD}}$ is a half-saturation constant for the sediment oxygen demand.

#### Other oxygen sources/sinks (optional) {-} 
- Oxygen consumption during baterial mineralisation of DOC is done in the bacteria module - aed2_bacteria;
- Oxygen consumption during nitrification is done in the nitrogen module - [aed2_nitrogen][Inorganic Nutrients: C/N/P/Si];
- Oxygen production/consumption by phytoplankton phtosynthesis/respiration is done in the phytoplankton module - [aed2_phytoplankton][Phytoplankton];
- Oxygen consumption due to zooplankton respiration is done in the zooplankton module - [aed2_zooplankton][Zooplankton];
- Oxygen production/consumption by seagrass phtosynthesis/respiration is done in the bateria module - aed2_seagrass;
- Oxygen consumption due to bivalve respiration is done in the benthic module - [aed2_benthic][Benthic Vegetation];

### Variable Summary



#### Diagnostics{-}

### Parameter Summary


### Optional Module Links


### Feedbacks to the Host Model


## Setup & Configuration
<!--Previously from 'Setup Example'-->
An example `nml` block for the oxygen module is shown below:
```{}
&aed2_oxygen
   oxy_initial = 225.0
   Fsed_oxy = -40.0
   Ksed_oxy = 100.0
   theta_sed_oxy = 1.08
!  Fsed_oxy_variable = 'SDF_Fsed_oxy'
   oxy_min = 0
   oxy_max = 500
 /
```


## Case Studies & Examples

### Case Study

<!--html_preserve--><div id="htmlwidget-463ed6c10fc2f8c92984" style="width:770px;height:385px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-463ed6c10fc2f8c92984">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"setView":[[-31.991618,115.835235],10,[]],"calls":[{"method":"addTiles","args":["//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]},{"method":"addMarkers","args":[-31.991618,115.835235,null,null,null,{"interactive":true,"draggable":false,"keyboard":true,"title":"","alt":"","zIndexOffset":0,"opacity":1,"riseOnHover":false,"riseOffset":250},"Swan River",null,null,null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"limits":{"lat":[-31.991618,-31.991618],"lng":[115.835235,115.835235]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

<br>


<!-- Previously from 'Examples' on website version -->

<center>

![Example 1: Cross-section plots comparing modelled and field salinity (psu, left) and oxygen (mg/L, right) for Sep-Dec 2008 at Swan River. The field plots are based on a contouring around 20 profile data locations.](images/oxygen_example4.png){width=75%}

</center>

<center>

![Example 2: The total area of anoxia (<2 mg O2 / L) and hypoxia (<4 mg O2 / L) within the estuary for 2008 and 2010, comparing the model (black line) and spatially interpolated weekly profile data (shaded region).](images/oxygen_example2.png){width=75%} 

</center>

### Publications

