library(shiny)
library(reticulate)
use_python('/usr/bin/python3')


# Define UI for app that draws a histogram ----
fluidPage(

  # App title ----
  titlePanel("Shiny and Python!"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(

      # Input: Slider for the number of bins ----
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)

    ),

    # Main panel for displaying outputs ----
    mainPanel(

      # Output: Histogram ----
      plotOutput(outputId = "distPlot"),
      textOutput(outputId = 'text'),
      textOutput(outputId = 'text2'),
      textOutput(outputId = 'text3')


    )
  )
)
