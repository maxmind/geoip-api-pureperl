package Geo::IP::PurePerl;

use strict;
use vars qw(@ISA $VERSION @EXPORT);

use constant COUNTRY_BEGIN => 16776960;
use constant RECORD_LENGTH => 3;

$VERSION = '1.10';

require Exporter;
@ISA = qw(Exporter);

sub GEOIP_STANDARD(){0;}
sub GEOIP_MEMORY_CACHE(){1;}

@EXPORT = qw( GEOIP_STANDARD GEOIP_MEMORY_CACHE );

my @countries = (undef,"AP","EU","AD","AE","AF","AG","AI","AL","AM","AN","AO","AQ","AR","AS","AT","AU","AW","AZ","BA","BB","BD","BE","BF","BG","BH","BI","BJ","BM","BN","BO","BR","BS","BT","BV","BW","BY","BZ","CA","CC","CD","CF","CG","CH","CI","CK","CL","CM","CN","CO","CR","CU","CV","CX","CY","CZ","DE","DJ","DK","DM","DO","DZ","EC","EE","EG","EH","ER","ES","ET","FI","FJ","FK","FM","FO","FR","FX","GA","GB","GD","GE","GF","GH","GI","GL","GM","GN","GP","GQ","GR","GS","GT","GU","GW","GY","HK","HM","HN","HR","HT","HU","ID","IE","IL","IN","IO","IQ","IR","IS","IT","JM","JO","JP","KE","KG","KH","KI","KM","KN","KP","KR","KW","KY","KZ","LA","LB","LC","LI","LK","LR","LS","LT","LU","LV","LY","MA","MC","MD","MG","MH","MK","ML","MM","MN","MO","MP","MQ","MR","MS","MT","MU","MV","MW","MX","MY","MZ","NA","NC","NE","NF","NG","NI","NL","NO","NP","NR","NU","NZ","OM","PA","PE","PF","PG","PH","PK","PL","PM","PN","PR","PS","PT","PW","PY","QA","RE","RO","RU","RW","SA","SB","SC","SD","SE","SG","SH","SI","SJ","SK","SL","SM","SN","SO","SR","ST","SV","SY","SZ","TC","TD","TF","TG","TH","TJ","TK","TM","TN","TO","TP","TR","TT","TV","TW","TZ","UA","UG","UM","US","UY","UZ","VA","VC","VE","VG","VI","VN","VU","WF","WS","YE","YT","YU","ZA","ZM","ZR","ZW","A1","A2");
my @code3s = ( undef,"AP","EU","AND","ARE","AFG","ATG","AIA","ALB","ARM","ANT","AGO","AQ","ARG","ASM","AUT","AUS","ABW","AZE","BIH","BRB","BGD","BEL","BFA","BGR","BHR","BDI","BEN","BMU","BRN","BOL","BRA","BHS","BTN","BV","BWA","BLR","BLZ","CAN","CC","COD","CAF","COG","CHE","CIV","COK","CHL","CMR","CHN","COL","CRI","CUB","CPV","CX","CYP","CZE","DEU","DJI","DNK","DMA","DOM","DZA","ECU","EST","EGY","ESH","ERI","ESP","ETH","FIN","FJI","FLK","FSM","FRO","FRA","FX","GAB","GBR","GRD","GEO","GUF","GHA","GIB","GRL","GMB","GIN","GLP","GNQ","GRC","GS","GTM","GUM","GNB","GUY","HKG","HM","HND","HRV","HTI","HUN","IDN","IRL","ISR","IND","IO","IRQ","IRN","ISL","ITA","JAM","JOR","JPN","KEN","KGZ","KHM","KIR","COM","KNA","PRK","KOR","KWT","CYM","KAZ","LAO","LBN","LCA","LIE","LKA","LBR","LSO","LTU","LUX","LVA","LBY","MAR","MCO","MDA","MDG","MHL","MKD","MLI","MMR","MNG","MAC","MNP","MTQ","MRT","MSR","MLT","MUS","MDV","MWI","MEX","MYS","MOZ","NAM","NCL","NER","NFK","NGA","NIC","NLD","NOR","NPL","NRU","NIU","NZL","OMN","PAN","PER","PYF","PNG","PHL","PAK","POL","SPM","PCN","PRI","PSE","PRT","PLW","PRY","QAT","REU","ROM","RUS","RWA","SAU","SLB","SYC","SDN","SWE","SGP","SHN","SVN","SJM","SVK","SLE","SMR","SEN","SOM","SUR","STP","SLV","SYR","SWZ","TCA","TCD","TF","TGO","THA","TJK","TKL","TLS","TKM","TUN","TON","TUR","TTO","TUV","TWN","TZA","UKR","UGA","UM","USA","URY","UZB","VAT","VCT","VEN","VGB","VIR","VNM","VUT","WLF","WSM","YEM","YT","YUG","ZAF","ZMB","ZR","ZWE","A1","A2");
my @names = (undef,"Asia/Pacific Region","Europe","Andorra","United Arab Emirates","Afghanistan","Antigua and Barbuda","Anguilla","Albania","Armenia","Netherlands Antilles","Angola","Antarctica","Argentina","American Samoa","Austria","Australia","Aruba","Azerbaijan","Bosnia and Herzegovina","Barbados","Bangladesh","Belgium","Burkina Faso","Bulgaria","Bahrain","Burundi","Benin","Bermuda","Brunei Darussalam","Bolivia","Brazil","Bahamas","Bhutan","Bouvet Island","Botswana","Belarus","Belize","Canada","Cocos (Keeling) Islands","Congo, The Democratic Republic of the","Central African Republic","Congo","Switzerland","Cote D'Ivoire","Cook Islands","Chile","Cameroon","China","Colombia","Costa Rica","Cuba","Cape Verde","Christmas Island","Cyprus","Czech Republic","Germany","Djibouti","Denmark","Dominica","Dominican Republic","Algeria","Ecuador","Estonia","Egypt","Western Sahara","Eritrea","Spain","Ethiopia","Finland","Fiji","Falkland Islands (Malvinas)","Micronesia, Federated States of","Faroe Islands","France","France, Metropolitan","Gabon","United Kingdom","Grenada","Georgia","French Guiana","Ghana","Gibraltar","Greenland","Gambia","Guinea","Guadeloupe","Equatorial Guinea","Greece","South Georgia and the South Sandwich Islands","Guatemala","Guam","Guinea-Bissau","Guyana","Hong Kong","Heard Island and McDonald Islands","Honduras","Croatia","Haiti","Hungary","Indonesia","Ireland","Israel","India","British Indian Ocean Territory","Iraq","Iran, Islamic Republic of","Iceland","Italy","Jamaica","Jordan","Japan","Kenya","Kyrgyzstan","Cambodia","Kiribati","Comoros","Saint Kitts and Nevis",
"Korea, Democratic People's Republic of","Korea, Republic of","Kuwait","Cayman Islands","Kazakhstan","Lao People's Democratic Republic","Lebanon","Saint Lucia","Liechtenstein","Sri Lanka","Liberia","Lesotho","Lithuania","Luxembourg","Latvia","Libyan Arab Jamahiriya","Morocco","Monaco","Moldova, Republic of","Madagascar","Marshall Islands","Macedonia, the Former Yugoslav Republic of","Mali","Myanmar","Mongolia","Macau","Northern Mariana Islands","Martinique","Mauritania","Montserrat","Malta","Mauritius","Maldives","Malawi","Mexico","Malaysia","Mozambique","Namibia","New Caledonia","Niger","Norfolk Island","Nigeria","Nicaragua","Netherlands","Norway","Nepal","Nauru","Niue","New Zealand","Oman","Panama","Peru","French Polynesia","Papua New Guinea","Philippines","Pakistan","Poland","Saint Pierre and Miquelon","Pitcairn","Puerto Rico","Palestinian Territory, Occupied","Portugal","Palau","Paraguay","Qatar","Reunion","Romania","Russian Federation","Rwanda","Saudi Arabia","Solomon Islands","Seychelles","Sudan","Sweden","Singapore","Saint Helena","Slovenia","Svalbard and Jan Mayen","Slovakia","Sierra Leone","San Marino","Senegal","Somalia","Suriname","Sao Tome and Principe","El Salvador","Syrian Arab Republic","Swaziland","Turks and Caicos Islands","Chad","French Southern Territories","Togo","Thailand","Tajikistan","Tokelau","Turkmenistan","Tunisia","Tonga","East Timor","Turkey","Trinidad and Tobago","Tuvalu","Taiwan, Province of China","Tanzania, United Republic of","Ukraine","Uganda","United States Minor Outlying Islands","United States","Uruguay","Uzbekistan","Holy See (Vatican City State)","Saint Vincent and the Grenadines","Venezuela","Virgin Islands, British","Virgin Islands, U.S.","Vietnam","Vanuatu","Wallis and Futuna","Samoa","Yemen","Mayotte","Yugoslavia","South Africa","Zambia","Zaire","Zimbabwe",
"Anonymous Proxy","Satellite Provider");

