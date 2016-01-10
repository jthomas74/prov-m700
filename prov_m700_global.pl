#!/usr/bin/perl
# Author : THOMAS Jonathan
# Date : 05/01/2015
# prov-m700-global.pl

use strict;
#use warnings;
use Getopt::Long;

my $ask_help = undef;
my $ask_version = undef;
my $version = "1.0";
my $PROGNAME=$0;
#
# Fichier de parametres pmy la generation de la configuration
my $file_gen = undef;
my $generate = undef;
my $generate_ldap = undef;
my $send = undef;
my $IP = undef;

GetOptions(
	"help"	=> \$ask_help,
	"v"	=> \$ask_version,
	"filegen|fg=s"	=> \$file_gen,
	"gs"	=> \$generate,
	"gl"	=> \$generate_ldap,
	"s"	=> \$send,
	"IP|H=s" => \$IP
);

# Appel de la fonction pour la verification des options
sub check_options {

##### Check Si l'aide est demandee #####
if (defined($ask_help)) { print_help();};

##### Check Si la version du plugin est demandee #####
if (defined($ask_version)) { show_versioninfo();};

##### Check si l'option Generate a ete passee en argument
if (defined($generate) && !defined($file_gen)) {print "\n ### Please provide an option in order to generate a xml configuration file! ###\n"; print_usage();};
#&& (!defined($ask_help)

##### Check Si un fichier a ete passe en parametre pour la generation
if (defined($generate_ldap) && !defined($file_gen))  {print "\n ### Please provide a parameter file in order to generate the xml configuration file! ###\n"; print_usage();};
#&& (!defined($ask_help)

##### Check Si un fichier a ete passe en parametre pour la generation
if (defined($generate_ldap) && !defined($file_gen)) {print "\n ### Please provide a parameter file in order to generate the xml configuration file! ###\n"; print_usage();};

##### Check si un fichier a ete passe en parametre pmy l envoie de la configuration
if (defined($send) && !defined($IP)) {print "\n ### Please provide the DECT Gateway IP Address! ###\n"; print_usage();};

}

### Appel des fonctions globales ###
check_options();

# Lecture du fichier de parametres et mise en variable
open (FILE, "<$file_gen" );

my $alias_temp = <FILE>;
my ($alias) = $alias_temp =~ /alias=(.+)/;

my $macaddress_temp = <FILE>;
my ($macaddress) = $macaddress_temp =~ /macaddress=(.+)/;

my $ipaddress_temp = <FILE>;
my ($ipaddress) = $ipaddress_temp =~ /ipaddress=(.+)/;

my $httpuser_temp = <FILE>;
my ($httpuser) = $httpuser_temp =~ /httpuser=(.+)/;

my $httppass_temp = <FILE>;
my ($httppass) = $httppass_temp =~ /httppass=(.+)/;

my $ntpserver_temp = <FILE>;
my ($ntpserver) = $ntpserver_temp =~ /ntpserver=(.+)/;

my $vlan_temp = <FILE>;
my ($vlan) = $vlan_temp =~ /vlan=(.+)/;

my $dhcp_temp = <FILE>;
my ($dhcp) = $dhcp_temp =~ /dhcp=(.+)/;

my $basename_temp = <FILE>;
my ($basename) = $basename_temp =~ /basename=(.+)/;

my $tone_temp = <FILE>;
my ($tone) = $tone_temp =~ /tone=(.+)/;

my $language_temp = <FILE>;
my ($language) = $language_temp =~ /language=(.+)/;

my $ldap_temp = <FILE>;
my ($ldap) = $ldap_temp =~ /ldap=(.+)/;

my $ldapname_temp = <FILE>;
my ($ldapname) = $ldapname_temp =~ /ldapname=(.+)/;

my $ldapport_temp = <FILE>;
my ($ldapport) = $ldapport_temp =~ /ldapport=(.+)/;

my $ldapou_temp = <FILE>;
my ($ldapou) = $ldapou_temp =~ /ldapou=(.+)/;

