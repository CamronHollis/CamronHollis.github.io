
###  The Map Shiny App


# Shiny app to see overall data

library(shiny)
library(readxl)
library(ggplot2)
library(pals)
library(dplyr)
library(leaflet)


##dataf = read_xlsx('consolidated-data.xlsx')
dataf = read_xlsx("~/Desktop/consolidated-data09c93ffd57385d58de8e82313555d7a07f41d0cbf664abb633a64dddd92f14ec.xlsx")

# Define UI ----
library(shiny)
library(readxl)

# Define UI
ui <- fluidPage(
  titlePanel("United States City Map"),
  
  sidebarLayout(
    sidebarPanel(
      # Input: Select a sheet
      selectInput("sheet", "Select a data type:",
                  choices = excel_sheets("~/Desktop/consolidated-data09c93ffd57385d58de8e82313555d7a07f41d0cbf664abb633a64dddd92f14ec.xlsx")),
      
      # Input: Select variables
      uiOutput("variable_selector")
    ),
    
    mainPanel(
      # Output: Plot
      plotOutput("mapchart")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Convert 'City' to a factor with specific order
  dataf$City <- factor(dataf$City, levels = unique(dataf$City))
  
  # Load data based on selected sheet
  datasetInput <- reactive({
    data <- read_excel("~/Desktop/consolidated-data09c93ffd57385d58de8e82313555d7a07f41d0cbf664abb633a64dddd92f14ec.xlsx", sheet = input$sheet)
    
    data$City <- factor(data$City, levels = unique(data$City))
    
    return(data)
  })
  
  # Dynamically generate variable selector based on selected sheet
  output$variable_selector <- renderUI({
    selectInput("variable", "Select variable:",
                choices = names(datasetInput()[-1]))
  })
  
  
  # Plot selected variables
  output$mapchart <- renderPlot({
    
    leaflet() %>% addProviderTiles(provider = "CartoDB.Positron") %>%
      addMarkers(lat = 32.9887, lng = -96.7479, popup = "Your current location")
    
    
    
  })
  
}

# Run the application
shinyApp(ui, server)
