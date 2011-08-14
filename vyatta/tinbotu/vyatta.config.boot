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
        vif 5 {
            address 192.168.25.254/24
        }
        vif 6 {
            address 192.168.26.254/24
        }
        vif 7 {
            address 192.168.27.254/24
        }
        vif 8 {
            address 192.168.28.254/24
        }
        vif 9 {
            address 192.168.29.254/24
        }
    }
    loopback lo {
    }
}
service {
    dhcp-server {
        disabled false
        global-parameters "default-lease-time 300;"
        global-parameters "option domain-name-servers 8.8.8.8;"
        shared-network-name LOCAL02 {
            authoritative disable
            subnet 192.168.22.0/24 {
                default-router 192.168.22.254
                lease 86400
                start 192.168.22.16 {
                    stop 192.168.22.160
                }
            }
        }
        shared-network-name LOCAL03 {
            authoritative disable
            subnet 192.168.23.0/24 {
                default-router 192.168.23.254
                lease 86400
                start 192.168.23.16 {
                    stop 192.168.23.160
                }
            }
        }
        shared-network-name LOCAL04 {
            authoritative disable
            subnet 192.168.24.0/24 {
                default-router 192.168.24.254
                lease 86400
                start 192.168.24.16 {
                    stop 192.168.24.160
                }
            }
        }
        shared-network-name LOCAL05 {
            authoritative disable
            subnet 192.168.25.0/24 {
                default-router 192.168.25.254
                lease 86400
                start 192.168.25.16 {
                    stop 192.168.25.160
                }
            }
        }
        shared-network-name LOCAL06 {
            authoritative disable
            subnet 192.168.26.0/24 {
                default-router 192.168.26.254
                lease 86400
                start 192.168.26.16 {
                    stop 192.168.26.160
                }
            }
        }
        shared-network-name LOCAL07 {
            authoritative disable
            subnet 192.168.27.0/24 {
                default-router 192.168.27.254
                lease 86400
                start 192.168.27.16 {
                    stop 192.168.27.160
                }
            }
        }
        shared-network-name LOCAL08 {
            authoritative disable
            subnet 192.168.28.0/24 {
                default-router 192.168.28.254
                lease 86400
                start 192.168.28.16 {
                    stop 192.168.28.160
                }
            }
        }
        shared-network-name LOCAL09 {
            authoritative disable
            subnet 192.168.29.0/24 {
                default-router 192.168.29.254
                lease 86400
                start 192.168.29.16 {
                    stop 192.168.29.160
                }
            }
        }
    }
    dns {
        forwarding {
            cache-size 150
            listen-on eth4
            system
        }
    }
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
    name-server 8.8.8.8
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
