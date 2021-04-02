function (input, output, session, db.service, log.service, saveSettings, loadSettings) {

  observeEvent(
    eventExpr = input$analyzer.save, 
    handlerExpr = {
      if (db.service$is.connected()) {
        saveSettings(db.service, input)
      } else {
        showModal(modalDialog(
          title = "Error",
          "Please download a corpus!",
          easyClose = TRUE,
          footer = NULL
        ))
      }
    }
  )
  
  observeEvent(
    eventExpr = input$analyzer.load, 
    handlerExpr = {
      if (db.service$is.connected()) {
        loadSettings(db.service, session, "analyzer")
      } else {
        showModal(modalDialog(
          title = "Error",
          "Please download a corpus!",
          easyClose = TRUE,
          footer = NULL
        ))
      }
    }
  )
  
  observeEvent(
    eventExpr = input$analyzer.load.stylo, 
    handlerExpr = {
      if (db.service$is.connected()) {
        loadSettings(db.service, session, "stylo")
      } else {
        showModal(modalDialog(
          title = "Error",
          "Please download a corpus!",
          easyClose = TRUE,
          footer = NULL
        ))
      }
    }
  )
  
  observeEvent(
    eventExpr = input$analyzer.load.wizard, 
    handlerExpr = {
      if (db.service$is.connected()) {
        loadSettings(db.service, session, "wizard")
      } else {
        showModal(modalDialog(
          title = "Error",
          "Please download a corpus!",
          easyClose = TRUE,
          footer = NULL
        ))
      }
    }
  )
  
  observeEvent(
    eventExpr = input$analyzer.load.text, 
    handlerExpr = {
      if (db.service$is.connected()) {
        tryCatch({
            read_yaml(text = input$analyzer.load.textbox)
            write_file(input$analyzer.load.textbox, "analyzer.conf")
            loadSettings(db.service, session, "analyzer")
	  },
	  error = function(ex) {
            showModal(modalDialog(
              title = "Error",
              "Invalid configuration."
            ))
	    return()
	  }
        )
      } else {
        showModal(modalDialog(
          title = "Error",
          "Please download a corpus!",
          easyClose = TRUE,
          footer = NULL
        ))
      }
    }
  )
  
  observeEvent(
    eventExpr = input$analyzer.export.text, 
    handlerExpr = {
      if (db.service$is.connected()) {
        saveSettings(db.service, input)
        updateTextAreaInput(
          session,
          "analyzer.load.textbox",
          value = read_file("analyzer.conf")
        )
      } else {
        showModal(modalDialog(
          title = "Error",
          "Please download a corpus!",
          easyClose = TRUE,
          footer = NULL
        ))
      }
    }
  )
  
  sidebar <- reactiveValues(
    run = 0
  )
  
  observe({
    updateSelectInput(
      session, 
      "analyzerInputSelect", 
      choices = c(
        "Plain Text" = "plain",
        "XML" = "xml",
        "XML (plays)" = "xml.drama",
        "XML (no titles)" = "xml.notitles",
        "HTML" = "html"
      )
    )
  })
  
  observe({
    updateSelectInput(
      session, 
      "analyzerLanguageSelect", 
      choices = c(
        "English" = "English",
        "English w/ contractions" = "English.contr",
        "English w/ contractions and compounds" = "English.all",
        "Latin" = "Latin",
        "Latin w/ u/v correction" = "Latin.corr",
        "Polish" = "polish",
        "Hungarian" = "hungarian",
        "French" = "french",
        "Italian" = "italian",
        "Spanish" = "spanish",
        "Dutch" = "dutch",
        "German" = "german",
        "Chinese, Japanese, Korean" = "CJK",
        "Other" = "Other"
      )
    )
  })
  
  observe({
    updateSelectInput(
      session, 
      "analyzerFeaturesSelect", 
      choices = c(
        "Characters" = "c",
        "Words" = "w"
      )
    )
  })
  
  observe({
    updateSelectInput(
      session, 
      "analyzerStatisticsSelect", 
      choices = c(
        "Cluster Analysis" = "CA",
        "MDS" = "MDS",
        "PCA (covariance)" = "PCV",
        "PCA (correlation)" = "PCR",
        "tSNE" = "TSNE",
        "Consensus Tree" = "BCT"
      )
    )
  })
  
  observe({
    updateSelectInput(
      session, 
      "analyzerScatterplotSelect", 
      choices = c(
        "Labels" = "labels",
        "Points" = "points",
        "Both" = "both"
      )
    )
  })
  
  observe({
    updateSelectInput(
      session, 
      "analyzerPcaFlavourSelect", 
      choices = c(
        "Classic" = "classic",
        "Loadings" = "loadings",
        "Technical" = "technical",
        "Symbols" = "symbols"
      )
    )
  })
  
  observe({
    updateSelectInput(
      session, 
      "analyzerDistancesSelect", 
      choices = c(
        "Classic Delta" = "dist.delta",
        "Argamon's Delta" = "dist.argamon",
        "Eder's Delta" = "dist.eder",
        "Eder's Simple Distance" = "dist.simple",
        "Manhattan" = "dist.manhattan",
        "Canberra" = "dist.canberra",
        "Euclidean" = "dist.euclidean",
        "Cosine" = "dist.cosine"
      )
    )
  })
  
  observe({
    updateSelectInput(
      session, 
      "analyzerSamplingSelect", 
      choices = c(
        "No Sampling" = "no.sampling",
        "Normal Sampling" = "normal.sampling",
        "Random Sampling" = "random.sampling"
      )
    )
  })
  
  observe({
    updateSelectInput(
      session, 
      "analyzerOutputPlotColourChoices", 
      choices = c(
        "Colours" = "colors",
        "Greyscale" = "greyscale",
        "Black" = "black"
      )
    )
  })
  
  export <- list(sidebar)
  names(export) <- c("params")
  export
}
