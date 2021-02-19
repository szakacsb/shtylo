function (input, output, session, db.service, log.service, stylo.analyzer.params.service) {
  
  observeEvent(
    
    eventExpr = input$analyzer.run, 
    handlerExpr = {
      withProgress(
        message = "Analyzer job in progress",
        min = 0,
        max = 1,
        detail = "Loading corpus",
        style = "notification",
        expr = {
          
          corpus <- isolate(db.service$load.collection())
          
          parseCorpus <- function(feature, ngram) {
            parsedCorpus <- parse.corpus(
              corpus, 
              encoding = ifelse(
                input$analyzerUtf8Checkbox,
                "UTF-8",
                "native.enc"
              ),
              corpus.lang = input$analyzerLanguageSelect,
              features = feature,
              ngram.size = ngram
            )
            return(parsedCorpus)
          }
          
          parsed <- parseCorpus(feature = "w", ngram = 1)
          
          incProgress(
            amount = 0.1,
            detail = "Capturing Stylo console output"
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
            incProgress(
              amount = 0.01,
              detail = "Doing an iteration"
            )
            isolate({
              result = stylo(
                
                # Invoke without GUI with predefined corpus
                gui = FALSE, 
                parsed.corpus = parsed,
                
                # Input & language
                corpus.format = input$analyzerInputSelect,
                encoding = ifelse(
                  input$analyzerUtf8Checkbox,
                  "UTF-8",
                  "native.enc"
                ),
                # corpus.lang = input$analyzerLanguageSelect,
                
                # Features
                analyzed.features = typeSelect(optionVector[[1]]),
                ngram.size = ifelse(optionVector[[1]], optionVector[[2]], round(optionVector[[2]] / 2)),
                preserve.case = input$analyzerCaseCheckbox,
                
                # Most Frequent Words
                mfw.min = optionVector[[3]],
                mfw.max = optionVector[[3]],
                mfw.incr = 0,
                start.at = 1,
                
                # Culling
                culling.min = optionVector[[4]],
                culling.max = optionVector[[4]],
                culling.incr = 0,
                mfw.list.cutoff = input$analyzerCullingListCutoffInput,
                delete.pronouns = input$analyzerCullingPronounCheckbox,
                
                #Statistics
                analysis.type = input$analyzerStatisticsSelect,
                consensus.strength = input$analyzerStatisticsConsensusInput,
                text.id.on.graph = input$analyzerScatterplotSelect,
                add.to.margins = input$analyzerScatterplotMarginInput,
                label.offset = input$analyzerScatterplotOffsetInput,
                pca.visual.flavour = input$analyzerPcaFlavourSelect,
                dendrogram.layout.horizontal = input$analyzerClusteringHorizontalCheckbox,
                distance.measure = distanceSelect(optionVector[[5]]),
                
                # Sampling
                sampling = input$analyzerSamplingSelect,
                sample.size = input$analyzerSamplingInput,
                
                # Output
                display.on.screen = TRUE,
                write.pdf.file = FALSE,
                write.jpg.file = FALSE,
                write.png.file = FALSE,
                write.svg.file = FALSE,
                plot.options.reset = input$analyzerOutputPlotDefaultCheckbox,
                plot.custom.height = input$analyzerOutputPlotHeightInput,
                plot.custom.width = input$analyzerOutputPlotWidthInput,
                plot.font.size = input$analyzerOutputPlotFontInput,
                plot.line.thickness = input$analyzerOutputPlotLineInput,
                colors.on.graphs = input$analyzerOutputPlotColourChoices,
                titles.on.graphs = input$analyzerOutputPlotTitlesCheckbox,
                
                # Undocumented but useful options
                custom.graph.filename = custom.graph.file.prefix
              )
            })
            
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
          
          lut <- c()
          res <- c()
          index <- 1
          candidates <- c()
          results <- c()
          if (input$usePreCyclesCheckbox) {
            while(index < input$numberOfPreCycles + 1){
              candidates[[index]] <- c(
                ifelse(runif(1) > 0.5, TRUE, FALSE),
                round(runif(1)*4) + 2,
                round(runif(1)*16)*5 + 20,
                round(runif(1)*18)*5,
                round(runif(1)*6) + 1
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
              if(distanceSelect(i) == input$analyzerDistancesSelect) {
                j <- i
              }
            }
            candidates[[1]] <- c(
              ifelse(input$analyzerFeaturesSelect == "c", TRUE, FALSE),
              ifelse(input$analyzerFeaturesSelect == "c", input$analyzerNgramInput * 2, input$analyzerNgramInput),
              input$analyzerMfwMinimumInput,
              input$analyzerCullingMinimumInput,
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
          
          kmax <- input$numberOfCycles
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
          
          updateSelectInput(session, "analyzerFeaturesSelect",
                             selected = typeSelect(start[[1]]))
          updateNumericInput(session, "analyzerNgramInput",
                             value = ifelse(start[[1]], start[[2]], round(start[[2]]/2)))
          updateNumericInput(session, "analyzerMfwMinimumInput",
                             value = start[[3]])
          updateNumericInput(session, "analyzerMfwMaximumInput",
                             value = start[[3]])
          updateNumericInput(session, "analyzerCullingMinimumInput",
                             value = start[[4]])
          updateNumericInput(session, "analyzerCullingMaximumInput",
                             value = start[[4]])
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
                            ), selected = distanceSelect(start[[5]])
          )
        }
      )
    }
  )
}
