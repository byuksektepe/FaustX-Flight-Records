library(shiny)
library(shinydashboard)
library(datasets)



fluidPage(
          tags$style(type="text/css",
                     "label {font-size: 12px;}",
                     ".recalculating {opacity: 1.0;}",
                     ".logo {margin-top: 15px; margin-bottom:12px}"
          ),
          
          # Application title
          tags$img(src="https://www.faustx.com/img/fx-stat/FX-FR-LOGO.png", width="160", class="logo"),
          p("Welcome to the FaustX Flight Records. Here you can examine the data received from FX-1 Artificial intelligence and FX-FCP."),
          hr(),
          fluidRow(
            box(style="background_color: #11111;",
              title = "Explore the FX Black Box", status = "primary",
              tags$p("Test text")
              
            ),

            box(
              title = "Setup Data", status = "primary",
              helpText("Select a Flight Record for setup data"),
              selectInput("region", "Select Flight Record", 
                        choices=colnames(WorldPhones)),
              hr(),
            ),

          ),

          # Create a spot for the barplot
          fluidRow(
            box(title = "Climb Rate", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
              plotOutput("climb")
            ),
          ),

          column(12,
            tags$br(),
            hr(),
            tags$p("This page and its data are completely open source, developed with R and Love ❤.", style="text-align: center;"),
            p("© Copyright FaustX Technology all rights reserved." ,style="text-align: center;")
          )
          
)