sub open {
  die "Geo::IP::PurePerl::open() requires a path name"
    unless( @_ > 1 and $_[1] );
  my ($class, $db_file, $flags) = @_;
  my $fh;
  CORE::open $fh, "$db_file" or die "Error opening $db_file";
  binmode($fh);
  if ($flags && $flags & GEOIP_MEMORY_CACHE == 1) {
    my $buf;
    local($/) = undef;
    $buf = <$fh>;
    bless {buf => $buf}, $class;
  } else {
    bless {fh => $fh}, $class;
  }
}

sub new {
  my ($class, $db_file, $flags) = @_;
  # this will be less messy once deprecated new( $path, [$flags] )
  # is no longer supported (that's what open() is for)
  if ( !defined $db_file ) {
    # called as new()
    $db_file = '/usr/local/share/GeoIP/GeoIP.dat';
  } elsif ( $db_file eq '1'  or  $db_file eq '0' ) {
    # called as new( $flags )
    $flags = $db_file;
    $db_file = '/usr/local/share/GeoIP/GeoIP.dat';
  } # else called as new( $database_filename, [$flags] );

  $class->open( $db_file, $flags );
}

sub country_code_by_addr {
  my ($gi, $ip_address) = @_;
  return unless $ip_address =~ m!^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$!;
  return $countries[$gi->_seek_country(addr_to_num($ip_address))];
}

