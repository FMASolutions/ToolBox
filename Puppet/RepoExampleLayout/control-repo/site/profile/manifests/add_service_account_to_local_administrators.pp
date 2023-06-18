define profile::add_service_account_to_local_administrators() {
    if !($name =~ /^[a-zA-z0-9]/) {
        fail "name: ${name} should be alphanumeric"
    }

    $realm = hiera('realm')
    $user = upcase($name)
    $user_with_realm = "${realm}\\${user}"

    if ( $trusted['domain'] != undef) {
        if (!defined(Exec["add ${user_with_realm} to Administrators group"])) {
            exec { "add ${user_with_realm} to Administrators group":
                command     => "Add-LocalGroupMember -Group Administrators -Member \'${user_with_realm}\'",
                provider    => 'powershell'
                unless      => "if (!(net localgroup Administrators | Where-Object {\$_ -eq \'${user_with_realm}\'})) {exit 1}",
            }
        }
    }
}