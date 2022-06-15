library(shiny)
library(shinydashboard)
library(datasets)
library(leaflet)



fluidPage(
          tags$style(type="text/css",
                     "label {font-size: 12px;}",
                     ".recalculating {opacity: 1.0;}",
                     ".logo {margin-top: 15px; margin-bottom:12px}"
          ),class="container",
          
          # Application title
          tags$img(src="https://www.faustx.com/img/fx-stat/FX-FR-LOGO.png", width="160", class="logo"),
          p("Welcome to the FaustX Flight Records. Here you can examine the data received from FX-1 Artificial intelligence and FX-FCP."),
          hr(),
          fluidRow(
            box(
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
          fluidRow(  class="row",
            box(title = "FR GPS Location Map", status = "primary", solidHeader = TRUE,class="col-lg-12", width = "12",
                collapsible = F,
                leafletOutput("latmap"),
                helpText(textOutput("maptext")),
            ),
            box(title = "Climb Rate", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                plotOutput("climb")
            ),
            box(title = "Fuel Usage", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                plotOutput("fuel")
            ),
            box(title = "G Force", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                plotOutput("gforce")
            ),
            box(title = "Pitch", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                plotOutput("pitch")
            ),
            box(title = "Angle of Attack", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                plotOutput("aoa")
            ),
            box(title = "Side Slip Angle", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                plotOutput("ssa")
            ),
            box(title = "TAS / GS", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                plotOutput("tasgs")
            ),
          ),

          column(12, class = "text-center",
            tags$br(),
            hr(),
            tags$p("This page and its data are completely open source, developed with R and Love ❤.", style="text-align: center;"),
            p("© Copyright 2022 FaustX Technology all rights reserved. CC BY-NC 4.0 International License." ,style="text-align: center;"),
            hr(),
            
            
          ),
          column(12, class = "text-center",
                 
                 fillRow( flex = 1, align = "center", width="50vw", style="margin: 0 auto;",
                          
                          a(href="https://www.faustx.com/en/fx1-tests", target="_blank", style="display: table;", rel="ai",img(style="border-width: 0;margin-bottom:25px;",width="88px", src="https://www.faustx.com/img/fx-stat/114x40-one-ai.png", alt="FX-1-AI")),
                          a(href="https://www.faustx.com/en/fx1-tests", target="_blank", style="display: table;", rel="fcp",img(style="border-width: 0;margin-bottom:25px;",width="88px", src="https://www.faustx.com/img/fx-stat/114x40-fcp.png", alt="FX-1-AI")),
                          a(href="https://github.com/Berkantyuks/FaustX-Flight-Records", target="_blank", style="display: table;", rel="git",img(style="border-width: 0;margin-bottom:25px;",width="88px", src="https://www.faustx.com/img/fx-stat/114x40-git.png", alt="FX-1-GIT")),
                          a(href="http://creativecommons.org/licenses/by-nc/4.0/", target="_blank", style="display: table;", rel="license",img(style="border-width: 0;margin-bottom:25px;", src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png", alt="Creative Commons License")),
                          img(style="border-width: 0;margin-bottom:25px;", src="https://www.faustx.com/img/fx-stat/114x40-r-bg-b.png",width="88px", alt="FX-R-BG"),
                          img(style="border-width: 0;margin-bottom:25px;", src="https://www.faustx.com/img/fx-stat/114x40-shiny.png",width="88px", alt="FX-SH-BG")
                          
                 )
                 
          )

          
)