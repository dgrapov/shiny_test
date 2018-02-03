# Example shiny app and docker

code: 

## Functionality:

* ###  create file

* ### view environment variables


## Run app from `R`
```{r,eval=FALSE}

shiny::runApp('app',host='0.0.0.0',port=3838)

```

## Build `docker` container
```{bash, eval=FALSE}
docker build -t "shiny_test" .
```

## Run `docker` container
```{bash,eval=FALSE}
docker-compose -f run.yml up -d

```
### Connect to container at `<YOUR IP>:3838`