stylo.wizard.controller <- dget("./controllers/stylo.wizard.controller.R")
stylo.analyzer.controller <- dget("./controllers/stylo.analyzer.controller.R")
stylo.sidebar.controller <- dget("./controllers/stylo.sidebar.controller.R")
log.controller <- dget("./controllers/log.controller.R")
db.controller <- dget("./controllers/db.controller.R")
stylo.main.controller <- dget("./controllers/stylo.main.controller.R")
stylo.wizard.preanalyzer <- dget("./controllers/stylo.wizard.preanalyzer.controller.R")
stylo.wizard.update <- dget("./controllers/stylo.wizard.update.R")
stylo.wizard.saveSettings <- dget("./controllers/stylo.wizard.save.R")
stylo.wizard.loadSettings <- dget("./controllers/stylo.wizard.load.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  # initialize logging
  log.service <- log.controller(input, output, session)
  #initialize database
  db.service <- db.controller(input, output, session, log.service)
  
  # initialize the sidebar
  stylo.params.service <- stylo.sidebar.controller(
    input, 
    output, 
    session, 
    db.service, 
    log.service
  )
  
  stylo.wizard.service <- stylo.wizard.controller(
    input, 
    output, 
    session, 
    db.service, 
    log.service,
    stylo.wizard.preanalyzer,
    stylo.wizard.update,
    stylo.wizard.saveSettings,
    stylo.wizard.loadSettings
  )
  
  stylo.analyzer.service <- stylo.analyzer.controller(
    input, 
    output, 
    session, 
    db.service, 
    log.service,
    stylo.wizard.preanalyzer,
    stylo.wizard.update
  )
    
  #initialize stylometry plots
  stylo.main.controller(
    input, 
    output, 
    session, 
    db.service, 
    log.service, 
    stylo.params.service
  )
})
