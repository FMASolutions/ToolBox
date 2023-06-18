class role::application_name::elastic {
    contain profile::base::windows::server    
    contain profile::application_name::elastic

    Class['profile::base::windows::server']    
    -> Class['profile::application_name::elastic']
}