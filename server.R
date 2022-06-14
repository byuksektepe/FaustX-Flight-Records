# package (which generally comes preloaded).
library(datasets)

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
            main="Climb Data by Flight Time",
            ylab="Climb Rate",
            xlab="Flight Time")
  })
  output$fuel <- renderPlot({
    
    plot(type = "o",formatted_fcp_data$Fuel, 
         main="Fuel Use Over Time",
         ylab="FUEL (%)",
         xlab="Flight Time")
  })
}