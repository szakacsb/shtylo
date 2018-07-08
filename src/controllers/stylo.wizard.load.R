function(filename, session){
  
  load(paste(filename, "asr", sep = "."))
  
  updateSelectInput(
    session,
    "wizardInputSelect",
    selected = saveVector[1]
  )
  
  updateSelectInput(
    session,
    "wizardLanguageSelect",
    selected = saveVector[2]
  )

  updateCheckboxInput(
    session,
    "wizardUtf8Checkbox",
    value = saveVector[3]
  )

  updateSelectInput(
    session,
    "wizardFeaturesSelect",
    selected = saveVector[4]
  )

  updateNumericInput(
    session,
    "wizardNgramInput",
    value = saveVector[5]
  )

  updateCheckboxInput(
    session,
    "wizardCaseCheckbox",
    value = saveVector[6]
  )

  updateNumericInput(
    session,
    "wizardMfwMinimumInput",
    value = saveVector[7]
  )

  updateNumericInput(
    session,
    "wizardMfwMaximumInput",
    value = saveVector[8]
  )

  updateNumericInput(
    session,
    "wizardMfwIncrementInput",
    value = saveVector[9]
  )

  updateNumericInput(
    session,
    "wizardMfwFreqRankInput",
    value = saveVector[10]
  )

  updateNumericInput(
    session,
    "wizardCullingMinimumInput",
    value = saveVector[11]
  )

  updateNumericInput(
    session,
    "wizardCullingMaximumInput",
    value = saveVector[12]
  )

  updateNumericInput(
    session,
    "wizardCullingIncrementInput",
    value = saveVector[13]
  )

  updateNumericInput(
    session,
    "wizardCullingListCutoffInput",
    value = saveVector[14]
  )

  updateCheckboxInput(
    session,
    "wizardCullingPronounCheckbox",
    value = saveVector[15]
  )

  updateSelectInput(
    session,
    "wizardStatisticsSelect",
    selected = saveVector[16]
  )

  updateNumericInput(
    session,
    "wizardStatisticsConsensusInput",
    value = saveVector[17]
  )

  updateSelectInput(
    session,
    "wizardScatterplotSelect",
    selected = saveVector[18]
  )

  updateNumericInput(
    session,
    "wizardScatterplotMarginInput",
    value = saveVector[19]
  )

  updateNumericInput(
    session,
    "wizardScatterplotOffsetInput",
    value = saveVector[20]
  )

  updateSelectInput(
    session,
    "wizardPcaFlavourSelect",
    selected = saveVector[21]
  )

  updateCheckboxInput(
    session,
    "wizardClusteringHorizontalCheckbox",
    value = saveVector[22]
  )

  updateSelectInput(
    session,
    "wizardDistancesSelect",
    selected = saveVector[23]
  )

  updateSelectInput(
    session,
    "wizardSamplingSelect",
    selected = saveVector[24]
  )

  updateNumericInput(
    session,
    "wizardSamplingInput",
    value = saveVector[25]
  )

  updateNumericInput(
    session,
    "wizardOutputPlotHeightInput",
    value = saveVector[26]
  )

  updateNumericInput(
    session,
    "wizardOutputPlotWidthInput",
    value = saveVector[27]
  )

  updateNumericInput(
    session,
    "wizardOutputPlotFontInput",
    value = saveVector[28]
  )

  updateNumericInput(
    session,
    "wizardOutputPlotLineInput",
    value = saveVector[29]
  )

  updateSelectInput(
    session,
    "wizardOutputPlotColourChoices",
    selected = saveVector[30]
  )

  updateCheckboxInput(
    session,
    "wizardOutputPlotDefaultCheckbox",
    value = saveVector[31]
  )

  updateCheckboxInput(
    session,
    "wizardOutputPlotTitlesCheckbox",
    value = saveVector[32]
  )
}