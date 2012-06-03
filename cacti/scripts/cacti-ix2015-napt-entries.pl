#!/usr/bin/perl
=head1 NAME

IX2015 napt entries

=head1 SYNOPSIS

cacti-ix2015-napt-entries.pl <hostname> <userid> <password> (<debug>) 

=head1 DESCRIPTION

reading IX2015 NAPT Entries via telnet

=head AUTHOR

Akira KUMAGAI <kuma _at_ ultrasync _dot_ net>

=cut


use strict;
use warnings;
use Net::Telnet;

use Data::Dumper;


my $host   = $ARGV[0] || "";
my $userid = $ARGV[1] || "admin";
my $passwd = $ARGV[2] || "";
my $debug  = $ARGV[3] ? 1:undef;

my $command = "show ip napt transl";

my $start  = 'Interface: FastEthernet0\/0.1';
my $search = '^NAPT Cache \- ([0-9]+) entry, [0-9]+ free, ([0-9]+) peak, [0-9]+ create, ([0-9]+) overflow';
my @names = ("entry", "peak", "overflow");
my @values;



if(@ARGV < 3){
  die("Usage: $0 <hostname|ip_address> <userid> <passwd>\n");
}


my $telnet = Net::Telnet->new(
  Timeout   => 2,
  Prompt    => '/(?m:^[\w.-]+\s?(?:\((dhcp-config|config)[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)/',
#  Input_log => "./input.txt",
);

$telnet->max_buffer_length(20485760);
$telnet->open($host);
$telnet->waitfor("/login: /i");
$telnet->print($userid);

$telnet->waitfor("/Password: /i");
$telnet->print($passwd);

$telnet->waitfor("/# /");
$telnet->print("en");

# % You may use `svintr-config' command with administrator privilege.
eval{
  $telnet->waitfor('/svintr-config/');
  $telnet->print("svintr-config");
};

$telnet->waitfor("/# /");
$telnet->print("terminal length 0");

$telnet->waitfor('/\(config\)# /');
my @lines = $telnet->cmd($command);

sleep(1);

$telnet->print("exit");
$telnet->print("exit");

$telnet->waitfor("/# /");
$telnet->close;


my $skip = 1;
my @result;
foreach(@lines)
{
 if($skip && /$start/){ $skip = 0;}
 
 if(!$skip && /$search/){
   @values = ($1, $2, $3);
   print STDERR if $debug;
 }
}

warn Dumper @values if $debug;

my $cacti_readable = undef;
for(my $i=0; $names[$i]; $i++){
  $cacti_readable .= sprintf("%s:%s ", $names[$i], $values[$i]);
}

print $cacti_readable;