my $ldapuser_temp = <FILE>;
my ($ldapuser) = $ldapuser_temp =~ /ldapuser=(.+)/;

my $ldappass_temp = <FILE>;
my ($ldappass) = $ldappass_temp =~ /ldappass=(.+)/;

my $ldapattributes_temp = <FILE>;
my ($ldapattributes) = $ldapattributes_temp =~ /ldapattributes=(.+)/;

my $phonebooklocation_temp = <FILE>;
my ($phonebooklocation) = $phonebooklocation_temp =~ /phonebooklocation=(.+)/;

my $gateway_temp = <FILE>;
my ($gateway) = $gateway_temp =~ /gateway=(.+)/;

my $netmask_temp = <FILE>;
my ($netmask) = $netmask_temp =~ /netmask=(.+)/;

my $accode_temp = <FILE>;
my ($accode) = $accode_temp =~ /accode=(.+)/;

my $serveridx_temp = <FILE>;
my ($serveridx) = $serveridx_temp =~ /serveridx=(.+)/;

my $server_temp = <FILE>;
my ($server) = $server_temp =~ /server=(.+)/;

my $firmwareserver_temp = <FILE>;
my ($firmwareserver) = $firmwareserver_temp =~ /firmwareserver=(.+)/;

my $firmwareversion_temp = <FILE>;
my ($firmwareversion) = $firmwareversion_temp =~ /firmwareversion=(.+)/;

# Variable d etat
my $state_on = "on";
my $state_off = "off";

close (FILE);


my $conf_firm = "m700-$macaddress-firmware.xml";


