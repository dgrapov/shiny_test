
#create folder structure
library(fs)
library(aws.s3)
library(dplyr) # using for left_join


#default data load/save
start_data<-function(){}
end_data<-function(){}


#if s3 is set then will try to use the s3_prefix
save_path<-Sys.getenv('TEST_PATH') # used to save file in container

obj<-list('AWS_ACCESS_KEY_ID',
          'AWS_SECRET_ACCESS_KEY','AWS_DEFAULT_REGION',
          'S3_BUCKET')

using_s3<-function(obj){
  sapply(obj,function(x){Sys.getenv(x) != ""}) %>% all()
}

if(using_s3(obj)){
  s3_bucket<-Sys.getenv('S3_BUCKET')
  s3_prefix<-path<-save_path
  #make this a an expression w/ an env
  #onStop can get: curl::curl_fetch_memory: Operation was aborted by an application callback
  start_data<-function(){sync_from_s3(path=path,bucket=s3_bucket,prefix=s3_prefix)}
  end_data<-function(){sync_to_s3(path=path,bucket=s3_bucket)}
 
} else {
  
  if(save_path =='') {
    save_path <- './'
  } else {
    start_data<-function(){dir_create(save_path, mode = "u=rwx,go=rx", recursive = TRUE)}
  }
  
}

#start data sync here to control if no S3

tryCatch(start_data(),error=function(e){e})