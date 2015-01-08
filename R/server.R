library(mvtnorm)
library(mirt)
source("ItemPlot.R")
source("AlgoritmoSICS3PL.R")
shinyServer(
  function(input, output) {
    
    output$est    <- renderDataTable({
      datos = read.table(input$dataset$datapath,header = T)  
      fit = estimacion.Newton(datos)
      zita = fit$zita
      zita = cbind((1:length(zita)),zita)
      colnames(zita) <- c("Item","a","b","c")
      as.data.frame(zita)
    }, options = list(orderClasses = TRUE))
    
    #output$est <- renderDataTable(as.data.frame(matrix(rnorm(25),ncol = 5)))
    
    #output$map <- renderPlot({
    #  if(!(is.null(input$dataset))){
    #    data = read.table(input$dataset$datapath,header = T)
    #    print(data)
    #    med = colMeans(data)
    #    plot((1:length(med)),med)
        #plot.item(zita = zita,hess = hess,item = input$Item,numboot = input$bootstrap,alpha = input$alpha,envel = input$env)    
    #  }  
    #})
  }
)
