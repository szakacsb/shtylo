# initialize the main view of the stylometry page

mainPanel(
  width = 12,
  tags$head(
    tags$style(
      type='text/css',
      '#styloConsole {overflow-y:scroll; min-height: 420px; max-height: 420px; display: flex; flex-direction: column-reverse;}
      #wizardConsole {overflow-y:scroll; min-height: 350px; max-height: 350px;}'
    )
  ),
  tabsetPanel(
    type = "tabs",
    id = "stylo.result.panel",
    tabPanel(
      "Result Plot",
      div(
        width = "100%",
        conditionalPanel(
          condition = "output.jobDone",
          downloadButton(
            "download.plot.pdf",
            label = "  PDF",
	    class = "btn-sm",
	    icon = icon(name = "download", lib = "font-awesome")
          ),
          downloadButton(
            "download.plot.png",
            label = "  PNG",
	    class = "btn-sm",
	    icon = icon(name = "download", lib = "font-awesome")
          ),
          downloadButton(
            "download.plot.svg",
            label = "  SVG",
	    class = "btn-sm",
	    icon = icon(name = "download", lib = "font-awesome")
          ),
          htmlOutput(
            'download.plot.msg',
            inline = TRUE,
          )
        ),
        div(
          width = "100%",
          style = "overflow-y:scroll; max-height: 100%;",
          uiOutput(
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
          downloadButton(
            "download.frequencies",
            label = "  Frequency Table CSV",
	    class = "btn-sm",
	    icon = icon(name = "download", lib = "font-awesome")
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
          downloadButton(
            "download.distances",
            label = "  Distances CSV",
	    class = "btn-sm",
	    icon = icon(name = "download", lib = "font-awesome")
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
          downloadButton(
            "download.all.features",
            label = "  All Features CSV",
	    class = "btn-sm",
	    icon = icon(name = "download", lib = "font-awesome")
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
          downloadButton(
            "download.used.features",
            label = "  Used Features CSV",
	    class = "btn-sm",
	    icon = icon(name = "download", lib = "font-awesome")
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
