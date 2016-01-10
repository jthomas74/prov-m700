#!/usr/bin/perl
# Author : THOMAS Jonathan
# Date : 05/01/2015
# prov-m700-extensions.pl

use strict;
use warnings;
use Getopt::Long;

my $ask_help = undef;
my $ask_version = undef;
my $version = "1.0";
my $PROGNAME=$0;
#
# Fichier de parametres pour la generation de la configuration
our $file_gen = undef;
#
# Fichier de configuration xml a envoyer a la borne
our $file_send = undef;
#
my $generate = undef;
my $send = undef;
our $user = undef;
our $password = undef;
our $IP = undef;

GetOptions(
	"help"	=> \$ask_help,
	"v"	=> \$ask_version,
	"filegen|fg=s"	=> \$file_gen,
	"filesend|fs=s"	=> \$file_send,
	"g"	=> \$generate,
	"s"	=> \$send,
	"U=s"	=> \$user,
	"P=s"	=> \$password,
	"IP|H=s" => \$IP
);

sub check_options {

##### Check Si l'aide est demandee #####
if (defined($ask_help)) { print_help();};

##### Check Si la version du plugin est demandee #####
if (defined($ask_version)) { show_versioninfo();};

##### Check Si un fichier a ete passe en parametre pour la generation
if (defined($generate) && !defined($file_gen)) {print "\n ### Please provide a parameter file in order to generate the xml configuration file! ###\n"; print_usage();};

##### Check si un fichier a ete passe en parametre pour l envoie de la configuration
if (defined($send) && !defined($file_send)) {print "\n ### Please provide a xml configuration file in order to load the configuration! ###\n"; print_usage();};

##### Check pour le login et mot de passe de la borne DECT
if (defined($send) && !defined($user)) {print "\n ### Please provide authentification information! ###\n";};

##### Check pour le login et mot de passe de la borne DECT
if (defined($send) && !defined($password)) {print "\n ### Please provide authentification information! ###\n";};

}

check_options();

if (defined($generate)) {
	generate();
}

if (defined($send)) {
	send_conf();
}


######### OK #########
sub send_conf {

open (FILE, "<$password" );

my $pass_temp = <FILE>;
my ($pass) = $pass_temp =~ /pass=(.+)/;

close (FILE);

#Envoi de la configuration du DECT
system "curl -u $user:$pass -sS --form \"Settings=\@$file_send\" http://$IP/UploadSettings.html >/dev/null";

}


