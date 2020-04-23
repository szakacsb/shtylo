# Docker support

## Installation

The Dockerfile uses the shiny dockerimage as a base. It requires internet access for cloning this code. The .shiny_app.conf file is copied into the image during the build process, so any configuration settings should take part before that.
This should include setting the working directory of the shiny app and also the access to the mongodb server.
The project uses the mongolite R package to access a mongodb database that is not included in the image. It is advised to create another docker container for that and attach both to the same docker network. After that, running the container looks like this:

`sudo docker run --name shtylo -p 4700:4700 --network first -d shtylo:latest`

Where first is the name of the network. This allows for access on localhost:4700. The url should include this query: username=<user> to work properly.
