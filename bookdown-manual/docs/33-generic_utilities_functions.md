# (PART)  Supporting Material {-} 

# Generic Utilities & Functions

## Overview


## Physico-chemical

### Gas Transfer

Target: review and select a few most popularly used gas exchange velocity to be used in AED modules. Note only key factors of wind speed, current speed, and water depths are considered. 

Selection criteria:

1. Environment: ocean; lake; estuary/river;
2. Study for which gas: O~2~, CH~4~, N~2~O, CO~2~
3. Variables: wind speeds ($U$), current speeds ($v$), depths ($h$)
4. Schmidt number normalization: yes/no. $Sc = \frac{\mu }{d} = \frac{\text{kinematic viscosity}}{\text{diffusion}}$


<center>
<div style="border: 1px solid #ddd; padding: 5px; overflow-y: scroll; height:400px; overflow-x: scroll; width:725px; "><table class="table table-condensed" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:center;"> Source </th>
   <th style="text-align:center;"> Computation </th>
   <th style="text-align:center;"> AED Case Number </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;min-width: 12em; "> NA </td>
   <td style="text-align:center;min-width: 17em; "> $schmidt = (0.9+0.1*\frac{salt}{35.0})*(1953.4+temp*(-128.0+temp*(3.9918-temp*0.050091)))$ </td>
   <td style="text-align:center;min-width: 10em; "> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; "> NA </td>
   <td style="text-align:center;min-width: 17em; "> $schmidt = 0.9 + \frac{salt}{350.0}$ <br> $schmidt = schmidt * (2073.1 -125.62*temp +3.6276*temp^{2} - 0.043219*temp^{3})$ </td>
   <td style="text-align:center;min-width: 10em; "> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; "> NA </td>
   <td style="text-align:center;min-width: 17em; "> $schmidt = (1.0 + 3.4e-3*salt)$ <br> $schmidt = schmidt * (1800.6 -120.1*temp +3.7818*temp^{2} - 0.047608*temp^{3})$ </td>
   <td style="text-align:center;min-width: 10em; "> 3 </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; "> Arianto Santoso </td>
   <td style="text-align:center;min-width: 17em; "> $schmidt = 2039.2 - (120.31*temp) + (3.4209*temp^{2}) - (0.040437*temp^{3})$ <br> $schmidt = \frac{schmidt}{600}$ </td>
   <td style="text-align:center;min-width: 10em; "> 4 </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; "> @wanninkhof1992 </td>
   <td style="text-align:center;min-width: 17em; "> $schmidt = 1897.8 - (114.28*temp) + (3.2902*temp^{2}) - (0.039061*temp^{3})$ </td>
   <td style="text-align:center;min-width: 10em; "> 5 </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; "> @wanninkhof1992 </td>
   <td style="text-align:center;min-width: 17em; "> $schmidt = 2055.6 - (137.11*temp) + (4.3173*temp^{2}) - (0.054350*temp^{3})$ </td>
   <td style="text-align:center;min-width: 10em; "> 6 </td>
  </tr>
