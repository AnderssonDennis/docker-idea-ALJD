Hello developers!

This is a message from your friendly DevOp!
Dennis, Jesper, Ali and Andreas will be supporting you through out this project.

## Exciting times!
Finally we are moving from a monolith application development model to systems built upon microservices.

This means that we need a new development environment and build system where the teams working in the same main project, but with different services can separate their code and run it on different servers!

For this purpose we have chosen Docker in conjunction with our own setup for automating Docker.

This is the Readme file to help and guide you on how to get up and running.

## Branches
This GitHub repo will serve you the containers you need to get going. We have a main branch that we use as a base branch to create branch of with different microservices. We already created the branches needed so that all teams can create their own branches if needed to work on their on microservice. The docker branch is the default branch and it will serve you with the tools needed to run your development enviroment in the containers.

## Docker
We created all tools for you to be able to start and stop containers. If you are not familiar with docker we suggest using docker desktop. You will be able to start and stop single containers directly instead of using terminal.

## How to get started!
When you use the /.start script the first time it will not run correctly. BUT it will give you a SSH-key in the terminal and provide you with information on how to procced so that you can use the script. The script will fail untill you add the SSH-key to your GitHub account.

Checkout the docker branch and run the following command in your terminal:

```
./create-docker-tools.sh
```

This will give you two shell scripts (that are git-ignored and thus available in all branches):

```
# start all Docker containers
./start
```

```
# stop all docker containers
./stop
```

(You will also see a git ignored folder called docker-tools. There is *no need* for you to work in this folder.)

## In your branch

### Create a Dockerfile
Make sure there is: A file named **Dockerfile** which specifies at least:
* a base image (FROM) 
* and a command to run (CMD) when the server starts.

Example:

```
# start with a debian node image
FROM node:16.15-buster

# run necessary start commands
CMD npm install && node index
```

**Important:** - You dont need to specify a WORK DIR. This is done automaticly when running the shellscripts. The WORKD DIR will be set to where the code is checked out in your branch within dockers containers/volume

### Create a dockerSettings.json file
The dockerSettings.json should contain info about which branches you want to create containers from (your own one and other branches with services you want to communicate with) and on which port they should be running:

```json
[
  "dev-frontend",
  [
    4000
  ],
  "main-frontend",
  [
    4001
  ]
]
```

### Important! Listen to the environment variable PORT when you start your service!

The system sends an environment variable called PORT to your container (each branch runs in a container that you setup by writing a Dockerfile in your branch).

Start your service on this port!

### I don't know how to start my service on a specific port

Since you are in control of your microservice and its technology stack it is up to you investigate how to start in on a particular port, but here are some suggestion for technologies we know are going to be used in this project

#### React using the Vite development server

In your **config.vite.js** file:

```js
export default defineConfig({
  plugins: [react()],
  server: {
    // use process.env.PORT
    // to read the environment variable
    port: process.env.PORT
  }
})
```

#### Node.js/Express

```js
// Where you start your Express server
app.listen(process.env.PORT)
```

#### For database containers etc
Create a separate branch with your Dockerfile (and backup like SQL-dumps etc).

Refer to the documentation about the container you are using (MySQL, MariaDB, MongoDB etc) for how to start the db server on a particular port!

**Important!** If the server/service needs a command line argument rather than an environment variable to set the port it is starting on -  refter to the Docker documentation on how to read environment variables in your Dockerfile and pass them along as comman line arguments in your start CMD!



#### Dockerfiles and how the commands work

In our dockerfiles we have different commands for how we want to run our image. Down below is a brief explanation.

### Country-info dockerfile

RUN docker-php-ext-install pdo pdo_mysql

  This command installs the PHP driver for MYSQL

CMD rm -r /var/www/html \
  && ln -s $(pwd) /var/www/html \
  && sed -i "s/80/$PORT/" /etc/apache2/sites-enabled/000-default.conf \
  && sed -i "s/80/$PORT/" /etc/apache2/ports.conf \
  && apache2-foreground

  These commands deletes the Apache root folder /var/www/html, creates a symbolic link pointing
  towards our work dir, replaces port 80 to our own in the Apache config files and then runs Apache.


### Country-info-database dockerfile

ENV ALLOW_EMPTY_PASSWORD=yes
 This commands allows us to use an epmty password and thus makes it easier during development.

ENV MYSQL_PORT_NUMBER=$PORT
 Allows us to set the port for mySQL server




### Capital-info dockerfile

CMD npm install && npm run dev

 These commands installs npm and then runs in Vite development mode.


### Capitals-database dockerfile

CMD mongod --port=$PORT --bind_ip_all

mongod starts mongoDB

$PORT allows you to specify a port but we must also specify an ip(external ip for the server)
since we dont know wich ip number docker uses for our container we --bind_ip_all.


### Reverse-proxy dockerfile 

COPY nginx.conf /etc/nginx/nginx.conf

This command replaces the original conifig with our own.


### Iframer dockerfile

FROM nginx  
This command creates a layer from the officisal nginx Image

CMD rm -r /usr/share/nginx/html \
  && ln -s $(pwd) /usr/share/nginx/html \
  && sed -i "s/80/$PORT/" /etc/nginx/conf.d/default.conf \
  && nginx -g "daemon off;" 

These commands:
  first:  delete the reeal Nginx root folder
  Then:  make a symblic link which pointing to our owrk dir
  Then:  replace port 80 with our port in the config file 
  Then:  start Nginx
