### Example shiny app via docker container


Simple tests involve setting the `path` based on the `TEST_PATH` environmental variable and:


* viewing `path` contents and all environmental variables

* create a file in the `path`

* copy file to/from [`AWS S3`](https://aws.amazon.com/s3/) on application start up and shutdown 



#### ***R***
```
shiny::runApp('app',host='0.0.0.0',port=3838)
```

#### ***Docker***

##### `Build` 
```
docker build -t "shiny_test" .
```


##### `Run` 

1) Mount host path at `<HOST_PATH>` in container. The `<TEST_PATH>` directory will be created in he mounted location. A sample file will be saved to this location after pushing the in app button.

```
export TEST_PATH='/test_folder/'
export HOST_PATH='<HOST PATH TO MOUNT CONTAINER>'

docker run --rm -p 3838:3838 \
--name shiny_test \
-v $HOST_PATH:/app \
-e TEST_PATH=$TEST_PATH \
-d dgrapov/shiny_test:latest
```

2) Sync data to `<TEST_PATH>` from an AWS S3 bucket `<S3_BUCKET>` on app start up and shutdown.
Note the `<TEST_PATH>` is used as a prefix to identify the S3 subpath under the main `<S3_BUCKET>`. For example if `<S3_BUCKET>` is set to s3://my-bucket and `<TEST_PATH>` to 'test/' then contents of s3://my-bucket/test/ will be attempted to be loaded into the container at start up and saved from the container to S3 on shutdown.

```
export AWS_ACCESS_KEY_ID='' 
export AWS_SECRET_ACCESS_KEY=''
export AWS_DEFAULT_REGION=''
export S3_BUCKET=''

docker run --rm -p 3838:3838 \
--name shiny_test \
-v $HOST_PATH:/app \
-e TEST_PATH=$TEST_PATH \
-e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
-e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
-e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
-e S3_BUCKET=$S3_BUCKET \
-d dgrapov/shiny_test:latest
```

#### ***NOTES***

Connect to container at `<YOUR IP>:3838`

View created objects at `<HOST_PATH>`


