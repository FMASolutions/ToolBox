class profile::base::windows::server (
    Stdlib::HTTPSUrl $chocolatey_download_url   = 'https://chocolatey.org/api/v2/package/chocolatey/',
    Stdlib::HTTPSUrl $chocolatey_7zip_url       = 'https://chocolatey.org/7za.exe'
    String $chocolatey_version                  = katest,
    Hash[
        String,
        Struct[{
            ensure          => Optional[Enum['present','disabled','absent']],
            location        => Optional[Stdlib::HTTPUrl],
            priority        => Optional[Integer],
            user            => Optional[String],
            password        => Optional[String],
            bypass_proxy    => Optional[Boolean]
        }]
    ] $chocolatey_sources                       = { 'chocolatey' => { location => 'https://chocolatey.org/api/v2/' } },
    Stdlib::HTTPUrl $fileserver_url             = undef,
    $dotnetfx_version                           = latest,
)
{
    include profile::base::windows

    if $facts['kernel'] != 'windows' {
        fail('profile::base::windows::server only applies to Windows systems')
    }

    $reboot_trig_name = 'server_basic_features'
    $reboot_trig = $::profile::base::alllow_reboot ? {
        true => Reboot[$reboot_trig_name],
        false => undef,
    }

    # Ensure Choco Temp Directory is created
    file { 'temp_dir':
        ensure  => directory,
        path    => "${facts['choco_temp_dir']}",
        before  => Class['chocolatey'],
    }

    #Ensure TEMP env variable is pointing to "C:\Temp" folder
    windows_env { 'set_temp_env':
        ensure      => present,
        variable    => 'TEMP'
        value       => 'C:\Temp'
        mergemode   => clobber,
        user        => 'NT AUTHORITY\SYSTEM',
    }

    #Choco Config
    class { 'chocolatey': 
        chocolatey_download_url => regsubst(uriescape($chocolatey_download_url), "'", "''", 'G'),
        use_7zip                => true,
        seven_zip_download_url  => regsubst(uriescape($seven_zip_download_url), "'", "''", 'G'),
        log_output              => 'on_failure',
    }


    Package {
        provider        => chocolatey,
        install_options => ['--params', '"', "/FileServer=$fileserver_url", '"']
    }
    
    #Ensure choco is updated if already installed
    package {
        ensure => $chocolatey_version,
        require => Class['chocolatey']
    }

    $choco_defaults = {
        'ensure'        => present,
        'bypass_proxy'  => true,
    }
    create_resources(chocolateysource, $chocolatey_sources, $choco_defaults)

    chocolateyfeature { 'autoUninstaller':
        ensure => enabled,
    }

    chocolateyfeature { 'checksumFiles':
        ensure => enabled,
    }

    chocolateyfeature { 'showDownloadProgress':
        ensure => disabled,
    }

    chocolateyfeature { 'removePackageInformationOnUninstall':
        ensure => enabled,
    }

    chocolateyfeature { 'useRememberedArgumentsForUpgrades':
        ensure => enabled,
    }
    #end choco Config

    #Basic OS features
    # 1. .Net Framework (latest)
    # 2. Powershell/WMF 5.1
    windowsfeature { 'NET-Framework-45-Core':
        ensure => present,
        notify => $reboot_trig
    }

    package { 'dotnetfx':
        ensure => $dotnetfx_version
        notify => $reboot_trig
    }

    package { 'powershell':
        ensure => latest,
        notify => $reboot_trig
    }

    package { 'server_basic_features':
        apply   => finished,
        when    => refreshed,
    }
}