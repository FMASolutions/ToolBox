### [Home](../Home.md) | [Docker Home](./Docker.md)

# **Building Images (Dockerfile)**

## **Dockerfile Anatomy**
A **"Dockerfile"** is a text document containing a series of instructions which are used to create a docker image.

Example dockerfile to build a ASP.NET Web Application / API:

```Dockerfile
#Base image containing the dotnet sdk which will only be used to build / publish our application
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build

#Set the working directory
WORKDIR /app

#Copy the application csproj file from the host into a new layer (NEW LAYER CREATED)  
COPY *.csproj ./
#Run the dotnet restore command (NEW LAYER CREATED)
RUN dotnet restore

#Copy the compiled code into a new layer (NEW LAYER CREATED)
COPY . ./
#Publish our application code into an 'out' folder using a 'Release' configuration (NEW LAYER CREATED)
RUN dotnet publish -c Release -o out

#New Base Image to work from, containing the dotnet runtime only (much smaller than the sdk) which will be used to run our application
FROM mcr.microsoft.com/dotnet/aspnet:5.0

#Set the working directory
WORKDIR /app
#Copy our published application from the SDK base image into the new base image (NEW LAYER CREATED)
COPY --from=build /app/out .
#Use the ENTRYPOINT instruction to specify a command to be exectured when a container is launched, in this case, use the dotnet cli to run our application.
#Application dll location should be relative to the most recent "WORKDIR" command, for this example that's "/app"
ENTRYPOINT ["dotnet", "ApplicationName.dll"]
```

## **Building a custom docker image**
We can build the above example dockerfile into a docker image using the following command:

    docker image build -t mytag ./pathToBuildContextContainingDockerfile

### Build context
The build context is the location of you application code which is passed to the docker daemon when running the "docker image build" command.
As the build context is copied to the daemon it's a good idea to ensure the build context only contains what is required to build our application/image.

### Image Build Process
The "docker image build" command reads the dockerfile from the build context, one line at a time from top to bottom, executing the instructions and building the required layers.

when building the layers which make up the image, docker will spin up temporary containers to run any commands / copy data into. The data from these temporary containers are then used to create the read only layers which make up our final image. The temporary containers are then automatically destoryed.

we can see a history of the commands used to build each of the layers / meta data using the below command (where IMAGE is the image id / image name):

    docker history IMAGE

we can also see the manifest json object by running the following command (where IMAGE is the image id / image name):

    docker inspect IMAGE    
