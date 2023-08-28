# For now, we will do all our tutorial testing in this one script. We need a
# listing of all the tutorials. I still worry that I don't really know which
# paths this is getting. I *think* it is not doing what we want, which is to get
# all the paths from this version of the package. Instead, it is getting the
# paths from the most recently installed version of the package. So, you really
# need to install before testing. If true, that is a hack!

# Turns out that CRAN does not like tests to take longer than 10 minutes. Alas,
# we now have so many tests, that the total time is 15 minutes, at least on
# Windows. So, we skip knitting all the tutorials on CRAN. (We can keep the
# expected components check because those are very fast.)
  
tut_paths <- tutorial.helpers::return_tutorial_paths("r4ds.tutorials")

test_that("All tutorials can be knit without error", {
  skip_on_cran()
  expect_null(
    tutorial.helpers::knit_tutorials(tut_paths)
  )
})


test_that("All tutorials have the expected components", {
  expect_null(
    tutorial.helpers::check_tutorial_defaults(tut_paths)
  )
})

