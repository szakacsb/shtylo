function(db.service, input){
  
  saveVector <- c(
    input$input.select,
    input$language.select,
    input$utf8.checkbox,
    
    input$features.select,
    input$ngram.input,
    input$case.checkbox,
    
    input$mfw.minimum.input,
    input$mfw.maximum.input,
    input$mfw.increment.input,
    input$mfw.freq.rank.input,
    
    input$culling.minimum.input,
    input$culling.maximum.input,
    input$culling.increment.input,
    input$culling.list.cutoff.input,
    input$culling.pronoun.checkbox,
    
    input$statistics.select,
    input$statistics.consensus.input,
    input$scatterplot.select,
    input$scatterplot.margin.input,
    input$scatterplot.offset.input,
    input$pca.flavour.select,
    input$clustering.horizontal.checkbox,
    input$distances.select,
    
    input$sampling.select,
    input$sampling.input,
    
    input$output.plot.height.input,
    input$output.plot.width.input,
    input$output.plot.font.input,
    input$output.plot.line.input,
    input$output.plot.colour.choices,
    input$output.plot.default.checkbox,
    input$output.plot.titles.checkbox
  )
  
  isolate(db.service$upload.save(saveVector, "stylo"))
}