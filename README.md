## Example shiny app and docker

`code`: https://github.com/dgrapov/shiny_test

`docker`: https://hub.docker.com/r/dgrapov/shiny_test/

### Functionality:

* ####  create file

* #### view environment variables


### Run app from `R`
```{r,eval=FALSE}

shiny::runApp('app',host='0.0.0.0',port=3838)

```

### Build `docker` 
```{r,eval=FALSE}
docker build -t "shiny_test" .
```

### Run `docker`
```{r,eval=FALSE}
docker run -p 3838:3838 \
-e "DATA_PATH=<host_path_to_data>" \ #mount path where data will be saved
-v "<host_path_to_data>:/user_data" \ 
-d dgrapov/shiny_test:latest
```


### Connect to container at `<YOUR IP>:3838`
### View created data at `<host_path_to_data>`