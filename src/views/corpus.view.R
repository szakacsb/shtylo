# define the main panel of the corpus view
corpus.main.view <- mainPanel(
  width = 12,
  tags$head(
    tags$style(
      type='text/css', 
      '#corpusConsole {overflow-y:scroll; min-height: 350px; max-height: 350px;'
    )
  ),
  div(
    h5(
      "Corpus log"
    ),
    verbatimTextOutput(
      "corpusConsole"
    )
  )
)

# define the database connection config sidebar
corpus.config.view <- sidebarPanel(
  width = 12,
  wellPanel(
    textInput("corpus.url", "Corpus URL (zip file)", value = "", width = "100%", placeholder = "https://.../corpus.zip"),
    textInput("corpus.name", "Corpus Name", value = "", width = "100%", placeholder = "my_corpus"),
    bsButton("CorpusDownload", label = "Download", type = "action", icon = icon(name = "plug", lib = "font-awesome"))
  )
)

# define the corpus connection view
fluidRow(
  column(
    4, # width out of 12
    corpus.config.view
  ),
  column(
    8, # width out of 12
    corpus.main.view
  )
)
