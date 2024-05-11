#' Display the contents of a text file that match a pattern
#'
#' This function reads the contents of a text file and prints the specified range of rows
#' that match a given regular expression pattern to the console. If start, end, or pattern
#' are not provided, the function prints all rows or all matching rows.
#'
#' @param path A character vector representing the path to the text file.
#' @param start An integer specifying the starting row number (inclusive) to consider. Default is 1.
#' @param end An integer specifying the ending row number (inclusive) to consider. Default is the last row.
#' @param pattern A regular expression pattern to match against each row. Default is NULL (no pattern matching).
#'
#' @return This function does not return a value. It prints the contents of the specified
#' range of rows that match the pattern (if provided) to the console.
#'
#' @examples
#' # Display all rows of a text file
#' show_file("path/to/your/file.txt")
#'
#' # Display rows 5 to 10 of a text file
#' show_file("path/to/your/file.txt", start = 5, end = 10)
#'
#' # Display all rows of a text file that contain the word "example"
#' show_file("path/to/your/file.txt", pattern = "example")
#'
#' @export
show_file <- function(path, start = 1, end = NULL, pattern = NULL) {
  # Check if the file exists
  if (!file.exists(path)) {
    stop("File does not exist.")
  }
  
  # Read the contents of the file
  contents <- readLines(path)
  
  # Get the total number of rows
  total_rows <- length(contents)
  
  # Set default value for end if not provided
  if (is.null(end)) {
    end <- total_rows
  }
  
  # Check if start is smaller or equal to end
  if (start > end) {
    stop("start must be smaller or equal to end.")
  }
  
  # Check if start and end are within the valid range
  if (start < 1 || start > total_rows || end < 1 || end > total_rows) {
    stop("start and end must be within the valid range of rows.")
  }
  
  # Extract the specified range of rows
  selected_contents <- contents[start:end]
  
  # Filter the selected rows based on the pattern (if provided)
  if (!is.null(pattern)) {
    selected_contents <- selected_contents[grepl(pattern, selected_contents)]
  }
  
  # Print the selected contents to the console
  cat(selected_contents, sep = "\n")
}