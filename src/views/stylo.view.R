# import the stylometry sidebar
stylo.sidebar.view <- dget("./views/stylo.sidebar.view.R")
stylo.main.view <- dget("./views/stylo.main.view.R")
wizard.panel <- dget("./views/stylo.wizard.view.R")

wizard.text <- read_file("./texts/wizard.help.txt")
runstylo.text <- read_file("./texts/runstylo.help.txt")
analyzer.text <- read_file("./texts/analyzer.help.txt")
# define the stylometry view

div(
  tabsetPanel(
    id = "stylo.start.tabsetpanel",
    tabPanel(
      "Get started",
      div(
        div(
          h5("Wizard"),
          p(wizard.text),
          actionButton(
            "wizard.run",
            label = "Run Wizard"
          )
        ),
        div(
          h5("Run stylo"),
          p(runstylo.text),
          actionButton(
            "stylo.activate",
            label = "Go to stylo"
          )
        ),
        div(
          h5("Analyzer"),
          p(analyzer.text),
          actionButton(
            "analyzer.run",
            label = "Run Analyzer"
          )
        )
      )
    ),
    tabPanel(
      "Wizard",
      wizard.panel
    ),
    tabPanel(
      "Run Stylo",
      fluidRow(
        column(
          4, # width out of 12
          stylo.sidebar.view
        ),
        column(
          8, # width out of 12
          stylo.main.view
        )
      )
    ),
    tabPanel(
      "Analyzer"
    )
  )
)