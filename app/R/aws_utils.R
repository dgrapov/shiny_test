

#' @title check_s3_files
#' @export
#' @import dplyr
#' @details compare file creation time between local and s3 only checkign names
check_s3_files<-function(path,s3_files){
  
  local_files<-dir(path,recursive = TRUE) %>%
    paste0(path,.) %>% file.info() %>% mutate(Key=rownames(.))
  check<-left_join(s3_files,local_files,by="Key") %>%
    mutate(update=TRUE)

  check$update[check$LastModified<check$mtime]<-FALSE
  check
}

#' @title sync_from_s3
#' @export
#' @import aws.s3
#' @details hack to deal nested bucket/file control
sync_from_s3<-function(path,bucket,prefix){
  files<-get_bucket_df(bucket=bucket,prefix=prefix)
  check<-check_s3_files(path,files)
  .files<-check$Key[check$update]
  
  lapply(.files,function(x) {
    save_object(object=x,bucket = s3_bucket, file=x)
  })
}

#' @title sync_to_s3
#' @export
#' @import aws.s3
sync_to_s3<-function(path,bucket){
  files<-paste0(path,dir(path,recursive = TRUE))
  s3sync(files=files, bucket=bucket, direction = "upload",verbose=TRUE)
}
