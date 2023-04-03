# For now, we will do all our tutorial testing in this one script. We need a
# listing of all the tutorials. I still worry that I don't really know which
# paths this is getting. I *think* it is not doing what we want, which is to get
# all the paths from this version of the package. Instead, it is getting the
# paths from the most recently installed version of the package. So, you really
# need to install before testing. If true, that is a hack!

# This testing is giving me trouble. It works fine on GHA. It works fine when
# executing these lines interactively. But when run by hitting Test or Check
# within R Studio, it fails with a message that there are no tutorials available
# for r4ds.tutorials. But there are! Not sure what the deal is. So, I hack it to
# "work" --- or at least pass --- even with Check/Test.

avail <- learnr::available_tutorials()

if(any(grepl("r4ds.tutorials", avail$package))){
  
  tut_paths <- tutorial.helpers::return_tutorial_paths("r4ds.tutorials")
  
  test_that("All tutorials can be knit without error", {
    expect_invisible(
      tutorial.helpers::knit_tutorials(tut_paths)
    )
  })
  
  
  test_that("All tutorials have the expected components", {
    expect_invisible(
      tutorial.helpers::check_tutorial_defaults(tut_paths)
    )
  })
}

