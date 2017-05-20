# pkgnews

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/imanuelcostigan/pkgnews?branch=master&svg=true)](https://ci.appveyor.com/project/imanuelcostigan/pkgnews) [![Travis-CI Build Status](https://travis-ci.org/imanuelcostigan/pkgnews.svg?branch=master)](https://travis-ci.org/imanuelcostigan/pkgnews) [![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/pkgnews)](https://cran.r-project.org/package=pkgnews)

The goal of pkgnews is to make it easier to view package all the main types of `NEWS` files used by package maintainers including the following: `NEWS`, `NEWS.md` or `NEWS.markdown` and `inst/NEWS.Rd` files. At present the first and second is supported by `utils::news()`. However, `NEWS.md` files cannot be as parsimoniously read. 

This package provides `show_pkg_news()` that wraps `utils::news()` in the cases where this works and supports `NEWS.md` files in a similarly parsimonious fashion. It also provides a shortcut to access a Github hosted package's release page where the Github URL is listed in its `DESCRIPTION` file.

## Install

This isn't on CRAN. You can install this from Github directly:

```r
ghit::install_github("imanuelcostigan/pkgnews")
```

## Example

``` r
## NEWS
show_pkg_news("curl")

## inst/NEWS.Rd
show_pkg_news("Rcpp")

## NEWS.md
show_pkg_news("dplyr")

## Github release page
show_pkg_news("dplyr", gh_release = TRUE)
```
