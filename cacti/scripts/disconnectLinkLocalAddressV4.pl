#!/usr/bin/env perl
=head1 NAME

disconnectLinkLocalAddressV4.pl

=head1 SYNOPSIS

% disconnectLinkLocalAddressV4.pl

=head1 DESCRIPTION

This script help to disconnect IPv4 link local addres e.g. 169.254.x.x, from Cisco Aironet series.

Why?

IPv4 link local address can happen to appear, this case that, the client associated to access point was unable to get from DHCP server. it may occurs if the access point reach capacity.

The point is that client has 169.254 will lose internet connection and cannot resume until the user disables wifi once manually. unfortunately This is indiscernible for users.


=head AUTHOR

Akira KUMAGAI <kuma _at_ ultrasync _dot_ net>

=cut

package disconnectLinkLocalAddressV4;

my $debug = 1;
use strict;
use warnings;
use Carp;
use Try::Tiny;
use Net::SSH::Perl;
use Net::MAC::Vendor;
use Data::Dumper;
use Sys::Syslog;
use Getopt::Std;


my $syslogFacility = "local7";

my %waps = 
(
  "172.25.0.11" =>
  {
    name   => "ap1242-1",
    id     => "Cisco", 
    passwd => "xxxxxxxx",
    enable => 1,
  },
  "172.25.0.12" =>
  {
    name   => "ap1242-2",
    id     => "Cisco", 
    passwd => "xxxxxxxx",
    enable => 1,
  },
  "172.25.0.13" =>
  {
    name   => "ap1242-3",
    id     => "Cisco", 
    passwd => "xxxxxxxx",
    enable => 1,
  },
  "172.25.0.14" =>
  {
    name   => "ap1242-4",
    id     => "Cisco", 
    passwd => "xxxxxxxx",
    enable => 1,
  },
  "172.25.0.15" =>
  {
    name   => "ap1242-5",
    id     => "Cisco", 
    passwd => "xxxxxxxx",
    enable => 1,
  },
  "172.25.0.16" =>
  {
    name   => "ap1242-6",
    id     => "Cisco", 
    passwd => "xxxxxxxx",
    enable => 1,
  },
  "172.25.0.17" =>
  {
    name   => "ap1242-7",
    id     => "Cisco", 
    passwd => "xxxxxxxx",
    enable => 0,
  },
);

openlog($0, "pid", $syslogFacility);

my %opt;
my $disconnectiongMode = 0;

getopts("d" => \%opt);
if($opt{"d"}){
  $disconnectiongMode = 1;
}

foreach my $host(keys(%waps))
{
  if(! $host || !$waps{$host}{"enable"}){
    warn "Skipping: ". $host . "\n" if $debug;
    next;
  }
  my $id     = $waps{$host}{"id"}     || "Cisco";
  my $passwd = $waps{$host}{"passwd"} || "Cisco";
  my @wrongmac=();

#  Prompt    => '/(?m:^[\w.-]+\s?(?:\((dhcp-config|config)[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)/',
  my $ssh = Net::SSH::Perl->new($host, debug => 0) or croak();

  $ssh->login($id, $passwd);

  my($out, $err, $exit)  = $ssh->cmd("show dot11 assoc");
  my($assoc, $interface) = &getAssociatedStations($out);

  while ( my($mac, $ip) = each(%$assoc) ) { 
    print "mac:$mac, ip:$ip\n" if $debug;
    if($ip =~ /^169\.254\.\d{1,3}\.\d{1,3}/){
      push(@wrongmac, $mac);
    }
  }
  foreach my $mac(@wrongmac){
    printf("MAC address of wrong ip address : %s (do%d)\n", $mac, $interface->{$mac}) if $debug;
    my $macoui = $mac;
    if($macoui =~ /^[0-9a-fA-F\.]{14,}/){
       $macoui =~ s/\.//g;
       $macoui =~ s/.{2}/$&:/g;
       chop($macoui);
    }
    my $vendor = (Net::MAC::Vendor::lookup($macoui))[0][0]; 

	my $log;
	if($disconnectiongMode){
       my($out, $err, $exit) = $ssh->cmd(sprintf("clear dot11 client %s", $mac));
        $log = sprintf("%s(%s) force disconnect: %s %s (%s)", $waps{$host}{"name"}, $host, $assoc->{$mac}, $mac, $vendor);
	    print $log, "\n";
     	syslog("info", $log);

    }
	else{
      my $log = sprintf("%s(%s) Link Local: %s %s (%s)", $waps{$host}{"name"}, $host, $assoc->{$mac}, $mac, $vendor);

 	  print $log , "\n";
	}
  }
  $ssh->cmd("exit");
}

sub
getAssociatedStations()
{
  my ($log) = @_;
  my %interfaces=();
  my %assoc=();
  my $do = -1;
  
  if(! $log){ return (\%assoc, \%interfaces); }

  my @log = split(/\n/, $log);
  $log = undef;

  foreach my $line(@log){
   # detect Dot11 interface number and continue
   if($line =~ /^802\.11\ Client\ Stations\ on\ Dot11Radio(\d+):/){
     $do = int($1);
     next;
   }

   if($do != -1){
     if($line =~ /([0-9a-f]{4}\.[0-9a-f]{4}.[0-9a-f]{4})\s(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*?Assoc/){
      my ($mac, $ip) = ($1, $2);
      $assoc{$mac}      = $ip;
      $interfaces{$mac} = $do;
     }
   }
  }
  return (\%assoc, \%interfaces);
}

__END__

ap1231-1>sh dot11 as

802.11 Client Stations on Dot11Radio1:

SSID [PKR64] :

MAC Address    IP address      Device        Name            Parent         State
0019.d2be.0000 192.168.20.27   unknown       -               self           Assoc


802.11 Client Stations on Dot11Radio0:

SSID [E100VS] :

MAC Address    IP address      Device        Name            Parent         State
0023.762b.0000 192.168.20.29   unknown       -               self           Assoc
0025.bc07.0000 192.168.20.23   unknown       -               self           Assoc

ap1231-1>
ap1231-1>
