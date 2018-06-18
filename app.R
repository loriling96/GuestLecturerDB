#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
responses <- read_csv("FormResponses.csv")
allchoices <- responses[6,5] %>% unname() %>% as.character() %>% strsplit(", ") %>% unlist()

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("SURPAS pilot program: Database of postdocs who wish to guest lecture"),
   
   sidebarLayout(
      sidebarPanel(
        # Input: Selector for choosing dataset ----
        selectInput(inputId = "subdiscipline",
                    label = "Choose a subdiscipline:",
                    choices = allchoices),
      ),
      
      # Show a table
      mainPanel(
        h3("Postdocs who match your criteria"),
        # Output: HTML table with requested number of observations ----
        tableOutput('table')
      )
     
   )
)


server <- function(input, output) {
  # Filter data based on selections
  output$table <- renderTable(responses %>% filter(Discipline ))
  
}
  
  
      


# Run the application 
shinyApp(ui = ui, server = server)

