style <- "default"

input.language.panel <- wellPanel(
  selectInput(
    "analyzerInputSelect", 
    "Input", 
    selected = NULL, 
    multiple = FALSE, 
    choices = NULL, 
    width = "100%"
  ),
  selectInput(
    "analyzerLanguageSelect", 
    "Language", 
    selected = NULL, 
    multiple = FALSE, 
    choices = NULL, 
    width = "100%"
  ),
  checkboxInput(
    "analyzerUtf8Checkbox", 
    "UTF-8", 
    value = TRUE, 
    width = NULL
  )
)

features.panel <- wellPanel(
  selectInput(
    "analyzerFeaturesSelect", 
    "Features", 
    selected = NULL, 
    multiple = FALSE, 
    choices = NULL, 
    width = "100%"
  ),
  numericInput(
    "analyzerNgramInput", 
    "Ngram size", 
    value = 1, 
    min = 1, 
    max = NA, 
    step = 1, 
    width = NULL
  ),
  checkboxInput(
    "analyzerCaseCheckbox", 
    "Preserve Case", 
    value = FALSE, 
    width = NULL
  )
)

mfw.panel <- wellPanel(
  numericInput(
    "analyzerMfwMinimumInput", 
    "Minimum", 
    value = 100, 
    min = 1, 
    max = NA, 
    step = 1, 
    width = NULL
  ),
  numericInput(
    "analyzerMfwMaximumInput", 
    "Maximum", 
    value = 100, 
    min = 1, 
    max = NA, 
    step = 1, 
    width = NULL
  ),
  numericInput(
    "analyzerMfwIncrementInput", 
    "Increment", 
    value = 100, 
    min = 1, 
    max = NA, 
    step = 1, 
    width = NULL
  ),
  numericInput(
    "analyzerMfwFreqRankInput", 
    "Starting frequency rank", 
    value = 1, 
    min = 1, 
    max = NA, 
    step = 1, 
    width = NULL
  )
)

culling.panel <- wellPanel(
  numericInput(
    "analyzerCullingMinimumInput", 
    "Minimum", 
    value = 0, 
    min = 0, 
    max = NA, 
    step = 1, 
    width = NULL
  ),
  numericInput(
    "analyzerCullingMaximumInput", 
    "Maximum", 
    value = 0, 
    min = 0, 
    max = NA, 
    step = 1, 
    width = NULL
  ),
  numericInput(
    "analyzerCullingIncrementInput", 
    "Increment", 
    value = 20, 
    min = 1, 
    max = NA, 
    step = 1, 
    width = NULL
  ),
  numericInput(
    "analyzerCullingListCutoffInput", 
    "List cutoff", 
    value = 5000, 
    min = 1, 
    max = NA, 
    step = 1, 
    width = NULL
  ),
  checkboxInput(
    "analyzerCullingPronounCheckbox", 
    "Delete pronouns", 
    value = FALSE, 
    width = NULL
  )
)

statistics.panel <- wellPanel(
  selectInput(
    "analyzerStatisticsSelect", 
    "Statistics", 
    selected = NULL, 
    multiple = FALSE, 
    choices = NULL, 
    width = "100%"
  ),
  conditionalPanel(
    condition = "input['statistics.select'] === 'BCT'",
    numericInput(
      "analyzerStatisticsConsensusInput", 
      "Consensus Strength", 
      value = 0.5, 
      min = 0.4, 
      max = 1, 
      step = 0.1, 
      width = NULL
    ),
    HTML('<hr style="color: grey;">')
  ),
  conditionalPanel(
    condition = "['MDS', 'PCV', 'PCR'].indexOf(input['statistics.select']) !== -1",
    HTML('<hr style="color: grey;">'),
    selectInput(
      "analyzerScatterplotSelect", 
      "Texts on plot", 
      selected = NULL, 
      multiple = FALSE, 
      choices = NULL, 
      width = "100%"
    ),
    numericInput(
      "analyzerScatterplotMarginInput", 
      "Margins", 
      value = 2, 
      min = 1, 
      max = NA, 
      step = 1, 
      width = NULL
    ),
    numericInput(
      "analyzerScatterplotOffsetInput", 
      "Label offset", 
      value = 3, 
      min = 1, 
      max = NA, 
      step = 1, 
      width = NULL
    ),
    HTML('<hr style="color: grey;">')
  ),
  conditionalPanel(
    condition = "['PCV', 'PCR'].indexOf(input['statistics.select']) !== -1",
    HTML('<hr style="color: grey;">'),
    selectInput(
      "analyzerPcaFlavourSelect", 
      "PCA flavour", 
      selected = NULL, 
      multiple = FALSE, 
      choices = NULL, 
      width = "100%"
    ),
    HTML('<hr style="color: grey;">')
  ),
  conditionalPanel(
    condition = "input['statistics.select'] === 'CA'",
    HTML('<hr style="color: grey;">'),
    checkboxInput(
      "analyzerClusteringHorizontalCheckbox", 
      "Horizontal CA tree", 
      value = TRUE, 
      width = NULL
    ),
    HTML('<hr style="color: grey;">')
  ),
  selectInput(
    "analyzerDistancesSelect", 
    "Distances", 
    selected = NULL, 
    multiple = FALSE, 
    choices = NULL, 
    width = "100%"
  )
)

