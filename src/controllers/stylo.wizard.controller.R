function (input, output, session, db.service, log.service, preanalyzer, updater, saveSettings, loadSettings) {

  observeEvent(
    eventExpr = input$wizard.run, 
    handlerExpr = {
      if (db.service$is.connected()) {
        preanalyzer(input, output, session, db.service)
      } else {
        
      }
    }
  )
  
  observeEvent(
    eventExpr = input$wizard.previous, 
    handlerExpr = {
      select <- as.integer(input$wizard.tabsetpanel)
      
      if(select > 1)
        updateTabsetPanel(
          session,
          "wizard.tabsetpanel",
          selected = toString(select - 1)
        )
    }
  )
  
  observeEvent(
    eventExpr = input$wizard.next, 
    handlerExpr = {
      select <- as.integer(input$wizard.tabsetpanel)
      
      if(select < 7)
      updateTabsetPanel(
        session,
        "wizard.tabsetpanel",
        selected = toString(select + 1)
      )
    }
  )
  
  observeEvent(
    eventExpr = input$wizard.apply, 
    handlerExpr = {
      if (db.service$is.connected()) {
        updater(session, input)
        updateTabsetPanel(
          session,
          "stylo.start.tabsetpanel",
          selected = "Run Stylo"
        )
      } else {
        log.service$log(
          "Please connect to a database!",
          where = "stylo"
        )
      }
    }
  )
  
  observeEvent(
    eventExpr = input$wizard.save, 
    handlerExpr = {
      if (db.service$is.connected()) {
        saveSettings(filename = input$wizardFileName, input = input)
      } else {
        log.service$log(
          "Please connect to a database!",
          where = "stylo"
        )
      }
    }
  )
  
  observeEvent(
    eventExpr = input$wizard.load, 
    handlerExpr = {
      if (db.service$is.connected()) {
        loadSettings(filename = input$wizardFileName, session = session)
      } else {
        log.service$log(
          "Please connect to a database!",
          where = "stylo"
        )
      }
    }
  )
  
  observe({
    updateSelectInput(
      session, 
      "wizardInputSelect", 
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
      "wizardLanguageSelect", 
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
      "wizardFeaturesSelect", 
      choices = c(
        "Characters" = "c",
        "Words" = "w"
      )
    )
  })
  
  observe({
    updateSelectInput(
      session, 
      "wizardStatisticsSelect", 
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
      "wizardScatterplotSelect", 
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
      "wizardPcaFlavourSelect", 
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
      "wizardOutputPlotColourChoices", 
      choices = c(
        "Colours" = "colors",
        "Greyscale" = "greyscale",
        "Black" = "black"
      )
    )
  })
}