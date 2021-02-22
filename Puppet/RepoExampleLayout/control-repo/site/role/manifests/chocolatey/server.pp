class role::chocolatey::server {
    contain profile::base::windows::server
    contain profile::iis::web
    contain profile::chocolatey::server::simple

    Class['profile::base::windows::server']
    -> Class['profile::iis::web']
    -> Class['profile::chocolatey::server::simple']
}