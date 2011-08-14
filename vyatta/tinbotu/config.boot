interfaces {
    ethernet eth0 {
        address 192.168.20.2/24
        duplex auto
        hw-id 08:00:27:0e:00:a4
        smp_affinity auto
        speed auto
    }
    ethernet eth4 {
        address 192.168.21.192/24
        duplex auto
        hw-id 00:07:40:53:cf:03
        smp_affinity auto
        speed auto
        vif 2 {
            address 192.168.22.254/24
        }
        vif 3 {
            address 192.168.23.254/24
        }
        vif 4 {
            address 192.168.24.254/24
        }
    }
    loopback lo {
    }
}
service {
    nat {
        rule 20 {
            outbound-interface eth0
            type masquerade
        }
    }
    ssh {
        port 22
        protocol-version v2
    }
}
system {
    config-management {
        commit-revisions 20
    }
    console {
    }
    gateway-address 192.168.20.10
    host-name vtinbotu
    login {
        user vyatta {
            authentication {
                encrypted-password $1$6bLEUy3k$BIEzdraLulIilZTNJc.sg.
            }
            level admin
        }
    }
    name-server 192.168.20.10
    ntp {
        server ntp.ring.gr.jp {
        }
    }
    package {
        auto-sync 1
        repository community {
            components main
            distribution stable
            password ""
            url http://packages.vyatta.com/vyatta
            username ""
        }
    }
    syslog {
        global {
            facility all {
                level notice
            }
            facility protocols {
                level debug
            }
        }
    }
    time-zone Asia/Tokyo
}


/* Warning: Do not remove the following line. */
/* === vyatta-config-version: "cluster@1:qos@1:zone-policy@1:system@4:vrrp@1:ipsec@2:conntrack-sync@1:dhcp-relay@1:webgui@1:webproxy@1:quagga@2:dhcp-server@4:firewall@4:config-management@1:wanloadbalance@2:nat@3:content-inspection@2" === */
