# For now, we will do all our tutorial testing in this one script. First, we
# make sure that all the tutorials can be knitted.

tutorial.helpers::knit_tutorials(package = "r4ds.tutorials")

# Ensure that all the tutorials have the default components: copy-code button,
# information/download pages.

tutorial_paths <- tutorial.helpers::return_tutorial_paths(package = "r4ds.tutorials")

for(i in tutorial_paths){
  tutorial.helpers::check_tutorial_defaults(i)
  }
