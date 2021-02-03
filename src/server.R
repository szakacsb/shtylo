stylo.wizard.controller <- dget("./controllers/stylo.wizard.controller.R")
analyzer.main.controller <- dget("./controllers/analyzer.main.controller.R")
analyzer.sidebar.controller <- dget("./controllers/analyzer.sidebar.controller.R")
stylo.sidebar.controller <- dget("./controllers/stylo.sidebar.controller.R")
log.controller <- dget("./controllers/log.controller.R")
corpus.controller <- dget("./controllers/corpus.controller.R")
stylo.main.controller <- dget("./controllers/stylo.main.controller.R")
stylo.wizard.preanalyzer <- dget("./controllers/stylo.wizard.preanalyzer.controller.R")
stylo.wizard.update <- dget("./controllers/stylo.wizard.update.R")
stylo.wizard.saveSettings <- dget("./controllers/stylo.wizard.save.R")
stylo.wizard.loadSettings <- dget("./controllers/stylo.wizard.load.R")
stylo.saveSettings <- dget("./controllers/stylo.save.R")
stylo.loadSettings <- dget("./controllers/stylo.load.R")
stylo.analyzer.saveSettings <- dget("./controllers/stylo.analyzer.save.R")
stylo.analyzer.loadSettings <- dget("./controllers/stylo.analyzer.load.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  # initialize logging
  log.service <- log.controller(input, output, session)
  #initialize database
  corpus.service <- corpus.controller(input, output, session, log.service)
  
  # initialize the sidebar
  stylo.params.service <- stylo.sidebar.controller(
    input, 
    output, 
    session, 
    corpus.service, 
    log.service,
    stylo.saveSettings,
    stylo.loadSettings
  )
  
  stylo.wizard.service <- stylo.wizard.controller(
    input, 
    output, 
    session, 
    corpus.service, 
    log.service,
    stylo.wizard.preanalyzer,
    stylo.wizard.update,
    stylo.wizard.saveSettings,
    stylo.wizard.loadSettings
  )
  
  stylo.analyzer.params.service <- analyzer.sidebar.controller(
    input, 
    output, 
    session, 
    corpus.service, 
    log.service,
    stylo.analyzer.saveSettings,
    stylo.analyzer.loadSettings
  )
  
  stylo.analyzer.service <- analyzer.main.controller(
    input, 
    output, 
    session, 
    corpus.service, 
    log.service,
    stylo.analyzer.params.service
  )
    
  #initialize stylometry plots
  stylo.main.controller(
    input, 
    output, 
    session, 
    corpus.service, 
    log.service, 
    stylo.params.service
  )
})
