class profile::base::filesystem (
    Array[Struct[{
        path => String[1],
        ensure => String[1]  
    }]] $paths,    
) {
    $paths.each |$path| {
        file { $path['path']:
            ensure => $path['ensure']
        }
    }
}