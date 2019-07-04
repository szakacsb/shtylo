function (input, output, session, log.service) {
  
  mongodb <- reactiveValues(
    conn = NULL
  )
  
  set.workspace <- function (db, coll) {
    dir.create(file.path(wd, db), showWarnings = FALSE)
    dir.create(file.path(paste(wd, db, sep = "/"), coll), showWarnings = FALSE)
    setwd(paste(wd, db, coll, sep = "/"))
  }
  
  status.string <- eventReactive(input$db.connect, {
    paste("Connected to", paste(parseQueryString(session$clientData$url_search)$username, input$db.collection, sep = ":"), sep = " ")
  })
  
  observeEvent(input$db.connect, {
    tryCatch({
      mongodb$conn <- mongolite::mongo(
        collection = input$db.collection,
        db = parseQueryString(session$clientData$url_search)$username,
        url = db.url,
        verbose = TRUE
      )
      log.service$log(
        paste(
          "Connection successful: ",
          parseQueryString(session$clientData$url_search)$username,
          ":",
          input$db.collection,
          sep = ""
        ),
        where = "db"
      )
      log.service$default.label$error <- FALSE
      set.workspace(parseQueryString(session$clientData$url_search)$username, input$db.collection)
    },
    error = function(err) {
      log.service$log(
        paste(
          "Connection failed! invalid connection parameters: database='",
          parseQueryString(session$clientData$url_search)$username,
          "', collection='",
          input$db.collection,
          "'!",
          sep = ""
        ),
        where = "db"
      )
      log.service$default.label$error <- TRUE
      setwd(wd)
    },
    finally = {
      log.service$default.label$default <- FALSE
    }
    )
  })
  
  observeEvent(input$corpus.upload, {
    if (is.null(files$files) || is.null(mongodb$conn)) {
      log.service$log("Please connect to a database and select some files for upload!", where = "db")
      return()
    }
    tryCatch({
      texts <- files$files
      content <- sapply(texts$datapath, function (path) {
        paste(readLines(path), collapse = "\n")
      }, simplify = TRUE)
      texts$content <- content
      texts$title <- texts$name
      texts$datapath <- NULL
      mongodb$conn$insert(texts)
      log.service$log(
        paste(
          "Corpus insertion successful: ",
          parseQueryString(session$clientData$url_search)$username,
          ":",
          input$db.collection,
          sep = ""
        ),
        where = "db"
      )
    },
    error = function(err) {
      log.service$log(
        paste(
          "Corpus insertion failed at: ",
          parseQueryString(session$clientData$url_search)$username,
          ":",
          input$db.collection,
          ", error: ",
          err,
          sep = ""
        ),
        where = "db"
      )
    })
  })
  
  output$db.status <- renderText({
    if(log.service$default.label$default == TRUE) {
      "Not Connected"
    } else if (log.service$default.label$error == TRUE){
      "Invalid connection parameters!"
    } else {
      status.string()
    }
  })
  
  output$corpus.table <- renderTable({
    texts <- files$files
    if (is.null(texts)) {
      return(NULL)
    }
    texts$datapath <- NULL
    names(texts) <- c("File names", "File sizes (Bytes)", "MIME Type")
    texts
  })
  
  files <- reactiveValues(
    files = NULL
  )
  
  observe({
    input$corpus.upload
    files$files <- NULL
  })
  
  
  observe({
    files$files <- input$corpus.selector
  })
  
  output$resettable.file.input <- renderUI({
    input$corpus.upload
    fileInput(
      "corpus.selector",
      "Select texts to upload",
      multiple = TRUE,
      accept = c(
        "application/xml",
        "text/xml",
        "text/html",
        "text/plain"
      ),
      width = "100%"
    )
  })
  
  load.collections <- function () {
    base <- mongolite::mongo(
      url = db.url,
      verbose = TRUE
    )
    result <- base$run('{"listCollections":1}')
    result <- as.list(result$name)
    result
  }
  
  load.corpus <- function () {
    collection <- mongodb$conn$find()
    corpus <- as.list(collection$content)
    corpus <- setNames(
      object = corpus,
      nm = collection$title
    )
    corpus$config.conf <- NULL
    corpus
  }
  
  load.save <- function () {
    collection <- mongodb$conn$find('{"title":"config.conf"}')
    saves <- as.list(collection$content)
    corpus <- setNames(
      object = saves,
      nm = collection$title
    )
    return(corpus$config.conf)
  }
  
  upload.save <- function (save) {
    if (is.null(save) || is.null(mongodb$conn)) {
      log.service$log("Please connect to a database and select some files for upload!", where = "db")
      return()
    }
    tryCatch({
      texts <- NULL
      content <- save
      texts$content <- content
      texts$title <- "config.conf"
      texts$datapath <- NULL
      mongodb$conn$insert(texts)
      log.service$log(
        paste(
          "Save of settings successful"
        ),
        where = "db"
      )
    },
    error = function(err) {
      log.service$log(
        paste(
          "Save of settings failed"
        ),
        where = "db"
      )
    })
  }
  
  is.connected <- function () {
    ifelse(
      test = is.null(mongodb$conn),
      yes = FALSE,
      no = TRUE
    )
  }
  
  observe({
    updateSelectInput(
      session,
      "db.collections",
      choices = c(
        load.collections()
      )
    )
  })
  
  export <- list(load.corpus, is.connected, load.save, upload.save)
  names(export) <- c("load.corpus", "is.connected", "load.save", "upload.save")
  export
}