# Fonction de generation de conf avec ldap
sub generate_ldap {

my $conf_dect = "m700-global-ldap-$macaddress.xml";

# Construction du fichier de configuration de la borne
open (FILE, ">$conf_dect" );
chmod 0777, $conf_dect;
# Entete XML
print FILE "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
# Config Generale
print FILE "<settings>\n";
print FILE "<global>\n";
print FILE "<web_inputs_allowed>on</web_inputs_allowed>\n";
print FILE "<pnp_config>on</pnp_config>\n";
print FILE "<dhcp_option_pnp>on</dhcp_option_pnp>\n";
print FILE "<setting_server></setting_server>\n";
print FILE "<management_upload_script>/CfgUpload</management_upload_script>\n";
print FILE "<ip_adr>$ipaddress</ip_adr>\n";
print FILE "<http_user>$httpuser</http_user>\n";
print FILE "<http_pass>$httppass</http_pass>\n";
print FILE "<auto_dect_register>on</auto_dect_register>\n";
print FILE "<syslog_server></syslog_server>\n";
print FILE "<ntp_server>$ntpserver</ntp_server>\n";
print FILE "<ntp_refresh_timer>3600</ntp_refresh_timer>\n";
print FILE "<vlan_id>$vlan</vlan_id>\n";
print FILE "<dhcp>$dhcp</dhcp>\n";
print FILE "<phone_name>$basename</phone_name>\n";
print FILE "<min_jittbuf_depth>2</min_jittbuf_depth>\n";
print FILE "<max_jittbuf_depth>7</max_jittbuf_depth>\n";
print FILE "<rtp_port_start>50004</rtp_port_start>\n";
print FILE "<rtp_port_end>50043</rtp_port_end>\n";
print FILE "<tone_scheme>$tone</tone_scheme>\n";
print FILE "<timezone_by_country_region>off</timezone_by_country_region>\n";
print FILE "<dst_by_country_region>on</dst_by_country_region>\n";
print FILE "<dst_enable>auto</dst_enable>\n";
print FILE "<dst_fixed_day_enable>on</dst_fixed_day_enable>\n";
print FILE "<dst_start_month>3</dst_start_month>\n";
print FILE "<dst_start_date>0</dst_start_date>\n";
print FILE "<dst_start_time>2</dst_start_time>\n";
print FILE "<dst_start_day_of_week>1</dst_start_day_of_week>\n";
print FILE "<dst_start_wday_last_in_month>5</dst_start_wday_last_in_month>\n";
print FILE "<dst_stop_month>10</dst_stop_month>\n";
print FILE "<dst_stop_date>0</dst_stop_date>\n";
print FILE "<dst_stop_time>2</dst_stop_time>\n";
print FILE "<dst_stop_day_of_week>1</dst_stop_day_of_week>\n";
print FILE "<dst_stop_wday_last_in_month>5</dst_stop_wday_last_in_month>\n";
print FILE "<timezone>FRA+1</timezone>\n";
print FILE "<web_language>$language</web_language>\n";
print FILE "<language></language>\n";
print FILE "<ldap_name_attributes>$ldapname</ldap_name_attributes>\n";
print FILE "<ldap_search_filter></ldap_search_filter>\n";
print FILE "<ldap_server>$ldap</ldap_server>\n";
print FILE "<ldap_port>$ldapport</ldap_port>\n";
print FILE "<ldap_base>$ldapou</ldap_base>\n";
print FILE "<ldap_username>$ldapuser</ldap_username>\n";
print FILE "<ldap_password>$ldappass</ldap_password>\n";
print FILE "<ldap_number_attributes>$ldapattributes</ldap_number_attributes>\n";
print FILE "<phonebook_filename></phonebook_filename>\n";
print FILE "<phonebook_location></phonebook_location>\n";
print FILE "<phonebook_reload_time>0</phonebook_reload_time>\n";
print FILE "<phonebook_server_location>$phonebooklocation</phonebook_server_location>\n";
print FILE "<stun_server></stun_server>\n";
print FILE "<stun_binding_interval>90</stun_binding_interval>\n";
print FILE "<sip_stun_bindtime_determine>on</sip_stun_bindtime_determine>\n";
print FILE "<sip_stun_bindtime_guard>80</sip_stun_bindtime_guard>\n";
print FILE "<dns_server1>0.0.0.0</dns_server1>\n";
print FILE "<dns_server2>0.0.0.0</dns_server2>\n";
print FILE "<sip_use_different_ports>off</sip_use_different_ports>\n";
print FILE "<voip_sip_auto_upload>off</voip_sip_auto_upload>\n";
print FILE "<network_sip_log_server></network_sip_log_server>\n";
print FILE "<sip_conf_key_dtmf_string></sip_conf_key_dtmf_string>\n";
print FILE "<sip_r_key_dtmf_string></sip_r_key_dtmf_string>\n";
print FILE "<vlan_qos>0</vlan_qos>\n";
print FILE "<codec_tos>160</codec_tos>\n";
print FILE "<signaling_tos>160</signaling_tos>\n";
print FILE "<gateway>$gateway</gateway>\n";
print FILE "<netmask>$netmask</netmask>\n";
print FILE "<network_id_port>5060</network_id_port>\n";
print FILE "<network_vlan_synchronization>on</network_vlan_synchronization>\n";
print FILE "<dialplan_enabled>off</dialplan_enabled>\n";
print FILE "<dialplan_maxlength>0</dialplan_maxlength>\n";
print FILE "<dialplan_prefix>\"</dialplan_prefix>\n";
print FILE "<rtp_collision_control>off</rtp_collision_control>\n";
print FILE "<network_sntp_broadcast_enable>on</network_sntp_broadcast_enable>\n";
print FILE "<enable_rport_rfc3581>on</enable_rport_rfc3581>\n";
print FILE "<tls_server_authentication>off</tls_server_authentication>\n";
print FILE "<log_level>6</log_level>\n";
print FILE "<ac_code>$accode</ac_code>\n";
print FILE "<country_region_id>0</country_region_id>\n";
print FILE "</global>\n";
#Config Server
print FILE "<server>\n";
print FILE "<srv_sip_server_alias idx=\"$serveridx\">$alias</srv_sip_server_alias>";
print FILE "<user_srtp idx=\"$serveridx\">off</user_srtp>\n";
print FILE "<user_host idx=\"$serveridx\">$server</user_host>\n";
print FILE "<srv_sip_show_ext_name_in_hs idx=\"$serveridx\">on</srv_sip_show_ext_name_in_hs>\n";
print FILE "<srv_sip_enable_blind_transfer idx=\"$serveridx\">on</srv_sip_enable_blind_transfer>\n";
print FILE "<keepalive_interval idx=\"$serveridx\">on</keepalive_interval>\n";
print FILE "<timer_support idx=\"$serveridx\">on</timer_support>\n";
print FILE "<session_timer idx=\"$serveridx\">3600</session_timer>\n";
print FILE "<srv_sip_signal_tcp_port idx=\"$serveridx\">on</srv_sip_signal_tcp_port>\n";
print FILE "<srv_sip_use_one_tcp_conn_per_ext idx=\"$serveridx\">off</srv_sip_use_one_tcp_conn_per_ext>\n";
print FILE "<user_outbound idx=\"$serveridx\">$server</user_outbound>\n";
print FILE "<conferencing idx=\"$serveridx\"></conferencing>\n";
print FILE "<srv_srtp_auth idx=\"$serveridx\">off</srv_srtp_auth>\n";
print FILE "<user_full_sdp_answer idx=\"$serveridx\">off</user_full_sdp_answer>\n";
print FILE "<srv_sip_rtp_base_equal idx=\"$serveridx\">disabled</srv_sip_rtp_base_equal>\n";
print FILE "<srv_sip_ua_data_server_nat_adaption idx=\"$serveridx\">enabled</srv_sip_ua_data_server_nat_adaption>\n";
print FILE "<srv_dtmf_payload_type idx=\"$serveridx\">101</srv_dtmf_payload_type>\n";
print FILE "<user_hold_inactive idx=\"$serveridx\">off</user_hold_inactive>\n";
print FILE "<srv_sip_transport idx=\"$serveridx\">udp</srv_sip_transport>\n";
print FILE "<user_dtmf_info idx=\"$serveridx\">sip_info_only</user_dtmf_info>\n";
print FILE "<codec_size idx=\"$serveridx\">20</codec_size>\n";
print FILE "<codec_priority_list idx=\"$serveridx\">pcmu, pcma, g722</codec_priority_list>\n";
print FILE "<user_auth_tag idx=\"$serveridx\">on</user_auth_tag>\n";
print FILE "<user_expiry idx=\"$serveridx\">3600</user_expiry>\n";
print FILE "<srv_att_transfer_2nd_call_on_hold idx=\"$serveridx\">on</srv_att_transfer_2nd_call_on_hold>\n";
print FILE "</server>\n";
#Repeater
print FILE "<repeater>\n";
print FILE "</repeater>\n";
#Multicell
print FILE "<multicell>\n";
print FILE "<network_auto_multi_primary>off</network_auto_multi_primary>\n";
print FILE "<network_allow_multi_primary>off</network_allow_multi_primary>\n";
print FILE "<network_sync_chain_id>512</network_sync_chain_id>\n";
print FILE "<network_sync_enable>off</network_sync_enable>\n";
print FILE "<network_roaming_deregister>off</network_roaming_deregister>\n";
print FILE "<network_sync_data_transport>multicast</network_sync_data_transport>\n";
print FILE "<network_dect_auto_sync_tree_config>on</network_dect_auto_sync_tree_config>\n";
print FILE "<network_sync_time>60</network_sync_time>\n";
print FILE "<network_sync_max_sip_reg_per_base>8</network_sync_max_sip_reg_per_base>\n";
print FILE "<network_sync_primary_static_ip>0.0.0.0</network_sync_primary_static_ip>\n";
print FILE "<network_sync_debug_enable>off</network_sync_debug_enable>\n";
print FILE "</multicell>\n";
print FILE "</settings>\n";

sleep 2;

close (FILE);
}


