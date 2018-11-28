[![Travis-CI Build Status](https://travis-ci.org/omarbenites/cropdatape.svg?branch=master)](https://travis-ci.org/omarbenites/cropdatape)

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/omarbenites/cropdatape?branch=master&svg=true)](https://ci.appveyor.com/project/omarbenites/cropdatape)


# cropdatape package

Open data in agriculture is becoming crucial in order to give unrestricve access and reproducible sets of data worldwide. Large amounts of data regarding to yields, harvest areas, food production and nutrition, among others; are relevant to quantify how much we need to feed a big population that is increasing every year. However, this information is stored in formats and files that are not easy to retrieve and analyze. Reseachers, students, and people in general, spend huge amount time and effort cleaning data to get it ready for analysis `(Tidy Data, Hadley W, 2014)`.

Peru is one the most important countries in term of bioversity and food production around the wolrd. Nevertheless, the access to open, clean and curated data is critical. For this reason, `cropdata` arises as an initiave to provide open and cleaned data ready to use. This package have been developed by researchers and students interested in promote findability and accessibility of agricultural crop's production in Peru using `R` and `tidy principles`.


`cropdatape` provides peruvian agricultural production data from the Agriculture Minestry of Peru (MINAGRI). The first version includes `6` crops: `rice`, `quinoa`, `potato`, `sweet potato`, `tomato` and `wheat`; all of them across `24` departments. Initially,  in excel files which has been transformed and assembled using tidy data principles, i.e. each variable is in a column, each observation is a row and each value is in a cell. The variables variables are `sowing` and `harvest area per crop`, `yield`, `production` and `price per plot`, every one year, from `2004` to `2014`.


### Installation

To install this package you need package devtools:
```{r eval=F}
install.packages(devtools)
```
Then type:
```{r eval=F}
devtools::install_github("omarbenites/cropdatape")
```

### Usage
To load the package type in your computer:

```{r eval=F}
library(cropdatape)
```

#Help

To get help about package:

```{r eval=F}
help(package = cropdatape)
```