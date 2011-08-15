interfaces {
    ethernet eth0 {
        address 192.168.20.2/24
        duplex auto
        hw-id 08:00:27:0e:00:a4
        smp_affinity auto
        speed auto
    }
    ethernet eth4 {
        address 10.10.10.10/24
        duplex auto
        hw-id 00:07:40:53:cf:03
        smp_affinity auto
        speed auto
        vif 2 {
            address 10.10.12.254/24
        }
        vif 3 {
            address 10.10.13.254/24
        }
        vif 4 {
            address 10.10.14.254/24
        }
        vif 5 {
            address 10.10.15.254/24
        }
        vif 6 {
            address 10.10.16.254/24
        }
        vif 7 {
            address 10.10.17.254/24
        }
        vif 8 {
            address 10.10.18.254/24
        }
        vif 9 {
            address 10.10.19.254/24
        }
        vif 10 {
            address 10.10.20.254/24
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
            authoritative enable
            subnet 10.10.12.0/24 {
                default-router 10.10.12.254
                lease 1200
                start 10.10.12.16 {
                    stop 10.10.12.160
                }
            }
        }
        shared-network-name LOCAL03 {
            authoritative enable
            subnet 10.10.13.0/24 {
                default-router 10.10.13.254
                lease 1200
                start 10.10.13.16 {
                    stop 10.10.13.160
                }
            }
        }
        shared-network-name LOCAL04 {
            authoritative enable
            subnet 10.10.14.0/24 {
                default-router 10.10.14.254
                lease 1200
                start 10.10.14.16 {
                    stop 10.10.14.160
                }
            }
        }
        shared-network-name LOCAL05 {
            authoritative enable
            subnet 10.10.15.0/24 {
                default-router 10.10.15.254
                lease 1200
                start 10.10.15.16 {
                    stop 10.10.15.160
                }
            }
        }
        shared-network-name LOCAL06 {
            authoritative enable
            subnet 10.10.16.0/24 {
                default-router 10.10.16.254
                lease 1200
                start 10.10.16.16 {
                    stop 10.10.16.160
                }
            }
        }
        shared-network-name LOCAL07 {
            authoritative enable
            subnet 10.10.17.0/24 {
                default-router 10.10.17.254
                lease 1200
                start 10.10.17.16 {
                    stop 10.10.17.160
                }
            }
        }
        shared-network-name LOCAL08 {
            authoritative enable
            subnet 10.10.18.0/24 {
                default-router 10.10.18.254
                lease 1200
                start 10.10.18.16 {
                    stop 10.10.18.160
                }
            }
        }
        shared-network-name LOCAL09 {
            authoritative enable
            subnet 10.10.19.0/24 {
                default-router 10.10.19.254
                lease 1200
                start 10.10.19.16 {
                    stop 10.10.19.160
                }
                subnet-parameters "default-lease-time 300;"
            }
        }
        shared-network-name LOCAL10 {
            authoritative enable
            subnet 10.10.20.0/24 {
                default-router 10.10.20.254
                lease 1200
                start 10.10.20.16 {
                    stop 10.10.20.160
                }
            }
        }
    }
    dns {
        forwarding {
            cache-size 1024
            listen-on eth4
            listen-on eth4.2
            listen-on eth4.3
            listen-on eth4.4
            listen-on eth4.5
            listen-on eth4.6
            listen-on eth4.7
            listen-on eth4.8
            listen-on eth4.9
            listen-on eth4.10
            system
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
        commit-revisions 21
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
