#' @title Select Wise Setting for RStudio and for .Rprofile
#'
#' @description
#'
#' This functions selects RStudio settings which make learning easier. It also
#' sets the "pkgType" global option to "binary" in your .Rprofile. Students,
#' especially those on Windows, should never install from source. Doing so fails
#' too often, and too confusingly.
#'
#' You can examine your .Rprofile to confirm this change with
#' usethis::edit_r_profile()
#'
#' @export

prep_rstudio_settings <- function(){

  # Change default settings in RStudio. Here all are settings:
  # https://docs.posit.co/ide/server-pro/reference/session_user_settings.html

  message("Changing RStudio settings to better defaults.")

  rstudioapi::writeRStudioPreference("save_workspace", "never")
  rstudioapi::writeRStudioPreference("load_workspace", FALSE)
  rstudioapi::writeRStudioPreference("insert_native_pipe_operator", TRUE)
  rstudioapi::writeRStudioPreference("show_hidden_files", TRUE)
  rstudioapi::writeRStudioPreference("rmd_viewer_type", "pane")

  # The first three are definitely good. The last two are . . .
  
  # Other settings which might be looked at include: document_author,
  # packages_pane_enabled, always_write_history, rainbow_parantheses,
  # show_invisibles, show_rmd_render_commit, sync_files_pane_working_dir,
  # syntax_color_console and use_tiny_tex.

  # These settings are stored in: ~/.config/rstudio/rstudio-prefs.json

  # This portion of the function is modeled after the function census_api_key()
  # from the tidycensus package. We only do it on non-Linux systems because
  # Linux is confusing and students rarely use Linux. (What about Chromebooks?) 

  if(Sys.info()["sysname"] != "Linux"){

    # Get path to user Rprofile and Renviron

    home <- Sys.getenv("HOME")
    rprof <- file.path(home, ".Rprofile")

    # Create lines to insert. We added the trailing newline because there is a
    # bug (?) whereby the .Rprofile script does not run when the .Rprofile file
    # does not end with a trailing newline.

    rprof_line <- "options(pkgType = 'binary')\n"

    # If user already has an .Rprofile, then just append to that file
    # If not, create an .Rprofile in home directory and write to that.

    if (file.exists(rprof)){

      curr_prof <- readr::read_file(rprof)


      # If option already in user's .Rprofile, then just don't write in it

      if (stringr::str_detect(gsub(" ", "", curr_prof), stringr::fixed(gsub(" ", "", rprof_line)))){

        message("options(pkgType = 'binary') is already in your .Rprofile.")

      }else{
        
        # We claim to be appending, but we are really replacing. Should we just
        # append?

        message("Appending options(pkgType = 'binary') to your .Rprofile")

        write(paste0(trimws(curr_prof), "\n", rprof_line), file = rprof, append = FALSE)

      }
    }
    if (!file.exists(rprof)){

      message("Creating .Rprofile in your home directory")

      file.create(rprof)

      write(rprof_line, file = rprof, append = TRUE)

    }

  # Set pkgType to "binary" for this R session

    options(pkgType = "binary")
    message("You will now only install the binary version of packages.")
  }
  else{
    message("No changes made to your .Rprofile because you are using Linux.")
  }

}
