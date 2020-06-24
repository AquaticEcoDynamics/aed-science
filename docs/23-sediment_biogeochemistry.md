# (PART) AED+ Benthic Modules {-} 

# Sediment Biogeochemistry

## Contributors

Daniel Paraska, Matthew R Hipsey

## Overview

Sediment diagenesis models are highly complex environmental reactive transport modelling tools. The meta-analysis by Paraska et al (2014) discussed the history of their evolution to these complex configurations, in which the original models of Boudreau (1996), Van Cappellen and Wang (1996) and Soetaert et al. (1996) were taken up and applied in many contexts by new modellers, who added new features and extended their capabilities, or discarded old features as required. The meta-analysis also identified the major challenges associated with developing new sediment diagenesis models. Here, a new modelling package for sediment biogeochemistry is presented, CANDI-AED, which is an extension of the Approach 1 models, but reengineered and augmented with new model approaches and capabilities as a way to address some of these challenges. 

Paraska et al (in prep) outlined the significance and uncertainty associated with different parameterisation approaches of organic matter dynamics. In these cases, simulations were run to test the significance of different theoretical approaches and model structural assumptions, using an idealised model setup with only primary oxidation reactions and no physical processes or spatial resolution. The true impact of these different model approaches within a spatially-resolved model, accounting for all of the advection, diffusion and secondary reaction processes, however, is yet to be determined and it is unclear whether some formulations may suit some application contexts better than others. Therefore there is a need for a fully flexible model structure that can include these different organic matter breakdown parameterisations and allow users to assess critically the alternative approaches. In addition, other aspects related to 
secondary redox reactions, mineral reactions, precipitation and adsorption should similarly be subject to comparative assessments.

A further challenge identified in Paraska et al (2014) was the difficulty involved in taking up these models by the broader modelling community, because of problems related to connecting these complex model structures with other water quality and aquatic ecosystem models. For example, there are problems related to mapping variables of ecosystem models to those of diagenesis models. There are also problems related to the mismatch between the resolution of processes that occur over different spatial and temporal scales, for example fast equilibrium reactions between sediment layers, and seasonal temperature or salinity changes across a study site.

The model developed as part of this research aimed to address these challenges by building a full-featured, open-source model code with the flexibility to do the following:
-	set different kinetic rate equation approaches
-	set different organic matter pools and breakdown processes
-	use standard inhibition or thermodynamic limits on primary oxidation
- optionally use manganese, iron and iron sulphide reactions
-	simulate adsorbed metals and nutrients
-	simulate calcium, iron and manganese carbonates
-	connect the boundary to either another model, a programmed file or a fixed concentration
Therefore the numerical model presented in this chapter has many optional features and alternative parameterisations for key processes, without mandating their inclusion in the calculations or enforcing a fixed model structure. To facilitate the coupling, the model is implemented with the “Framework for Aquatic Biogeochemical Models” (FABM), which is a new object-oriented model software framework by Bruggeman and Bolding (2014). Through the definition of a generic architecture for configuring and coupling both benthic and pelagic models, the FABM has been designed to couple a wide range of ecological and biogeochemical models from various developers with numerous different hydrodynamic models (Trolle et al. 2011). To date the FABM has been applied with the 1D lake hydrodynamic model GLM (Hipsey et al. 2014), and the unstructured mesh model TUFLOW-FV (Bruce et al. 2014).

The sediment model CANDI-AED presented here is implemented within the AED model library within the FABM (Hipsey et al. 2013b), however, it is able to couple with one or more of the FABM model libraries (Figure \@ref(fig:23-pic1)). Through the model coupling approach it may be applied with any of the hydrodynamic models listed above, or alternatively, run in isolation. This document provides a complete scientific description of the model and describes attributes of the model associated with its practical implementation and operation. An application of the model framework is subsequently demonstrated. 

<center>
<div class="figure">
<img src="images/23-sediment_biogeochemistry/image1.png" alt="Schematic of the framework of aquatic biogeochemical models. The new diagenesis model code AED CANDI fits into the category of multilayer 1D diagenesis models, coupled to other biogeochemical and physical models (Trolle et al. 2011)" width="75%" />
<p class="caption">(\#fig:23-pic1)Schematic of the framework of aquatic biogeochemical models. The new diagenesis model code AED CANDI fits into the category of multilayer 1D diagenesis models, coupled to other biogeochemical and physical models (Trolle et al. 2011)</p>
</div>
</center>

## Model Description
###	Process Descriptions
###	Variable Summary
###	Parameter Summary
###	Optional Module Links
###	Feedbacks to the Host Model
## Setup & Configuration
## Case Studies & Examples
###	Case Study
###	Publications
