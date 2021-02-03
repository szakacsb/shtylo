function(db.service, input){
  
  saveVector <- c(
    input$analyzerInputSelect,
    input$analyzerLanguageSelect,
    input$analyzerUtf8Checkbox,
    
    input$analyzerFeaturesSelect,
    input$analyzerNgramInput,
    input$analyzerCaseCheckbox,
    
    input$analyzerMfwMinimumInput,
    input$analyzerMfwMaximumInput,
    input$analyzerMfwIncrementInput,
    input$analyzerMfwFreqRankInput,
    
    input$analyzerCullingMinimumInput,
    input$analyzerCullingMaximumInput,
    input$analyzerCullingIncrementInput,
    input$analyzerCullingListCutoffInput,
    input$analyzerCullingPronounCheckbox,
    
    input$analyzerStatisticsSelect,
    input$analyzerStatisticsConsensusInput,
    input$analyzerScatterplotSelect,
    input$analyzerScatterplotMarginInput,
    input$analyzerScatterplotOffsetInput,
    input$analyzerPcaFlavourSelect,
    input$analyzerClusteringHorizontalCheckbox,
    input$analyzerDistancesSelect,
    
    input$analyzerSamplingSelect,
    input$analyzerSamplingInput,
    
    input$analyzerOutputPlotHeightInput,
    input$analyzerOutputPlotWidthInput,
    input$analyzerOutputPlotFontInput,
    input$analyzerOutputPlotLineInput,
    input$analyzerOutputPlotColourChoices,
    input$analyzerOutputPlotDefaultCheckbox,
    input$analyzerOutputPlotTitlesCheckbox
  )
  

  isolate(db.service$upload.save(saveVector, "analyzer"))
  
}