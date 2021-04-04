function(db.service, input){
  
  saveList <- list(
    filetype = input$analyzerInputSelect,
    language = input$analyzerLanguageSelect,
    encoding = input$analyzerUtf8Checkbox,
    
    features = input$analyzerFeaturesSelect,
    NgramInput = input$analyzerNgramInput,
    CaseCheckbox = input$analyzerCaseCheckbox,
    
    MfwMinimumInput = input$analyzerMfwMinimumInput,
    MfwMaximumInput = input$analyzerMfwMaximumInput,
    MfwIncrementInput = input$analyzerMfwIncrementInput,
    MfwFreqRankInput = input$analyzerMfwFreqRankInput,
    
    CullingMinimumInput = input$analyzerCullingMinimumInput,
    CullingMaximumInput = input$analyzerCullingMaximumInput,
    CullingIncrementInput = input$analyzerCullingIncrementInput,
    CullingListCutoffInput = input$analyzerCullingListCutoffInput,
    CullingPronoun = input$analyzerCullingPronounCheckbox,
    
    Statistics = input$analyzerStatisticsSelect,
    StatisticsConsensus = input$analyzerStatisticsConsensusInput,
    Scatterplot = input$analyzerScatterplotSelect,
    ScatterplotMargin = input$analyzerScatterplotMarginInput,
    ScatterplotOffset = input$analyzerScatterplotOffsetInput,
    PcaFlavour = input$analyzerPcaFlavourSelect,
    ClusteringHorizontal = input$analyzerClusteringHorizontalCheckbox,
    Distances = input$analyzerDistancesSelect,
    
    SamplingMethod = input$analyzerSamplingSelect,
    SamplingNumber = input$analyzerSamplingInput,
    
    OutputPlotHeight = input$analyzerOutputPlotHeightInput,
    OutputPlotWidth = input$analyzerOutputPlotWidthInput,
    OutputPlotFont = input$analyzerOutputPlotFontInput,
    OutputPlotLine = input$analyzerOutputPlotLineInput,
    OutputPlotColour = input$analyzerOutputPlotColourChoices,
    OutputPlotDefault = input$analyzerOutputPlotDefaultCheckbox,
    OutputPlotTitles = input$analyzerOutputPlotTitlesCheckbox
  )

  isolate(db.service$upload.save(saveList, "analyzer"))
  
}
