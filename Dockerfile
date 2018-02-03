FROM rocker/r-base

COPY app /app

RUN R -e "install.packages('shiny')"