#' Display the contents of a text file that match a pattern
#'
#' This function reads the contents of a text file and either prints the specified range of rows
#' that match a given regular expression pattern or returns the code lines within R code chunks.
#' If start is a negative number, it prints the last abs(start) lines and removes blank lines at the end.
#'
#' @param path A character vector representing the path to the text file.
#' @param start An integer specifying the starting row number (inclusive) to consider. Default is 1.
#'              If negative, it represents the number of lines to print from the end of the file.
#' @param end An integer specifying the ending row number (inclusive) to consider. Default is the last row.
#' @param pattern A regular expression pattern to match against each row. Default is NULL (no pattern matching).
#' @param chunk A logical value indicating whether to return code lines within R code chunks. Default is FALSE.
#'
#' @return If chunk is FALSE (default) and start is non-negative, the function prints the contents of the specified
#'         range of rows that match the pattern (if provided) to the console. If chunk is TRUE,
#'         the function returns a character vector containing the code lines within R code chunks.
#'         If start is negative, the function prints the last abs(start) lines and removes blank lines at the end.
#'
#' @examples
#' \dontrun{
#' # Display all rows of a text file
#' show_file("path/to/your/file.txt")
#'
#' # Display rows 5 to 10 of a text file
#' show_file("path/to/your/file.txt", start = 5, end = 10)
#'
#' # Display all rows of a text file that contain the word "example"
#' show_file("path/to/your/file.txt", pattern = "example")
#'
#' # Return code lines within R code chunks
#' show_file("path/to/your/file.txt", chunk = TRUE)
#'
#' # Display the last 5 lines of a text file and remove blank lines at the end
#' show_file("path/to/your/file.txt", start = -5)
#' }
#'
#' @importFrom utils tail
#'
#' @export
show_file <- function(path, start = 1, end = NULL, pattern = NULL, chunk = FALSE) {
  # Check if the file exists
  if (!file.exists(path)) {
    stop("File does not exist.")
  }
  
  # Read the contents of the file
  contents <- readLines(path)
  
  # If start is negative, print the last abs(start) lines and remove blank lines at the end
  if (start < 0) {
    selected_contents <- tail(contents, abs(start))
    selected_contents <- selected_contents[selected_contents != ""]
    cat(selected_contents, sep = "\n")
    return(invisible(NULL))
  }
  
  # If chunk is TRUE, return code lines within R code chunks
  if (chunk) {
    in_chunk <- FALSE
    code_lines <- character()
    
    for (line in contents) {
      if (grepl("^```\\{r", line)) {
        in_chunk <- TRUE
      } else if (grepl("^```$", line)) {
        in_chunk <- FALSE
      } else if (in_chunk) {
        code_lines <- c(code_lines, line)
      }
    }
    
    return(code_lines)
  }
  
  # Get the total number of rows
  total_rows <- length(contents)
  
  # Set default value for end if not provided
  if (is.null(end)) {
    end <- total_rows
  }
  
  # Check if start and end are within the valid range
  if (start < 1 || start > total_rows || end < 1 || end > total_rows) {
    stop("start and end must be within the valid range of rows.")
  }
  
  # Check if start is smaller or equal to end
  if (start > end) {
    stop("start must be smaller or equal to end.")
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