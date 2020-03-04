# data set https://data.cms.gov/Medicare-Inpatient/Inpatient-Prospective-Payment-System-IPPS-Provider/97k6-zzx3

library(shiny)
library(dplyr)

# read in data from same directory that app.R file is in
payments <- readr::read_csv("healthcare_payments.csv")

# get unique Medicare Severity Diagnosis Related Group (MS-DRG) values
drgs <- unique(payments$`DRG Definition`)

# design user interface
ui <- fluidPage(
    
    # application title 
    titlePanel("CMS Indiana Provider Summary"),
     
    # filter by DRG
    fluidRow(selectInput("drg", "Select DRG", 
                         choices = drgs,
                         multiple = TRUE)),
    
    # show table of payment data
    fluidRow(tableOutput("table"))

)

# defign server logic
server <- function(input, output) {
    
    # create output of table data
    output$table <- renderTable({
        
        # get vector of DRG values
        drg <- ifelse(is.null(input$drg),
                      drgs,
                      input$drg)
        
        # filter by DRG values
        payments %>%
            dplyr::filter(`DRG Definition` %in% drg) %>%
            dplyr::select(c(1, 3, 8:12))
    })
}

# run the app
shinyApp(ui = ui, server = server)
