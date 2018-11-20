## Example shiny app via docker container and optionally kubernetes


### Simple tests involve setting the `path` based on the `TEST_PATH` environmental variable and:


* #### viewing `path` contents and all environmental variables

* #### create a file in the `path`



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

export TEST_PATH='/test_folder/'
export HOST_PATH='<HOST PATH TO MOUNT CONTAINER>'

docker run --rm -p 3838:3838 \
-v $HOST_PATH=$TEST_PATH
-e TEST_PATH=$TEST_PATH \
-d dgrapov/shiny_test:latest
```

### Connect to container at `<YOUR IP>:3838`
### View created objects at `<HOST_PATH>`


