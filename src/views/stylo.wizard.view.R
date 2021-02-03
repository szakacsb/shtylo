
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

wizard.culling.minimum.tooltip <- read_file("./texts/culling/wizard.culling.minimum.tooltip.txt")
wizard.culling.maximum.tooltip <- read_file("./texts/culling/wizard.culling.maximum.tooltip.txt")
wizard.culling.increment.tooltip <- read_file("./texts/culling/wizard.culling.increment.tooltip.txt")
wizard.culling.listCutoff.tooltip <- read_file("./texts/culling/wizard.culling.listCutoff.tooltip.txt")
wizard.culling.pronouns.tooltip <- read_file("./texts/culling/wizard.culling.pronouns.tooltip.txt")
wizard.culling.help <- read_file("./texts/culling/wizard.culling.help.txt")

wizard.statistics.select.tooltip <- read_file("./texts/statistics/wizard.statistics.select.tooltip.txt")
wizard.statistics.consensus.tooltip <- read_file("./texts/statistics/wizard.statistics.consensus.tooltip.txt")
wizard.statistics.scatterplot.tooltip <- read_file("./texts/statistics/wizard.statistics.scatterplot.tooltip.txt")
wizard.statistics.scatterplot.margin.tooltip <- read_file("./texts/statistics/wizard.statistics.scatterplot.margin.tooltip.txt")
wizard.statistics.scatterplot.offset.tooltip <- read_file("./texts/statistics/wizard.statistics.scatterplot.offset.tooltip.txt")
wizard.statistics.pcaFlavour.tooltip <- read_file("./texts/statistics/wizard.statistics.pcaFlavour.tooltip.txt")
wizard.statistics.clustering.horisontal.tooltip <- read_file("./texts/statistics/wizard.statistics.clustering.horisontal.tooltip.txt")
wizard.statistics.distance.tooltip <- read_file("./texts/statistics/wizard.statistics.distance.tooltip.txt")
wizard.statistics.help <- read_file("./texts/statistics/wizard.statistics.help.txt")

wizard.sampling.select.tooltip <- read_file("./texts/sampling/wizard.sampling.select.tooltip.txt")
wizard.sampling.input.tooltip <- read_file("./texts/sampling/wizard.sampling.input.tooltip.txt")
wizard.sampling.help <- read_file("./texts/sampling/wizard.sampling.help.txt")

