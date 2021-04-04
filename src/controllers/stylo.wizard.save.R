function(db.service, input){
  
  saveList <- list(
    filetype = input$wizardInputSelect,
    language = input$wizardLanguageSelect,
    encoding = input$wizardUtf8Checkbox,
    
    features = input$wizardFeaturesSelect,
    NgramInput = input$wizardNgramInput,
    CaseCheckbox = input$wizardCaseCheckbox,
    
    MfwMinimumInput = input$wizardMfwMinimumInput,
    MfwMaximumInput = input$wizardMfwMaximumInput,
    MfwIncrementInput = input$wizardMfwIncrementInput,
    MfwFreqRankInput = input$wizardMfwFreqRankInput,
    
    CullingMinimumInput = input$wizardCullingMinimumInput,
    CullingMaximumInput = input$wizardCullingMaximumInput,
    CullingIncrementInput = input$wizardCullingIncrementInput,
    CullingListCutoffInput = input$wizardCullingListCutoffInput,
    CullingPronoun = input$wizardCullingPronounCheckbox,
    
    Statistics = input$wizardStatisticsSelect,
    StatisticsConsensus = input$wizardStatisticsConsensusInput,
    Scatterplot = input$wizardScatterplotSelect,
    ScatterplotMargin = input$wizardScatterplotMarginInput,
    ScatterplotOffset = input$wizardScatterplotOffsetInput,
    PcaFlavour = input$wizardPcaFlavourSelect,
    ClusteringHorizontal = input$wizardClusteringHorizontalCheckbox,
    Distances = input$wizardDistancesSelect,
    
    SamplingMethod = input$wizardSamplingSelect,
    SamplingNumber = input$wizardSamplingInput,
    
    OutputPlotHeight = input$wizardOutputPlotHeightInput,
    OutputPlotWidth = input$wizardOutputPlotWidthInput,
    OutputPlotFont = input$wizardOutputPlotFontInput,
    OutputPlotLine = input$wizardOutputPlotLineInput,
    OutputPlotColour = input$wizardOutputPlotColourChoices,
    OutputPlotDefault = input$wizardOutputPlotDefaultCheckbox,
    OutputPlotTitles = input$wizardOutputPlotTitlesCheckbox
  )
  
  isolate(db.service$upload.save(saveList, "wizard"))
}