sampling.panel <- wellPanel(
  selectInput(
    "analyzerSamplingSelect", 
    "Sampling Method", 
    selected = NULL, 
    multiple = FALSE, 
    choices = NULL, 
    width = "100%"
  ),
  conditionalPanel(
    condition = "input['sampling.select'] === 'normal.sampling'",
    numericInput(
      "analyzerSamplingInput", 
      "Sample Size", 
      value = 10000, 
      min = 1, 
      max = NA, 
      step = 1, 
      width = NULL
    )
  ),
  conditionalPanel(
    condition = "input['sampling.select'] === 'random.sampling'",
    numericInput(
      "analyzerSamplingInput", 
      "Random Samples", 
      value = 10000, 
      min = 1, 
      max = NA, 
      step = 1, 
      width = NULL
    )
  )
)

output.panel <- wellPanel(
    numericInput(
      "analyzerOutputPlotHeightInput", 
      "Plot Height", 
      value = 10, 
      min = 1, 
      max = NA, 
      step = 1, 
      width = NULL
    ),
    numericInput(
      "analyzerOutputPlotWidthInput", 
      "Plot Width", 
      value = 10, 
      min = 1, 
      max = NA, 
      step = 1, 
      width = NULL
    ),
    numericInput(
      "analyzerOutputPlotFontInput", 
      "Font Size", 
      value = 10, 
      min = 1, 
      max = NA, 
      step = 1, 
      width = NULL
    ),
    numericInput(
      "analyzerOutputPlotLineInput", 
      "Line Width", 
      value = 1, 
      min = 1, 
      max = NA, 
      step = 1, 
      width = NULL
    ),
    selectInput(
      "analyzerOutputPlotColourChoices", 
      "Plot Colours", 
      choices = NULL, 
      selected = NULL, 
      multiple = FALSE, 
      width = NULL
    ),
    checkboxInput(
      "analyzerOutputPlotDefaultCheckbox", 
      "Set defaults", 
      value = FALSE, 
      width = NULL
    ),
    checkboxInput(
      "analyzerOutputPlotTitlesCheckbox", 
      "Display titles", 
      value = FALSE, 
      width = NULL
    )
)

cycles.panel <- wellPanel(
    checkboxInput(
      "usePreCyclesCheckbox",
      "Set defaults",
      value = FALSE,
      width = NULL
    ),
    conditionalPanel(
      condition = "input['usePreCyclesCheckbox'] === true",
      numericInput(
        "numberOfPreCycles",
        "Number of Pre-Cycles",
        value = 10,
        min = 1,
        max = NA,
        step = 1,
        width = NULL
      )
    ),
    numericInput(
      "numberOfCycles",
      "Number of Cycles",
      value = 40,
      min = 1,
      max = NA,
      step = 1,
      width = NULL
    )
)

# create the stylometry sidebar
sidebarPanel(
  width = 12,
  bsCollapse(
    id = "analyzer.sidebar",
    bsCollapsePanel(
      title = "Input & Language",
      style = style,
      input.language.panel
    ),
    bsCollapsePanel(
      title = "Features",
      style = style,
      features.panel
    ),
    bsCollapsePanel(
      title = "Most Frequent Words",
      style = style,
      mfw.panel
    ),
    bsCollapsePanel(
      title = "Culling",
      style = style,
      culling.panel
    ),
    bsCollapsePanel(
      title = "Statistics",
      style = style,
      statistics.panel
    ),
    bsCollapsePanel(
      title = "Sampling",
      style = style,
      sampling.panel
    ),
    bsCollapsePanel(
      title = "Output",
      style = style,
      output.panel
    ),
    bsCollapsePanel(
      title = "Manage Settings",
      style = style,
      wellPanel(
        actionButton(
          "analyzer.save",
          label = "Save Settings"
        ),
        actionButton(
          "analyzer.load",
          label = "Load Settings"
        )
      ),
      wellPanel(
        textAreaInput(
          "analyzer.load.textbox",
          "Paste text here",
          value = "",
          width = "100%"
        ),
        actionButton(
          "analyzer.load.text",
          label = "Load from text"
        ),
        actionButton(
          "analyzer.export.text",
          label = "Save to text"
        )
      ),
      wellPanel(
        actionButton(
          "analyzer.load.stylo",
          label = "Load from Stylo"
        ),
        actionButton(
          "analyzer.load.wizard",
          label = "Load from Wizard"
        )
      )
    ),
    bsCollapsePanel(
      title = "Analyzer Cycles",
      style = style,
      cycles.panel
    )
  ),
  actionButton(
      "analyzer.run",
      label = "Run Analyzer"
  )
)
