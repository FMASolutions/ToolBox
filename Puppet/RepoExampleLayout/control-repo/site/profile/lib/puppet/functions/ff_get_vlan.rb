Puppet::Functions.create_function(:ff_get_vlan) do
    dispatch :ff_get_vlan do
        param 'String', :ipaddress
        param 'Array[Struct[{dc => String[1], name => String[1], id => Integer, network => String[1]}]]', :vlans
    end

    def ff_get_vlan(ipaddress, vlans)
        vlans.each do |vlan|
            net = IPAddr.new(vlan['network'])
            return vlan if net === IPAddr.new(ipaddress)
        end
        raise Puppet::ParseError, "ff_get_vlan: No VLAN found for IP: #{ipaddress}"
    end
end