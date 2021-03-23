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
    proc_download <- future({
      set.workspace(i1)
      download.file(i2, paste(i1, ".zip", sep = ""), "curl", extra="--insecure")
      if (file.info(paste(i1, ".zip", sep = ""))$size < 100) {
	stop("File download failed. Check the URL.")
      }
      progress$set(
        value = 0.8,
        detail = "Extracting .zip file",
        message = "Extracting .zip file"
      )
      unzip(paste(i1, ".zip", sep = ""))
      if (!dir.exists('corpus')) {
	stop("Corpus directory does not exists in the downloaded file.")
      }
    })
    tryCatch({
        value(proc_download)
        log.service$log(
          "Succesfully downloaded corpus.",
          where = "corpus"
        )
      },
      error = function(ex) {
        log.service$log(
          paste("Downloading and extracting failed.", ex),
          where = "corpus"
        )
        # trace <- backtrace(proc_download)
        # print(trace)
      }
    )
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
