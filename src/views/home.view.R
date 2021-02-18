corpus.text <- read_file("./texts/corpus.help.txt")
wizard.text <- read_file("./texts/wizard.help.txt")
runstylo.text <- read_file("./texts/runstylo.help.txt")
analyzer.text <- read_file("./texts/analyzer.help.txt")

div(
  h3("Get started"),
      div(
        div(
          h5("Corpus"),
          p(corpus.text)
        ),
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
)
