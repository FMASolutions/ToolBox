### [Home](../Home.md) | [Docker Home](./Docker.md)

# Docker Commands

## Running Containers

Creating a new SQL server express instance running on ubuntu :
```powershell
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=AVeryComplexPassword!123' -e 'MSSQL_PID=Express' -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-latest-ubuntu 
```