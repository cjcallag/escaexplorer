#' @title Launch Application
#'
#' @param app Name of the application.
#' @param use_browser Logical.
#'
#' @importFrom shiny runApp
#'
#' @examples
#' \dontrun{launch_app(app = "explorer", user_browser = TRUE)}
#'
#' @export
launch_app <- function(app = "explorer", use_browser = TRUE) {
  stopifnot("`use_browser should be logical`" = is.logical(use_browser))
  stopifnot("`app` must be a character" = is.character(app))
  # Locate escaexplorer app within the package ---------------------------------
  dir <- system.file(app, package = PACKAGE_NAME)
  # Run the app ----------------------------------------------------------------
  runApp(appDir = dir, launch.browser = use_browser)
}

