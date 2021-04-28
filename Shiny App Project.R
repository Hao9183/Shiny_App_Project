library(shiny)
library(tidyverse)


ui <- fluidPage(
  h2("STAT-413/613 Shiny App Project: USArrests Data"),
  h3("by Xuehao Wang and Isabella Natke", style ="color:blue"),
  h5("The USArrests data contains statstics, in arrests per 100,000 residents in each of the 50 US states in 1973. Arrests include assault, murder, and rape. UrbanPop is the percent of the population living in urban areas.", style="color:grey"),
  textOutput("text"),
  verbatimTextOutput("summary"),
  selectInput("v1", "Variable 1", choices = names(USArrests)),
  selectInput("v2", "Variable 2", choices = names(USArrests)),
  plotOutput(outputId = "boxplot"),
  plotOutput(outputId = "histogramplot"),
  plotOutput(outputId = "scatterplot")
)

server <- function(input, output) {
  output$text <- renderText({
    "USArrests Variable Summaries"
  })
  
   output$summary <- renderPrint({
     summary(USArrests)
  })

   output$boxplot <- renderPlot({
    ggplot(USArrests, aes(x = .data[[input$v1]]))+
      ggtitle("USArrest Boxplot for Variable 1") +
      geom_boxplot(fill = "cyan3")+
      coord_flip()
  })
  
  output$histogramplot <- renderPlot({
    ggplot(USArrests, aes(x = .data[[input$v1]])) +
      ggtitle("USArrest Boxplot for Variable 1") +
      geom_histogram(col = "black", fill = "cornflowerblue", binwidth = 20)
  })
  
  output$scatterplot <- renderPlot({
    ggplot(USArrests, aes(x = .data[[input$v1]], y = .data[[input$v2]])) +
      geom_point(color = "deepskyblue4") +
      geom_smooth(method = lm, mapping = aes(x = .data[[input$v1]], y = .data[[input$v2]]), se=FALSE, color = "black") +
      ggtitle("USArrest Scatter Plot for Variable 1 and 2")
  })
}


shinyApp(ui = ui, server = server)




