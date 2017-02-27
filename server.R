#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  
  
  output$distPlot <- renderPlot({
    
    # use variables based on input$variables from ui.R
    new_mtcars <- subset(mtcars, select= c(mpg, wt, qsec, factor(am), hp, disp, drat, gear, carb, factor(vs)))
    variables <-  input$variables + 1
    
    new_mtcars_out_01 <-
      lm(
        as.formula(paste(colnames(new_mtcars)[1], "~",
                         paste(colnames(new_mtcars)[c(2, variables)], collapse = "+"),
                         sep = ""
        )),
        data=new_mtcars
      )
    
    par(mfrow=c(2, 3))
    
    hist(new_mtcars$mpg, breaks=10)
    
    plot(x=new_mtcars$mpg, y=predict(new_mtcars_out_01), xlab="actual mpg", ylab="predicted mpg", main="Actual MPG v/s Predicted by Model")
    abline(0,1)
    
    # draw the histogram with the specified number of bins
    plot(new_mtcars_out_01)
    
  })
  
})
