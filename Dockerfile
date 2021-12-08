
FROM openanalytics/r-base

MAINTAINER Tobias Verbeke "tobias.verbeke@openanalytics.eu"

# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    libssl1.1 \
    && rm -rf /var/lib/apt/lists/*

# system library dependency for the shiny app
RUN apt-get update && apt-get install -y \
    libmpfr-dev \
    && rm -rf /var/lib/apt/lists/*

# basic shiny functionality and reticulate and DT
RUN R -e "install.packages(c('shiny', 'rmarkdown', 'reticulate', 'DT'), repos='https://cloud.r-project.org/')"

## install dependencies if required
#RUN R -e "install.packages('DT', repos='https://cloud.r-project.org/')"

################################################################################
# Python
################################################################################

RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Dash and dependencies
RUN pip3 install matplotlib

# copy the app to the image
RUN mkdir /root/app
COPY app /root/app

COPY Rprofile.site /usr/lib/R/etc/

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/root/app')"]


# docker build -t shiny-python-app .
# docker run -it -p 3838:3838 shiny-python-app
# docker network create shinyproxy-net
# docker build . -t shinyproxy-test
# docker run -d -v /var/run/docker.sock:/var/run/docker.sock --net shinyproxy-net -p 8080:8080 shinyproxy-test