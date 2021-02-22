#Common parameters for the application_name
#Shared config parameters only in this file

class profile::application_name (
    String      $active_dc,
    Hash[
        String,
        Array[Stdlib::Fqdn]
    ]           $application_hosts,
    String[1]   $es_cluster_name,
    Hash[
        String,
        Array[Struct[{
            host => Stdlib::Fqdn,
            port => Stdlib::Port::User,
        }]]
    ]           $es_hosts,
    String[1]   $administrator_group
) {

}