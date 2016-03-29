shinyServer(function(input, output) {
        
        # Expression that generates a histogram. The expression is
        # wrapped in a call to renderPlot to indicate that:
        #
        #  1) It is "reactive" and therefore should re-execute automatically
        #     when inputs change
        #  2) Its output type is a plot
        
        output$plot <- renderPlot({
                set.seed(input$seed)
                
                thisData <- rnorm(input$samples)
                
                thisHist <-  hist(rnorm(thisData),
                                  breaks=30)
                
                curve(dnorm(x)*length(thisData)/5, 
                      col="darkblue",
                      lwd=2, 
                      add=TRUE)
        })
        
        output$data <- renderTable({
                set.seed(input$seed)
                
                as.data.frame(rnorm(input$samples))
        })
})