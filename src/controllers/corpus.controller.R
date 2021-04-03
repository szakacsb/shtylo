function (input, output, session, log.service) {
  
  observeEvent(input$CorpusDownload, {
    #session$corpus.ready <- TRUE
    i1 <- trimws(input$corpus.name)
    i2 <- trimws(input$corpus.url)
    if (i1 == "" || i2 == "") {
      showModal(modalDialog(
          title = "Error",
          "Enter the corpus location and its name!"
        ))
      return()
    }
    if (corpus.exists(i1)) {
      setwd(get.corpus.path(i1))
      cconf <- load.save('corpus')
      if (cconf['url'] != i2) {
        showModal(modalDialog(
          title = "Error",
          "A different corpus with the same name already exists. Choose a different name!"
        ))
        return()
      }
      # If the name and the URL is the same, load the existing corpus
    }
    disable_run_buttons(session)
    disable_download(session)
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
    if (!corpus.exists(i1)) proc_download <- future({
      setwd(create.corpus.path(i1))
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
        if (!corpus.exists(i1)) {
          value(proc_download)
          setwd(get.corpus.path(i1))
          log.service$log(
            "Succesfully downloaded the corpus.",
            where = "corpus"
          )
          init.config.files(input)
          upload.save(list(name = i1, url = i2), 'corpus')
	} else {
          log.service$log(
            "Loading already existing corpus. Choose a different corpus name if you would like to create a new corpus.",
            where = "corpus"
          )
	  # TODO load settings?
	}
        enable_run_buttons(session)
      },
      error = function(ex) {
        log.service$log(
          paste("Downloading and extracting failed.", trimws(ex)),
          where = "corpus"
        )
        unlink(get.corpus.path(i1), recursive = TRUE, force = TRUE)
        # trace <- backtrace(proc_download)
        # print(trace)
      }
    )
    progress$close()
    enable_download(session)
  })

  load.collection <- function () {
    filelist <- list.files("./corpus")
    load.corpus(files=filelist, corpus.dir = "./corpus")
  }

  detect.languages <- function () {
    filelist <- list.files("./corpus")
    # TODO check all files and return the best guess
    detect_language_mixed(read_file(paste("./corpus", filelist[[1]], sep = "/")), size = 1)
    #f <- function(fname) {
      #detect_language_mixed(read_file(paste("./corpus", fname, sep = "/")), size = 1)
    #}
    #sort(names(lapply(filelist, f)), decreasing = TRUE)
  }
  
  load.save <- function (type) {
    read_yaml(paste(type, ".conf", sep = ""))
  }
  
  upload.save <- function (x, type) {
    write_yaml(x, paste(type, ".conf", sep = ""))
  }
  
  is.connected <- function () {
    return(file.exists("./corpus"))
  }

  corpus.exists <- function(corpus_name) {
    # d = normalizePath(paste(wd, format(Sys.time(), "%F"), corpus_name, sep="/"), winslash = "\\")
    p = get.corpus.path(corpus_name)
    if (!dir.exists(p)) {
      return(FALSE)
    }
    # check if the corpus is properly inicialized
    file.exists(paste(p, 'corpus.conf', sep="/"))
  }

  get.corpus.path <- function(corpus_name) {
    # TODO use a user-specific directory
    # normalizePath(paste(wd, format(Sys.time(), "%F"), corpus_name, sep="/"), winslash = "\\")
    normalizePath(paste(wd, corpus_name, sep="/"), winslash = "\\")
  }

  create.corpus.path <- function(corpus_name) {
    p = get.corpus.path(corpus_name)
    if (!dir.exists(p)) {
      dir.create(p, recursive = TRUE)
    }
    p
  }

  init.config.files <- function (input) {
    stylo.wizard.saveSettings(corpus.service, input)
    stylo.saveSettings(corpus.service, input)
    stylo.analyzer.saveSettings(corpus.service, input)
  }

  export <- list(load.collection, is.connected, load.save, upload.save, detect.languages)
  names(export) <- c("load.collection", "is.connected", "load.save", "upload.save", "detect.languages")
  export
}
