
# academyDatasets

<!-- badges: start -->
[![R-CMD-check](https://github.com/rstudio/academyDatasets/workflows/R-CMD-check/badge.svg)](https://github.com/rstudio/academyDatasets/actions)
<!-- badges: end -->

Datasets for use with RStudio Academy exercises, tutorials, and recipes.

## Installation

To install academyDatasets from GitHub, be sure to [connect your computer to your GitHub account](https://happygitwithr.com/push-pull-github.html). Then, use the remotes package to install academyDatasets:

``` r
remotes::install_github("rstudio/academyDatasets")
```

## Adding a new dataset

You have a new dataset you would like to add to this collection. Great!

Before you get started, clone (but don't _fork_) this repository onto your computer.
Then, open the academyDatasets project in RStudio and create a new branch named after the data you'll be adding.
When you're done with the process below, you'll push this branch to GitHub and open a pull request for review.

One way to quickly create this branch is to use [usethis](https://usethis.r-lib.org).

```r
usethis::pr_init("dataset-name"")
```

### Import and clean the data (`data-raw/<dataset>/<dataset>.R`)

Start by creating a folder in `data-raw` named after your dataset.
In this folder, you can add any R scripts or data files that you need to import and process your dataset.

If possible, download the data using `download.file()` in R rather than manually copying the source data into this folder.
Use the [here](https://here.r-lib.org/) package to create robust file paths.
For example, I used the following pattern to download the MDRD source data into `data-raw/mdrd/`.

```r
remote_url <- "https://rsacdn.link/ac/milestones/fda/pilot/milestone-3/data/data_3_baseline.xpt"
local_path <- here::here("data-raw", "mdrd", basename(remote_url))
download.file(remote_url, local_path)
```

There are no restrictions on the packages you can use in this file,
since it will not be part of the final academyDatasets package.
Please make a note if you use a package that isn't part of the tidyverse.

Your goal in this step is to create a reproducible flow that

1. Downloads the data
2. Imports and cleans it in R
3. Stores the data in an object with the datasets final name

### Describe the data (`data-raw/<dataset>/<dataset>.R`)

I've created a helper function called `describe_dataset()` that will create a small, machine-readable data dictionary and will make it easier to write the package documentation.

To use this function, you should add `pkgload::load_all()` to the top of your data-sourcing R script. Then, after creating your final data object, you can create a new object with the suffix `_dictionary`. Use `.title` to give the dataset a title and use named arguments to describe the variables in the dataset:

```r
mdrd #<- ... steps to create the `mdrd` data ...

mdrd_dictionary <- describe_dataset(
  mdrd,
  .title   = "Modification of Diet in Renal Disease",
  ptid     = "Patient identifier",
  gfr      = "Glomerular filtration rate in milliliters per minute. A measure of how much blood the kidneys filter per minute. "
  # ... more variable descriptions ...
  # <variable name> = "<variable description>"
)
```

### Add the data to the package (`data-raw/<dataset>/<dataset>.R`)

Finally, call `usethis::use_data()` to add the data and data dictionary objects to the package:

```r
usethis::use_data(
  mdrd,
  mdrd_dictionary,
  overwrite = TRUE
)
```

### Document the dataset (`R/<dataset>.R`)

Document the dataset in an R script in the `R` folder. You can quickly create this file by running

```r
usethis::use_r("mdrd.R")
```

You only need one R file per _family_ of datasets. It's fine to document multiple individual objects in a single file.

In this file, use [roxygen2](https://roxygen2.r-lib.org) to describe the dataset. Start from the template below:

```r
#' MDRD Dataset Title
#'
#' @description
#' A paragraph or two describing the mdrd dataset. You may use markdown.
#'
#' @source <https://repository.niddk.nih.gov/studies/mdrd/>
#' @family MDRD datasets
#'
#' @format `r rd_describe_format(mdrd, mdrd_dictionary)`
"mdrd"
```

Be sure to replace `mdrd` with the name of the object containing your dataset. You can see a complete example in `R/mdrd.R`. 

Use the `@family` tag when you have several versions of sets of data with your dataset. The text after `@family` will appear as `Other ____:` in the help documentation, with links to the help pages of the other objects in this family.

Notice that I used the `rd_describe_format()` function to create a description of the dataset. This relies on having created a dictionary in a previous step, and it will automatically use variable descriptions you created.

If you did not create a data dictionary for your dataset, you'll need to manually fill in the template below:

```
#' @format A THING with N rows and M variables:
#' \describe{
#'   \item{\code{VARIABLE_NAME}}{[TYPE] DESCRIPTION.}
#'   \item{\code{VARIABLE_NAME}}{[TYPE] DESCRIPTION.}
#'   \item{\code{VARIABLE_NAME}}{[TYPE] DESCRIPTION.}
#' }
```

For each data dictionary, use the `@describeIn` roxygen2 tag so that the dictionary is mentioned in the help file of its associated data object.

```r
#' @describeIn mdrd The `mdrd` data dictionary
"mdrd_dictionary"
```

### Recreate documentation and check the package

To wrap up, update the package documentation.

```r
devtools::document()
```

Then reload the package and check that your documentation renders correctly. (Some links won't work until you re-build and install the package.)

```r
devtools::load_all()
?mdrd
```

Finally, run a check on the academyDatasets package to make sure everything loads properly.

```r
devtools::check()
```

### Submit a new PR

The final step is to create a PR submit this dataset to the academyDatasets pacakge. You can use [usethis](https://usethis.r-lib.org) again to help with this:

```r
usethis::pr_push()
```

If any additional changes are needed to merge the PR, you can make them locally in this branch and call the above function again to push the updates to GitHub.

When your PR is approved and merged, you can use usethis again to help clean up:

```r
usethis::pr_finish()
```