sub country_code3_by_addr {
  my ($gi, $ip_address) = @_;
  return unless $ip_address =~ m!^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$!;
  return $code3s[$gi->_seek_country(addr_to_num($ip_address))];
}

sub country_name_by_addr {
  my ($gi, $ip_address) = @_;
  return unless $ip_address =~ m!^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$!;
  return $names[$gi->_seek_country(addr_to_num($ip_address))];
}

sub _seek_country {
  my ($gi, $ipnum) = @_;

  my $fh  = $gi->{fh};
  my $buf = $gi->{buf};
  my $offset = 0;

  my ($x0, $x1);

  for (my $depth = 31; $depth >= 0; $depth--) {
    if ($fh) {
      seek $fh, $offset * 2 * RECORD_LENGTH, 0;
      read $fh, $x0, RECORD_LENGTH;
      read $fh, $x1, RECORD_LENGTH;
    } else {
      $x0 = substr($buf, $offset * 2 * RECORD_LENGTH, RECORD_LENGTH);
      $x1 = substr($buf, $offset * 2 * RECORD_LENGTH + RECORD_LENGTH, RECORD_LENGTH);
    }

    $x0 = unpack("I1", $x0."\0");
    $x1 = unpack("I1", $x1."\0");

    if ($ipnum & (1 << $depth)) {
      if ($x1 >= COUNTRY_BEGIN) {
        return $x1 - COUNTRY_BEGIN;
      }
      $offset = $x1;
    } else {
      if ($x0 >= COUNTRY_BEGIN) {
        return $x0 - COUNTRY_BEGIN;
      }
      $offset = $x0;
    }
  }

  print STDERR "Error Traversing Database for ipnum = $ipnum - Perhaps database is corrupt?";
}

sub country_code_by_name {
  my ($gi, $host) = @_;
  my $country_id = $gi->country_id_by_name($host);
  return $countries[$country_id];
}

