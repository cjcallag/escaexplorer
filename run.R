if(!requireNamespace("remotes")) install.packages("remotes")

remotes::install_github("cjcallag/escaexplorer")

port <- Sys.getenv('PORT')

escaexplorer::launch_app(app = "explorer",
                         use_browser = TRUE,
                         host = "0.0.0.0",
                         port = as.numeric(port))
