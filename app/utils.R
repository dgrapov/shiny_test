
#create folder structure
library(fs)

user<-Sys.getenv('SHINYPROXY_USERNAME')
folders<-paste0(user,'folder_',1:3)
dir_create(folders, mode = "u=rwx,go=rx", recursive = TRUE)
