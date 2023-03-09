library(testthat)
library(dplyr)
library(learnr)
library(r4ds.tutorials)

# This testing approach only works, I think, when you click `Build -> Check`.
# Otherwise, the tutorials you are testing might be those you installed
# previously, not the ones you just edited. See discussion in
# all.primer.tutorials.

package_location <- system.file("tutorials", package = "r4ds.tutorials")

tutorial_paths <-
  available_tutorials("r4ds.tutorials") |>
  mutate(path = paste0(package_location, "/", name, "/tutorial.Rmd")) |>
  pull(path)

stopifnot(length(tutorial_paths) >= 1)

# We use the tutorial_paths vector in the testing functions which now get run.

test_check("r4ds.tutorials")
