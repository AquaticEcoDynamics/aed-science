# AED Science Manual

[![AED](https://img.shields.io/badge/AED-2.0-brightgreen)](https://aquatic.science.uwa.edu.au/research/models/AED/quickstart.html)
[![GPLv3 license](https://img.shields.io/badge/License-GPLv3-blue.svg)](http://perso.crans.org/besson/LICENSE.html)

This repository is the R bookdown science manual and user guide for the AED aquatic ecosystem modelling library.

View the latest version [here](https://aquaticecodynamics.github.io/aed-science/): https://aquaticecodynamics.github.io/aed-science/


## What is AED?

**AED** is a open-source scientific modelling library written in Fortran for simulating the most important aspects of aquatic ecosystems. 

This **aed-science** repository is the home of *Modelling Aquatic Eco-Dynamics: overview of the AED modular simulation platform* online book, which describes the technical details of AED, considering both the scientific and operational aspects; this is often referred to as *"The AED manual"*.

The [AED modelling code-base](https://github.com/AquaticEcoDynamics/libaed-water) is an open-source community-driven library of model components for simulation of **Aquatic Ecosystem Dynamics**. The model has been developed researchers at The University of Western Australia, with active developers also from industry givernemnt and and he broader research community. The code of the AED library consists of numerous modules that are designed as individual model ‘components’ able to be configured in a way that facilitates custom aquatic ecosystem conceptualisations – either simple or complex. These may be relevant to specific water quality problems or aquatic ecosystem investigations. Users select water quality and ecosystem variables they wish to simulate and then are able to customize connections and dependencies with other modules, thereby constructing relevant interactions and feedbacks that may be occurring within an aquatic system. The code also allows for easy customisation at an algorithm level how model components operate (e.g. photosynthesis functions, sorption algorithms etc.). In general, model components consider the cycling of carbon, nitrogen and phosphorus, and other relevant components such as oxygen, and are able to simulate organisms including different functional groups of phytoplankton and zooplankton, and also organic matter. Modules to support simulation of water column and sediment geochemistry, including coupled kinetic- equilibria interactions, are also included.

The model can be used in a wide range of spatial contexts – including with 0D, 1D, 2D and 3D models that are able to simulate the aquatic environment (termed 'host' models). The model has been applied to many diverse aquatic environments across the globe, and this book provides assistance to users in getting started, or advanced users looking to customise their simulation.


## How to cite the AED model and this documentation

Please cite this edited book and the AED model in scientific publications as: 

Hipsey, M.R., (ed.). 2022. Modelling Aquatic Eco-Dynamics: Overview of the AED modular simulation platform.
Zenodo repository. DOI: 10.5281/zenodo.xxxxxx. 

If you would like to cite an individual chapter of this book (not the AED model), please
use this format (example given for chapter 4): 

Hipsey, M.R. and P. Huang, 2022. Chapter 4: Dissolved oxygen. In: Hipsey, M.R. (ed.) Modelling Aquatic Eco-Dynamics: Overview of the AED modular simulation platform. Zenodo repository. DOI: 10.5281/zenodo.xxxxxx.


## How to contribute?

You may be a new user seeking to understand how to get started, or you may be interested in tailoring a module to your research or management application. As modules evolve, through incremental improvements or wholesale changes, experts working on these changes can ensure the latest information is available to the community by continuously updating and improving the model's documentation.

This docuemntation uses **bookdown**, which makes editing a book as easy as editing a wiki, provided you have a GitHub account ([sign-up at github.com](https://github.com/)). Once logged-in to GitHub, click on the 'edit me' icon highlighted with a red ellipse in the image below.

This will take you to an editable version of the [R Markdown](http://rmarkdown.rstudio.com/) source file that generated the page you're on:

<center>
```{r editting, echo=FALSE, out.width = '100%'}
knitr::include_graphics("images/index/edit.png")
```
</center>

To raise an issue about the book's content (e.g. code not running) or make a feature request, check-out the [issue tracker](hhttps://github.com/AquaticEcoDynamics/aed-science/issues).

Readers may also use the **hypothes.is** utility on the right margin of the book to add personal annotations and public comments on the book content.

Maintainers and contributors must follow this repository’s [CODE OF CONDUCT](https://github.com/AquaticEcoDynamics/aed-science/blob/master/CODE_OF_CONDUCT.md).


## Editing the book

To build the book locally, clone or download this `aed-science` repo, load R in root directory (e.g. by opening aed-sceince.Rproj in RStudio) and run the following lines:

```{r eval=FALSE}
bookdown::render_book("index.Rmd") # to build the book
browseURL("_book/index.html") # to view it
```
Any changes and additions can be included within the book by completing a pull-request.

## Supporting the AED model project

The AED project is a largely voluntary effort supported by numerous researchers working on scientific grants. If you find AED useful, please support it by:

- Telling people about it in person
- Join our Slack channel: general-lake-model.slack.com
- Communicating about the model in digital media, e.g. via the "AEDmodel" hashtag on Twitter 
- Citing the book, as described above
- Contributing to this book via [GitHub](https://github.com/AquaticEcoDynamics/aed-science) or the AED model more broadly via [Github](https://github.com/AquaticEcoDynamics)
