
wizard.input.select.tooltip <- read_file("./texts/inputAndLanguage/wizard.input.select.tooltip.txt")
wizard.language.select.tooltip <- read_file("./texts/inputAndLanguage/wizard.language.select.tooltip.txt")
wizard.utf8.checkbox.tooltip <- read_file("./texts/inputAndLanguage/wizard.utf8.checkbox.tooltip.txt")
wizard.inputAndLanguage.help <- read_file("./texts/inputAndLanguage/wizard.inputAndLanguage.help.txt")

wizard.features.select.tooltip <- read_file("./texts/features/wizard.features.select.tooltip.txt")
wizard.ngram.input.tooltip <- read_file("./texts/features/wizard.ngram.input.tooltip.txt")
wizard.case.checkbox.tooltip <- read_file("./texts/features/wizard.case.checkbox.tooltip.txt")
wizard.features.help <- read_file("./texts/features/wizard.features.help.txt")

wizard.mfw.minimum.tooltip <- read_file("./texts/mfw/wizard.mfw.minimum.tooltip.txt")
wizard.mfw.maximum.tooltip <- read_file("./texts/mfw/wizard.mfw.maximum.tooltip.txt")
wizard.mfw.increment.tooltip <- read_file("./texts/mfw/wizard.mfw.increment.tooltip.txt")
wizard.mfw.freqRank.tooltip <- read_file("./texts/mfw/wizard.mfw.freqRank.tooltip.txt")
wizard.mfw.help <- read_file("./texts/mfw/wizard.mfw.help.txt")

wizard.inputAndLanguage.panel <- tabPanel(
  "Input & language",
  value = "1",
  fluidRow(
    column(
      6, # width out of 12
      selectInput(
        "wizardInputSelect", 
        "Input", 
        selected = NULL, 
        multiple = FALSE, 
        choices = NULL, 
        width = "100%"
      ),
      bsPopover(
        "wizardInputSelect",
        "Input select",
        wizard.input.select.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
      ),
      selectInput(
        "wizardLanguageSelect", 
        "Language", 
        selected = NULL, 
        multiple = FALSE, 
        choices = NULL, 
        width = "100%"
      ),
      bsPopover(
        "wizardLanguageSelect",
        "Language select",
        wizard.language.select.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
      ),
      checkboxInput(
        "wizardUtf8Checkbox", 
        "UTF-8", 
        value = TRUE, 
        width = NULL
      ),
      bsPopover(
        "wizardUtf8Checkbox",
        "UTF-8 encoding",
        wizard.utf8.checkbox.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
      )
    ),
    column(
      6, # width out of 12
      div(
        wizard.inputAndLanguage.help
      )
    )
  )
)

wizard.features.panel <- tabPanel(
  "Features",
  value = "2",
  fluidRow(
    column(
      6, # width out of 12
      selectInput(
        "wizardFeaturesSelect", 
        "Features", 
        selected = NULL, 
        multiple = FALSE, 
        choices = NULL, 
        width = "100%"
      ),
      bsPopover(
        "wizardFeaturesSelect",
        "Features",
        wizard.features.select.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
      ),
      numericInput(
        "wizardNgramInput", 
        "Ngram size", 
        value = 1, 
        min = 1, 
        max = NA, 
        step = 1, 
        width = NULL
      ),
      bsPopover(
        "wizardNgramInput",
        "Ngram size",
        wizard.ngram.input.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
      ),
      checkboxInput(
        "wizardCaseCheckbox", 
        "Preserve Case", 
        value = FALSE, 
        width = NULL
      ),
      bsPopover(
        "wizardCaseCheckbox",
        "Preserve Case",
        wizard.case.checkbox.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
      )
    ),
    column(
      6, # width out of 12
      div(
        wizard.features.help
      )
    )
  )
)

