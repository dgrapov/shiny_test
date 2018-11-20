
#create folder structure
library(fs)

#create path if it does not exist
dir_create(Sys.getenv('TEST_PATH'), mode = "u=rwx,go=rx", recursive = TRUE)
