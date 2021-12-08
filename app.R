library(shiny)
library(reticulate)
use_virtualenv("./venv", required = T)

# Define UI for app that draws a histogram ----
ui <- fluidPage(

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

server <- # server
function(input, output) {

  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$distPlot <- renderPlot({

    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    hist(x, breaks = bins, col = "#75AADB", border = "white",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")
    })

  output$text <- renderText({
      plt <- import("matplotlib.pyplot")
      as.character(plt)
  })

    output$text2 <- renderText({
    as.character(py_config()[1][1])
  })

  #
  source_python('./euler/hello.py')

  output$text3 <- renderText({
    Hello('ich wurde in Python generiert')$print_hello()
  })

}

shinyApp(ui, server)



