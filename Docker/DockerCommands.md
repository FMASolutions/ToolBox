### [Home](../Home.md) | [Docker Home](./Docker.md)

# Docker Commands

## Building Images

    docker build [options] PATH

The PATH parameter requires a folder (or URL / GIT Repo) which will be passed to the daemon as the **build context** and needs to contain a **"dockerfile"**
as the build context is copied to the daemon it's a good idea to ensure the build context only contains what is required to build our application/image

Example build command:

    docker image build -t mytag .

The above will build an image with a tag of "mytag" and using the current directory (.) as the build context

## Running Containers

Creating a new SQL server express instance running on ubuntu :
```powershell
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=AVeryComplexPassword!123' -e 'MSSQL_PID=Express' -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-latest-ubuntu 
```