#!/usr/bin/env perl
=head1 NAME

=head1 SYNOPSIS

=head1 DESCRIPTION

=head AUTHOR

=cut

package searchMacOUI;

use strict;
use warnings;
use Carp;
use Net::MAC::Vendor;

open(FH, "macaddr.txt") or croak();
my @content = <FH>;
close(FH);

my %vendors=();

foreach (@content)
{
  chomp;
  my $mac = $_;

  my $macoui = $mac;
  if($macoui =~ /^[0-9a-fA-F]{12,}/){
     $macoui =~ s/\.//g;
     $macoui =~ s/.{2}/$&:/g;
     chop($macoui);
  }
  my $vendor = (Net::MAC::Vendor::lookup($macoui))[0][0]; 
  printf("%s (%s)\n", $macoui, $vendor);
  $vendors{$vendor}++;
}

foreach (sort keys %vendors){
  printf("%s: %d\n", $_, $vendors{$_});
}

__END__
