# server
function(input, output) {

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

  # the sourced file is in the same directory as the ui and server files
  source_python('hello.py')

  output$text3 <- renderText({
        Hello$print_sys_version()
  })

}



