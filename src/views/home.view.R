corpus.text <- read_file("./texts/corpus.help.txt")
wizard.text <- read_file("./texts/wizard.help.txt")
runstylo.text <- read_file("./texts/runstylo.help.txt")
analyzer.text <- read_file("./texts/analyzer.help.txt")
citation.html <- "./texts/citation.html"
contact.html <- "./texts/contact.html"

div(
  h3("Get started"),
      div(
        div(
          h4("Corpus"),
          p(corpus.text)
        ),
        div(
          h4("Wizard"),
          p(wizard.text)
        ),
        div(
          h4("Stylo"),
          p(runstylo.text)
        ),
        div(
          h4("Analyzer"),
          p(analyzer.text)
        )
      ),
      h3("Citation"),
        div(
          includeHTML(citation.html)
        ),
      h3("Contact"),
        div(
          includeHTML(contact.html)
        )
)
