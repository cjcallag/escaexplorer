shinyUI(
    fluidPage(
        includeCSS("extra.css"),
        tags$style('.container-fluid {background-color: #FFFFFF;}'),
        titlePanel(
            tags$div(
                tags$img(src = "ESCA-logo.png", height = "60"), "ESCA Explorer",
                tags$span(actionButton('load_about', 'About'),
                          style = "position:absolute;right:0.5em;")
            ),
            windowTitle = "ESCA Explorer"
            ),
        theme = shinytheme("paper"),
        fluidRow(
            tags$style(type = "text/css", "#map {height: calc(100vh - 120px) !important;}"),
            absolutePanel(top = 120, left = 10, right = "auto", bottom = "auto", width = 250, height = "auto", draggable = FALSE,
                          wellPanel(
                              # tags$h4("Parcel Glimpses"),
                              selectInput(inputId = "data_set",
                                          label = tags$b("View data by:"),
                                          choices = c("MRA Groups",
                                                      # 1-June BRAC comment ----
                                                      # "Ownership",
                                                      "Municipal Jurisdictions" #,
                                                      #"Proposed Reuse"
                                                      ))),
                          style = "opacity: 0.75; z-index:10;"),
            absolutePanel(top = "auto", left = 10, right = "auto", bottom = 10, width = 250, height = "auto", draggable = FALSE,
                          wellPanel(
                              uiOutput("information")),
                          style = "opacity: 0.75; z-index:10;"),
            withSpinner(leafletOutput("map"), type = 6, size = 2)
        ) # fluidRow
    ) # fluidPage
)
