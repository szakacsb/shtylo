function(session, input){

  updateSelectInput(
    session,
    "input.select",
    selected = input$wizardInputSelect
  )
  
  updateSelectInput(
    session,
    "language.select",
    selected = input$wizardLanguageSelect
  )
  
  updateCheckboxInput(
    session,
    "utf8.checkbox",
    value = input$wizardUtf8Checkbox
  )
  
  
  updateSelectInput(
    session,
    "features.select",
    selected = input$wizardFeaturesSelect
  )
  
  updateCheckboxInput(
    session,
    "case.checkbox",
    value = input$wizardCaseCheckBox
  )
  
  updateNumericInput(
    session,
    "ngram.input",
    value = input$wizardNgramInput
  )
  
  
  updateNumericInput(
    session,
    "mfw.minimum.input",
    value = input$wizardMfwMinimumInput
  )
  
  updateNumericInput(
    session,
    "mfw.maximum.input",
    value = input$wizardMfwMaximumInput
  )
  
  updateNumericInput(
    session,
    "mfw.increment.input",
    value = input$wizardMfwIncrementInput
  )
  
  updateNumericInput(
    session,
    "mfw.freq.rank.input",
    value = input$wizardMfwFreqRankInput
  )
  
  
  updateNumericInput(
    session,
    "culling.minimum.input",
    value = input$wizardCullingMinimumInput
  )
  
  updateNumericInput(
    session,
    "culling.maximum.input",
    value = input$wizardCullingMaximumInput
  )
  
  updateNumericInput(
    session,
    "culling.increment.input",
    value = input$wizardCullingIncrementInput
  )
  
  updateNumericInput(
    session,
    "culling.list.cutoff.input",
    value = input$wizardCullingListCutoffInput
  )
  
  updateCheckboxInput(
    session,
    "culling.pronoun.checkbox",
    value = input$wizardCullingPronounCheckbox
  )
  
  
  updateSelectInput(
    session,
    "statistics.select",
    selected = input$wizardStatisticsSelect
  )
  
  updateNumericInput(
    session,
    "statistics.consensus.input",
    value = input$wizardStatisticsConsensusInput
  )
  
  updateSelectInput(
    session,
    "scatterplot.select",
    selected = input$wizardScatterplotSelect
  )
  
  updateNumericInput(
    session,
    "scatterplot.margin.input",
    value = input$wizardScatterplotMarginInput
  )
  
  updateNumericInput(
    session,
    "scatterplot.offset.input",
    value = input$wizardScatterplotOffsetInput
  )
  
  updateSelectInput(
    session,
    "pca.flavour.select",
    selected = input$wizardPcaFlavourSelect
  )
  
  updateCheckboxInput(
    session,
    "clustering.horizontal.checkbox",
    value = input$wizardClusteringHorizontalCheckbox
  )
  
  updateSelectInput(
    session,
    "distances.select",
    selected = input$wizardDistancesSelect
  )
  
  updateSelectInput(
    session,
    "sampling.select",
    selected = input$wizardSamplingSelect
  )
  
  updateNumericInput(
    session,
    "sampling.input",
    value = input$wizardSamplingInput
  )
  
  updateNumericInput(
    session,
    "output.plot.height.input",
    value = input$wizardOutputPlotHeightInput
  )
  
  updateNumericInput(
    session,
    "output.plot.width.input",
    value = input$wizardOutputPlotWidthInput
  )
  
  updateNumericInput(
    session,
    "output.plot.font.input",
    value = input$wizardOutputPlotFontInput
  )
  
  updateNumericInput(
    session,
    "output.plot.line.input",
    value = input$wizardOutputPlotLineInput
  )
  
  updateSelectInput(
    session,
    "output.plot.colour.choices",
    selected = input$wizardOutputPlotColourChoices
  )
  
  updateCheckboxInput(
    session,
    "output.plot.default.checkbox",
    value = input$wizardOutputPlotDefaultCheckbox
  )
  
  updateCheckboxInput(
    session,
    "output.plot.titles.checkbox",
    value = input$wizardOutputPlotTitlesCheckbox
  )
}