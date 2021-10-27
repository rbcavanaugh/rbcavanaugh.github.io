# This script builds both the HTML and PDF versions of your CV

# If you wanted to speed up rendering for googlesheets driven CVs you could use
# this script to cache a version of the CV_Printer class with data already
# loaded and load the cached version in the .Rmd instead of re-fetching it twice
# for the HTML and PDF rendering. This exercise is left to the reader.

library(here)
# Knit the HTML version
  rmarkdown::render("CV/cv.rmd")
  
  file.copy(here("CV", "cv.html"),
              here("cv.html"), overwrite = T)
 

# Convert to PDF using Pagedown
pagedown::chrome_print(input = "~/github-repos/personal-website-distill/cv.html",
                       output = here("CV", "cv.pdf"))

file.copy(here("CV", "cv.pdf"),
          here("cv.pdf"), overwrite = T)

rmarkdown::render_site(encoding = 'UTF-8')
