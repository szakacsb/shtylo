function (input, output, session, log.service) {
  
  set.workspace <- function (corpus) {
    dir.create(file.path(wd, corpus), showWarnings = FALSE)
    setwd(paste(wd, corpus, sep = "/"))
  }
  
  observeEvent(input$corpus.download, {
    #session$corpus.ready <- TRUE
    i1 <- input$corpus.name
    i2 <- input$corpus.url
    set.workspace(i1)
    progress <- AsyncProgress$new(
      message = "Downloading corpus",
      min = 0,
      max = 1,
      detail = "Setting up corpus",
      style = "notification",
      session = session
    )
    progress$set(
      value = 0.2,
      detail = "Downloading .zip file"
    )
    future({
      set.workspace(i1)
      tryCatch({
        download.file(i2, paste(i1, ".zip", sep = ""), "curl")
        progress$set(
          value = 0.8,
          detail = "Extracting .zip file"
        )
        unzip(paste(i1, ".zip", sep = ""))
        FALSE
      },
      error=function(cond){
        TRUE
      })
    }) %...>% {
      if (.) {
        showModal(modalDialog(
          title = "Error",
          "Downloading and extracting failed."
        ))
        log.service$log(
          "Could not download or extract corpus.",
          where = "corpus"
        )
      } else {
        log.service$log(
          "Succesfully downloaded corpus.",
          where = "corpus"
        )
      }
    }
    progress$close()
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
    return(file.exists("./corpus"))
  }
  
  export <- list(load.collection, is.connected, load.save, upload.save)
  names(export) <- c("load.collection", "is.connected", "load.save", "upload.save")
  export
}
