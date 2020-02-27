# data set https://data.cms.gov/Medicare-Inpatient/Inpatient-Prospective-Payment-System-IPPS-Provider/97k6-zzx3

library(shiny)
library(dplyr)

payments <- readr::read_csv("healthcare_payments.csv")


ui <- fluidPage(
    
    titlePanel("CMS Indiana Provider Summary"),
     
    fluidRow(tableOutput("table"))

)


server <- function(input, output) {

    output$table <- renderTable({
        payments %>%
            dplyr::select(c(1, 3, 8:12))
    })
}

 
shinyApp(ui = ui, server = server)
