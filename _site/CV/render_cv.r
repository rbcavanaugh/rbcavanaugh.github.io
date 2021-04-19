# This script builds both the HTML and PDF versions of your CV

# If you wanted to speed up rendering for googlesheets driven CVs you could use
# this script to cache a version of the CV_Printer class with data already
# loaded and load the cached version in the .Rmd instead of re-fetching it twice
# for the HTML and PDF rendering. This exercise is left to the reader.
rmarkdown::render_site(encoding = 'UTF-8')

library(here)
# Knit the HTML version
rmarkdown::render(here("CV", "cv.rmd"),
                  #params = list(pdf_mode = FALSE),
                  output_file = "~/Documents/github-repos/personal-website-distill/_site/cv.html")

# Convert to PDF using Pagedown
pagedown::chrome_print(input = "~/Documents/github-repos/personal-website-distill/_site/cv.html",
                       output = here("CV", "cv.pdf"))
