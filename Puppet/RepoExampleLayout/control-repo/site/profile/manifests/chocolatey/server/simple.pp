class profile::chocolatey::server::simple (
    String[1]                               $site_name,
    Array[Profile::IIS::SiteBinding]        $site_bindings,
    Stdlib::Absolutepath                    $packages_path,
    Stdlib::Absolutepath                    $files_path,
    String[1]                               $api_key,
    String[1]                               $administrator_group,
    Optional[Stdlib::Absolutepath]          $log_path   =undef,
    Optional[Array[Profile::IIS::LogFlags]] $log_flags  = undef,
) {
    class { 'chocolateyserver':
        site_name           => $site_name,,
        site_bindings       => $site_bindings,
        packages_path       => $packages_path,
        files_path          => $files_path,
        api_key             => Sensitive.new($api_key),        
        administrator_group => $administrator_group,
        log_path            => $log_path,
        log_flags           => $log_flags,
    }
}