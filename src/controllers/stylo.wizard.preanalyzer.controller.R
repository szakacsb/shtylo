function(input, output, session, db.service) {
  withProgress(
    message = "Running Preanalyzer",
    min = 0,
    max = 1,
    detail = "Loading corpus",
    style = "notification",
    expr = {
      corpus <- isolate(db.service$load.collection())
      incProgress(
        amount = 0.5,
        detail = "Parsing corpus"
      )
      
      parsed <- parse.corpus(
        corpus, 
        encoding = ifelse(
          input$utf8.checkbox,
          "UTF-8",
          "native.enc"
        ),
        corpus.lang = ifelse(
          "language.select" %in% input$names,
          input$language.select,
          'hungarian'
        ),
        features = "w",
        ngram.size = 1
        # sampling = input$sampling.select,
        # sample.size = input$sampling.input
      )
      incProgress(
        amount = 0.1,
        detail = "Analyzing corpus"
      )
      frequencyList <- make.frequency.list(parsed, value = TRUE)
      
      meanOfFreq <- mean(frequencyList)
      firstCap <- 0.01
      secondCap <- 0.05
      
      feat_ <- "w"
      val_ <- 2
      if(meanOfFreq < firstCap){
        feat_ <- "c"
        val_ <- 3
      } else if(meanOfFreq < secondCap){
        feat_ <- "w"
        val_ <- 1
      }
      updateSelectInput(session, "wizardFeaturesSelect",
                        selected = feat_)
      updateNumericInput(session, "wizardNgramInput",
                         value = val_)
      
      topFrequencyList <- frequencyList[1:10]
      output$wizard.tfwTable <- renderTable(
        topFrequencyList,
        include.rownames = FALSE
      )
      frequencyList2 <- make.frequency.list(parsed, value = TRUE, relative = FALSE)
      avglen <- sum(frequencyList2) / length(frequencyList2)
      val_ <- round((avglen / (avglen + 5)) * 100)
      updateNumericInput(session, "wizardMfwMinimumInput",
                         value = val_)
      updateNumericInput(session, "wizardMfwMaximumInput",
                         value = val_)
      
      lengths_ <- vector(mode = "numeric", length = length(corpus))
      i <- 0
      for(item in corpus){
        var_ <- txt.to.words.ext(item)
        lengths_[i] <- length(var_)
        i = i + 1
      }
      avgOfFileLength <- mean(lengths_)
      culling_ <- round((avgOfFileLength / (avgOfFileLength + (100000 / length(corpus)))) * 100)
      updateNumericInput(session, "wizardCullingMinimumInput",
                         value = culling_)
      updateNumericInput(session, "wizardCullingMaximumInput",
                         value = culling_)
      
      if(length(frequencyList) > sum(frequencyList2)/10){
        updateNumericInput(
          session,
          "wizardCullingListCutoffInput",
          value = round(sum(frequencyList2)/10)
        )
      }
      
      updateCheckboxInput(session,
        "wizardCullingPronounCheckbox",
        value = TRUE
      )
      
      namesOfCorpus <- c()
      numbersOfCorpus <- c()
      index <- 1
      for(name in names(corpus)){
        writer <- strsplit(name, "_")[[1]][[1]]
        if(writer %in% namesOfCorpus){
          numbersOfCorpus[match(writer, namesOfCorpus)[[1]]] <- numbersOfCorpus[match(writer, namesOfCorpus)[[1]]] + 1
        }else{
          namesOfCorpus[[index]] <- writer
          index <- index + 1
        }
      }
      isVariedDistance <- FALSE
      for(itemA in numbersOfCorpus){
        for(itemB in numbersOfCorpus){
          if(itemA > itemB * 1.5){
            isVariedDistance <- TRUE
            break;
          }
        }
      }
      
      isVariedLength <- FALSE
      for(itemA in lengths_){
        for(itemB in lengths_){
          if(itemA > itemB * 2){
            isVariedLength <- TRUE
            break;
          }
        }
      }
      
      updateNumericInput(session,
        "wizardOutputPlotHeightInput",
        value = 10 + round(length(corpus) / 5)
      )
      
      updateNumericInput(session,
         "wizardOutputPlotWidthInput",
         value = 10 + round(length(corpus) / 10)
      )
      
      updateNumericInput(session,
         "wizardSamplingInput",
         value = round(mean(lengths_) / 2)
      )
      
      preanalyzerSet <- c("isVariedLength" = isVariedLength, "isVariedDistance" = isVariedDistance)
      
      if(preanalyzerSet[[1]]){
        samplingSet <- c(
          "Normal Sampling" = "normal.sampling",
          "Random Sampling" = "random.sampling"
        )
      }else{
        samplingSet <- c(
          "No Sampling" = "no.sampling"
        )
      }
      
      if(preanalyzerSet[[2]]){
        distanceSet <- c(
          "Eder's Simple Distance" = "dist.simple",
          "Manhattan" = "dist.manhattan",
          "Canberra" = "dist.canberra",
          "Euclidean" = "dist.euclidean",
          "Cosine" = "dist.cosine"
        )
      }else{
        distanceSet <- c(
          "Classic Delta" = "dist.delta",
          "Argamon's Delta" = "dist.argamon",
          "Eder's Delta" = "dist.eder"
        )
      }
      
      updateSelectInput(
        session,
        "wizardDistancesSelect",
        choices = distanceSet
      )
      updateSelectInput(
        session,
        "wizardSamplingSelect",
        choices = samplingSet
      )
      updateTabsetPanel(
        session,
        "stylo.start.tabsetpanel",
        selected = "Wizard"
      )
    }
  )
}