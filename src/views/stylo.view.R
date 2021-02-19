# import the stylometry sidebar
stylo.sidebar.view <- dget("./views/stylo.sidebar.view.R")
stylo.main.view <- dget("./views/stylo.main.view.R")

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