wizard.mfw.panel <- tabPanel(
  "MFW",
  value = "3",
  fluidRow(
    column(
      6, # width out of 12
      numericInput(
        "wizardMfwMinimumInput", 
        "Minimum", 
        value = 100, 
        min = 1, 
        max = NA, 
        step = 1, 
        width = NULL
      ),
      bsPopover(
        "wizardMfwMinimumInput",
        "Minimum",
        wizard.mfw.minimum.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
      ),
      numericInput(
        "wizardMfwMaximumInput", 
        "Maximum", 
        value = 100, 
        min = 1, 
        max = NA, 
        step = 1, 
        width = NULL
      ),
      bsPopover(
        "wizardMfwMaximumInput",
        "Maximum",
        wizard.mfw.maximum.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
      ),
      numericInput(
        "wizardMfwIncrementInput", 
        "Increment", 
        value = 100, 
        min = 1, 
        max = NA, 
        step = 1, 
        width = NULL
      ),
      bsPopover(
        "wizardMfwIncrementInput",
        "Increment",
        wizard.mfw.increment.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
      ),
      numericInput(
        "wizardMfwFreqRankInput", 
        "Starting frequency rank", 
        value = 1, 
        min = 1, 
        max = NA, 
        step = 1, 
        width = NULL
      ),
      bsPopover(
        "wizardMfwFreqRankInput",
        "Starting Frequency Rank",
        wizard.mfw.freqRank.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
      )
    ),
    column(
      6, # width out of 12
      div(
        wizard.mfw.help,
        div(
          width = "100%",
          style = "overflow-y:scroll; max-height: 550px",
          tableOutput("wizard.tfwTable")
        )
      )
    )
  )
)

wizard.culling.panel <- tabPanel(
  "Culling",
  value = "4",
  fluidRow(
    column(
      6, # width out of 12
      numericInput(
        "wizardCullingMinimumInput", 
        "Minimum", 
        value = 0, 
        min = 0, 
        max = NA, 
        step = 1, 
        width = NULL
      ),
      numericInput(
        "wizardCullingMaximumInput", 
        "Maximum", 
        value = 0, 
        min = 0, 
        max = NA, 
        step = 1, 
        width = NULL
      ),
      numericInput(
        "WizadrCullingIncrementInput", 
        "Increment", 
        value = 20, 
        min = 1, 
        max = NA, 
        step = 1, 
        width = NULL
      ),
      numericInput(
        "wizardCullingListCutoffInput", 
        "List cutoff", 
        value = 5000, 
        min = 1, 
        max = NA, 
        step = 1, 
        width = NULL
      ),
      checkboxInput(
        "wizardCullingPronounCheckbox", 
        "Delete pronouns", 
        value = FALSE, 
        width = NULL
      )
    ),
    column(
      6, # width out of 12
      div(
        p("help goes here")
      )
    )
  )
)

