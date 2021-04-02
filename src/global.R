# load dependencies
library(stylo)
library(shiny)
library(shinyBS)
library(properties)
library(readr)
library(rjson)
library(promises)
library(future)
library(ipc)
library(utf8)
library(yaml)
library(cld3)
#library(textutils)
plan(multiprocess)

shtylo.properties <- read.properties("./.shiny_app.conf")
writeLines("The following Shtylo properties were loaded:")
for (key in names(shtylo.properties)) {
  writeLines(
    paste(
      key,
      shtylo.properties[[key]],
      sep = "="
    )
  )
}

wd <- normalizePath(shtylo.properties$wd, winslash = "\\")
custom.graph.file.prefix <- shtylo.properties$custom.graph.file.prefix

disable_run_buttons <- function(session) {
  updateButton(session, "WizardRun", disabled = TRUE)
  updateButton(session, "AnalyzerRun", disabled = TRUE)
  updateButton(session, "StyloRun", disabled = TRUE)
}
enable_run_buttons <- function(session) {
  updateButton(session, "WizardRun", disabled = FALSE)
  updateButton(session, "AnalyzerRun", disabled = FALSE)
  updateButton(session, "StyloRun", disabled = FALSE)
}
disable_download <- function(session) {
  updateButton(session, "CorpusDownload", disabled = TRUE)
}
enable_download <- function(session) {
  updateButton(session, "CorpusDownload", disabled = FALSE)
}
