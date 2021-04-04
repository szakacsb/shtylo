home.view <- dget("./views/home.view.R")
stylo.view <- dget("./views/stylo.view.R")
corpus.view <- dget("./views/corpus.view.R")
wizard.view <- dget("./views/stylo.wizard.view.R")
analyzer.view <- dget("./views/analyzer.view.R")


# Define the top level menu
fluidPage(
  # define a Boostrap style (found in the ./www folder)
  theme = "bootstrap.css",
  
  # create a navbar with menu items for major functions
  navbarPage(
    title = "Shtylo",
    id = "root.page",
    tabPanel(
      title = "Home",
      value = "home",
      icon = icon(name = "home", lib = "font-awesome"),
      home.view
    ),
    tabPanel(
      title = "Corpus",
      value = "corpus",
      icon = icon(name = "database", lib = "font-awesome"),
      corpus.view
    ),
    tabPanel(
      title = "Wizard",
      icon = icon(name = "magic", lib = "font-awesome"),
      wizard.view
    ),
    tabPanel(
      title = "Stylo",
      icon = icon(name = "paint-brush", lib = "font-awesome"),
      stylo.view
    ),
    tabPanel(
      title = "Analyzer",
      icon = icon(name = "spinner", lib = "font-awesome"),
      analyzer.view
    )
  )
)
