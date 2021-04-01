function (input, output, session) {
  default.label <- reactiveValues(
    default = TRUE,
    error = FALSE
  )
  
  console <- reactiveValues(
    corpus.log = c(),
    stylo.log = c(),
    wizard.log = c()
  )
  
  log <- function (msg, where) {
    entry <- paste(format(Sys.time(), "[%Y-%m-%d %H:%M:%S]"), msg, sep = " ")
    if (where == "corpus") {
      console$corpus.log <- c(console$corpus.log, entry)
    } else if (where == "stylo"){
      console$stylo.log <- c(console$stylo.log, entry)
    } else if (where == "wizard"){
      console$wizard.log <- c(console$wizard.log, entry)
    } else if (where == "analyzer"){
      console$analyzer.log <- c(console$analyzer.log, entry)
    }
  }
  
  output$corpusConsole <- renderText({
    return(paste(console$corpus.log, collapse = '\n'))
  })
  
  
  output$styloConsole <- renderText({
    return(paste(console$stylo.log, collapse = '\n'))
  })

  output$wizardConsole <- renderText({
    return(paste(console$wizard.log, collapse = '\n'))
  })
  
  output$analyzerConsole <- renderText({
    return(paste(console$analyzer.log, collapse = '\n'))
  })
  
  export <- list(console, log, default.label)
  names(export) <- c("console", "log", "default.label")
  export
}