######### OK #########
sub generate {

open (FILE, "<$file_gen" );

#my $prov_temp = <FILE>;
#my ($prov) = $prov_temp =~ /prov=(\d+)/;

my $idx_temp = <FILE>;
my ($idx) = $idx_temp =~ /idx=(.+)/;

my $sip_line_temp = <FILE>;
my ($sip_line) = $sip_line_temp =~ /sipline=(.+)/;

my $sip_pass_temp = <FILE>;
my ($sip_pass) = $sip_pass_temp =~ /sippass=(.+)/;

my $mailbox_temp = <FILE>;
my ($mailbox) = $mailbox_temp =~ /mailbox=(\*\w+)/;

my $ac_code_temp = <FILE>;
my ($ac_code) = $ac_code_temp =~ /accode=(.+)/;

my $ipei_temp = <FILE>;
my ($ipei) = $ipei_temp =~ /ipei=(.+)/;

my $name_temp = <FILE>;
my ($name) = $name_temp =~ /name=(.+)/;

# Variable d etat
my $state_on = "on";
my $state_off = "off";

close (FILE);

# Construction du fichier de configuration de la borne
my $conf_dect = "dect-$sip_line-$idx.xml";

# Ouverture du fichier
open (FILE, ">$conf_dect" );
chmod 0777, $conf_dect;

# Entete XML
print FILE "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";

# Extensions
print FILE "<extension>\n";
print FILE "<user_name idx=\"$idx\">$sip_line</user_name>\n";
print FILE "<user_realname idx=\"$idx\">$name</user_realname>\n";
print FILE "<user_pname idx=\"$idx\">$sip_line</user_pname>\n";
print FILE "<user_pass idx=\"$idx\">$sip_pass</user_pass>\n";
print FILE "<user_active idx=\"$idx\">$state_on</user_active>\n";
print FILE "<fwd_all_enabled idx=\"$idx\">$state_off</fwd_all_enabled>\n";
print FILE "<fwd_all_target idx=\"$idx\"></fwd_all_target>\n";
print FILE "<fwd_time_enabled idx=\"$idx\">$state_off</fwd_time_enabled>\n";
print FILE "<fwd_time_target idx=\"$idx\"></fwd_time_target>\n";
print FILE "<fwd_busy_enabled idx=\"$idx\">$state_off</fwd_busy_enabled>\n";
print FILE "<fwd_busy_target idx=\"$idx\"></fwd_busy_target>\n";
print FILE "<fwd_time_secs idx=\"$idx\">90</fwd_time_secs>\n";
print FILE "<subscr_sip_hs_idx idx=\"$idx\">$idx</subscr_sip_hs_idx>\n";
print FILE "<subscr_sip_line_name idx=\"$idx\">$sip_line</subscr_sip_line_name>\n";
print FILE "<subscr_sip_ua_data_server_id idx=\"$idx\">1</subscr_sip_ua_data_server_id>\n";
print FILE "<user_mailbox idx=\"$idx\"></user_mailbox>\n";
print FILE "<subscr_dect_ipui idx=\"$idx\">$ipei</subscr_dect_ipui>\n";
print FILE "<subscr_ua_data_emergency_number idx=\"$idx\"></subscr_ua_data_emergency_number>\n";
print FILE "<subscr_ua_data_emergency_line idx=\"$idx\">255</subscr_ua_data_emergency_line>\n";
print FILE "<subscr_sip_ua_use_base idx=\"$idx\">255</subscr_sip_ua_use_base>\n";
print FILE "<subscr_sip_ua_pref_outg_sip_id idx=\"$idx\"></subscr_sip_ua_pref_outg_sip_id>\n";
print FILE "<call_waiting idx=\"$idx\">$state_on</call_waiting>\n";
print FILE "<subscr_sip_pincode_dialout idx=\"$idx\"></subscr_sip_pincode_dialout>\n";
print FILE "<subscr_dect_ac_code idx=\"$idx\">$ac_code</subscr_dect_ac_code>\n";
print FILE "<user_mailnumber idx=\"$idx\">$mailbox</user_mailnumber>\n";
print FILE "</extension>";
close (FILE);
}


######### OK #########
sub print_help {
    print "##############################################\n";
    print "#    Copyright (c) 2016 THOMAS Jonathan      #\n";
    print "##############################################\n";
	print_usage();
	print "\n";
}

######### OK #########
sub print_usage {
	print "\nUsage:\n";
    print "$PROGNAME\n";
   	print "-h = Help\n";
	print "-v = Version\n";
	print "-fg or -filegen = parameter file used to generate xml configuration file\n";
	print "-fs or -filesend = xml configuration file used to send configuration to the DECT Gateway\n";
	print "-g = select the function to generate the xml configuration file\n";
	print "-s = select the function to send the xml configuration file to the DECT Gateway\n";
	print "-U or -user = provide username of the DECT Gateway used to connect to the webpage\n";
	print "-P or -password = provide the password file containing the DECT Gateway password used to connect to the webpage\n";
	print "-H or -IP = DECT Gateway IP\n";
	print "\n";
	print "##########################################################################################\n";
  	print "# Exemple : ./m700-prov-extensions.pl -g -fg DECT1.txt 				   	 #\n";
	print "#	./m700-prov-extensions.pl -s -fs DECT1.xml -U admin -P m700-pass -H 10.10.10.10  #\n";
    	print "##########################################################################################\n";
}

######### OK #########
sub show_versioninfo {
	print "$PROGNAME\n";
	print "Version : $version\n";
}
