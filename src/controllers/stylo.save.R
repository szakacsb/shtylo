function(db.service, input){
  
  saveList <- list(
    filetype = input$input.select,
    language = input$language.select,
    encoding = input$utf8.checkbox,
    
    features = input$features.select,
    NgramInput = input$ngram.input,
    CaseCheckbox = input$case.checkbox,
    
    MfwMinimumInput = input$mfw.minimum.input,
    MfwMaximumInput = input$mfw.maximum.input,
    MfwIncrementInput = input$mfw.increment.input,
    MfwFreqRankInput = input$mfw.freq.rank.input,
    
    CullingMinimumInput = input$culling.minimum.input,
    CullingMaximumInput = input$culling.maximum.input,
    CullingIncrementInput = input$culling.increment.input,
    CullingListCutoffInput = input$culling.list.cutoff.input,
    CullingPronoun = input$culling.pronoun.checkbox,
    
    Statistics = input$statistics.select,
    StatisticsConsensus = input$statistics.consensus.input,
    Scatterplot = input$scatterplot.select,
    ScatterplotMargin = input$scatterplot.margin.input,
    ScatterplotOffset = input$scatterplot.offset.input,
    PcaFlavour = input$pca.flavour.select,
    ClusteringHorizontal = input$clustering.horizontal.checkbox,
    Distances = input$distances.select,
    
    SamplingMethod = input$sampling.select,
    SamplingNumber = input$sampling.input,
    
    OutputPlotHeight = input$output.plot.height.input,
    OutputPlotWidth = input$output.plot.width.input,
    OutputPlotFont = input$output.plot.font.input,
    OutputPlotLine = input$output.plot.line.input,
    OutputPlotColour = input$output.plot.colour.choices,
    OutputPlotDefault = input$output.plot.default.checkbox,
    OutputPlotTitles = input$output.plot.titles.checkbox
  )
  
  isolate(db.service$upload.save(saveList, "stylo"))
}
