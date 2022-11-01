#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(countrycode)
library(tidyr)
library(dplyr)
library(highcharter)

# Read in the UN Voting data from the csv file
df <- read.csv('/Users/jimbobeck/Documents/unvoting/6358424.csv')

# Add an ISO-3 code based on a mapping to the COW Code 1 to use for the choropleth map
df$iso1 <- countrycode(df$ccode1, origin='cown', destination='iso3c')

# Add an ISO-3 code based on a mapping to the COW Code 2 to use for the choropleth map
df$iso2 <- countrycode(df$ccode2, origin='cown', destination='iso3c')

# Add an Country name based on a mapping to the COW Code 1 to use for dropdown selector
df$country1 <- countrycode(df$ccode1, origin='cown', destination='country.name')

# Add an Country name based on a mapping to the COW Code 2 to use for table output
df$Country <- countrycode(df$ccode2, origin='cown', destination='country.name')

# Create a list of unique Country Names
countrySelection <- unique(df$country)

# Create a list of unique years
yearSelection <- unique(df$year)

# Set the breaking points for the percentage classes in the legend and color class
brk = seq(from = 0, by = .1, length.out = 11)

# Set the color of each percentage band in the legend and in the choropleth map
clr <- c('#a50026', '#d73027', '#f46d43', '#fdae61', '#fee090', '#e0f3f8', '#abd9e9','#74add1', '#4575b4', '#313695')

# Read in the data for the map
data(worldgeojson, package = "highcharter")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    # titlePanel("United Nations Voting Coincidence"),

    # Sidebar with a slider input for number of bins 
    navbarPage(
        title = "United Nations Voting Coincidence",
        fluidRow(
          column(4,
            selectInput("in1", 
                        "Choose a Country",
                        choices = countrySelection, 
                        multiple=FALSE, 
                        selectize=TRUE,
                        width = '98%')
          ),
          column(4,
            selectInput("in2", 
                        "Choose a Start Year",
                        choices = yearSelection, 
                        multiple=FALSE, 
                        selectize=TRUE,
                        width = '98%')
          ),
          column(4,
            selectInput("in3", 
                        "Choose an End Year",
                        choices = yearSelection, 
                        multiple=FALSE, 
                        selectize=TRUE,
                        width = '98%',
                        selected = 2021)
          )
        ),
        fluidRow(
        # Show a plot of the generated distribution
          column(9,
             highchartOutput("out1", height="80vh")
          ),
          column(3,
             tableOutput("out2"),
             style = "height:80vh; overflow-y: scroll;"
          )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  selected <- reactive(df %>%
      filter(year >= input$in2 & year <= input$in3 & country1 == input$in1)
  )

  votingData <- reactive({selected() %>%
      group_by(iso1, iso2, Country) %>%
      summarise(Coincidence = mean(agree)) %>%
      drop_na()
  })
  
  tableData <- reactive({votingData() %>%
      subset(select=c('Country', 'Coincidence'))
  })
  
  output$out1 <- renderHighchart({

    highchart() %>%
      hc_title(text = "United Nations Voting Coincidence", align = 'left') %>%
      hc_subtitle(text = "Source: United Nations", align = 'left') %>%
      hc_add_series_map(worldgeojson,
                        df = votingData(),
                        name = "Voting Coincidence",
                        value = "Coincidence",
                        joinBy = c("iso3", "iso2")
      ) %>%
    hc_colorAxis(dataClasses = color_classes(brk, clr)) %>%
    hc_credits(enabled = FALSE)

  })
  
  output$out2 <- renderTable(tableData())
}

# Run the application 
shinyApp(ui = ui, server = server)
