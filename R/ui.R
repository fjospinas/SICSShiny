# ui.R

shinyUI(fluidPage(
  titlePanel("SICS ALGORITHM"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Test for shiny app with SICS algorithm"),
      #Item estimations
      h3("Item estimations"),      
      fileInput("dataset", label = h4("Dataset")),
      actionButton("goButton", "Estimate"),
      h3("Score estimations")
      #fileInput("filehess", label = h3("Hessian imput")),
      #sliderInput("Item", 
      #            label = "Item Plot",
      #            min = 1, max = 5, value = 1),
      #sliderInput("bootstrap", 
      #            label = "Num Bootstrap",
      #            min = 200, max = 5000, value = 1000),
      #numericInput("alpha", label = "Alpha", value = 1),
      #checkboxInput("env", label = "Envelopes", value = FALSE)
    ),
    
    mainPanel(
      tabsetPanel(
        id = 'salidas',
        tabPanel('Item estimations', dataTableOutput('est')),
        tabPanel('Score estimations', dataTableOutput('hab')),
        tabPanel('Item plots', dataTableOutput('mytable3'))
      )    
      )
  )
))

?sliderInput
