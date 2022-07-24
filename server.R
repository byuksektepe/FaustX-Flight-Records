# package (which generally comes preloaded).

library(datasets)
library(leaflet)

library(maps)
library(mapdata)
library(geosphere)

# Define a server for the Shiny app

read.tcsv <- function(file, header=TRUE, sep=",", ...) {
  
  n = max(count.fields(file, sep=sep), na.rm=TRUE)
  x = readLines(file)
  
  .splitvar = function(x, sep, n) {
    var = unlist(strsplit(x, split=sep))
    length(var) = n
    return(var)
  }
  
  x = do.call(cbind, lapply(x, .splitvar, sep=sep, n=n))
  x = apply(x, 1, paste, collapse=sep) 
  out = read.csv(text=x, sep=sep, header=header, ...)
  return(out)
  
}


function(input, output) {
  
  fcp_rel <- reactive({
      input_data <- input$fcp_data
      input_data <- gsub(" ", "", input_data)
      read.tcsv(paste0("./Data/",input_data))
  })
  
  
  # Fill in the spot we created for a plot
  
  ## Climb
  ClimbGraph <- renderPlot({
    
    formatted_fcp_data <- fcp_rel()
    
    plot(type = "s",formatted_fcp_data$Climb_Rate,
         main="Climb Data by Flight Time (M/S)",
         ylab="Climb Rate (M/S)",
         xlab="Flight Time")
    
  })
  
  output$climb <- ClimbGraph
  
  observeEvent(input$climb, {
    showModal(modalDialog(
      title = "Enlarged Graph View: Climb Data",
      easyClose = TRUE,
      footer = modalButton("Close"),
      size = "l",
      ClimbGraph
    ))
  })
  ##
  ## Fuel
  FuelGraph <- renderPlot({
    
    formatted_fcp_data <- fcp_rel()
    
    plot(type = "o",formatted_fcp_data$Fuel, 
         main="Fuel Usege Over Flight Time (%)",
         ylab="FUEL (%)",
         xlab="Flight Time")
  })
  output$fuel <- FuelGraph
  
  observeEvent(input$fuel, {
    showModal(modalDialog(
      title = "Enlarged Graph View: Fuel Usage Data",
      easyClose = TRUE,
      footer = modalButton("Close"),
      size = "l",
      FuelGraph
    ))
  })
  ##
  ## GForce
  GForceGraph <- renderPlot({
    
    formatted_fcp_data <- fcp_rel()
    
    plot(type = "s",formatted_fcp_data$G, 
         main="G Force (Z ACC)",
         ylab="G (Z ACC)",
         xlab="Flight Time")
  })
  output$gforce <- GForceGraph
  observeEvent(input$gforce, {
    showModal(modalDialog(
      title = "Enlarged Graph View: G Force Data",
      easyClose = TRUE,
      footer = modalButton("Close"),
      size = "l",
      GForceGraph
    ))
  })
  ##
  ## AOA
  AOAGraph <- renderPlot({
    
    formatted_fcp_data <- fcp_rel()
    
    plot(type = "s",formatted_fcp_data$AOA,
         main="Angle of Attack (DEG)",
         ylab="AOA (DEG)",
         xlab="Flight Time")
    
    # lines(formatted_fcp_data$SSA*3, type = "o", col = "blue")
  }) 
  output$aoa <- AOAGraph
  observeEvent(input$aoa, {
    showModal(modalDialog(
      title = "Enlarged Graph View: Attack Of Angle Data",
      easyClose = TRUE,
      footer = modalButton("Close"),
      size = "l",
      AOAGraph
    ))
  })
  ##
  ## SSA
  SSAGraph <- renderPlot({
    
    formatted_fcp_data <- fcp_rel()
    
    plot(type = "s",formatted_fcp_data$SSA,
         main="Side Slip Angle (DEG)",
         ylab="SSA (DEG)",
         xlab="Flight Time")
    
  })
  output$ssa <- SSAGraph
  observeEvent(input$ssa, {
    showModal(modalDialog(
      title = "Enlarged Graph View: Attack Of Angle Data",
      easyClose = TRUE,
      footer = modalButton("Close"),
      size = "l",
      SSAGraph
    ))
  })
  ##
  ## Pitch
  PitchGraph <- renderPlot({
    
    formatted_fcp_data <- fcp_rel()
    
    plot(type = "s",formatted_fcp_data$Pitch,
         main="Pitch (DEG)",
         ylab="Pitch (DEG)",
         xlab="Flight Time")
    
  })
  output$pitch <- PitchGraph
  observeEvent(input$pitch, {
    showModal(modalDialog(
      title = "Enlarged Graph View: Pitch Data",
      easyClose = TRUE,
      footer = modalButton("Close"),
      size = "l",
      PitchGraph
    ))
  })
  ##
  ## TAS/GS
  TASGSGraph <- renderPlot({
    
    formatted_fcp_data <- fcp_rel()
    
    plot(type = "s",formatted_fcp_data$TAS,
         main="True Air Speed and Ground Speed (M/S)",
         ylab="TAS, GS (M/S)",
         xlab="Flight Time")
    
    lines(formatted_fcp_data$GS, type = "s", col = "red")
    
    legend(x = "topleft",
           col = c("black", "red"), lty = 1, lwd = 1,
           legend = c('TAS', 'GS'))
    
  })
  output$tasgs <- TASGSGraph
  
  observeEvent(input$tasgs, {
    showModal(modalDialog(
      title = "Enlarged Graph View: True Air Speed and Ground Speed Data",
      easyClose = TRUE,
      footer = modalButton("Close"),
      size = "l",
      TASGSGraph
    ))
  })
  ##
  ## RPM
  RPMGraph <- renderPlot({
    
    formatted_fcp_data <- fcp_rel()
    
    plot(type = "s",formatted_fcp_data$RPM,
         main="RPM (Unit)",
         ylab="RPM (Unit)",
         xlab="Flight Time")
    
  })
  output$rpm <- RPMGraph
  observeEvent(input$rpm, {
    showModal(modalDialog(
      title = "Enlarged Graph View: Engine RPM Data",
      easyClose = TRUE,
      footer = modalButton("Close"),
      size = "l",
      RPMGraph
    ))
  })
  ##
  ## Throttle
  ThrottleGraph <- renderPlot({
    
    formatted_fcp_data <- fcp_rel()
    
    plot(type = "s",formatted_fcp_data$Throttle,
         main="Throttle (%)",
         ylab="Throttle (%)",
         xlab="Flight Time")
    
  })
  output$throttle <- ThrottleGraph
  
  observeEvent(input$throttle, {
    showModal(modalDialog(
      title = "Enlarged Graph View: Throttle Data",
      easyClose = TRUE,
      footer = modalButton("Close"),
      size = "l",
      ThrottleGraph
    ))
  })
  ##
  ## YAW
  YAWGraph <- renderPlot({
    
    formatted_fcp_data <- fcp_rel()
    
    plot(type = "o",formatted_fcp_data$Yaw,
         main="Heading or Yaw (DEG)",
         ylab="YAW (DEG)",
         xlab="Flight Time")
    
  })
  output$yaw <- YAWGraph
  observeEvent(input$yaw, {
    showModal(modalDialog(
      title = "Enlarged Graph View: Yaw Data",
      easyClose = TRUE,
      footer = modalButton("Close"),
      size = "l",
      YAWGraph
    ))
  })
  ##
  ## Roll
  RollGraph <- renderPlot({
    
    formatted_fcp_data <- fcp_rel()
    
    plot(type = "o",formatted_fcp_data$Roll,
         main="Roll (DEG)",
         ylab="Roll (DEG)",
         xlab="Flight Time")
    
  })
  output$roll <- RollGraph
  
  observeEvent(input$roll, {
    showModal(modalDialog(
      title = "Enlarged Graph View: Roll Data",
      easyClose = TRUE,
      footer = modalButton("Close"),
      size = "l",
      RollGraph
    ))
  })
  ##
  ## ABSP
  ABSPGraph <- renderPlot({
    
    formatted_fcp_data <- fcp_rel()
    
    plot(type = "s",formatted_fcp_data$ABSP,
         main="Absolute Pressure ABSP (hPa)",
         ylab="ABSP (hPa)",
         xlab="Flight Time")
    
  })
  output$absp <- ABSPGraph
  
  observeEvent(input$absp, {
    showModal(modalDialog(
      title = "Enlarged Graph View: Absolute Pressure Data",
      easyClose = TRUE,
      footer = modalButton("Close"),
      size = "l",
      ABSPGraph
    ))
  })
  ##
  ## Altitude
  AltitudeGraph <- renderPlot({
    
    formatted_fcp_data <- fcp_rel()
    
    plot(type = "s",formatted_fcp_data$Altitude,
         main="Altitude Relative to Home (FEET)",
         ylab="Altitude (FEET)",
         xlab="Flight Time")
    
  })
  output$altitude <- AltitudeGraph
  
  observeEvent(input$altitude, {
    showModal(modalDialog(
      title = "Enlarged Graph View: Altitude Data",
      easyClose = TRUE,
      footer = modalButton("Close"),
      size = "l",
      AltitudeGraph
    ))
  })
  ##
  ##
  output$latmap <- renderLeaflet({
    
    formatted_fcp_data <- fcp_rel()
    
    Start_lat <- formatted_fcp_data$Start_Latitude[1]
    Start_long <- formatted_fcp_data$Start_Longitude[1]
    
    Stop_lat <- formatted_fcp_data$Stop_Latitude[1]
    Stop_long <- formatted_fcp_data$Stop_Longitude[1]
    
    data_red <- data.frame(LONG=Stop_long, LAT=Stop_lat, PLACE=paste("Red_place_",seq(10,10)))
    data_blue <- data.frame(LONG=Start_long, LAT=Start_lat, PLACE=paste("Blue_place_",seq(10,10)))
    
    data_line <- data.frame(LONG=c(Start_long,Stop_long), LAT=c(Start_lat,Stop_lat))
    
    leaflet() %>% 
      addProviderTiles("CartoDB.Positron") %>%
      
      setView(lat=Stop_lat,lng=Stop_long, zoom=12 ) %>%
      
      addPolylines(data = data_line, lng = ~LONG, lat = ~LAT, group = "blue") %>%
      
      addCircleMarkers(data=data_red, lng=~LONG , lat=~LAT, radius=8 , color="black",
                       fillColor="red", stroke = TRUE, fillOpacity = 0.8, group="Red") %>%
      addCircleMarkers(data=data_blue, lng=~LONG , lat=~LAT, radius=8 , color="black",
                       fillColor="blue", stroke = TRUE, fillOpacity = 0.8, group="Blue")
    
  })
  output$table <- renderDataTable({
    
    formatted_fcp_data <- fcp_rel()
    formatted_fcp_data
    
  })
  output$maptext <- renderText({
    
    formatted_fcp_data <- fcp_rel()
    
    Start_lat <- formatted_fcp_data$Start_Latitude[1]
    Start_long <- formatted_fcp_data$Start_Longitude[1]
    
    Stop_lat <- formatted_fcp_data$Stop_Latitude[1]
    Stop_long <- formatted_fcp_data$Stop_Longitude[1]

    paste("First Seen Location", Start_lat,",",Start_long,"(Blue Point) ","- Last Seen Location", Stop_lat,",",Stop_long,"(Red Point) ")
  })
  output$recordtext <- renderText({
    
    formatted_fcp_data <- fcp_rel()
    
    paste(formatted_fcp_data$RecordID_FL[1]," ",formatted_fcp_data$RecordID_LT[1])
  })
  output$tagtext <- renderText({
    
    formatted_fcp_data <- fcp_rel()
    
    paste(formatted_fcp_data$RecordTag[1])
  })
  
  output$explore <- renderText({
    formatted_fcp_data <- fcp_rel()
    
    complete_fl = paste(formatted_fcp_data$RecordID_FL[1]," ",formatted_fcp_data$RecordID_LT[1]," ",formatted_fcp_data$RecordTag[1],":")
    
    paste("This field contains preliminary information for flight record",complete_fl,
          "Record started at ",formatted_fcp_data$FR_Start[2],", stopped at ",formatted_fcp_data$FR_Stop[2], ". Time zone (",formatted_fcp_data$FR_Start[1],").",
          "Last recorded fuel data: ",formatted_fcp_data$Last_Fuel[1])
  })
  output$tablehead <- renderText({
    formatted_fcp_data <- fcp_rel()
    
    complete_tag = paste("Examine With Pure Flight Data: FX ",formatted_fcp_data$RecordID_FL[1]," ",formatted_fcp_data$RecordID_LT[1]," ",formatted_fcp_data$RecordTag[1])
    
    paste(complete_tag)
  })
}