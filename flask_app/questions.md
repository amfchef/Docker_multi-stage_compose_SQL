# Questions

###### 1.1 Docker and container technology
- What is Docker (platform)
Docker is a public and private platform, were you can develop, ship and run applications. Docker is separating your application from your infrastructure,
so you can deliver software faster. Docker got a lot of services included, for example testing, developing, deployment.
With Docker it doesn't matter which OS you are running on, or what dependencies you have installer in your machine, it is meant
to run regardless of which operating system you have.
Docker is making it possible to run an application on a isolated environment, which is called a container. You can easily share your container,
with your friends, and co-workers, as this will make your business more agile and efficient.

- What is a Docker image and how do you relate it to Docker containers
Docker image is a read-only template with its instructions of creating a Docker container. You may find pre-exited images from other developers online.
To you don't have to start from scratch.
A container is a runnable instance of you image. You will be able to start, stop, restart and delete your container, with the help of 
Docker API, and CLI.
A container is defined by its image, you may say that the image is a configuration of your container.

- What is Container technology
Docker uses several features of Linux Kernal to deliver its functionality. Docker is also using a technology which is called `namespaces`
to maintain the isolated container. Each time you create a container, Docker will automatically create a set of namespaces, for that specific container.
These namespaces provide a layer of isolation.

- What is Docker registry
Docker Registry stores Docker images. DockerHub is a perfect example of a registry. As you can store your images there public and private.
There are other registries as well, but DockerHub is the largest one in the market.
You can store different versions of your images, as tags (eg. :latest or :1.0)

- How do you describe Linux Kernels (what does it do?)
Docker technologies uses Linux kernels, like namespaces and Cgroups to be able to process, so they can run it independently.
Its one of the purpose to be able to run multiple apps separate from the other one. This will make it easier for the infrastructure

- How can Docker and Docker Containers be similar to a docker shipment
The analogy that the Docker containers relates to a docker shipment, its simple. Because you will recieve a pre set container, exaclt how you 
want it in Docker container, and it will work in which envorinment you are using. The same thing for a shipping container from a ship.
You will recieve exactly the product you ordered, or built.
Docker containers are also self-sufficent. Similarly, shipping containers don't care which shipment they're on, as long as 
the ship has the capacity to transport them. No need to stack goods by hand below deck and worry about temperature, 
moisture, etc. The container takes care of that, not the ship.

- What is happening when you execute the command `docker build .` Describe the process
As soon as you execute the command docker build .:
Docker will find a dockerfile in your active folder. Then it will execute all the instruction in that file. And build a new container image from these instructions.
Each of the instructions will create layers to be downloaded. 
This is an example of a Dockerfile:
```
FROM python
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
CMD ["python3","app.py"]
```
- First we need to tell Docker that we use `Python` in this application
- We create a working directory in our docker client.
- We copy the folder we are in to docker
- We run the command `pip install -r requirements.txt` to install all dependencies
- We execute the command python3 and app.py, this will run the application
- When we build the container, we need to tell docker which port we are using.

###### 1.2 Docker Client
Describe a containers lifecycle with commands

`docker create --name <container name> <image-name>`
`docker start <container-id/name>`
`docker run -it --name <container name> <image-name>`
`docker pause <container-id/name>`
`docker stop <container-id/name>`
`docker rm <container-id/name>`
`docker kill <container-id/name>`


##### 1.3 Docker Compose

Describe each row, in this docker-compose file:
```yaml
version: "3.8"      # Version is something a docker-compose file needs, to seperate each versions, the latest version is 3.x
services:           # services need to be described to tell docker, which services that we need to include.
                    # Which containers/images we are including. A service needs to be based on an image.
 flask:             # First service we use, named flask
  container_name: flaskcontainer  # Assign the name flaskcontainer to our service
  build:            # We give it instructions to build the container in path:"./app"
   context: ./app
   dockerfile: Dockerfile.dev # We tell which name our Dockerfile is, per default the file is named: Dockerfile
  ports:
   - 5000:5000      # We tell docker that we will be listening on port 5000 from both our localhost and docker
  depends_on: 
   - db             # Without the db service, our flask service wont work
  networks:
    - flask_app_net # We specify our network that we will operate 
 db:
  container_name: dbcontainer # We tell docker our second service is named dbcontainer
  image: postgres:latest      # Here we tell docker that we will use a pre exiting image from psotgres with tag :latest
  restart: always             # We tell docker that it needs to restart if any errors occurs
  environment:                # Here vi store our environment variables, this will be for security resons, so we dont store it in a public file.
                              # Here we put our confident information
   POSTGRES_DB: mydb          # Name of our db, 
   POSTGRES_PASSWORD: postgres # The password we will use
   POSTGRES_USER: postgres    # The username we will use
  volumes:                    # Here we are telling docker were the volume (postgresdata should be stored on docker)
                              # Volumes are used to bind, mount and manage data in Docker containers, we use it to perist or share data between containers.
   - postgres_data:/var/lib/postgresql/data/
  networks:
   - flask_app_net            # Here we mention which network we will operate in
       
networks:                     
  flask_app_net:
      driver: bridge          # We tell docker that we need a bridge-driver as a network

volumes:        
 postgres_data:               # We tell docker the name of volume

```

- `docker-compose up`     active the docker-compose file
- `docker-compose down`   deactivate the docker-compose file