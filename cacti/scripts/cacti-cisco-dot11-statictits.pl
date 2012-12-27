#!/usr/bin/perl
=head1 NAME

cacti-cisco-dot11.pl


=head1 SYNOPSIS

cacti-cisco-dot11.pl <hostname|ip_address> <community> <snmp_version>


=head1 DESCRIPTION

howto

1. Place this cacti scripts directory, e.g. /var/www/cacti/scripts/

2. Open browser and cacti console

3. Data Input Method -> add
Cisco Aironet dot11 statictics
Script/Command
perl <path_cacti>/scripts/cacti-cisco-dot11-statictits.pl <host> <community> <version>


4. 


=head AUTHOR
Akira KUMAGAI <kuma _at_ ultrasync _dot_ net>

=cut

use strict;
use warnings;
use Net::SNMP;
use Data::Dumper;


my @cDot11Active = (
  "cD11ActiveWlClient1",
  "cD11ActiveWlClient2",
  "cD11ActiveBridges1",
  "cD11ActiveBridges2",
  "cD11ActiveRepeater1",
  "cD11ActiveRepeater2",
);

my @cDot11AssStats = (
  "cD11AscAssoced1",
  "cD11AscAssoced2",
  "cD11AscAuthed1",
  "cD11AscAuthed2",
  "cD11AscRoamedIn1",
  "cD11AscRoamedIn2",
  "cD11AscRoamedAway1",
  "cD11AscRoamedAway2",
  "cD11AscDeauthed1",
  "cD11AscDeauthed2",
  "cD11AscDisassoced1",
  "cD11AscDisassoced2",
);


my @dot11 = (
  "d11TxFragment1",
  "d11TxFragment2",
  "d11MuticastTxFrame1",
  "d11MuticastTxFrame2",
  "d11FailedCount1",
  "d11FailedCount2",
  "d11RetryCount1",
  "d11RetryCount2",
  "d11MultipleRetryCt1",
  "d11MultipleRetryCt2",
  "d11FrameDupCt1",
  "d11FrameDupCt2",
  "d11RTSSuccessCount1",
  "d11RTSSuccessCount2",
  "d11RTSFailureCt1",
  "d11RTSFailureCt2",
  "d11ACKFailureCt1",
  "d11ACKFailureCt2",
  "d11RcvdFragmentCt1",
  "d11RcvdFragmentCt2",
  "d11MtiCstRcvFrgmtC1",
  "d11MtiCstRcvFrgmtC2",
  "d11FCSErrorCount1",
  "d11FCSErrorCount2",
  "d11TxFrames1",
  "d11TxFrames2",
  "d1WEPUnDecryptable1",
  "d1WEPUnDecryptable2",
);

my %mibs = (
  ".1.3.6.1.4.1.9.9.273.1.1.2" => \@cDot11Active,
  ".1.3.6.1.4.1.9.9.273.1.1.3" => \@cDot11AssStats,
  ".1.2.840.10036.2.2.1"       => \@dot11,
  );

if(@ARGV != 3){
  #die("Usage: $0 <hostname|ip_address> <community> <snmp_version>\n");
}

my $hostname  = $ARGV[0] || "aironet";
my $community = $ARGV[1] || "public";
my $version   = $ARGV[2] || "2c";
my $debug     = $ARGV[3] ? 1:undef;

my($snmp, $error) = Net::SNMP->session(
  -hostname  => $hostname,
  -community => $community,
  -version   => $version,
  ) or croak("Net::SNMP->session()\n");


my $cacti_readable = undef;
foreach my $mib(keys %mibs){
 my $oid = $mib;
  for(my $walk=0; $walk<= 50; $walk++){
   my $result = $snmp->get_next_request(-varbindlist => [$oid]) or die($snmp->error);
   if(!defined($mibs{$mib}[$walk])){ last; }
   if($result){
     my $data;
     ($oid, $data) = (%{$result});
     $cacti_readable .= sprintf("%s:%s ", $mibs{$mib}[$walk], $data);
     printf("%s(%s): %s\n", $mibs{$mib}[$walk], $oid, $data) if $debug;
   }
  }
}

print $cacti_readable;


__END__

traffic: COUNTER
exact: GAUGE


CISCO-DOT11-ASSOCIATION-MIB::cDot11ActiveWirelessClients.1 = Gauge32: 1 Device
CISCO-DOT11-ASSOCIATION-MIB::cDot11ActiveWirelessClients.2 = Gauge32: 1 Device
CISCO-DOT11-ASSOCIATION-MIB::cDot11ActiveBridges.1 = Gauge32: 0 Device
CISCO-DOT11-ASSOCIATION-MIB::cDot11ActiveBridges.2 = Gauge32: 0 Device
CISCO-DOT11-ASSOCIATION-MIB::cDot11ActiveRepeaters.1 = Gauge32: 0 Device
CISCO-DOT11-ASSOCIATION-MIB::cDot11ActiveRepeaters.2 = Gauge32: 0 Device

