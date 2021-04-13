### [Home](../Home.md) | [Docker Home](./Docker.md)

# **Containers**

## General Info
A container is simply a running instance of an **[Image](./DockerImages.md)** with a **thin writeable layer** on top (Rembember images are read-only). 

Multiple containers can all point to a single image but will all have their very own independant writeable layer. If a change is required to a file residing on the read-only portion of the image, then the file is first copied to the writeable layer where the changes are made. This is known as **Copy on Write** 

When a contianer is stopped the writeable portion of the container remains so when the container is started again then any data on that layer will still be available, however, if the container is destoryed, the writeable layer is also destroyed along with the container.

If the main process ran during the start up of for the container is terminated or completes, then the container will automatically stop.


## Managing Containers

A container can be created and automatically started with the following command

    docker container run IMAGE

A container can be stopped with the following command

    docker container stop CONTAINER

A stopped container can be started with the following command

    docker container start CONTAINER