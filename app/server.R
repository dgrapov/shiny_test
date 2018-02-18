
#set wd based on user path
wd<-Sys.getenv("DATA_PATH")
if(!is.null(wd)) setwd(wd)


shinyServer(function(input, output) {

  #create a file on click
  output$create<-renderUI({
    fluidRow(
      column(width = 6,
        actionButton('create_btn',h1(HTML('<span>&#9760;</span>')))
      ),
      column(width = 6,
             h3(paste('date time: ',get_time()))
      )
    )
  })
  
  #save date-time stamp
  observeEvent(input$create_btn,{
    obj<-as.character(Sys.time())
    cat(obj,file='date-time.txt')
  })
  
  #update file contents
  get_time<-reactive({
    input$create_btn
    tryCatch(readLines('date-time.txt'),error=function(e){as.character(e)})
  })
  
  #environment
  output$env_in<-renderText({
    paste(paste(names(Sys.getenv()),Sys.getenv(),sep=" = "),collapse='\n')
  })
  output$env<-renderUI({
    tagList(
      h3('Environment'),
      verbatimTextOutput('env_in')
    )
  })
  
  output$mainUI <- renderUI({
    
    fluidRow(
      column(12,
        uiOutput('create'),
        uiOutput('env')
      )
    )
    
  })

})