CISCO-DOT11-ASSOCIATION-MIB::cDot11AssStatsAssociated.1 = Counter32: 7 client
CISCO-DOT11-ASSOCIATION-MIB::cDot11AssStatsAssociated.2 = Counter32: 6 client
CISCO-DOT11-ASSOCIATION-MIB::cDot11AssStatsAuthenticated.1 = Counter32: 7 client
CISCO-DOT11-ASSOCIATION-MIB::cDot11AssStatsAuthenticated.2 = Counter32: 6 client
CISCO-DOT11-ASSOCIATION-MIB::cDot11AssStatsRoamedIn.1 = Counter32: 0 client
CISCO-DOT11-ASSOCIATION-MIB::cDot11AssStatsRoamedIn.2 = Counter32: 2 client
CISCO-DOT11-ASSOCIATION-MIB::cDot11AssStatsRoamedAway.1 = Counter32: 0 client
CISCO-DOT11-ASSOCIATION-MIB::cDot11AssStatsRoamedAway.2 = Counter32: 0 client
CISCO-DOT11-ASSOCIATION-MIB::cDot11AssStatsDeauthenticated.1 = Counter32: 6 client
CISCO-DOT11-ASSOCIATION-MIB::cDot11AssStatsDeauthenticated.2 = Counter32: 5 client
CISCO-DOT11-ASSOCIATION-MIB::cDot11AssStatsDisassociated.1 = Counter32: 6 client
CISCO-DOT11-ASSOCIATION-MIB::cDot11AssStatsDisassociated.2 = Counter32: 5 client

IEEE802dot11-MIB::dot11TransmittedFragmentCount.1 = Counter32: 154004
IEEE802dot11-MIB::dot11TransmittedFragmentCount.2 = Counter32: 929290
IEEE802dot11-MIB::dot11MulticastTransmittedFrameCount.1 = Counter32: 72556
IEEE802dot11-MIB::dot11MulticastTransmittedFrameCount.2 = Counter32: 136711
IEEE802dot11-MIB::dot11FailedCount.1 = Counter32: 540272
IEEE802dot11-MIB::dot11FailedCount.2 = Counter32: 65673
IEEE802dot11-MIB::dot11RetryCount.1 = Counter32: 4633
IEEE802dot11-MIB::dot11RetryCount.2 = Counter32: 47653
IEEE802dot11-MIB::dot11MultipleRetryCount.1 = Counter32: 719
IEEE802dot11-MIB::dot11MultipleRetryCount.2 = Counter32: 11548
IEEE802dot11-MIB::dot11FrameDuplicateCount.1 = Counter32: 249
IEEE802dot11-MIB::dot11FrameDuplicateCount.2 = Counter32: 7037
IEEE802dot11-MIB::dot11RTSSuccessCount.1 = Counter32: 66770
IEEE802dot11-MIB::dot11RTSSuccessCount.2 = Counter32: 2216
IEEE802dot11-MIB::dot11RTSFailureCount.1 = Counter32: 1085403
IEEE802dot11-MIB::dot11RTSFailureCount.2 = Counter32: 429006
IEEE802dot11-MIB::dot11ACKFailureCount.1 = Counter32: 8545
IEEE802dot11-MIB::dot11ACKFailureCount.2 = Counter32: 137490
IEEE802dot11-MIB::dot11ReceivedFragmentCount.1 = Counter32: 0
IEEE802dot11-MIB::dot11ReceivedFragmentCount.2 = Counter32: 0
IEEE802dot11-MIB::dot11MulticastReceivedFrameCount.1 = Counter32: 0
IEEE802dot11-MIB::dot11MulticastReceivedFrameCount.2 = Counter32: 0
IEEE802dot11-MIB::dot11FCSErrorCount.1 = Counter32: 9474486
IEEE802dot11-MIB::dot11FCSErrorCount.2 = Counter32: 20682
IEEE802dot11-MIB::dot11TransmittedFrameCount.1 = Counter32: 4150848
IEEE802dot11-MIB::dot11TransmittedFrameCount.2 = Counter32: 4527186
IEEE802dot11-MIB::dot11WEPUndecryptableCount.1 = Counter32: 0
IEEE802dot11-MIB::dot11WEPUndecryptableCount.2 = Counter32: 8
