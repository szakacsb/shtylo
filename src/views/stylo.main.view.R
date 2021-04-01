# initialize the main view of the stylometry page

mainPanel(
  width = 12,
  tags$head(
    tags$style(
      type='text/css',
      '#styloConsole {overflow-y:scroll; min-height: 350px; max-height: 350px; display: flex; flex-direction: column-reverse;}
      #wizardConsole {overflow-y:scroll; min-height: 350px; max-height: 350px; display: flex; flex-direction: column-reverse;}'
    )
  ),
  tabsetPanel(
    type = "tabs",
    id = "stylo.result.panel",
    tabPanel(
      "Plot",
      div(
        width = "100%",
        conditionalPanel(
          condition = "output.jobDone",
          selectInput(
            "output.plot.format.choices",
            "Plot file formats",
            choices = NULL,
            selected = NULL,
            multiple = FALSE,
            width = NULL
          ),
          downloadLink(
            "download.plot",
            label = "Download"
          )
        ),
        div(
          width = "100%",
          style = "overflow-y:scroll; max-height: 550px",
          imageOutput(
            "stylo.plot"
          )
        )
      )
    ),
    tabPanel(
      "Frequencies",
      div(
        width = "100%",
        conditionalPanel(
          condition = "output.jobDone",
          downloadLink(
            "download.frequencies",
            label = "Download"
          )
        ),
        div(
          width = "100%",
          style = "overflow-y:scroll; max-height: 550px",
          tableOutput("frequency.table")
        )
      )
    ),
    tabPanel(
      "Distances",
      div(
        width = "100%",
        conditionalPanel(
          condition = "output.jobDone",
          downloadLink(
            "download.distances",
            label = "Download"
          )
        ),
        div(
          width = "100%",
          style = "overflow-y:scroll; max-height: 550px",
          tableOutput("distance.table")
        )
      )
    ),
    tabPanel(
      "All Features",
      div(
        width = "100%",
        conditionalPanel(
          condition = "output.jobDone",
          downloadLink(
            "download.all.features",
            label = "Download"
          )
        ),
        div(
          width = "100%",
          style = "overflow-y:scroll; max-height: 550px",
          verbatimTextOutput("all.features.table")
        )
      )
    ),
    tabPanel(
      "Used Features",
      div(
        width = "100%",
        conditionalPanel(
          condition = "output.jobDone",
          downloadLink(
            "download.used.features",
            label = "Download"
          )
        ),
        div(
          width = "100%",
          style = "overflow-y:scroll; max-height: 550px",
          verbatimTextOutput("used.features.table")
        )
      )
    ),
    tabPanel(
      "Stylometry Log",
      div(
        width = "100%",
        div(
          width = "100%",
          verbatimTextOutput("styloConsole")
        )
      )
    )
  )
)
