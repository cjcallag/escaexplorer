`{escaexplorer}`
================

-   [Installation](#installation)
-   [Launching App](#launching-app)

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/cjcallag/escaexplorer.svg?branch=main)](https://travis-ci.com/cjcallag/escaexplorer)
[![Depends](https://img.shields.io/badge/Depends-GNU_R%3E=3.5-blue.svg)](https://www.r-project.org/)
[![License:
MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://www.mit.edu/~amini/LICENSE.md)
<!-- badges: end -->

**{escaexplorer}** is a repository for the ESCA Explorer application
developed for the City of Seaside Environmental Services Cooperative
Agreement.

## Installation

The R installation can be accomplished using **{remotes}**:

``` r
if(!requireNamespace("remotes")) install.packages("remotes")

remotes::install_github("cjcallag/escaexplorer")
```

## Launching App

Launching can be done programmatically like so:

``` r
escaexplorer::launch_app(app = "explorer",
                         use_browser = TRUE)
```

<img src="man/figures/app.png" width="100%" />
