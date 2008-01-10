#!/usr/bin/perl

use strict;

my $old_country;
my $old_region;
my $had_region;

open(FILE,"timezone.txt");
my $str = <FILE>;

print "sub  GeoIP_time_zone_by_country_and_region { \n";
print 'my $country = shift;' . "\n";
print 'my $region = shift;' . "\n";
print 'my $timezone;';

while ($str = <FILE>) {
  $str =~ s!\s*$!!; 
  my ($country,$region,$timezone) = split("\t",$str);
  if ($country ne $old_country) {
    if ($had_region) {
      print "    }\n";
      $had_region = "";
      $old_region = "";
    }
    if ($old_country ne "") {
      print "  } elsif (". '$' ."country eq " . qq(") . $country . qq(") . ") {\n";
    } else {
      print "    if (" . '$' . "country eq " . qq(") . $country . qq(") . ") {\n";
    }
  }
  if ($region ne "") {
    $had_region = 1;
    if ($old_region ne "") {
      print "    } elsif (" . '$' . "region eq " . qq(") . $region . qq(") . ") {\n  ";
    } else {
      print "    if (" . '$' . "region eq " . qq(") . $region . qq(") . ") {\n  ";
    }
  } elsif ($old_region ne "") {
    print "      } else {\n  ";
  }
  print '      $timezone = ' . qq(") . $timezone . qq(") . ";\n";
  $old_country = $country;
  $old_region = $region;
}
print "  }\n";
print '  return $timezone;' . "\n";
print "}\n";

close(FILE);


