# Test file path
test_file <- "show_file_test.txt"

# Test cases
test_that("show_file function works correctly", {
  # Test case 1: Display all rows
  expect_equal(capture.output(show_file(test_file)), readLines(test_file))
  
  # Test case 2: Display rows 3 to 7
  expect_equal(capture.output(show_file(test_file, start = 3, end = 7)), readLines(test_file)[3:7])
  
  # Test case 3: Display rows matching the pattern "example"
  expect_equal(capture.output(show_file(test_file, pattern = "example")), c(
    "This is line 3 with the word example.",
    "This is line 5 with another example."
  ))
  
  # Test case 4: Return code lines within R code chunks
  expect_equal(show_file(test_file, chunk = TRUE), c(
    "# This is a code chunk",
    "x <- 1:10",
    "print(x)",
    "# Another code chunk",
    "y <- 20:30",
    "mean(y)"
  ))
  
  # Test case 5: File does not exist
  expect_error(show_file("nonexistent_file.txt"), "File does not exist.")
  
  # Test case 6: Start is greater than end
  expect_error(show_file(test_file, start = 5, end = 3), "start must be smaller or equal to end.")
  
  # Test case 7: Start is out of range
  expect_error(show_file(test_file, start = 0), "start and end must be within the valid range of rows.")
  
  # Test case 8: End is out of range
  expect_error(show_file(test_file, end = 30), "start and end must be within the valid range of rows.")
  
  # Test case 9: Print the last 3 lines of the file and remove blank lines at the end
  expect_equal(capture.output(show_file(test_file, start = -3)), c(
    "This is line 8.",
    "This is line 9.",
    "This is line 10."
  ))
})