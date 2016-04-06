library(shiny)

shinyServer(function(input,output) {
        
        output$scatterPlot <- renderPlot({
                set.seed(input$seed)
                
                min <- input$range[1]
                max <- input$range[2]
                step <- (max - min)/(input$samples-1)
                sampleSize <- input$trainSize
                
                x <- seq(min,max,step)
                y <- rnorm(length(x))
                
                df <- data.frame(x = x,
                                 y = x+y)
                
                inTrain <- createDataPartition(df$y,p=sampleSize,list=F)
                training <- df[inTrain,]
                testing <- df[-inTrain,]
                
                fn <- function(x) {x*modFit$coefficients[2]+modFit$coefficients[1]}
                fn2 <- function(x) {x*modFit2$coefficients[2]+modFit2$coefficients[1]}
                
                modFit <- lm(y ~ x, training)
                modFit2 <- lm(y ~ x, df)
                
                ggplot(training, aes(x,y)) +
                        geom_point(aes(color="Training")) +
                        geom_point(data=testing,aes(color="Testing")) +
                        stat_function(fun=fn,size=2,aes(color="Predicted Fit")) + 
                        stat_function(fun=fn2,size=2,aes(color="Actual Fit")) +
                        scale_colour_manual(name='', values=c("Actual Fit"="blue",
                                                              "Testing"="darkblue",
                                                              "Predicted Fit"="red",
                                                              "Training"="darkred"
                                                              )
                                            )
        })
        
        output$dataTable <- renderDataTable({
                set.seed(input$seed)
                
                min <- input$min
                max <- input$max
                step <- input$step
                
                x <- seq(min,max,step)
                y <- rnorm(length(x))
                
                df <- data.frame(x = x,
                                 y = x+y)
                
                df
        })
})