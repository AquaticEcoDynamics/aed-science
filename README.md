# AED Science Manual

[![AED](https://img.shields.io/badge/AED-2.0.0-brightgreen)](https://aquatic.science.uwa.edu.au/research/models/AED/quickstart.html)
[![GPLv3 license](https://img.shields.io/badge/License-GPLv3-blue.svg)](http://perso.crans.org/besson/LICENSE.html)

This repository is the R bookdown science manual and user guide for the AED aquatic ecosystem modelling library.

View the latest version here: https://aquaticecodynamics.github.io/aed-science/



## An open-source platform for modelling Aquatic Ecosystem Dynamics

**AED** is a open-source sceintific modelling library written fortran for simulating the most important aspects of aquatic ecosystems.

This repository is the home of *Modelling Aquatic Eco-Dynamics*, an online book describing AED (previously released as AED2) scientific and operation aspects.

The AED model platform has been applied to many diverse sites across the globe and this book provides assistance to users in gettign started and usign the platform.

## How to contribute?{-}

You may be a new user seeking to understand how to get started, or you may be interested in tailoring a module to your research or management application. As modules evolve, through incremental improvements or wholesale changes, the experts working on these changes can ensure the latest information is available to the community by continuously updating and improving this book.

**bookdown** makes editing a book as easy as editing a wiki, provided you have a GitHub account ([sign-up at github.com](https://github.com/)).
Once logged-in to GitHub, click on the 'edit me' icon highlighted with a red ellipse in the image below.

This will take you to an editable version of the the source [R Markdown](http://rmarkdown.rstudio.com/) file that generated the page you're on:

<center>
```{r editting, echo=FALSE, out.width = '100%'}
knitr::include_graphics("images/index/edit.png")
```
</center>

To raise an issue about the book's content (e.g. code not running) or make a feature request, check-out the [issue tracker](https://github.com/Robinlovelace/geocompr/issues).

Readers may also use the hypothes.is utility on the right margin of the book to add personal annotations and public comments on the book content.

Maintainers and contributors must follow this repository’s [CODE OF CONDUCT](https://github.com/Robinlovelace/geocompr/blob/master/CODE_OF_CONDUCT.md).

## Editing the book{-}

To build the book locally, clone or download this aed-science repo, load R in root directory (e.g. by opening aed-sceince.Rproj in RStudio) and run the following lines:

```{r eval=FALSE}
bookdown::render_book("index.Rmd") # to build the book
browseURL("_book/index.html") # to view it
```

## How to cite this book{-}

Please cite this edited book and the AED model in scientific publications as: 

Hipsey, M.R., (ed.). 2022. Modelling Aquatic Eco-Dynamics: Overview of the AED modular simulation platform.
Zenodo repository. ADD ZENODO DOI LINK HERE. 

If you would like to cite an individual chapter of this book (not the AED model), please
use this format (example given for chapter 4): 

Hipsey, M.R. and P. Huang, 2022. Chapter 4: Dissolved oxygen. In: Hipsey, M.R. (ed.) Modelling Aquatic Eco-Dynamics: Overview of the AED modular simulation platform. Zenodo repository. ADD ZENODO DOI LINK HERE.


## Supporting the project{-}

The AED project is a largely volunteary effort supported by various researchers working on scientific grants. If you find AED useful, please support it by:

- Telling people about it in person
- Join our Slack channel: general-lake-model.slack.com
- Communicating about the model in digital media, e.g. via the "AEDmodel" hashtag on Twitter 
- Citing the book, as described above
- Contributing to this book via [GitHub](https://github.com/AquaticEcoDynamics/aed-science) or the AED model more broadly via [Github](https://github.com/AquaticEcoDynamics)