sub country_code3_by_name {
  my ($gi, $host) = @_;
  my $country_id = $gi->country_id_by_name($host);
  return $code3s[$country_id];
}

sub country_name_by_name {
  my ($gi, $host) = @_;
  my $country_id = $gi->country_id_by_name($host);
  return $names[$country_id];
}

sub country_id_by_name {
  my ($gi, $host) = @_;
  my $ip_address;
  if ($host =~ m!^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$!) {
    $ip_address = $host;
  } else {
    $ip_address = join('.',unpack('C4',(gethostbyname($host))[4]));
  }
  return unless $ip_address;
  return $gi->_seek_country(addr_to_num($ip_address));
}

sub addr_to_num {
  my @a = split('\.',$_[0]);
  return $a[0]*16777216+$a[1]*65536+$a[2]*256+$a[3];
}

1;
__END__

=head1 NAME

Geo::IP::PurePerl - Look up country by IP Address

=head1 SYNOPSIS

  use Geo::IP::PurePerl;

  my $gi = Geo::IP::PurePerl->new(GEOIP_STANDARD);

  # look up IP address '65.15.30.247'
  my $country = $gi->country_code_by_addr('65.15.30.247');
  $country = $gi->country_code_by_name('yahoo.com');
  # $country is equal to "US"

=head1 DESCRIPTION

This module uses a file based database.  This database simply contains
IP blocks as keys, and countries as values.  This database is  more
complete and accurate than reverse DNS lookups.

This module can be used to automatically select the geographically closest mirror,
to analyze your web server logs
to determine the countries of your visiters, for credit card fraud
detection, and for software export controls.

Free monthly updates to the database are available from
http://www.maxmind.com/download/geoip/database/

=head1 CLASS METHODS

=over 4

=item $gi = Geo::IP->new( [$flags] );

Constructs a new Geo::IP object with the default database located inside your system's
I<datadir>, typically I</usr/local/share/GeoIP/GeoIP.dat>.

Flags can be set to either GEOIP_STANDARD, or for faster performance
(at a cost of using more memory), GEOIP_MEMORY_CACHE.
The default flag is GEOIP_STANDARD (uses less memory, but runs slower).

=item $gi = Geo::IP->new( $database_filename );

Calling the C<new> constructor in this fashion was was deprecated after version
0.26 in order to make the XS and pure perl interfaces more similar. Use the
C<open> constructor (below) if you need to specify a path. Eventually, this
means of calling C<new> will no longer be supported.

Flags can be set to either GEOIP_STANDARD, or for faster performance
(at a cost of using more memory), GEOIP_MEMORY_CACHE.

=item $gi = Geo::IP->open( $database_filename, [$flags] );

Constructs a new Geo::IP object with the database located at C<$database_filename>.
The default flag is GEOIP_STANDARD (uses less memory, but runs slower).

The database is available for free, updated monthly:

  http://www.maxmind.com/download/geoip/database/

This free database is similar to the database contained in IP::Country,
as well as many paid databases.  It uses ARIN, RIPE, APNIC, and LACNIC
whois to obtain the IP->Country mappings.

If you require greater accuracy, MaxMind offers a Premium database
on a paid subscription basis.

=back

=head1 OBJECT METHODS

=over 4

=item $code = $gi->country_code_by_addr( $ipaddr );

Returns the ISO 3166 country code for an IP address.

=item $code = $gi->country_code_by_name( $ipname );

Returns the ISO 3166 country code for a hostname.

=item $code = $gi->country_code3_by_addr( $ipaddr );

Returns the 3 letter country code for an IP address.

=item $code = $gi->country_code3_by_name( $ipname );

Returns the 3 letter country code for a hostname.

=item $name = $gi->country_name_by_addr( $ipaddr );

Returns the full country name for an IP address.

=item $name = $gi->country_name_by_name( $ipname );

Returns the full country name for a hostname.

=back

=head1 VERSION

1.10

=head1 AUTHOR

Copyright (c) 2002 MaxMind.com

All rights reserved.  This package is free software; it is licensed
under the GPL.

=cut
