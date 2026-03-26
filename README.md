Personal website built with [Quarto](https://quarto.org/).

## Setup

1. Install [Quarto](https://quarto.org/docs/get-started/)
2. Install R dependencies:

```r
install.packages(c(
  "dplyr", "tidyr", "stringr", "magrittr", "glue",
  "lubridate", "purrr", "markdown", "htmltools",
  "reactable", "googlesheets4"
))

# datadrivencv is not on CRAN — install from GitHub:
devtools::install_github("Ash706/datadrivencv")
```

3. Render the site:

```bash
quarto render
```

## Structure

- Publication and presentation data is pulled from a Google Sheet via `{googlesheets4}` and `{datadrivencv}`
- CV is rendered separately with `{pagedown}` (not part of the Quarto build)
- Output goes to `docs/` for GitHub Pages

## CV

The CV uses `{pagedown}` and customized `{datadrivencv}` code. Updating the [Google Sheet](https://docs.google.com/spreadsheets/d/1B2gc55CwWn0QidoLk3aqWXFaKGFXqekKV94LVyY7Gug/) updates both the CV and website publications/presentations pages.
