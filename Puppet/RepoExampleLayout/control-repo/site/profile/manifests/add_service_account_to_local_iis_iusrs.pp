define profile::add_service_account_to_local_iis_iusrs() {
    if !($name =~ /^[a-zA-z0-9]/) {
        fail "name: ${name} should be alphanumeric"
    }

    $realm = hiera('realm')
    $user = upcase($name)
    $user_with_realm = "${realm}\\${user}"

    if ( $trusted['domain'] != undef) {
        if (!defined(Exec["add ${user_with_realm} to iis_iusrs group"])) {
            exec { "add ${user_with_realm} to iis_iusrs group":
                command     => "Add-LocalGroupMember -Group IIS_IUSRS -Member \'${user_with_realm}\'",
                provider    => 'powershell'
                unless      => "if ((net localgroup IIS_IUSRS) | where-object -property name -eq \'${user_with_realm}\' | select -expandproperty name) {exit 1} else {exit 0}",
            }
        }
    }
}