# Fonction de generation de conf sans ldap

sub generate {

my $conf_dect = "m700-global-$macaddress.xml";

# Construction du fichier de configuration de la borne
open (FILE, ">$conf_dect" );
chmod 0777, $conf_dect;
# Entete XML
print FILE "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
# Config Generale
print FILE "<settings>\n";
print FILE "<global>\n";
print FILE "<web_inputs_allowed>on</web_inputs_allowed>\n";
print FILE "<pnp_config>on</pnp_config>\n";
print FILE "<dhcp_option_pnp>on</dhcp_option_pnp>\n";
print FILE "<setting_server></setting_server>\n";
print FILE "<management_upload_script>/CfgUpload</management_upload_script>\n";
print FILE "<ip_adr>$ipaddress</ip_adr>\n";
print FILE "<http_user>$httpuser</http_user>\n";
print FILE "<http_pass>$httppass</http_pass>\n";
print FILE "<auto_dect_register>on</auto_dect_register>\n";
print FILE "<syslog_server></syslog_server>\n";
print FILE "<ntp_server>$ntpserver</ntp_server>\n";
print FILE "<ntp_refresh_timer>3600</ntp_refresh_timer>\n";
print FILE "<vlan_id>$vlan</vlan_id>\n";
print FILE "<dhcp>$dhcp</dhcp>\n";
print FILE "<phone_name>$basename</phone_name>\n";
print FILE "<min_jittbuf_depth>2</min_jittbuf_depth>\n";
print FILE "<max_jittbuf_depth>7</max_jittbuf_depth>\n";
print FILE "<rtp_port_start>50004</rtp_port_start>\n";
print FILE "<rtp_port_end>50043</rtp_port_end>\n";
print FILE "<tone_scheme>$tone</tone_scheme>\n";
print FILE "<timezone_by_country_region>off</timezone_by_country_region>\n";
print FILE "<dst_by_country_region>on</dst_by_country_region>\n";
print FILE "<dst_enable>auto</dst_enable>\n";
print FILE "<dst_fixed_day_enable>on</dst_fixed_day_enable>\n";
print FILE "<dst_start_month>3</dst_start_month>\n";
print FILE "<dst_start_date>0</dst_start_date>\n";
print FILE "<dst_start_time>2</dst_start_time>\n";
print FILE "<dst_start_day_of_week>1</dst_start_day_of_week>\n";
print FILE "<dst_start_wday_last_in_month>5</dst_start_wday_last_in_month>\n";
print FILE "<dst_stop_month>10</dst_stop_month>\n";
print FILE "<dst_stop_date>0</dst_stop_date>\n";
print FILE "<dst_stop_time>2</dst_stop_time>\n";
print FILE "<dst_stop_day_of_week>1</dst_stop_day_of_week>\n";
print FILE "<dst_stop_wday_last_in_month>5</dst_stop_wday_last_in_month>\n";
print FILE "<timezone>FRA+1</timezone>\n";
print FILE "<web_language>$language</web_language>\n";
print FILE "<language></language>\n";
print FILE "<phonebook_filename></phonebook_filename>\n";
print FILE "<phonebook_location></phonebook_location>\n";
print FILE "<phonebook_reload_time>0</phonebook_reload_time>\n";
print FILE "<phonebook_server_location>$phonebooklocation</phonebook_server_location>\n";
print FILE "<stun_server></stun_server>\n";
print FILE "<stun_binding_interval>90</stun_binding_interval>\n";
print FILE "<sip_stun_bindtime_determine>on</sip_stun_bindtime_determine>\n";
print FILE "<sip_stun_bindtime_guard>80</sip_stun_bindtime_guard>\n";
print FILE "<dns_server1>0.0.0.0</dns_server1>\n";
print FILE "<dns_server2>0.0.0.0</dns_server2>\n";
print FILE "<sip_use_different_ports>off</sip_use_different_ports>\n";
print FILE "<voip_sip_auto_upload>off</voip_sip_auto_upload>\n";
print FILE "<network_sip_log_server></network_sip_log_server>\n";
print FILE "<sip_conf_key_dtmf_string></sip_conf_key_dtmf_string>\n";
print FILE "<sip_r_key_dtmf_string></sip_r_key_dtmf_string>\n";
print FILE "<vlan_qos>0</vlan_qos>\n";
print FILE "<codec_tos>160</codec_tos>\n";
print FILE "<signaling_tos>160</signaling_tos>\n";
print FILE "<gateway>$gateway</gateway>\n";
print FILE "<netmask>$netmask</netmask>\n";
print FILE "<network_id_port>5060</network_id_port>\n";
print FILE "<network_vlan_synchronization>on</network_vlan_synchronization>\n";
print FILE "<dialplan_enabled>off</dialplan_enabled>\n";
print FILE "<dialplan_maxlength>0</dialplan_maxlength>\n";
print FILE "<dialplan_prefix>\"</dialplan_prefix>\n";
print FILE "<rtp_collision_control>off</rtp_collision_control>\n";
print FILE "<network_sntp_broadcast_enable>on</network_sntp_broadcast_enable>\n";
print FILE "<enable_rport_rfc3581>on</enable_rport_rfc3581>\n";
print FILE "<tls_server_authentication>off</tls_server_authentication>\n";
print FILE "<log_level>6</log_level>\n";
print FILE "<ac_code>$accode</ac_code>\n";
print FILE "<country_region_id>0</country_region_id>\n";
print FILE "</global>\n";
#Config Server
print FILE "<server>\n";
print FILE "<srv_sip_server_alias idx=\"$serveridx\">$alias</srv_sip_server_alias>";
print FILE "<user_srtp idx=\"$serveridx\">off</user_srtp>\n";
print FILE "<user_host idx=\"$serveridx\">$server</user_host>\n";
print FILE "<srv_sip_show_ext_name_in_hs idx=\"$serveridx\">on</srv_sip_show_ext_name_in_hs>\n";
print FILE "<srv_sip_enable_blind_transfer idx=\"$serveridx\">on</srv_sip_enable_blind_transfer>\n";
print FILE "<keepalive_interval idx=\"$serveridx\">on</keepalive_interval>\n";
print FILE "<timer_support idx=\"$serveridx\">on</timer_support>\n";
print FILE "<session_timer idx=\"$serveridx\">3600</session_timer>\n";
print FILE "<srv_sip_signal_tcp_port idx=\"$serveridx\">on</srv_sip_signal_tcp_port>\n";
print FILE "<srv_sip_use_one_tcp_conn_per_ext idx=\"$serveridx\">off</srv_sip_use_one_tcp_conn_per_ext>\n";
print FILE "<user_outbound idx=\"$serveridx\">$server</user_outbound>\n";
print FILE "<conferencing idx=\"$serveridx\"></conferencing>\n";
print FILE "<srv_srtp_auth idx=\"$serveridx\">off</srv_srtp_auth>\n";
print FILE "<user_full_sdp_answer idx=\"$serveridx\">off</user_full_sdp_answer>\n";
print FILE "<srv_sip_rtp_base_equal idx=\"$serveridx\">disabled</srv_sip_rtp_base_equal>\n";
print FILE "<srv_sip_ua_data_server_nat_adaption idx=\"$serveridx\">enabled</srv_sip_ua_data_server_nat_adaption>\n";
print FILE "<srv_dtmf_payload_type idx=\"$serveridx\">101</srv_dtmf_payload_type>\n";
print FILE "<user_hold_inactive idx=\"$serveridx\">off</user_hold_inactive>\n";
print FILE "<srv_sip_transport idx=\"$serveridx\">udp</srv_sip_transport>\n";
print FILE "<user_dtmf_info idx=\"$serveridx\">sip_info_only</user_dtmf_info>\n";
print FILE "<codec_size idx=\"$serveridx\">20</codec_size>\n";
print FILE "<codec_priority_list idx=\"$serveridx\">pcmu, pcma, g722</codec_priority_list>\n";
print FILE "<user_auth_tag idx=\"$serveridx\">on</user_auth_tag>\n";
print FILE "<user_expiry idx=\"$serveridx\">3600</user_expiry>\n";
print FILE "<srv_att_transfer_2nd_call_on_hold idx=\"$serveridx\">on</srv_att_transfer_2nd_call_on_hold>\n";
print FILE "</server>\n";
#Repeater
print FILE "<repeater>\n";
print FILE "</repeater>\n";
#Multicell
print FILE "<multicell>\n";
print FILE "<network_auto_multi_primary>off</network_auto_multi_primary>\n";
print FILE "<network_allow_multi_primary>off</network_allow_multi_primary>\n";
print FILE "<network_sync_chain_id>512</network_sync_chain_id>\n";
print FILE "<network_sync_enable>off</network_sync_enable>\n";
print FILE "<network_roaming_deregister>off</network_roaming_deregister>\n";
print FILE "<network_sync_data_transport>multicast</network_sync_data_transport>\n";
print FILE "<network_dect_auto_sync_tree_config>on</network_dect_auto_sync_tree_config>\n";
print FILE "<network_sync_time>60</network_sync_time>\n";
print FILE "<network_sync_max_sip_reg_per_base>8</network_sync_max_sip_reg_per_base>\n";
print FILE "<network_sync_primary_static_ip>0.0.0.0</network_sync_primary_static_ip>\n";
print FILE "<network_sync_debug_enable>off</network_sync_debug_enable>\n";
print FILE "</multicell>\n";
print FILE "</settings>\n";

sleep 2;

close (FILE);
}


