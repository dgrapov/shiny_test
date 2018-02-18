FROM rocker/r-base

COPY app /app

RUN R -e "install.packages(c('shiny','fs'))"

RUN cd /user_data

CMD ["R", "-e", "shiny::runApp('/app',host='0.0.0.0',port=3838)"]