</tbody>
</table></div>
</center>
<br>
<center>
<div style="border: 1px solid #ddd; padding: 5px; overflow-y: scroll; height:500px; overflow-x: scroll; width:725px; "><table class="table table-condensed" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:center;"> Source </th>
   <th style="text-align:center;"> Computation <br> $v$: current velocity <br> $U$: wind speed <br> $h$: water depth </th>
   <th style="text-align:center;"> Environment </th>
   <th style="text-align:center;"> Gas </th>
   <th style="text-align:center;"> Required Variables </th>
   <th style="text-align:center;"> $Sc$ Normalisation </th>
   <th style="text-align:center;"> Comment </th>
   <th style="text-align:center;"> AED Option Number </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;min-width: 12em; "> @liss1986 </td>
   <td style="text-align:center;min-width: 22em; "> $k = K_{600}(\frac{Sc}{600})^{-\frac{1}{2}}$ <br> $K_{600} = 0.17U$ for $U \leq 3.6$ <br> $K_{600} = 2.85U - 9.65$ for $3.6 \lt U \leq 13$ <br> $K_{600} = 5.9U - 49.3$ for $U \gt 13$ </td>
   <td style="text-align:center;"> Lake and ocean </td>
   <td style="text-align:center;"> CO~2~ </td>
   <td style="text-align:center;"> $U$ </td>
   <td style="text-align:center;"> Yes, 600 </td>
   <td style="text-align:center;min-width: 15em; "> One of the most popular formulas in early stage </td>
   <td style="text-align:center;"> $\Theta_{gas}^{schmidt} = 1$ </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; "> @wanninkhof1992 </td>
   <td style="text-align:center;min-width: 22em; "> $k = 0.31U^{2}(\frac{Sc}{660})^{-\frac{1}{2}}$ </td>
   <td style="text-align:center;"> Ocean, open lakes </td>
   <td style="text-align:center;"> CO~2~ </td>
   <td style="text-align:center;"> $U$ </td>
   <td style="text-align:center;"> Yes, 660 </td>
   <td style="text-align:center;min-width: 15em; "> One of the most globally popular formulas for oceans and lakes </td>
   <td style="text-align:center;"> $\Theta_{gas}^{schmidt} = 2$ </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; "> @wanninkhof2014 </td>
   <td style="text-align:center;min-width: 22em; "> $k = 0.251U^{2}(\frac{Sc}{660})^{-\frac{1}{2}}$ </td>
   <td style="text-align:center;"> Ocean, open lakes </td>
   <td style="text-align:center;"> CO~2~ </td>
   <td style="text-align:center;"> $U$ </td>
   <td style="text-align:center;"> Yes, 660 </td>
   <td style="text-align:center;min-width: 15em; "> Updated formula of @wanninkhof1992. Note the coefficient of 0.251 is now closer to @ho2011, @ho2016, and @borges2004. </td>
   <td style="text-align:center;"> $\Theta_{gas}^{schmidt} = 3$ </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; "> @ho2011 </td>
   <td style="text-align:center;min-width: 22em; "> $k = 0.26U^{2}(\frac{Sc}{600})^{-\frac{1}{2}}$ </td>
   <td style="text-align:center;"> Ocean, coastal area </td>
   <td style="text-align:center;"> He/SF~6~ </td>
   <td style="text-align:center;"> $U$ </td>
   <td style="text-align:center;"> Yes, 600 </td>
   <td style="text-align:center;min-width: 15em; "> Measurement at ocean and coastal area </td>
   <td style="text-align:center;"> $\Theta_{gas}^{schmidt} = 4$ </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; "> @ho2016 </td>
   <td style="text-align:center;min-width: 22em; "> $k = K_{600}(\frac{Sc}{600})^{-\frac{1}{2}}$ <br>  $K_{600} = 0.77v^{\frac{1}{2}}h^{-\frac{1}{2}}+0.266U^{2}$ </td>
   <td style="text-align:center;"> Estuary, rivers </td>
   <td style="text-align:center;"> He/SF~6~ </td>
   <td style="text-align:center;"> $v$,$U$,$h$ </td>
   <td style="text-align:center;"> Yes, 600 </td>
   <td style="text-align:center;min-width: 15em; "> Measurement at estuarine environment </td>
   <td style="text-align:center;"> $\Theta_{gas}^{schmidt} = 5$ </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; "> @raymond2001 </td>
   <td style="text-align:center;min-width: 22em; "> $k = K_{600}(\frac{Sc}{600})^{-\frac{1}{2}}$ <br> $K_{600} = 1.91exp(0.35U)$ </td>
   <td style="text-align:center;"> Estuary, rivers </td>
   <td style="text-align:center;"> CO~2~ </td>
   <td style="text-align:center;"> $U$ </td>
   <td style="text-align:center;"> Yes, 600 </td>
   <td style="text-align:center;min-width: 15em; "> An equation for estuary/river environment but against only on winds based on extensive review. Note the K value here is much higher than ocean environment in high wind speeds  (e.g. @wanninkhof1992). </td>
   <td style="text-align:center;"> $\Theta_{gas}^{schmidt} = 6$ </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; "> @borges2004 </td>
   <td style="text-align:center;min-width: 22em; "> $k = K_{600}(\frac{Sc}{600})^{-\frac{1}{2}}$ <br> $K_{600} = 1.0 + 1.719v^{\frac{1}{2}}h^{\frac{1}{2}}+2.85U$ </td>
   <td style="text-align:center;"> Scheldt Estuary </td>
   <td style="text-align:center;"> CO~2~ </td>
   <td style="text-align:center;"> $v$,$U$,$h$ </td>
   <td style="text-align:center;"> Yes, 600 </td>
   <td style="text-align:center;min-width: 15em; "> A equation for estuary environment from extensive measurement at Scheldt Estuary </td>
   <td style="text-align:center;"> $\Theta_{gas}^{schmidt} = 7$ </td>
  </tr>
  <tr>
   <td style="text-align:center;min-width: 12em; "> @rosentreter2016 </td>
   <td style="text-align:center;min-width: 22em; "> $k = K_{600}(\frac{Sc}{600})^{-\frac{1}{2}}$ <br> $K_{600CO_{2}} = -0.08+0.26v+0.83U+0.59h$ <br> $K_{600CO_{4}} = -1.07+0.36v+0.99U+0.87h$ </td>
   <td style="text-align:center;"> Estuaries </td>
   <td style="text-align:center;"> CO~2~, CH~4~ </td>
   <td style="text-align:center;"> $v$,$U$,$h$ </td>
   <td style="text-align:center;"> Yes, 600 </td>
   <td style="text-align:center;min-width: 15em; "> Equations developed specially for Queensland estuaries </td>
   <td style="text-align:center;"> $\Theta_{gas}^{schmidt} = 8$ </td>
  </tr>
</tbody>
</table></div>
</center>

## Biological



