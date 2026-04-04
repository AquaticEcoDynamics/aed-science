# AED Science Book - Rebuild Notes (2026-04-03)

## Project Summary

Bookdown project ("The AED Manual") describing the AED aquatic ecosystem modelling platform. Built from ~20 active `.Rmd` chapters via `bookdown::gitbook`. RStudio project file: `aed_manual.Rproj`.

## Environment

- **R version**: 4.2.2 (system install at `/usr/local/bin/R`)
- **Platform**: macOS (aarch64-apple-darwin20, Apple Silicon)
- **Pandoc**: 3.1.2 required (installed via R `pandoc` package at `~/Library/Application Support/r-pandoc/3.1.2`)

## Issues Resolved

### 1. Stale renv environment

The project had an `renv` setup from 2022 (lockfile pinned to R 4.2.0, 147 packages) but it was never actually used on this machine - the library was empty. Content continued to be edited through 2024 using global R packages.

**Fix**: Deactivated renv with `renv::deactivate()`. This removed `.Rprofile`. The project now uses the global R library.

### 2. Missing system libraries for R package compilation

Several R packages required system libraries not present on the machine:

| R Package | System Dependency | Install Command |
|-----------|------------------|-----------------|
| `terra`, `sf` | GDAL, PROJ, GEOS | `brew install gdal` |
| `oce`, `units` | udunits | `brew install udunits` |
| `ggtext`/`gridtext` | harfbuzz, fribidi | `brew install harfbuzz fribidi` |
| `jpeg` | libjpeg | `brew install jpeg` |
| Pandoc (not installed) | - | `brew install pandoc` |

### 3. gfortran not found by R

R's `Makeconf` hardcodes paths to `/opt/R/arm64/bin/gfortran` and `/opt/R/arm64/gfortran/lib/` for the Fortran compiler and libraries, but only Homebrew's GCC (`/opt/homebrew/bin/gfortran`) was available.

**Fix**: Created symlinks:
```bash
sudo ln -s /opt/homebrew/bin/gfortran /opt/R/arm64/bin/gfortran
sudo mkdir -p /opt/R/arm64/gfortran/lib/gcc/aarch64-apple-darwin20.6.0/12.0.1
sudo ln -s /opt/homebrew/lib/gcc/current/* /opt/R/arm64/gfortran/lib/gcc/aarch64-apple-darwin20.6.0/12.0.1/
sudo ln -s /opt/homebrew/lib/gcc/current/* /opt/R/arm64/gfortran/lib/
```

### 4. Homebrew include/lib paths not found by R compiler

R packages needing headers from Homebrew (e.g., `jpeg`) couldn't find them.

**Fix**: Created `~/.R/Makevars`:
```
CPPFLAGS += -I/opt/homebrew/include
LDFLAGS += -L/opt/homebrew/lib
FLIBS = -L/opt/homebrew/lib/gcc/current -lgfortran
```

The `FLIBS` override was also needed because R's default `FLIBS` references `-lemutls_w` and `-lquadmath`, which are specific to the older Apple gfortran and don't exist in Homebrew GCC 15.

### 5. Deprecated leaflet tile provider

`providers$Stamen.Terrain` was removed from the `leaflet` package (Stamen tiles retired).

**Fix**: Replaced with `providers$Stadia.StamenTerrain` in 4 source files:
- `10-dissolved_oxygen.Rmd`
- `11-carbon.Rmd`
- `16-phytoplankton.Rmd`
- `21-pesticides.Rmd`

### 6. Bookdown package version mismatches

`bookdown` 0.34 required a newer `xfun` than was installed.

**Fix**: Updated `xfun`, `knitr`, `rmarkdown`, and `bookdown` to current versions (bookdown 0.46).

### 7. Pandoc 3.9 breaks the table of contents

Pandoc 3.9 (from Homebrew) mishandles the `:::` fenced div / panelset syntax used in `23-sediment_biogeochemistry.Rmd`. It treats `::: panel` as opening divs that never properly close, which causes subsequent chapter `#` headings to be nested inside those divs. Bookdown then can't detect them as top-level chapters, so the sidebar TOC was truncated to only 9 of 18 chapters. The HTML pages themselves were generated but weren't linked in navigation.

**Fix**: Use pandoc 3.1.2 instead. Installed via `pandoc::pandoc_install("3.1.2")` in R. Build command:
```bash
PATH="$HOME/Library/Application Support/r-pandoc/3.1.2:$PATH" \
  Rscript -e 'bookdown::render_book("index.Rmd", "bookdown::gitbook")'
```

Or from RStudio, add to `.Rprofile`:
```r
Sys.setenv(PATH = paste0("~/Library/Application Support/r-pandoc/3.1.2:", Sys.getenv("PATH")))
```

## Build Command

```bash
PATH="$HOME/Library/Application Support/r-pandoc/3.1.2:$PATH" \
  Rscript -e 'bookdown::render_book("index.Rmd", "bookdown::gitbook")'
```

Output: `docs/index.html`
