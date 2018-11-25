

source('R/aws_utils.R')
source('R/startup.R')



shinyServer(function(input, output,session) {

  onStop(function(){
    cat('Ending session from server onStop')
    # end_data()
    tryCatch(end_data(),error=function(e){e}) # avoid curl::curl_fetch_memory errors
  })
  
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
  
  session$onSessionEnded(function(){
    
    #not clear if onStop is enough?
      cat('Ending session from onSessionEnded')
      end_data()
      Sys.sleep(2)
      cat('done')
   
  })

})
