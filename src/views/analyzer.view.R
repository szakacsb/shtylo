# import the stylometry sidebar
analyzer.sidebar.view <- dget("./views/analyzer.sidebar.view.R")
analyzer.main.view <- dget("./views/analyzer.main.view.R")

      fluidRow(
        column(
          4, # width out of 12
          analyzer.sidebar.view
        ),
        column(
          8, # width out of 12
          analyzer.main.view
        )
      )
