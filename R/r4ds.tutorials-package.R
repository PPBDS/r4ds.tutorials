#' @keywords internal
"_PACKAGE"


# Was able to resolve R CMD check import note by using tutorial.helpers::return_tutorial_paths(). 
# This was a good "do nothing" function. Note that it needs to be inside of a function definition for the build to recognize it.\

function_for_import  <- function()
{
  temp <- tutorial.helpers::return_tutorial_paths('learnr')
}

## usethis namespace: start
## usethis namespace: end
NULL
