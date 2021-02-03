# import the stylometry view
stylo.view <- dget("./views/stylo.view.R")
corpus.view <- dget("./views/corpus.view.R")

# Define the top level menu
fluidPage(
  # define a Boostrap style (found in the ./www folder)
  theme = "bootstrap.css",
  
  # create a navbar with menu items for major functions
  navbarPage(
    title = "Shtylo",
    id = "root.page",
    tabPanel(
      title = "Corpus",
      value = "corpus",
      icon = icon(name = "database", lib = "font-awesome"),
      corpus.view
    ),
    tabPanel(
      title = "Stylometry",
      value = "stylometry",
      icon = icon(name = "paint-brush", lib = "font-awesome"),
      stylo.view
    ),
    navbarMenu(
      title = "More",
      icon = icon(name = "info", lib = "font-awesome"),
      tabPanel(
        title = "About Shtylo",
        value = "about-shtylo",
        icon = icon(name = "html5", lib = "font-awesome")
      ),
      tabPanel(
        title = "About Stylo",
        value = "about-stylo",
        icon = icon(name = "paint-brush", lib = "font-awesome")
      )
    )
  )
)
