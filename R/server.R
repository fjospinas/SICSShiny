library(mvtnorm)
library(mirt)
source("ItemPlot.R")
source("AlgoritmoSICS3PL.R")
source("EstimacionHabilidades.R")
source("ItemPlot.R")
shinyServer(
  function(input, output) {
    
    fit <-reactive({
      #validate(
      #  need(input$dataset != NULL, "Please select a data set")
      #)
      datos = read.table(input$dataset$datapath,header = T)  
      estimacion.Newton(datos)
    })
    
    output$zita    <- renderDataTable({
      #Eséra activación
      input$goButton
      
      salida = isolate({
      zita = fit()$zita
      zita = cbind((1:nrow(zita)),zita)
      colnames(zita) <- c("Item","a","b","c")
      as.data.frame(zita)
      })
      salida
    }, options = list(orderClasses = TRUE))
    
    output$score    <- renderDataTable({
      #Eséra activación
      input$goButton2
      
      salida = isolate({
        if(input$radio == "1"){
          hab = hab.eap(fit())           
        }else{
          hab = hab.map(fit())
        }
        as.data.frame(hab)
      })
      salida
    }, options = list(orderClasses = TRUE))
    
    output$graf <- renderPlot({
      plot.item(est = fit(),item = input$item,numboot = input$bootstrap,alpha = input$alpha,envel = input$env)
    })
  }
)
