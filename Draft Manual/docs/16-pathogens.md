# Pathogens 

## Overview 

Understanding the fate and transport of pathogenic and indicator microbes within drinking water reservoirs is critical for managers to effectively reduce risk. Over the past decade several advances have been made for the simulating organism dynamics using coupled hydrodynamic-organism fate models. These have generally been used for simulating coliform bacteria (Hipsey et al., 2008), with applications also reported for Cryptosporidium (Hipsey et al., 2004) and viruses [@Sokolova2012] . In general, these models simulate organism concentrations within water bodies by accounting for external loading, advection and mixing process that occur within the lake interior, organism inactivation and sedimentation. The purpose of this document is to firstly synthesize relevant information from empirical and prior modelling studies to justify the necessary model required for reservoir systems, and secondly to summarise the implementation of the pathogen module within the AED2 model framework.  

## Process Description

### General Approach

The general balance equation for organism transport and fate is summarized in Hipsey et al., (2008) as: 

where $C$ is the organic concentration (orgs m-3), $t$ is time, xj is the distance in the $j$-th dimension (m), Uj is the velocity in the j-th dimension (m s-1), is the eddy-diffusivity and Cin and Cout are the inflow and outflow fluxes respectively (orgs m-3 s-1). This relates organism concentration through time to hydrodynamic characteristics within the lake (as captured by $U$, and ), and the environmental conditions experienced that influence organism fate (including temperature, salinity, light intensity, dissolved organic carbon, oxygen and pH). This comprehensive description is usually simplified for specific applications, based on justification of the dominant processes present in any particular lake and available data for model setup and validation. 

Within the TUFLOWFV-AED2 model framework, the 1st three terms on the RHS are solved via the finite volume scalar transport routines with TUFLOW-FV and the fourth and fifth terms are simulated by the aed2_pathogens module of the AED2 aquatic ecological modelling library. For this application the growth and predation terms suggested by Hipsey et al. (2008) are not considered directly since the likelihood of growth is small [@toze2012] and predation/grazing is factored into the die-off rate (described below). The remaining terms for simulation of organism resuspension and inactivation are described in detail next.

### Natural Mortality 

Natural mortality, or the ‘dark-death rate’, $kd$, is an important process determining the net rate of die off of protozoan, viral and bacterial organisms and has been reported to vary for specific organisms due to changes in temperature, salinity and pH. The reported die off rates in the literature however are widely variable, with a synthesis of numerous studies from a range of water bodies presented in Hipsey et al., (2008). For freshwater reservoirs, changes in salinity and pH are unlikely to be a significant driver of organism viability relative to the range presented Hipsey et al., (2008) and therefore a simple constant die-off rate that depends on temperature is appropriate: 

where is the rate of mortality in the dark at 20C and in freshwater. Since the AED2 implementation of the model to be applied with NPD does not include protozoan grazing as a separate term (as in Eq 1), the grazing effect needs to be embodied within the term. This effectively assumes a constant grazing pressure over time, and if chosen to be a low value this will essentially ensure conservative estimate of the die-off due to grazing. Empirical data from Wivenhoe dam shows the presence of native micro-organisms can increase the background die-off rate by 1.1-3.0x (eg Table 5 in @toze2012). 

### Sunlight Inactivation 
Depending on the clarity of the water, the light climate of the lake can be a dominant factor influencing organism viability and this has been observed empirically in Wivenhoe Dam by @toze2012. Different organism types experience different sensitivity to different light bandwidths, with most organisms sensitive to UV-B and UV-A and some sensitive to light in the visible spectrum [@sinton2007]. Hipsey et al. (2008) formulated a multiple band-width model for organisms that included direct and indirect mechanisms for sunlight mediated inactivation by accounting for the effect of salinity, oxygen and pH on free radical formation. Here we use a simplified form that accounts only for direct sunlight denaturation as the indirect mechanism is more specific to MS2 phage relative to rotavirus for example [@verbyla2015]. The implemented expression is therefore: 

where NB is the number of discrete solar bandwidths to be modeled, $b$ is the bandwidth class
{1, 2, … , NB}, kb is the freshwater inactivation rate coefficient for exposure to the bth class (m2 MJ-1), Ib is the intensity of the bth bandwidth class (Wm-2), j is a constant to convert units from seconds to days and J to MJ (= 8.64´10-2).  
 
In AED2, the light intensity is computed for 3 distinct bandwidths, including UV-B, UV-A and PAR, and the attenuation of each through the reservoir water column is based on bandwidth specific light extinction coefficients, that account for the effect of turbidity and chromophoric dissolved organic matter (CDOM) on attenutation. 

### Sedimentation 

Sedimentation of organisms occurs at a rate depending on the degree to which the population is attached to suspended particles. Within AED2, this is captured by simulating free and attached organisms and multiple groups of particles may be accounted for. If we assume a single dominant particle size and ignore the effect of salinity on the settling velocity, then the expression in Hipsey et al (2008) for the effective sedimentation velocity reduces to:  
where fa is the attached fraction, and $V$ is the vertical velocity of organisms or sediment particles.  

### Resupension 

Resuspension of organisms accumulated within the sediment has been show to be a relatively important terms in environments where high currents or waves exist. In reservoirs this can occur in the lake margins or deeper in the lake where internal waves or river underflows increase the shear stress at the sediment. The amount of organisms that resuspend depends not only on the shear stress but also n the concentration of organisms in the surficial layers of the sediment. This may be modelled by accounting for the deposited organisms, decay within the sediment and resuspension rate, however, this is notoriously difficult given potentially complex dynamics of organisms in the sediment. Instead we assume that a standard background concentration exists within different sediment regions (based on depth and local geomorphology) and simulate resuspension rate as: 

where, is the rate of organism suspension (orgs m-2 s-1), which occurs when the critical shear stress is exceeded in the relative computational cell. 

## Parameter Summary

## Setup & Configuration

## References

<div id="refs"></div> 
