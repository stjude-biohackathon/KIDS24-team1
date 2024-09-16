library("shiny")
library("shinyWidgets")
library("shinyjs")
library("shinythemes")
library("shinyBS")
library("shinycustomloader")
library("bslib")


shinyUI(page_navbar(
  title = "CHROMIC Data Exploratory Analysis",
  nav_spacer(),
  nav_item(
    input_dark_mode(id = "dark_mode")
  ),
  sidebar = sidebar(
    open = 'always',
    width = 500,
    useShinyjs(),
    plotOutput("lockup", inline = TRUE),
    textOutput('name'),
    downloadButton("downloadTemplate", "Download Template"),
    bsPopover('downloadTemplate', "Template Download", paste0("<p>Download template to begin visualizing your data.</p>"), placement = "bottom", trigger = "hover",
              options = NULL),
    downloadButton("demoData", "Download Pre-filled Demo Data"),
    bsPopover('demoData', "Demo Data", paste0("<p>Download pre-populated demo data to begin visualizing.</p>"), placement = "bottom", trigger = "hover",
              options = NULL),
    fileInput("fileCohort", "Upload your Cohort CSV data file to continue",
                     multiple = FALSE,
                     accept = c(".csv")),
    fileInput("fileLongitudinal", "Upload your Longitudinal CSV data file to continue",
              multiple = FALSE,
              accept = c(".csv")),
    htmlOutput("email", inline = TRUE),
    hidden(actionButton('reset', 'Reset', class = "btn-warning"))),
  nav_panel(
    title = 'Cohort',
    fluidRow(
      hidden(downloadButton("downloadCohort", "Download Cohort Report (HTML)", style = "width:400px;")),
      withLoader(uiOutput('reportCohort'))
      )
  ),
  nav_panel(
    title = 'Longitudinal',
    fluidRow(
      hidden(downloadButton("downloadLongitudinal", "Download Longitudinal Report (HTML)", style = "width:400px")),
      withLoader(uiOutput('reportLongitudinal'))
    )
  )
)
)