wizard.statistics.panel <- tabPanel(
  "Statistics",
  value = "5",
  fluidRow(
    column(
      6, # width out of 12
      selectInput(
        "wizardStatisticsSelect", 
        "Statistics", 
        selected = NULL, 
        multiple = FALSE, 
        choices = NULL, 
        width = "100%"
      ),
      conditionalPanel(
        condition = "input['wizardStatisticsSelect'] === 'BCT'",
        numericInput(
          "wizardStatisticsConsensusInput", 
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
        condition = "['MDS', 'PCV', 'PCR'].indexOf(input['wizardStatisticsSelect']) !== -1",
        HTML('<hr style="color: grey;">'),
        selectInput(
          "wizardScatterplotSelect", 
          "Texts on plot", 
          selected = NULL, 
          multiple = FALSE, 
          choices = NULL, 
          width = "100%"
        ),
        numericInput(
          "wizardScatterplotMarginInput", 
          "Margins", 
          value = 2, 
          min = 1, 
          max = NA, 
          step = 1, 
          width = NULL
        ),
        numericInput(
          "wizardScatterplotOffsetInput", 
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
        condition = "['PCV', 'PCR'].indexOf(input['wizardStatisticsSelect']) !== -1",
        HTML('<hr style="color: grey;">'),
        selectInput(
          "wizardPcaFlavourSelect", 
          "PCA flavour", 
          selected = NULL, 
          multiple = FALSE, 
          choices = NULL, 
          width = "100%"
        ),
        HTML('<hr style="color: grey;">')
      ),
      conditionalPanel(
        condition = "input['wizardStatisticsSelect'] === 'CA'",
        HTML('<hr style="color: grey;">'),
        checkboxInput(
          "wizardClusteringHorizontalCheckbox", 
          "Horizontal CA tree", 
          value = TRUE, 
          width = NULL
        ),
        HTML('<hr style="color: grey;">')
      ),
      selectInput(
        "wizardDistancesSelect", 
        "Distances", 
        selected = NULL, 
        multiple = FALSE, 
        choices = NULL, 
        width = "100%"
      )
    ),
    column(
      6, # width out of 12
      div(
        p("help goes here")
      )
    )
  )
)

wizard.sampling.panel <- tabPanel(
  "Sampling",
  value = "6",
  fluidRow(
    column(
      6, # width out of 12
      selectInput(
        "wizardSamplingSelect", 
        "Sampling Method", 
        selected = NULL, 
        multiple = FALSE, 
        choices = NULL, 
        width = "100%"
      ),
      conditionalPanel(
        condition = "input['wizardSamplingSelect'] === 'normal.sampling'",
        numericInput(
          "wizardSamplingInput", 
          "Sample Size", 
          value = 10000, 
          min = 1, 
          max = NA, 
          step = 1, 
          width = NULL
        )
      ),
      conditionalPanel(
        condition = "input['wizardSamplingSelect'] === 'random.sampling'",
        numericInput(
          "wizardSamplingInput", 
          "Random Samples", 
          value = 10000, 
          min = 1, 
          max = NA, 
          step = 1, 
          width = NULL
        )
      )
    ),
    column(
      6, # width out of 12
      div(
        p("help goes here")
      )
    )
  )
)

wizard.output.panel <- tabPanel(
  "Output",
  value = "7",
  fluidRow(
    column(
      6, # width out of 12
      numericInput(
        "wizardOutputPlotHeightInput", 
        "Plot Height", 
        value = 10, 
        min = 1, 
        max = NA, 
        step = 1, 
        width = NULL
      ),
      numericInput(
        "wizardOutputPlotWidthInput", 
        "Plot Width", 
        value = 10, 
        min = 1, 
        max = NA, 
        step = 1, 
        width = NULL
      ),
      numericInput(
        "wizardOutputPlotFontInput", 
        "Font Size", 
        value = 10, 
        min = 1, 
        max = NA, 
        step = 1, 
        width = NULL
      ),
      numericInput(
        "wizardOutputPlotLineInput", 
        "Line Width", 
        value = 1, 
        min = 1, 
        max = NA, 
        step = 1, 
        width = NULL
      ),
      selectInput(
        "wizardOutputPlotColourChoices", 
        "Plot Colours", 
        choices = NULL, 
        selected = NULL, 
        multiple = FALSE, 
        width = NULL
      ),
      checkboxInput(
        "wizardOutputPlotDefaultCheckbox", 
        "Set defaults", 
        value = FALSE, 
        width = NULL
      ),
      checkboxInput(
        "wizardOutputPlotTitlesCheckbox", 
        "Display titles", 
        value = FALSE, 
        width = NULL
      )
    ),
    column(
      6, # width out of 12
      div(
        p("help goes here")
      )
    )
  )
)

div(
  h4(
    "Wizard"
  ),
  tabsetPanel(
    id = "wizard.tabsetpanel",
    wizard.inputAndLanguage.panel,
    wizard.features.panel,
    wizard.mfw.panel,
    wizard.culling.panel,
    wizard.statistics.panel,
    wizard.sampling.panel,
    wizard.output.panel
  ),
  fluidRow(
    column(
      6,
      actionButton(
        "wizard.previous",
        label = "Previous"
      ),
      actionButton(
        "wizard.next",
        label = "Next"
      ),
      actionButton(
        "wizard.apply",
        label = "Apply"
      )
    ),
    column(
      6,
      textInput(
        "wizardFileName",
        NULL
      ),
      actionButton(
        "wizard.save",
        label = "Save Settings"
      ),
      actionButton(
        "wizard.load",
        label = "Load Settings"
      )
    )
  )
)
  