wizard.output.plot.height.tooltip <- read_file("./texts/output/wizard.output.plot.height.tooltip.txt")
wizard.output.plot.width.tooltip <- read_file("./texts/output/wizard.output.plot.width.tooltip.txt")
wizard.output.plot.font.tooltip <- read_file("./texts/output/wizard.output.plot.font.tooltip.txt")
wizard.output.plot.line.tooltip <- read_file("./texts/output/wizard.output.plot.line.tooltip.txt")
wizard.output.plot.colour.tooltip <- read_file("./texts/output/wizard.output.plot.colour.tooltip.txt")
wizard.output.plot.default.tooltip <- read_file("./texts/output/wizard.output.plot.default.tooltip.txt")
wizard.output.plot.titles.tooltip <- read_file("./texts/output/wizard.output.plot.titles.tooltip.txt")
wizard.output.help <- read_file("./texts/output/wizard.output.help.txt")

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
      bsPopover(
        "wizardCullingMinimumInput",
        "Minimum",
        wizard.culling.minimum.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
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
      bsPopover(
        "wizardCullingMaximumInput",
        "Maximum",
        wizard.culling.maximum.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
      ),
      numericInput(
        "wizardCullingIncrementInput", 
        "Increment", 
        value = 20, 
        min = 1, 
        max = NA, 
        step = 1, 
        width = NULL
      ),
      bsPopover(
        "wizardCullingIncrementInput",
        "Increment",
        wizard.culling.increment.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
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
      bsPopover(
        "wizardCullingListCutoffInput",
        "List cutoff",
        wizard.culling.listCutoff.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
      ),
      checkboxInput(
        "wizardCullingPronounCheckbox", 
        "Delete pronouns", 
        value = FALSE, 
        width = NULL
      ),
      bsPopover(
        "wizardCullingPronounCheckbox",
        "Delete pronouns",
        wizard.culling.pronouns.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
      )
    ),
    column(
      6, # width out of 12
      div(
        wizard.culling.help
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
      bsPopover(
        "wizardStatisticsSelect",
        "Statistics",
        wizard.statistics.select.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
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
        bsPopover(
          "wizardStatisticsConsensusInput",
          "Consensus Strength",
          wizard.statistics.consensus.tooltip,
          placement = "right",
          trigger = "hover",
          options=list(container="body")
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
        bsPopover(
          "wizardScatterplotSelect",
          "Texts on plot",
          wizard.statistics.scatterplot.tooltip,
          placement = "right",
          trigger = "hover",
          options=list(container="body")
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
        bsPopover(
          "wizardScatterplotMarginInput",
          "Margins",
          wizard.statistics.scatterplot.margin.tooltip,
          placement = "right",
          trigger = "hover",
          options=list(container="body")
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
        bsPopover(
          "wizardScatterplotOffsetInput",
          "Label offset",
          wizard.statistics.scatterplot.offset.tooltip,
          placement = "right",
          trigger = "hover",
          options=list(container="body")
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
        bsPopover(
          "wizardPcaFlavourSelect",
          "PCA flavour",
          wizard.statistics.pcaFlavour.tooltip,
          placement = "right",
          trigger = "hover",
          options=list(container="body")
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
        bsPopover(
          "wizardClusteringHorizontalCheckbox",
          "Horizontal CA tree",
          wizard.statistics.clustering.horisontal.tooltip,
          placement = "right",
          trigger = "hover",
          options=list(container="body")
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
      ),
      bsPopover(
        "wizardDistancesSelect",
        "Distances",
        wizard.statistics.distance.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
      )
    ),
    column(
      6, # width out of 12
      div(
        wizard.statistics.help
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
      bsPopover(
        "wizardSamplingSelect",
        "Sampling Method",
        wizard.sampling.select.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
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
        ),bsPopover(
          "wizardSamplingInput",
          "Sample Size",
          wizard.sampling.input.tooltip,
          placement = "right",
          trigger = "hover",
          options=list(container="body")
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
        ),
        bsPopover(
          "wizardSamplingInput",
          "Random Samples",
          wizard.sampling.input.tooltip,
          placement = "right",
          trigger = "hover",
          options=list(container="body")
        )
      )
    ),
    column(
      6, # width out of 12
      div(
        wizard.sampling.help
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
      bsPopover(
        "wizardOutputPlotHeightInput",
        "Plot Height",
        wizard.output.plot.height.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
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
      bsPopover(
        "wizardOutputPlotWidthInput",
        "Plot Width",
        wizard.output.plot.width.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
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
      bsPopover(
        "wizardOutputPlotFontInput",
        "Font Size",
        wizard.output.plot.font.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
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
      bsPopover(
        "wizardOutputPlotLineInput",
        "Line Width",
        wizard.output.plot.line.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
      ),
      selectInput(
        "wizardOutputPlotColourChoices", 
        "Plot Colours", 
        choices = NULL, 
        selected = NULL, 
        multiple = FALSE, 
        width = NULL
      ),
      bsPopover(
        "wizardOutputPlotColourChoices",
        "Plot Colours",
        wizard.output.plot.colour.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
      ),
      checkboxInput(
        "wizardOutputPlotDefaultCheckbox", 
        "Set defaults", 
        value = FALSE, 
        width = NULL
      ),
      bsPopover(
        "wizardOutputPlotDefaultCheckbox",
        "Set defaults",
        wizard.output.plot.default.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
      ),
      checkboxInput(
        "wizardOutputPlotTitlesCheckbox", 
        "Display titles", 
        value = FALSE, 
        width = NULL
      ),
      bsPopover(
        "wizardOutputPlotTitlesCheckbox",
        "Display titles",
        wizard.output.plot.titles.tooltip,
        placement = "right",
        trigger = "hover",
        options=list(container="body")
      )
    ),
    column(
      6, # width out of 12
      div(
        wizard.output.help
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
        "wizard.run",
        label = "Run Wizard"
      ),
      actionButton(
        "wizard.previous",
        label = "Previous"
      ),
      actionButton(
        "wizard.next",
        label = "Next"
      )
    ),
    column(
      6,
      wellPanel(
        actionButton(
          "wizard.save",
          label = "Save Settings"
        ),
        actionButton(
          "wizard.load",
          label = "Load Settings"
        )
      ),
      wellPanel(
        textAreaInput(
          "wizard.load.textbox",
          "Paste text here",
          value = "",
          width = "100%"
        ),
        actionButton(
          "wizard.load.text",
          label = "Load from text"
        ),
        actionButton(
          "wizard.export.text",
          label = "Save to text"
        )
      ),
      wellPanel(
        actionButton(
          "wizard.load.stylo",
          label = "Load from Stylo"
        ),
        actionButton(
          "wizard.load.analyzer",
          label = "Load from Analyzer"
        )
      )
    )
  )
)
  