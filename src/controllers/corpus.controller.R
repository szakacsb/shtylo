function (input, output, session, log.service) {
  
  set.workspace <- function (corpus) {
    dir.create(file.path(wd, corpus), showWarnings = FALSE)
    setwd(paste(wd, corpus, sep = "/"))
  }
  
  observeEvent(input$corpus.download, {
    tryCatch({
      #session$corpus.ready <- TRUE
      i1 <- input$corpus.name
      i2 <- input$corpus.url
      progress <- AsyncProgress$new(
        message = "Downloading corpus",
        min = 0,
        max = 1,
        detail = "Setting up corpus",
        style = "notification",
        session = session
      )
      set.workspace(i1)
      progress$set(
        value = 0.2,
        detail = "Downloading .zip file"
      )
      future({
        download.file(i2, paste(i1, ".zip", sep = ""), "curl")
        progress$set(
          value = 0.8,
          detail = "Extracting .zip file"
        )
        unzip(paste(i1, ".zip", sep = ""))
        
      }) %...>% {}
      log.service$log(
        "Succesfully downloaded corpus.",
        where = "db"
      )
      progress$close()
    },
    error=function(cond){
      showModal(modalDialog(
        title = "Error",
        "Downloading failed."
      ))
    })
  })

  load.collection <- function () {
    filelist <- list.files("./corpus")
    load.corpus(files=filelist, corpus.dir = "./corpus")
  }
  
  load.save <- function (type) {
    y <- read_file_raw(paste(type, ".conf", sep = ""))
    conffile <- unserialize(connection = y)
    conffile
  }
  
  upload.save <- function (x, type) {
    write_file(serialize(x, NULL), paste(type, ".conf", sep = ""))
  }
  
  is.connected <- function () {
    return(TRUE)
  }
  
  export <- list(load.collection, is.connected, load.save, upload.save)
  names(export) <- c("load.collection", "is.connected", "load.save", "upload.save")
  export
}
