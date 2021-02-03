# initialize the main view of the stylometry page

mainPanel(
  width = 12,
  tags$head(
    tags$style(
      type='text/css', 
      '#analyzerConsole {overflow-y:scroll; min-height: 350px; max-height: 350px;'
    )
  ),
  div(
    actionButton(
      "analyzer.run",
      label = "Run Analyzer"
    ),
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
  ),
  div(
    h5(
      "Corpus details"
    ),
    verbatimTextOutput(
      "analyzerConsole"
    )
  )
)