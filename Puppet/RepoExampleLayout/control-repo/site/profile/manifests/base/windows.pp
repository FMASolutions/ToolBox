class profile::base::windows (
    Array[Wincrypto::Protocol]          $allowed_client_protocols   = ['TLS 1.2', 'DTLS 1.2'],
    Array[Wincrypto::Protocol]          $allowed_server_protocols   = ['TLS 1.2', 'DTLS 1.2'],
    Array[Wincrypto::KeyExchange]       $allowed_key_exchange       = ['Diffie-Hellman','PKCS','ECDH']
    Integer[2048]                       $min_dh_key_ex_length       = 2048
    Array[Wincrypto::CipherSuite]       $allowed_ciphers            = ['AES 128/128','AES 256/256']
    Array[Wincrypto::HashingAlgorithm]  $allowed_hashes             = ['SHA256','SHA384','SHA512']
) {
    include profile::base

    $reboot_trig_name = 'windows_crypto_api_config'
    reboot_trig = $::profile::base::allow_reboot ? {
        true => Reboot[$reboot_trig_name],
        false => undef,
    }

    #Configure SCHANNEL
    class {'wincrypto':
        allowed_client_protocols    => $allowed_client_protocols,
        allowed_server_protocols    => $allowed_server_protocols,
        allowed_key_exchange        => $allowed_key_exchange,
        min_dh_key_ex_length        => $min_dh_key_ex_length,
        allowed_ciphers             => $allowed_ciphers,
        allowed_hashes              => $allowed_hashes,
    }

    if $reboot_trig != undef {
        reboot { $reboot_trig_name:
            apply       => finished,
            when        => refreshed,
            message     => 'Reconfiguration of Windows Crypto API requires system restart.',
            subscripbe  => Class['wincrypto']
        }
    }
}