# fonction pour la generation de la configuration firmware
sub gen_firmware {

# Construction du fichier de configuration firmware de la borne
open (FILE, ">$conf_firm" );
chmod 0777, $conf_firm;

# Entete XML
print FILE "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
#Firmware settings
print FILE "<firmware-settings>\n";
print FILE "<firmware>$firmwareserver</firmware>\n";
print FILE "<fp_fwu_sw_version>$firmwareversion</fp_fwu_sw_version>\n";
print FILE "<pp_fwu_sw_version type=M65>$firmwareversion</pp_fwu_sw_version>\n";
print FILE "</firmware-settings>\n";

close (FILE);

}


sub send_conf {

#qx(/etc/init.d/isc-dhcp-server restart);

#sleep 1;

system "curl -u $httpuser:$httppass -sS --form \"Settings=\@$conf_firm\" http://$IP/UploadSettings.html >/dev/null";

#Reboot de la borne
qx(wget --user $httpuser --password $httppass http://$IP/reboot.html > /dev/null 2>&1);
qx(rm reboot.html);

}


sub print_help {
    print "##############################################\n";
    print "#    Copyright (c) 2016 THOMAS Jonathan      #\n";
    print "##############################################\n";
	print_usage();
	print "\n";
}

sub print_usage {
	print "\nUsage:\n";
    print "$PROGNAME\n";
   	print "-h = Help\n";
	print "-v = Version\n";
	print "-fg or -filegen = parameter file used to generate xml configuration file\n";
	print "-gs = select the function to generate the xml configuration file without ldap settings\n";
	print "-gl = select the function to generate the xml configuration file with ldap settings\n";
	print "-s = select the function to send the xml configuration file to the DECT Gateway\n";
	print "-H or -IP = DECT Gateway IP\n";
	print "\n";
	print "##########################################################################################\n";
  	print "# Exemple : ./m700-prov-extensions.pl -g -fg DECT1.txt 				   	 #\n";
	print "#	./m700-prov-extensions.pl -s -fg conf_global.txt -H 10.10.10.10			 #\n";
    print "##########################################################################################\n";
}

sub show_versioninfo {
	print "$PROGNAME\n";
	print "Version : $version\n";
}



# Execution des fonctions globales
if (defined($generate)) {
	gen_firmware();
	generate();
}


if (defined($generate_ldap)) {
	gen_firmware();
	generate_ldap();
}

if (defined($send) && defined($IP)) {
	send_conf();
}
