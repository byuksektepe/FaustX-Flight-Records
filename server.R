# package (which generally comes preloaded).
library(datasets)
library(leaflet)

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

  
  formatted_fcp_data <- read.tcsv("./Data/FCP_FR_DATA.csv")
  
  # Fill in the spot we created for a plot
  output$climb <- renderPlot({
    
    plot(type = "o",formatted_fcp_data$Climb_Rate, 
            main="Climb Data by Flight Time (M/S)",
            ylab="Climb Rate (M/S)",
            xlab="Flight Time")
  })
  output$fuel <- renderPlot({
    
    plot(type = "o",formatted_fcp_data$Fuel, 
         main="Fuel Use Over Flight Time (%)",
         ylab="FUEL (%)",
         xlab="Flight Time")
  })
  output$gforce <- renderPlot({
    
    plot(type = "o",formatted_fcp_data$G, 
         main="G Force (Z ACC)",
         ylab="G (Z ACC)",
         xlab="Flight Time")
  })
  output$aoa <- renderPlot({
    
    plot(type = "o",formatted_fcp_data$AOA,
         main="Angle of Attack (DEG)",
         ylab="AOA (DEG)",
         xlab="Flight Time")
    
    # lines(formatted_fcp_data$SSA*3, type = "o", col = "blue")
  })
  output$ssa <- renderPlot({
    
    plot(type = "o",formatted_fcp_data$SSA,
         main="Side Slip Angle (DEG)",
         ylab="SSA (DEG)",
         xlab="Flight Time")
    
  })
  output$pitch <- renderPlot({
    
    plot(type = "o",formatted_fcp_data$Pitch,
         main="Pitch (DEG)",
         ylab="Pitch (DEG)",
         xlab="Flight Time")
    
  })
  
}