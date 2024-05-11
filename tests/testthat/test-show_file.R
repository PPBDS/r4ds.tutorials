# Test file path
test_file <- "show_file_test.txt"

# Test cases
test_that("show_file function works correctly", {
  # Test case 1: Display all rows
  expect_output(show_file(test_file), "This is line 1.\nThis is line 2.\nThis is line 3 with the word example.\nThis is line 4.\nThis is line 5 with another example.\nThis is line 6.\nThis is line 7.\nThis is line 8.\nThis is line 9.\nThis is line 10.")
  
  # Test case 2: Display rows 3 to 7
  expect_output(show_file(test_file, start = 3, end = 7), "This is line 3 with the word example.\nThis is line 4.\nThis is line 5 with another example.\nThis is line 6.\nThis is line 7.")
  
  # Test case 3: Display rows matching the pattern "example"
  expect_output(show_file(test_file, pattern = "example"), "This is line 3 with the word example.\nThis is line 5 with another example.")
  
  # Test case 4: Display rows 2 to 5 matching the pattern "line"
  expect_output(show_file(test_file, start = 2, end = 5, pattern = "line"), "This is line 2.\nThis is line 3 with the word example.\nThis is line 4.\nThis is line 5 with another example.")
  
  # Test case 5: File does not exist
  expect_error(show_file("nonexistent_file.txt"), "File does not exist.")
  
  # Test case 6: Start is greater than end
  expect_error(show_file(test_file, start = 5, end = 3), "start must be smaller or equal to end.")
  
  # Test case 7: Start is out of range
  expect_error(show_file(test_file, start = 0), "start and end must be within the valid range of rows.")
  
  # Test case 8: End is out of range
  expect_error(show_file(test_file, end = 15), "start and end must be within the valid range of rows.")
})