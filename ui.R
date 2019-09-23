library(shiny)

shinyUI(fluidPage(  
   titlePanel("2018 台灣公投"),
     sidebarLayout(
      sidebarPanel(
             # selectInput("mergeAllvote", "選擇公投案編號:", choices = unique(mergeAllvote[,1])),
             textInput("caption", "Caption:", "Data Summary"),
            
             selectInput("dataset", "公投案編號", choices = unique(mergeAllvote[,1])),
             selectInput("rate", "查看比率", choices = c("各縣同意率", "各縣投票率")),
             
             downloadButton('downloadData', 'Download')
             
           ),    

       
       mainPanel(
          h3(textOutput("caption", container = span)),
          verbatimTextOutput("summary"),
          plotlyOutput("plot"),
          plotlyOutput("plot2"),
          plotlyOutput("plot3")
         )
     )
  ))
