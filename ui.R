
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("chemistre yie"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      textInput("text", label = h3("Input Nominal Molecular Formula")),
      actionButton("action", label = "Calculate")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tableOutput('table'),
      fluidRow(column(6, verbatimTextOutput("value")))
    )
  )
))
