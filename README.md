# APACHE ONLY DOCKER COMPOSE TEMPLATE #

### What is this repository for? ###

This is a docker container for hosting a static build or pre-built react app that doesn't require PHP or a database.

### Set up ###

**Edit the .env file and update the variables to suit your project.**

* COMPOSE_PROJECT_NAME=**[git repo name]**
* HOST_NAME=**[project's production domain]**
* HOST_CONTAINER_NAME=**[git repo name]**
* HOST_CONTAINER_IMAGE=httpd:**[git repo name]**
* HOST_PORT=**[Assign and use a port number used with an Nginx Reverse Proxy ]**

### Project files ###

Place project files inside the **"www"** directory.

### scraps.txt ###

This is a useful copy and paste scratch pad to use while developing

### Server side boot up ###

**Development and production**

Via the command line, goto the root directory of the repo and use the command **"sh tools.sh"** to build or rebuild the docker container, this will also update the environment.

### Nginx reverse proxy, SSL and DNS setup ###

This docker container was intended to be used on shared hosting via Nginx Reverse proxy. Use Nginx to handle SSL and DNS pointing to the container's assigned port number