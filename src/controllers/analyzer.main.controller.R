function (input, output, session, db.service, log.service, stylo.analyzer.params.service, saveSettings) {
  
  # the stored console output
  analyzer.output <- vector('character')
  analyzer.output.connection <- textConnection(
    object = "analyzer.output",
    open = "a",
    local = TRUE
  )

  # TODO ez szerintem nem nagyon megy a future belsejéből
  observeEvent(poll.analyzer.output(), {
    entry <- poll.analyzer.output()
    if (entry != "") {
      log.service$log(
        entry,
        where = "analyzer"
      )
    }
  })
  
  poll.analyzer.output <- reactivePoll(
    intervalMillis = 1000, 
    session = session,
    # check for change of value to be printed
    checkFunc = function() {
      if (length(analyzer.output) > 0) {
        TRUE
      } else {
        FALSE
      }
    },
    # This function returns the content of the log entry
    valueFunc = function() {
      if (length(analyzer.output) > 0) {
        rev(analyzer.output)
      } else {
        ""
      }
    }
  )
  
  observeEvent(
    
    eventExpr = input$AnalyzerRun,
    handlerExpr = {
      if (!db.service$is.connected()) {
        showModal(modalDialog(
          title = "Error",
          "Corpus does not exists!"
        ))
        log.service$log(
          "Corpus does not exists!",
          where = "analyzer"
        )
        return()
      }
      sink(analyzer.output.connection)
      # sink(analyzer.output.connection, type = "message")
      
      progress <- AsyncProgress$new(
        message = "Analyzer is running",
        min = 0,
        max = 1,
        detail = "Loading corpus",
        style = "notification",
        session = session
      )
      corpus <- isolate(db.service$load.collection())
      
      i1 <- input$analyzerUtf8Checkbox
      i2 <- input$analyzerLanguageSelect
      i3 <- input$analyzerInputSelect
      i4 <- input$analyzerCaseCheckbox
      i5 <- input$analyzerCullingListCutoffInput
      i6 <- input$analyzerCullingPronounCheckbox
      i7 <- input$analyzerStatisticsSelect
      i8 <- input$analyzerStatisticsConsensusInput
      i9 <- input$analyzerScatterplotSelect
      i10 <- input$analyzerScatterplotMarginInput
      i11 <- input$analyzerScatterplotOffsetInput
      i12 <- input$analyzerPcaFlavourSelect
      i13 <- input$analyzerClusteringHorizontalCheckbox
      i14 <- input$analyzerSamplingSelect
      i15 <- input$analyzerSamplingInput
      i16 <- input$analyzerOutputPlotDefaultCheckbox
      i17 <- input$analyzerOutputPlotHeightInput
      i18 <- input$analyzerOutputPlotWidthInput
      i19 <- input$analyzerOutputPlotFontInput
      i20 <- input$analyzerOutputPlotLineInput
      i21 <- input$analyzerOutputPlotColourChoices
      i22 <- input$analyzerOutputPlotTitlesCheckbox
      i23 <- custom.graph.file.prefix
      i24 <- input$usePreCyclesCheckbox
      i25 <- input$numberOfPreCycles
      i26 <- input$analyzerDistancesSelect
      i27 <- input$analyzerFeaturesSelect
      i28 <- input$analyzerNgramInput
      i29 <- input$analyzerMfwMinimumInput
      i30 <- input$analyzerCullingMinimumInput
      i31 <- input$numberOfCycles
      p <- 0
      
      parseCorpus <- function(feature, ngram) {
        parsedCorpus <- parse.corpus(
          corpus, 
          encoding = ifelse(
            i1,
            "UTF-8",
            "native.enc"
          ),
          #corpus.lang = i2,
          features = feature,
          ngram.size = ngram
        )
        return(parsedCorpus)
      }
      
      RNGkind("L'Ecuyer-CMRG")
      
      parsed <- parseCorpus(feature = "w", ngram = 1)
      
      progress$set(
        value = 0.1,
        detail = "variable initialization"
      )
      
      distanceSelect <- function(x){
        distanceVector <- c(
          "dist.simple",
          "dist.manhattan",
          "dist.canberra",
          "dist.euclidean",
          "dist.cosine",
          "dist.delta",
          "dist.argamon",
          "dist.eder"
        )
        return(distanceVector[[x]])  
      }
      
      typeSelect <- function(x){
        r <- ifelse(
          x,
          "c",
          "w"
        )
        return(r)
      }
      
      #vector: ngramtype(true/false), ngramSize(1-7), mfwPercent(0-100), cullingPercent(0-100), distanceMeasurement(1-8)
      invokeStylo <- function(optionVector) {
        result = stylo(
          
          # Invoke without GUI with predefined corpus
          gui = FALSE, 
          parsed.corpus = parsed,
          
          # Input & language
          corpus.format = i3,
          encoding = ifelse(
            i1,
            "UTF-8",
            "native.enc"
          ),
          #corpus.lang = i2,
          
          # Features
          analyzed.features = typeSelect(optionVector[[1]]),
          ngram.size = ifelse(optionVector[[1]], optionVector[[2]], round(optionVector[[2]] / 2)),
          preserve.case = i4,
          
          # Most Frequent Words
          mfw.min = optionVector[[3]],
          mfw.max = optionVector[[3]],
          mfw.incr = 0,
          start.at = 1,
          
          # Culling
          culling.min = optionVector[[4]],
          culling.max = optionVector[[4]],
          culling.incr = 0,
          mfw.list.cutoff = i5,
          delete.pronouns = i6,

          #Statistics
          analysis.type = i7,
          consensus.strength = i8,
          text.id.on.graph = i9,
          add.to.margins = i10,
          label.offset = i11,
          pca.visual.flavour = i12,
          dendrogram.layout.horizontal = i13,
          distance.measure = distanceSelect(optionVector[[5]]),
          
          # Sampling
          sampling = i14,
          sample.size = i15,
          
          # Output
          display.on.screen = TRUE,
          write.pdf.file = FALSE,
          write.jpg.file = FALSE,
          write.png.file = FALSE,
          write.svg.file = FALSE,
          plot.options.reset = i16,
          plot.custom.height = i17,
          plot.custom.width = i18,
          plot.font.size = i19,
          plot.line.thickness = i20,
          colors.on.graphs = i21,
          titles.on.graphs = i22,
          
          # Undocumented but useful options
          custom.graph.filename = i23
        )
        
        return(result)
      }
      
      score <- function(tableOfResults){
        sumOfWrongGuesses <- 0;
        for(i in 1:length(rownames(tableOfResults))){
          sumOfPercents <- 0
          sumOfEPercents <- 0
          count <- 0
          Ecount <- 0
          for(j in 1:length(colnames(tableOfResults))){
            rName <- rownames(tableOfResults)[[i]]
            cName <- colnames(tableOfResults)[[j]]
            if(rName != cName){
              if(strsplit(rName, "_")[[1]][[1]] == strsplit(cName, "_")[[1]][[1]]){
                sumOfPercents = sumOfPercents + tableOfResults[i, j]
                count = count + 1
              }else{
                sumOfEPercents = sumOfEPercents + tableOfResults[i, j]
                Ecount = Ecount + 1
              }
            }
          }
          if(Ecount == 0 || (count > 0 && (sumOfPercents / count) < (sumOfEPercents / Ecount))){
            sumOfWrongGuesses = sumOfWrongGuesses - 1;
          } else {
            sumOfWrongGuesses = sumOfWrongGuesses + 1;
          }
        }
        return(sumOfWrongGuesses)
      }
      
      checkbounds <- function(v){
        upperBounds <- c(1, 6, 100, 90, 8)
        lowerBounds <- c(0, 2, 20, 0, 1)
        for(i in 1:5){
          if(v[[i]] < lowerBounds[[i]] || v[[i]] > upperBounds[[i]])
            return(FALSE)
        }
        if((v[[2]] > 2 && v[[4]] > 30) || (v[[2]] > 4 && v[[4]] > 10))
          return(FALSE)
        return(TRUE)
      }
          
      disable_run_buttons(session)
      disable_download(session)
      future({
        lut <- c()
        res <- c()
        index <- 1
        candidates <- c()
        results <- c()
        if (i24) {
          while(index < i25 + 1){
            candidates[[index]] <- c(
              ifelse(runif(1) > 0.5, TRUE, FALSE),
              round(runif(1)*4) + 2,
              round(runif(1)*16)*5 + 20,
              round(runif(1)*18)*5,
              round(runif(1)*6) + 1
            )
            progress$set(
              value = 0.1 + (index/(i25+1))*0.4,
              detail = paste("Pre-Cycle step #", index)
            )
            if(checkbounds(candidates[[index]])){
              sc <- 100000
              try({
                parsed <- parseCorpus(typeSelect(candidates[[index]][[1]]), candidates[[index]][[2]])
                result <- invokeStylo(candidates[[index]])
                sc <- score(result$distance.table)
              })
              results[[index]] <- sc
              lut[[index]] <- candidates[[index]]
              res[[index]] <- results[[index]]
              index = index + 1
            }
          }
        } else {
          j <- 0
          for (i in c(1,2,3,4,5,6,7,8)) {
            if(distanceSelect(i) == i26) {
              j <- i
            }
          }
          candidates[[1]] <- c(
            ifelse(i27 == "c", TRUE, FALSE),
            ifelse(i27 == "c", i28 * 2, i28),
            i29,
            i30,
            j
          )
          if(checkbounds(candidates[[1]])){
            sc <- 100000
            try({
              parsed <- parseCorpus(typeSelect(candidates[[1]][[1]]), candidates[[1]][[2]])
              result <- invokeStylo(candidates[[1]])
              sc <- score(result$distance.table)
            })
            results[[1]] <- sc
            lut[[1]] <- candidates[[1]]
            res[[1]] <- results[[1]]
          }
        }
        start <- candidates[[1]]
        e <- results[[1]]
        changeVector <- c(1, 1, 5, 5, 1)
          
        kmax <- i31
        k <- kmax
        while(k > 0){
          changeIndex <- round(runif(1)*4)+1
          nextVector <- start
          nextVector[[changeIndex]] <- start[[changeIndex]] + ifelse(runif(1) > 0.5, -1, 1) * changeVector[[changeIndex]]
          if(checkbounds(nextVector)){
            enew <- NULL
            for(i in 1:length(lut)){
              if(identical(x = lut[[i]], y = nextVector, num.eq = TRUE)){
                enew <- res[[i]]
              }
            }
            if(is.null(enew)){
              enew <- 100000
              try({
                if(changeIndex < 3){
                  parsed <- parseCorpus(typeSelect(nextVector[[1]]), nextVector[[2]])
                }
                result <- invokeStylo(nextVector)
                enew <- score(result$distance.table)
              })
              lut[[index]] <- nextVector
              res[[index]] <- enew
              index = index + 1
            }
            Temp <- k/kmax
            if(enew < e){
              P <- 1
            }else {
              P <- exp((-1*(enew - e))/Temp)
            }
            if(P > runif(1)){
              e <- enew
              start <- nextVector
            }
            k = k - 1
            progress$set(
              value = 0.6 + 0.5*((kmax-k)/kmax),
              detail = paste("iteration step #", kmax - k)
            )
          }
        }
        
        for(i in 1:length(res)){
          if(res[[i]] < e){
            e <- res[[i]]
            start <- lut[[i]]
          }
        }
        
        logData <- c()
        index2 <- 1
        for(i in 1:length(lut)){
          logData[[index2]] <- toString(c(lut[[i]], res[[i]]))
          index2 = index2 + 1
        }
        logData[[index2]] <- " "
        index2 = index2 + 1
        logData[[index2]] <- toString(c(start, e))
        
        fileConn<-file("log.txt")
        writeLines(toString(logData), fileConn, sep = "\n")
        close(fileConn)
        progress$close()
        
        start
      }) %...>% {
        updateSelectInput(session, "analyzerFeaturesSelect",
                          selected = typeSelect(.[[1]]))
        updateNumericInput(session, "analyzerNgramInput",
                           value = ifelse(.[[1]], .[[2]], round(.[[2]]/2)))
        updateNumericInput(session, "analyzerMfwMinimumInput",
                           value = .[[3]])
        updateNumericInput(session, "analyzerMfwMaximumInput",
                           value = .[[3]])
        updateNumericInput(session, "analyzerCullingMinimumInput",
                           value = .[[4]])
        updateNumericInput(session, "analyzerCullingMaximumInput",
                           value = .[[4]])
        updateSelectInput(session, "analyzerDistancesSelect",
                          choices = c(
                            "Classic Delta" = "dist.delta",
                            "Argamon's Delta" = "dist.argamon",
                            "Eder's Delta" = "dist.eder",
                            "Eder's Simple Distance" = "dist.simple",
                            "Manhattan" = "dist.manhattan",
                            "Canberra" = "dist.canberra",
                            "Euclidean" = "dist.euclidean",
                            "Cosine" = "dist.cosine"
                          ), selected = distanceSelect(.[[5]])
        )
        saveSettings(db.service, input)
        write("Analyzer is finished. Please review then save the suggested parameter settings.", stdout())
        sink()
        # sink(type = "message")
        enable_run_buttons(session)
        enable_download(session)
      }
    }
  )
}
