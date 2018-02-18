FROM rocker/r-base

COPY app /app

RUN R -e "install.packages(c('shiny','fs'))"

CMD ["R", "-e", "shiny::runApp('/app',host='0.0.0.0',port=3838)"]