function(filename, input){
  
  saveVector <- c(
    input$wizardInputSelect,
    input$wizardLanguageSelect,
    input$wizardUtf8Checkbox,
    
    input$wizardFeaturesSelect,
    input$wizardNgramInput,
    input$wizardCaseCheckbox,
    
    input$wizardMfwMinimumInput,
    input$wizardMfwMaximumInput,
    input$wizardMfwIncrementInput,
    input$wizardMfwFreqRankInput,
    
    input$wizardCullingMinimumInput,
    input$wizardCullingMaximumInput,
    input$wizardCullingIncrementInput,
    input$wizardCullingListCutoffInput,
    input$wizardCullingPronounCheckbox,
    
    input$wizardStatisticsSelect,
    input$wizardStatisticsConsensusInput,
    input$wizardScatterplotSelect,
    input$wizardScatterplotMarginInput,
    input$wizardScatterplotOffsetInput,
    input$wizardPcaFlavourSelect,
    input$wizardClusteringHorizontalCheckbox,
    input$wizardDistancesSelect,
    
    input$wizardSamplingSelect,
    input$wizardSamplingInput,
    
    input$wizardOutputPlotHeightInput,
    input$wizardOutputPlotWidthInput,
    input$wizardOutputPlotFontInput,
    input$wizardOutputPlotLineInput,
    input$wizardOutputPlotColourChoices,
    input$wizardOutputPlotDefaultCheckbox,
    input$wizardOutputPlotTitlesCheckbox
  )
  
  save(saveVector, file = paste(filename, "asr", sep = "."))
}