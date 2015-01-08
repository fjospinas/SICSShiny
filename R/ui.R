# ui.R

shinyUI(fluidPage(
  titlePanel("SICS ALGORITHM"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Test for shiny app with SICS algorithm"),
      #Item estimations
      h3("Item estimations"),      
      fileInput("dataset", label = h4("Dataset")),
      actionButton("goButton", "Item estimate"),
      h3("Score estimations"),
      radioButtons("radio", label = h4("Method"),
                   choices = list("EAP" = 1, "MAP" = 2), 
                   selected = 1),
      actionButton("goButton2", "Score estimate"),
      h3("Item plot"),
      numericInput('item', 'Item', 1,
                   min = 1, max = 1),
      checkboxInput("env", label = "Envelopes", value = FALSE),
      sliderInput("bootstrap", 
                              label = "Num Bootstrap",
                              min = 200, max = 5000, value = 500),
      numericInput("alpha", label = "Alpha", value = 1)
    ),
    
    mainPanel(
      tabsetPanel(
        id = 'salidas',
        tabPanel('Item estimations', dataTableOutput('zita')),
        tabPanel('Score estimations', dataTableOutput('score')),
        tabPanel('Item plots',  plotOutput('graf'))
      )    
      )
  )
))

?sliderInput
