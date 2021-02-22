type Profile::IIS::SiteBinding = Struct[
    {
        protocol            => Enum['http', 'https'],
        bindinginformation  => Pattern[/\A((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}\z/] #Regex to match IP Address
        sslflags            => Optional[Integer[0,4]],
        certifcatestorename => Optional[String[1]],
        certificatehash     => Options[Pattern[/\A(?i:[0-9a-f]{40})\z/]]
    }
]