library(shiny)

shinyUI(
        fluidPage(
                
                titlePanel("Linear modeling"),
                
                fluidRow(
                        column(4,
                               sliderInput("range",
                                           "Bounds:",
                                           min=-10,
                                           max=10,
                                           value=c(-1,1))),
                        column(4,
                               sliderInput("samples",
                                           "Points:",
                                           min=2,
                                           max=10000,
                                           value=20)),
                        column(4,
                               sliderInput("seed",
                                           "Seed:",
                                           min=1000,
                                           max=10000,
                                           step=1,
                                           value=1224))
                ),
                
                fluidRow(
                        column(4,
                               sliderInput("trainSize",
                                           "Training Set Size:",
                                           min=0.01,
                                           max=0.99,
                                           step=0.01,
                                           value=0.1))
                ),
                
                tabsetPanel(
                        tabPanel("Summary",
                                 plotOutput("scatterPlot"),
                                 
                                 tableOutput("summaryStats")
                        ),
                        tabPanel("Data",
                                 dataTableOutput("dataTable")
                        )
                )
                
        )
)