# This testing is giving me trouble. It works fine on GHA. It works fine when
# executing these lines interactively. But when run by hitting Check within R Studio, 

# For now, we will do all our tutorial testing in this one script. 

avail <- learnr::available_tutorials()

if(any(grepl("r4ds.tutorials", avail$package))){
  tutorial_paths <- tutorial.helpers::return_tutorial_paths(package = "r4ds.tutorials")
  
  # First, we make sure that all the tutorials can be knitted.
  
  tutorial.helpers::knit_tutorials(tutorial_paths)
  
  # Ensure that all the tutorials have the default components: copy-code button,
  # information/download pages.
  
  tutorial.helpers::check_tutorial_defaults(tutorial_paths)
}

