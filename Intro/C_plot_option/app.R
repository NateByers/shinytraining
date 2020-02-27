#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            textInput("title", "Plot title:", 
                      value = "Histogram"),
            
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot"),
           
           radioButtons("plot_type", "Plot type:",
                        choices = list("Base R" = 1, "ggplot2" = 2), 
                        selected = 1)
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({

        title <- input$title

        if(input$plot_type == 1) {
            x    <- faithful[, 2]
            bins <- seq(min(x), max(x), length.out = input$bins + 1)
            
            p <- hist(x, breaks = bins, col = 'darkgray', border = 'white',
                 main = title)
        } else if(input$plot_type == 2) {
            bins <- input$bins
            
            p <- ggplot(faithful, aes(waiting)) + geom_histogram(bins = bins) +
                  ggtitle(title)
        }
        
        p
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
