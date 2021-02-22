class role::application_name::webserver {
    contain profile::base::windows::server
    contain profile::iis::web
    contain profile::application_name::webserver

    Class['profile::base::windows::server']
    -> Class['profile::iis::web']
    -> Class['profile::application_name::webserver']
}