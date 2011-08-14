interfaces {
    ethernet eth0 {
        address dhcp
        duplex auto
        hw-id 00:23:54:04:70:04
        smp_affinity auto
        speed auto
    }
    ethernet eth1 {
        address 10.10.10.10/8
        duplex auto
        hw-id 00:40:26:c0:0f:8f
        smp_affinity auto
        speed auto
    }
    loopback lo {
    }
}
service {
    dhcp-server {
        disabled false
        shared-network-name yakesummer {
            authoritative disable
            subnet 10.10.10.0/8 {
                default-router 10.10.10.10
                dns-server 10.10.10.10
                lease 86400
                start 10.10.10.11 {
                    stop 10.10.10.254
                }
            }
        }
    }
    dns {
        forwarding {
            cache-size 150
            listen-on eth1
        }
    }
    nat {
        rule 10 {
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
    host-name vyatta
    login {
        user vyatta {
            authentication {
                encrypted-password $1$5Bs0iqUR$7HkIzR7uOVchZnda9qX9O1
            }
            level admin
        }
    }
    ntp {
        server 0.vyatta.pool.ntp.org {
        }
        server 1.vyatta.pool.ntp.org {
        }
        server 2.vyatta.pool.ntp.org {
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
/* === vyatta-config-version: "dhcp-server@4:vrrp@1:system@4:cluster@1:wanloadbalance@2:webproxy@1:ipsec@2:quagga@2:zone-policy@1:webgui@1:nat@3:firewall@4:qos@1:config-management@1:content-inspection@2:conntrack-sync@1:dhcp-relay@1" === */
