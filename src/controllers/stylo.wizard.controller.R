function (input, output, session, db.service, log.service, preanalyzer, updater, saveSettings, loadSettings) {

  # the stored console output
  wizard.output <- vector('character')
  wizard.output.connection <- textConnection(
    object = "wizard.output",
    open = "a",
    local = TRUE
  )
  
  observeEvent(poll.wizard.output(), {
    entry <- poll.wizard.output()
    if (entry != "") {
      log.service$log(
        entry,
        where = "wizard"
      )
    }
  })
  
  poll.wizard.output <- reactivePoll(
    intervalMillis = 1000, 
    session = session,
    # check for change of value to be printed
    checkFunc = function() {
      if (length(wizard.output) > 0) {
        TRUE
      } else {
        FALSE
      }
    },
    # This function returns the content of the log entry
    valueFunc = function() {
      if (length(wizard.output) > 0) {
        wizard.output
      } else {
        ""
      }
    }
  )
  
  observeEvent(
    eventExpr = input$WizardRun,
    handlerExpr = {
      if (db.service$is.connected()) {
        preanalyzer(input, output, session, db.service, saveSettings, wizard.output.connection)
        log.service$log(
          "Wizard invoked...",
          where = "wizard"
        )
      } else {
        showModal(modalDialog(
          title = "Error",
          "Corpus does not exist!"
        ))
        log.service$log(
          "Corpus does not exist!",
          where = "wizard"
        )
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
      
      if(select < 8)
        updateTabsetPanel(
          session,
          "wizard.tabsetpanel",
          selected = toString(select + 1)
        )
    }
  )
  
  observeEvent(
    eventExpr = input$wizard.save, 
    handlerExpr = {
      if (db.service$is.connected()) {
        saveSettings(db.service, input)
      } else {
        log.service$log(
          "Please connect to a database!",
          where = "wizard"
        )
      }
    }
  )
  
  observeEvent(
    eventExpr = input$wizard.load, 
    handlerExpr = {
      if (db.service$is.connected()) {
        loadSettings(db.service, session, "wizard")
      } else {
        log.service$log(
          "Please connect to a database!",
          where = "wizard"
        )
      }
    }
  )
  
  observeEvent(
    eventExpr = input$wizard.load.stylo, 
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
    eventExpr = input$wizard.load.analyzer, 
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
    eventExpr = input$wizard.load.text, 
    handlerExpr = {
      if (db.service$is.connected()) {
        write_file(serialize(fromJSON(input$wizard.load.textbox), NULL), "wizard.conf")
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
    eventExpr = input$wizard.export.text, 
    handlerExpr = {
      if (db.service$is.connected()) {
        saveSettings(db.service, input)
        y <- read_file_raw("wizard.conf")
        conffile <- unserialize(connection = y)
        updateTextAreaInput(
          session,
          "wizard.load.textbox",
          value = toJSON(conffile)
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
  
  observe({
    updateSelectInput(
      session, 
      "wizardFileName", 
      choices = c(
        "config1" = "config1.conf"
      )
    )
  })
}
