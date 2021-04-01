function (input, output, shiny.session, db.service, log.service, stylo.params.service) {
  
  # store the stylo output in a reactive variable
  session <- reactiveValues(
    stylo = NULL,
    jobDone = FALSE
  )
  
  # the stored console output of the stylo command
  stylo.output <- vector('character')
  stylo.output.connection <- textConnection(
    object = "stylo.output",
    open = "a",
    local = TRUE
  )
  
  dat <- function(){
    
    progress <- AsyncProgress$new(
      message = "Stylometry job in progress",
      min = 0,
      max = 1,
      detail = "Loading corpus",
      style = "notification",
      session = shiny.session
    )
    
    corpus <- db.service$load.collection()
    #session$stylo <- NULL
    
    sink(stylo.output.connection, append = TRUE, type = "output")
    sink(stylo.output.connection, append = TRUE, type = "message")
    
    i1 <- input$utf8.checkbox
    i2 <- input$language.select
    i3 <- input$features.select
    i4 <- input$ngram.input
    i5 <- input$input.select
    i6 <- input$case.checkbox
    i7 <- input$mfw.minimum.input
    i8 <- input$mfw.maximum.input
    i9 <- input$mfw.increment.input
    i10 <- input$mfw.freq.rank.input
    i11 <- input$culling.minimum.input
    i12 <- input$culling.maximum.input
    i13 <- input$culling.increment.input
    i14 <- input$culling.list.cutoff.input
    i15 <- input$culling.pronoun.checkbox
    i16 <- input$statistics.select
    i17 <- input$statistics.consensus.input
    i18 <- input$scatterplot.select
    i19 <- input$scatterplot.margin.input
    i20 <- input$scatterplot.offset.input
    i21 <- input$pca.flavour.select
    i22 <- input$clustering.horizontal.checkbox
    i23 <- input$distances.select
    i24 <- input$output.plot.default.checkbox
    i25 <- input$output.plot.height.input
    i26 <- input$output.plot.width.input
    i27 <- input$output.plot.font.input
    i28 <- input$output.plot.line.input
    i29 <- input$output.plot.colour.choices
    i30 <- input$output.plot.titles.checkbox
    i31 <- custom.graph.file.prefix
    i32 <- input$sampling.select
    i33 <- input$sampling.input
    
    future({
      result <- NULL
      tryCatch(
        {
          progress$set(
            value = 0.2,
            detail = "Parsing corpus"
          )
          
          parsed <- parse.corpus(
            corpus,
            encoding = ifelse(
              i1,
              "UTF-8",
              "native.enc"
            ),
            #corpus.lang = i2,
            features = i3,
            ngram.size = i4
          )
          
          progress$set(
            value = 0.4,
            detail = "Capturing Stylo console output"
          )
          
          progress$set(
            value = 0.6,
            detail = "Invoking Stylo"
          )
          
          result <- stylo(
            
            # Invoke without GUI with predefined corpus
            gui = FALSE,
            parsed.corpus = parsed,
            
            # Input & language
            corpus.format = i5,
            encoding = ifelse(
              i1,
              "UTF-8",
              "native.enc"
            ),
            corpus.lang = i2,
            
            # Features
            analyzed.features = i3,
            ngram.size = i4,
            preserve.case = i6,
            
            # Most Frequent Words
            mfw.min = i7,
            mfw.max = i8,
            mfw.incr = i9,
            start.at = i10,
            
            # Culling
            culling.min = i11,
            culling.max = i12,
            culling.incr = i13,
            mfw.list.cutoff = i14,
            delete.pronouns = i15,
            
            #Statistics
            analysis.type = i16,
            consensus.strength = i17,
            text.id.on.graph = i18,
            add.to.margins = i19,
            label.offset = i20,
            pca.visual.flavour = i21,
            dendrogram.layout.horizontal = i22,
            distance.measure = i23,
            
            # Sampling
            sampling = i32,
            sample.size = i33,
            
            # Output
            display.on.screen = TRUE,
            write.pdf.file = TRUE,
            write.jpg.file = TRUE,
            write.png.file = TRUE,
            write.svg.file = TRUE,
            plot.options.reset = i24,
            plot.custom.height = i25,
            plot.custom.width = i26,
            plot.font.size = i27,
            plot.line.thickness = i28,
            colors.on.graphs = i29,
            titles.on.graphs = i30,
            
            # Undocumented but useful options
            custom.graph.filename = i31
          )
        },
	error = function(ex) {
          log.service$log(
            paste("Stylo failed.", ex),
            where = "message"
          )
          # trace <- backtrace(proc_download)
          # print(trace)
        }
      )
      progress$close()
      sink()
      sink(type = "message")
      return(result)
    })
    
  }
  
  # plot controller
  output$stylo.plot <- renderPlot({
    if (input$StyloRun == 0) {
      return()
    } else {
      session$stylo
    }
  })
  
  output$jobDone <- reactive(session$jobDone)
  outputOptions(output, "jobDone", suspendWhenHidden = FALSE)
  
  observeEvent(
    eventExpr = input$StyloRun,
    handlerExpr = {
      if (db.service$is.connected()) {
        disable_run_buttons(shiny.session)
        disable_download(shiny.session)
        log.service$log(
          paste("Stylo version", packageVersion("stylo"),
                "invoked with given parameters"),
          where = "stylo"
        )
        isolate({
          session$stylo <- NULL
        })
        session$jobDone <- FALSE
        disable_run_buttons(shiny.session)
        disable_download(shiny.session)
        dat() %...>% {
          enable_run_buttons(shiny.session)
          enable_download(shiny.session)
          isolate({
            session$stylo <- .
            session$jobDone <- TRUE
          })
          return(.)
        }
      } else {
        showModal(modalDialog(
          title = "Error",
          "Corpus does not exist!"
        ))
        log.service$log(
          "Corpus does not exist!",
          where = "stylo"
        )
      }
    }
  )

  # frequency table controller
  output$frequency.table <- renderTable({
    frequencies <- session$stylo$frequencies.0.culling
    if (is.null(session$stylo)) {
      return(NULL)
    }
    session$frequencies <- t(frequencies)
    session$frequencies
  },
  include.rownames = TRUE)
  
  # all features table controller
  output$all.features.table <- renderText({
    features <- session$stylo$features
    if (is.null(session$stylo)) {
      return(NULL)
    }
    result <- strsplit(x = features, split = " ")
    session$features <- paste(result, collapse = "\n")
    session$features
  })
  
  # used feature table controller
  output$used.features.table <- renderText({
    features <- session$stylo$features.actually.used
    if (is.null(session$stylo)) {
      return(NULL)
    }
    result <- strsplit(x = features, split = " ")
    session$features.used <- paste(result, collapse = "\n")
    session$features.used
  })
  
  # distance table controller
  output$distance.table <- renderTable({
    distances <- session$stylo$distance.table
    if (is.null(session$stylo)) {
      return(NULL)
    }
    session$distances <- distances
    session$distances
  },
  include.rownames = TRUE)
  
  # all features table download controller
  output$download.all.features <- downloadHandler(
    filename = function() {
      paste(input$db.database, input$db.collection, "features.all", "txt", sep = ".")
    },
    content = function(handle) {
      writeLines(session$features, handle)
    }
  )
  
  # used features table download controller
  output$download.used.features <- downloadHandler(
    filename = function() {
      paste(input$db.database, input$db.collection, "features.used", "txt", sep = ".")
    },
    content = function(handle) {
      writeLines(session$features.used, handle)
    }
  )
  
  # frequencies table download controller
  output$download.frequencies <- downloadHandler(
    filename = function() {
      paste(input$db.database, input$db.collection, "frequencies", "txt", sep = ".")
    },
    content = function(handle) {
      write.csv(x = session$frequencies, file = handle, sep = ";")
    }
  )
  
  # distances table download controller
  output$download.distances <- downloadHandler(
    filename = function() {
      paste(input$db.database, input$db.collection, "distances", "txt", sep = ".")
    },
    content = function(handle) {
      write.csv(x = session$distances, file = handle, sep = ";")
    }
  )
  
  # distances table download controller
  output$download.plot <- downloadHandler(
    filename = function() {
      paste(
        input$corpus.name,
        input$output.plot.format.choices, 
        sep = "."
      )
    },
    content = function(handle) {
      file.copy(
        from = paste(
          custom.graph.file.prefix,
          "_001.",
          input$output.plot.format.choices,
          sep = ""
        ),
        to = handle,
        copy.date = FALSE,
        copy.mode = FALSE,
        recursive = FALSE,
        overwrite = FALSE
      )
    },
    contentType = switch (
      EXPR = input$output.plot.format.choices,
      "png" = "image/png",
      "svg" = "image/svg+xml",
      "jpg" = "image/jpeg",
      "pdf" = "application/pdf",
      "application/octet-stream"
    )
  )
  
  
  # plot file format selection controller
  observe({
    updateSelectInput(
      shiny.session, 
      "output.plot.format.choices", 
      choices = c(
        "PDF" = "pdf",
        "JPG" = "jpg",
        "SVG" = "svg",
        "PNG" = "png"
      )
    )
  })
  
  observeEvent(poll.stylo.output(), {
    entry <- poll.stylo.output()
    if (entry != "") {
      log.service$log(
        entry,
        where = "stylo"
      )
    }
  })
  
  poll.stylo.output <- reactivePoll(
    intervalMillis = 1000, 
    session = shiny.session,
    # check for change of value to be printed
    checkFunc = function() {
      if (length(stylo.output) > 0) {
        TRUE
      } else {
        FALSE
      }
    },
    # This function returns the content of the log entry
    valueFunc = function() {
      if (length(stylo.output) > 0) {
        stylo.output
      } else {
        ""
      }
    }
  )
}
