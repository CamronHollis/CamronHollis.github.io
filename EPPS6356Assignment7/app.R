library(shiny)
library(ggplot2)


require("readr")
require("shiny")

df = mtcars

ui <- fluidPage(
  
  sidebarLayout(
    
    # Variables
    sidebarPanel(
      
      # Inputs;
      selectInput(inputId = "cyl",
                  label = "Number of Cylinders:",
                  choices = c(8, 4) ),
      ##selectInput(inputId = "vs",
      ##            label = "Engine:",
      ##            choices = c("V-Shaped", "Straight" ) ),
      ##selectInput(inputId = "am",
      ##            label = "Transmission:",
      ##            choices = c("automatic", "manual" ) ),
      ##selectInput(inputId = "gear",
      ##            label = "Forward Gears:",
      ##            choices = c("3 gears", "4 gears", "5 gears" ) ),
      
      
    ),
    mainPanel(
      plotOutput(outputId = "bubbleplot")
    )
  ))


server <- function(input, output) {
  
  datasetInput <- reactive({
    df[df$cyl %in% input$cyl, ]
  })
  
  output$bubbleplot<- renderPlot({
    ggplot(datasetInput(), aes(x = mpg, y = hp, width = wt) ) +
      geom_point(aes(x = mpg, y = hp, size = wt, color = factor(vs) ) ) +
      xlab("Miles per Gallon") + ylab("Horsepower") +
      labs(color = "Engine Type", size = "Car Weight") +
      theme_classic() + scale_color_brewer(palette="Set1")
    
  } )
}


# Create Shiny app ----
shinyApp(ui, server)
