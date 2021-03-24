function(input, output, session, db.service, saveSettings) {
  disable_run_buttons(session)
  disable_download(session)
  progress <- AsyncProgress$new(
    message = "Wizard is running",
    min = 0,
    max = 1,
    detail = "Loading corpus",
    style = "notification",
    session = session
  )
  future({
    corpus <- isolate(db.service$load.collection())
    progress$set(
      value = 0.5,
      detail = "corpus preprocessing"
    )
    parsed <- parse.corpus(
      corpus, 
      encoding = ifelse(
        input$utf8.checkbox,
        "UTF-8",
        "native.enc"
      ),
      # corpus.lang = ifelse(
      #   "language.select" %in% input$names,
      #   input$language.select,
      #   'hungarian'
      # ),
      features = "w",
      ngram.size = 1
      # sampling = input$sampling.select,
      # sample.size = input$sampling.input
    )
    progress$set(
      value = 0.8,
      detail = "corpus analysis"
    )
    frequencyList <- make.frequency.list(parsed, value = TRUE)
    
    meanOfFreq <- mean(frequencyList)
    firstCap <- 0.01
    secondCap <- 0.05
    
    feat_ <- "w"
    ngramsize_ <- 2
    if(meanOfFreq < firstCap){
      feat_ <- "c"
      ngramsize_ <- 3
    } else if(meanOfFreq < secondCap){
      feat_ <- "w"
      ngramsize_ <- 1
    }
   
    topFrequencyList <- frequencyList[1:10]
    output$wizard.tfwTable <- renderTable(
      topFrequencyList,
      include.rownames = FALSE
    )
    frequencyList2 <- make.frequency.list(parsed, value = TRUE, relative = FALSE)
    avglen <- sum(frequencyList2) / length(frequencyList2)
    mfwmin_ <- round((avglen / (avglen + 5)) * 100)
    corpus_len <- length(corpus)
    lengths_ <- vector(mode = "numeric", length = corpus_len)
    i <- 0
    for(item in corpus){
      var_ <- txt.to.words.ext(item)
      lengths_[i] <- length(var_)
      i = i + 1
    }
    avgOfFileLength <- mean(lengths_)
    culling_ <- round((avgOfFileLength / (avgOfFileLength + (100000 / corpus_len))) * 100)
   
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
    progress$close()
    c(corpus_len, mean(lengths_), isVariedLength, isVariedDistance, feat_, ngramsize_, culling_, length(frequencyList), round(sum(frequencyList2)/10), mfwmin_)
  }) %...>% {
    corpus_len <- strtoi(.[[1]])
    mean <- strtoi(.[[2]])
    updateSelectInput(session, "wizardFeaturesSelect",
                      selected = .[[5]])
    updateNumericInput(session, "wizardNgramInput",
                       value = .[[6]])
    updateNumericInput(session, "wizardCullingMinimumInput",
                       value = .[[7]])
    updateNumericInput(session, "wizardCullingMaximumInput",
                       value = .[[7]])
    if(.[[8]] > .[[9]]){
      updateNumericInput(
        session,
        "wizardCullingListCutoffInput",
        value = .[[9]]
      )
    }
    updateNumericInput(session, "wizardMfwMinimumInput",
                       value = .[[10]])
    updateNumericInput(session, "wizardMfwMaximumInput",
                       value = .[[10]])
 
    updateCheckboxInput(session,
      "wizardCullingPronounCheckbox",
      value = TRUE
    )
    updateNumericInput(session,
                       "wizardOutputPlotHeightInput",
                       value = 10 + round(corpus_len / 5)
    )
    updateNumericInput(session,
                       "wizardOutputPlotWidthInput",
                       value = 10 + round(corpus_len / 10)
    )
    updateNumericInput(session,
                       "wizardSamplingInput",
                       value = round(mean / 2)
    )
    
    if(.[[3]]){
      samplingSet <- c(
        "Normal Sampling" = "normal.sampling",
        "Random Sampling" = "random.sampling"
      )
    }else{
      samplingSet <- c(
        "No Sampling" = "no.sampling"
      )
    }

    if(.[[4]]){
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
    saveSettings(db.service, input)
    enable_run_buttons(session)
    enable_download(session)
  }
}
