function(db.service, session, type){
  saveVector <- db.service$load.save(type)
  
  updateSelectInput(
    session,
    "analyzerInputSelect",
    selected = saveVector[1]
  )
  
  updateSelectInput(
    session,
    "analyzerLanguageSelect",
    selected = saveVector[2]
  )

  updateCheckboxInput(
    session,
    "analyzerUtf8Checkbox",
    value = saveVector[3]
  )

  updateSelectInput(
    session,
    "analyzerFeaturesSelect",
    selected = saveVector[4]
  )

  updateNumericInput(
    session,
    "analyzerNgramInput",
    value = saveVector[5]
  )

  updateCheckboxInput(
    session,
    "analyzerCaseCheckbox",
    value = saveVector[6]
  )

  updateNumericInput(
    session,
    "analyzerMfwMinimumInput",
    value = saveVector[7]
  )

  updateNumericInput(
    session,
    "analyzerMfwMaximumInput",
    value = saveVector[8]
  )

  updateNumericInput(
    session,
    "analyzerMfwIncrementInput",
    value = saveVector[9]
  )

  updateNumericInput(
    session,
    "analyzerMfwFreqRankInput",
    value = saveVector[10]
  )

  updateNumericInput(
    session,
    "analyzerCullingMinimumInput",
    value = saveVector[11]
  )

  updateNumericInput(
    session,
    "analyzerCullingMaximumInput",
    value = saveVector[12]
  )

  updateNumericInput(
    session,
    "analyzerCullingIncrementInput",
    value = saveVector[13]
  )

  updateNumericInput(
    session,
    "analyzerCullingListCutoffInput",
    value = saveVector[14]
  )

  updateCheckboxInput(
    session,
    "analyzerCullingPronounCheckbox",
    value = saveVector[15]
  )

  updateSelectInput(
    session,
    "analyzerStatisticsSelect",
    selected = saveVector[16]
  )

  updateNumericInput(
    session,
    "analyzerStatisticsConsensusInput",
    value = saveVector[17]
  )

  updateSelectInput(
    session,
    "analyzerScatterplotSelect",
    selected = saveVector[18]
  )

  updateNumericInput(
    session,
    "analyzerScatterplotMarginInput",
    value = saveVector[19]
  )

  updateNumericInput(
    session,
    "analyzerScatterplotOffsetInput",
    value = saveVector[20]
  )

  updateSelectInput(
    session,
    "analyzerPcaFlavourSelect",
    selected = saveVector[21]
  )

  updateCheckboxInput(
    session,
    "analyzerClusteringHorizontalCheckbox",
    value = saveVector[22]
  )

  updateSelectInput(
    session,
    "analyzerDistancesSelect",
    selected = saveVector[23]
  )

  updateSelectInput(
    session,
    "analyzerSamplingSelect",
    selected = saveVector[24]
  )

  updateNumericInput(
    session,
    "analyzerSamplingInput",
    value = saveVector[25]
  )

  updateNumericInput(
    session,
    "analyzerOutputPlotHeightInput",
    value = saveVector[26]
  )

  updateNumericInput(
    session,
    "analyzerOutputPlotWidthInput",
    value = saveVector[27]
  )

  updateNumericInput(
    session,
    "analyzerOutputPlotFontInput",
    value = saveVector[28]
  )

  updateNumericInput(
    session,
    "analyzerOutputPlotLineInput",
    value = saveVector[29]
  )

  updateSelectInput(
    session,
    "analyzerOutputPlotColourChoices",
    selected = saveVector[30]
  )

  updateCheckboxInput(
    session,
    "analyzerOutputPlotDefaultCheckbox",
    value = saveVector[31]
  )

  updateCheckboxInput(
    session,
    "analyzerOutputPlotTitlesCheckbox",
    value = saveVector[32]
  )
}