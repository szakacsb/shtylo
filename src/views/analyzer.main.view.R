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
    h5(
      "Analyzer Log"
    ),
    verbatimTextOutput(
      "analyzerConsole"
    )
  )
)
