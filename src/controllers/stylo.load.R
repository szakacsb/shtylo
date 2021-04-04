function(db.service, session, type){
  saveVector <- unlist(db.service$load.save(type), recursive = FALSE, use.names = FALSE)

  updateSelectInput(
    session,
    "input.select",
    selected = saveVector[1]
  )
  
  updateSelectInput(
    session,
    "language.select",
    selected = saveVector[2]
  )

  updateCheckboxInput(
    session,
    "utf8.checkbox",
    value = saveVector[3]
  )

  updateSelectInput(
    session,
    "features.select",
    selected = saveVector[4]
  )

  updateNumericInput(
    session,
    "ngram.input",
    value = saveVector[5]
  )

  updateCheckboxInput(
    session,
    "case.checkbox",
    value = saveVector[6]
  )

  updateNumericInput(
    session,
    "mfw.minimum.input",
    value = saveVector[7]
  )

  updateNumericInput(
    session,
    "mfw.maximum.input",
    value = saveVector[8]
  )

  updateNumericInput(
    session,
    "mfw.increment.input",
    value = saveVector[9]
  )

  updateNumericInput(
    session,
    "mfw.freq.rank.input",
    value = saveVector[10]
  )

  updateNumericInput(
    session,
    "culling.minimum.input",
    value = saveVector[11]
  )

  updateNumericInput(
    session,
    "culling.maximum.input",
    value = saveVector[12]
  )

  updateNumericInput(
    session,
    "culling.increment.input",
    value = saveVector[13]
  )

  updateNumericInput(
    session,
    "culling.list.cutoff.input",
    value = saveVector[14]
  )

  updateCheckboxInput(
    session,
    "culling.pronoun.checkbox",
    value = saveVector[15]
  )

  updateSelectInput(
    session,
    "statistics.select",
    selected = saveVector[16]
  )

  updateNumericInput(
    session,
    "statistics.consensus.input",
    value = saveVector[17]
  )

  updateSelectInput(
    session,
    "scatterplot.select",
    selected = saveVector[18]
  )

  updateNumericInput(
    session,
    "scatterplot.margin.input",
    value = saveVector[19]
  )

  updateNumericInput(
    session,
    "scatterplot.offset.input",
    value = saveVector[20]
  )

  updateSelectInput(
    session,
    "pca.flavour.select",
    selected = saveVector[21]
  )

  updateCheckboxInput(
    session,
    "clustering.horizontal.checkbox",
    value = saveVector[22]
  )

  updateSelectInput(
    session,
    "distances.select",
    selected = saveVector[23]
  )

  updateSelectInput(
    session,
    "sampling.select",
    selected = saveVector[24]
  )

  updateNumericInput(
    session,
    "sampling.input",
    value = saveVector[25]
  )

  updateNumericInput(
    session,
    "output.plot.height.input",
    value = saveVector[26]
  )

  updateNumericInput(
    session,
    "output.plot.width.input",
    value = saveVector[27]
  )

  updateNumericInput(
    session,
    "output.plot.font.input",
    value = saveVector[28]
  )

  updateNumericInput(
    session,
    "output.plot.line.input",
    value = saveVector[29]
  )

  updateSelectInput(
    session,
    "output.plot.colour.choices",
    selected = saveVector[30]
  )

  updateCheckboxInput(
    session,
    "output.plot.default.checkbox",
    value = saveVector[31]
  )

  updateCheckboxInput(
    session,
    "output.plot.titles.checkbox",
    value = saveVector[32]
  )
}
