library(shiny)
library(datasets)


shinyServer(function(input, output) {
   datasetInput <- reactive({
       input$dataset
   })
   
   rateInput <- reactive({
       input$rate
   })
   
   output$caption <- renderText({
       input$caption
     })
   
   output$summary <- renderPrint({
       dataset =  mergeAllvote[mergeAllvote$公投案編號 == datasetInput(), rateInput()]
       summary(dataset)
     })
   
   
   output$downloadData <- downloadHandler(
        filename = function() { paste(input$dataset, '.csv', sep='') },
        content = function(file) { write.csv(datasetInput(), file)}
      )
   
   
   output$plot<-renderPlotly({

     data <-  mergeAllvote[mergeAllvote$公投案編號 == datasetInput(),]
     data <- as.data.frame(data[,c('縣市', rateInput())])

     p <- plot_ly(data = data, labels = data[,1], values = data[,2], type = 'pie') %>%
        layout(title = rateInput(),
               xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
               yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
      
    })
   
   output$plot2 <- renderPlotly({
     plot2
   })
   
   output$plot3 <- renderPlotly({
     plot3
   })
})
