FROM rocker/r-base

COPY app /app

RUN apt-get update && apt-get install -y \
  libcurl4-gnutls-dev libssl-dev libxml2-dev 


RUN R -e "install.packages(c('curl', 'openssl','shiny','fs','aws.s3','dplyr'))"

CMD ["R", "-e", "shiny::runApp('/app',host='0.0.0.0',port=3838)"]