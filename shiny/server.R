library("shiny")
library("shinyjs")
library("knitr")
library("shinythemes")
library("httr")
library("dplyr")
library("tidyverse")
library("shinyBS")
library("rmarkdown")
httr::set_config(httr::config(ssl_verifypeer = FALSE))

shinyServer(function(input, output, session) {
  output$email <- renderText(HTML('If you encounter any issues, please email <a href="mailto:chromic@stjude.org">chromic@stjude.org</a>.'))
  output$downloadTemplate <- downloadHandler(
    filename = "template.csv",
    content = function(file) {
      file.copy('./www/template.csv', file)
    })
  output$demoData <- downloadHandler(
    filename = "demo-data.csv",
    content = function(file) {
      file.copy('./www/dummy-data.csv', file)
    })
  observe(
  if (input$dark_mode == 'light') {
    output$lockup <- renderImage({
      filename <- normalizePath(file.path('./www/Frame 19.svg'))
      list(src = filename,
           height = 57,
           width = 198)
      }, deleteFile = FALSE)
  }
  else if (input$dark_mode == 'dark') {
    output$lockup <- renderImage({
      filename <- normalizePath(file.path('./www/Frame 20.svg'))
      list(src = filename,
           height = 57,
           width = 198)
    }, deleteFile = FALSE)
  })

  observe({
    sjUser <- session$user
    userGet <- GET(paste0("https://<ST JUDE API URL>/", sjUser, sep=''))
    userMeta <- content(userGet, encoding = "UTF-8")
    userEmail <- userMeta[[1]]$mail
    userName <- userMeta[[1]]$givenName
    output$name <- renderText(paste("Hello", userName))

    isolate({
      observe({
        req(input$fileCohort)
        output$reportCohort <- renderUI({
          includeHTML(render('www/02-data-exploratory-analysis-htmlFrag.Rmd', output_dir = paste0("www/FragCohortOut/", sjUser, "/"),
                             output_file = paste0("02-data-exploratory-analysis-htmlFrag-", Sys.Date(), ".html"),
                             quiet = TRUE, params = list(PROJECT_NAME = "Comprehensive Omics Catalog for Hartwell",
                                                         START_DATE = "09/04/2024",
                                                         COMPLETION_DATE = "9/06/2024",
                                                         user = sjUser,
                                                         input_file = input$fileCohort$datapath)))
        })
        render('www/02-data-exploratory-analysis-htmlFull.Rmd', output_dir = paste0("www/CohortOut/", sjUser, "/"),
               output_file = paste0("Cohort Report_", Sys.Date(), ".html"),
               quiet = TRUE, params = list(PROJECT_NAME = "Comprehensive Omics Catalog for Hartwell",
                                           START_DATE = "09/04/2024",
                                           COMPLETION_DATE = "9/06/2024",
                                           user = sjUser,
                                           input_file = input$fileCohort$datapath))
        output$downloadCohort <- downloadHandler(
          filename = paste0("Cohort Report_", Sys.Date(), ".html"),
          content = function(file) {
            file.copy(paste0("www/CohortOut/", sjUser, "/Cohort Report_", Sys.Date(), ".html"), file)
          })
        shinyjs::show("downloadCohort")
      })
    })
    isolate({
      observe({
        req(input$fileLongitudinal)
        output$reportLongitudinal <- renderUI({
          includeHTML(render('www/03-data-exploratory-analysis-longitudinal-htmlFrag.Rmd', output_dir = paste0("www/FragLongOut/", sjUser, "/"),
                             output_file = paste0("03-data-exploratory-analysis-longitudinal-htmlFrag-", Sys.Date(), ".html"),
                             quiet = TRUE, params = list(PROJECT_NAME = "Comprehensive Omics Catalog for Hartwell",
                                                         START_DATE = "09/04/2024",
                                                         COMPLETION_DATE = "9/06/2024",
                                                         user = sjUser,
                                                         input_file = input$fileLongitudinal$datapath)))
        })
        render('www/03-data-exploratory-analysis-longitudinal-htmlFull.Rmd', output_dir = paste0("www/LongOut/", sjUser, "/"),
               output_file = paste0("Longitudinal Report_", Sys.Date(), ".html"),
               quiet = TRUE, params = list(PROJECT_NAME = "Comprehensive Omics Catalog for Hartwell",
                                           START_DATE = "09/04/2024",
                                           COMPLETION_DATE = "9/06/2024",
                                           user = sjUser,
                                           input_file = input$fileLongitudinal$datapath))
        output$downloadLongitudinal <- downloadHandler(
          filename = paste0("Longitudinal Report_", Sys.Date(), ".html"),
          content = function(file) {
            file.copy(paste0("www/LongOut/", sjUser, "/Longitudinal Report_", Sys.Date(), ".html"), file)
          })
        shinyjs::show("downloadLongitudinal")
      })
    })
  })
})
