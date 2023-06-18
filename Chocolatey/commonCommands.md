### [Home](../Home.md) | [Chocolatey Home](./chocolatey.md)

# Chocolatey - Common Commands

List locally installed packages:
```powershell
choco list -l
```

Search for package
```powershell
choco list package_name
```

install a package (-y is to auto-accept running any install script)
```powershell
choco install package_name -y
```

uninstall a package (-y is to auto-accept running any modify / uninstall scripts)
```powershell
choco uninstall package_name
```

upgrade a package (-y is to auto-accept running any modify / install scripts)
```powershell
choco upgrade package_name -y
```

force uninstall of a package, useful if a package has been uninstalled manually but choco thinks it's still installed
```powershell
choco uninstall package_name --force -n
``` 
