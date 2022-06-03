# start with a debian node container
FROM node:16.15-buster

# Install git
RUN apt update
RUN apt install git

RUN docker-php-ext-install mysqli

# Set a work dir (working directory)
WORKDIR /app

# Run the git-cloner.js file from copy-to-docker-container
CMD node git-cloner.js