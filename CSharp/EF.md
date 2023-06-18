### [Home](../Home.md) | [C# Home](./CSharp.md)

# Entity Framework
Add a new migration file for raw data

```powershell
dotnet ef --startup-project startUpProject.csproj migrations add SeedProducts -p dbContext.csproj
```

Update DB

```powershell
dotnet ef --startup-project pathTo.csproj database update
```