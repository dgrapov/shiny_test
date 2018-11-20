

#create folder structure
library(fs)

#create path if it does not exist
save_path<-Sys.getenv('TEST_PATH')
dir_create(save_path, mode = "u=rwx,go=rx", recursive = TRUE)



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
    cat(obj,file=paste0(save_path,'date-time.txt'))
  })
  
  #update file contents
  get_time<-reactive({
    input$create_btn
    tryCatch(readLines(paste0(save_path,'date-time.txt')),error=function(e){'press the button to create a file'})
  })
  
  #environment
  output$env_in<-renderText({
    
    paste(paste(names(Sys.getenv()),Sys.getenv(),sep=" = "),collapse='\n')
  })
  
  #contents
  output$dir_in<-renderText({
    input$create_btn
    dir(save_path)
  })
  
  output$info<-renderUI({
    tagList(
      h3('Contents'),
      verbatimTextOutput('dir_in'),
      h3('Environment'),
      verbatimTextOutput('env_in')
    )
  })
  
  output$mainUI <- renderUI({
    
    fluidRow(
      column(12,
        uiOutput('create'),
        uiOutput('info')
      )
    )
    
  })

})
