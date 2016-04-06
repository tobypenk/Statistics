shinyUI(fluidPage(
        
        titlePanel("Uniform Distribution"),
        
        sidebarLayout(
                sidebarPanel(
                        sliderInput("samples",
                                    "Number of samples:",
                                    min=1,
                                    max=10000,
                                    value=100),
                        sliderInput("seed",
                                    "Seed:",
                                    min=1,
                                    max=2000,
                                    value=1224)
                ),
                
                mainPanel(
                        tabsetPanel(
                                tabPanel("Plot",plotOutput("plot")),
                                tabPanel("Data",tableOutput("data"))
                        )
                )
        )
))