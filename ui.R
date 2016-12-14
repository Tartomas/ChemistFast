
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel(
    h2("ChemisFast 1.0")),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      textInput("text", label = h3("Input Nominal Molecular Formula")),
      actionButton("action", label = "Calculate"),
      hr(),
      HTML("Example: O3; CO2; N2CO3. Respect upper and lower letter of tour molecula")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      
      
      fluidRow(column(6, verbatimTextOutput("value"))),
      hr(),
      tableOutput('table')
    )
  )
))
