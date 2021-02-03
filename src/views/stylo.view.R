# import the stylometry sidebar
stylo.sidebar.view <- dget("./views/stylo.sidebar.view.R")
stylo.main.view <- dget("./views/stylo.main.view.R")
wizard.panel <- dget("./views/stylo.wizard.view.R")
analyzer.sidebar.panel <- dget("./views/analyzer.sidebar.view.R")
analyzer.main.view <- dget("./views/analyzer.main.view.R")

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
          p(wizard.text)
        ),
        div(
          h5("Stylo"),
          p(runstylo.text)
        ),
        div(
          h5("Analyzer"),
          p(analyzer.text)
        )
      )
    ),
    tabPanel(
      "Wizard",
      wizard.panel
    ),
    tabPanel(
      "Stylo",
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
      "Analyzer",
      fluidRow(
        column(
          4, # width out of 12
          analyzer.sidebar.panel
        ),
        column(
          8, # width out of 12
          analyzer.main.view
        )
      )
    )
  )
)