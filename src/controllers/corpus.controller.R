function (input, output, session, log.service) {
  
  set.workspace <- function (corpus) {
    dir.create(file.path(wd, corpus), showWarnings = FALSE)
    setwd(paste(wd, corpus, sep = "/"))
  }
  
  observeEvent(input$corpus.download, {
    withProgress(
      message = "Downloading corpus",
      min = 0,
      max = 1,
      detail = "Setting up corpus",
      style = "notification",
      expr = {
        set.workspace(input$corpus.name)
        incProgress(
          amount = 0.1,
          detail = "Downloading .zip file"
        )
        download.file(input$corpus.url, paste(input$corpus.name, ".zip", sep = ""), "curl")
        incProgress(
          amount = 0.4,
          detail = "Extracting .zip file"
        )
        unzip(paste(input$corpus.name, ".zip", sep = ""))
        log.service$log(
          "Succesfully downloaded corpus.",
          where = "db"
        )
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
