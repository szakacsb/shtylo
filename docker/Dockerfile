FROM rocker/shiny:3.5.1
WORKDIR /home
RUN apt-get update
RUN apt-get install git -y
RUN apt-get install tk -y
RUN R -e "install.packages('stylo')"
RUN apt-get install libssl-dev -y
RUN apt-get install libsasl2-dev -y
RUN R -e "install.packages('mongolite')"
RUN R -e "install.packages('shinyBS')"
RUN R -e "install.packages('properties')"
RUN R -e "install.packages('readr')"
RUN apt-get install xdg-utils --fix-missing -y
RUN mkdir wd
RUN git clone https://github.com/szakacsb/shtylo.git
RUN apt-get install -y nano
COPY .shiny_app.conf shtylo/src/.shiny_app.conf
#RUN apt-get install -y gnupg
#RUN apt-get install -y apt-transport-https ca-certificates
#RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
#RUN echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.2 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
#RUN apt-get update
#RUN apt-get install -y mongodb-org
CMD R -e "shiny::runApp('/home/shtylo/src', port=4700, host='0.0.0.0')"
