# This script builds both the HTML and PDF versions of your CV

# If you wanted to speed up rendering for googlesheets driven CVs you could use
# this script to cache a version of the CV_Printer class with data already
# loaded and load the cached version in the .Rmd instead of re-fetching it twice
# for the HTML and PDF rendering. This exercise is left to the reader.

library(here)
# Knit the HTML version
  rmarkdown::render("CV/cv-cavanaugh.rmd")
  
  file.copy(here("CV", "cv-cavanaugh.html"),
              here("cv-cavanaugh.html"), overwrite = T)
 

# Convert to PDF using Pagedown
pagedown::chrome_print(input = "~/github-repos/personal-website-distill/cv2.html",
                       output = here("CV", "cv-cavanaugh.pdf"))

file.copy(here("CV", "cv-cavanaugh.pdf"),
          here("cv-cavanaugh.pdf"), overwrite = T)

rmarkdown::render_site(encoding = 'UTF-8')
