# Class: idrac_config
# ========================================
# idrac_config is a module to configure basic settings for the OOB-idrac interface.
# ========================================

class idrac_config (
$ensure      = 'present',
$hostname		 = $::hostname,
$racname		 = "idrac-${::hostname}",
$dhcp			   = 1,
$staticip		 = $idrac_config::params::staticip,
$netmask		 = $idrac_config::params::netmask,
$gateway		 = $idrac_config::params::gateway,
$pridns			 = $idrac_config::params::pridns,
$secdns			 = $idrac_config::params::secdns,
$scriptpath  = $idrac_config::params::scriptpath, 
$idracversion = $idrac_config::params::idracversion,
$allsoftware =  [ 'srvadmin-idrac7', 'srvadmin-idrac', 'srvadmin-racadm5', 'srvadmin-racadm4' ]
) inherits idrac_config::params {
   if $::manufacturer == 'Dell Inc.' and $ensure=='present' {
   
#This makes sure that the idrac-inventory script is in place and that it has a cron-job running every sixth hour
     file { "$scriptpath/idrac_inventory.sh":
       ensure =>  file,
        owner =>  'root',
        group =>  'root',
         mode =>  '0744',
      content =>  template('idrac_config/idrac_inventory.erb'),
   }

     file { "$scriptpath/idrac_delay.sh":
        ensure =>   file,
         owner =>   'root',
         group =>   'root',
          mode =>   '0744',
       content =>   template('idrac_config/idrac_delay.erb'),
   }

     cron { 'idrac-inventory':
      command => "$scriptpath/idrac_inventory.sh",
      user    => 'root',
      hour    => '6',
      minute  => '0',
   }
     if $idracversion == 'all' {

        package { $allsoftware:
         ensure => 'installed',
       }
     }

     elsif $idracversion == '4' {
       package { 'srvadmin-racadm4':
         ensure => 'installed'
       }
     }

	 elsif $idracversion == '5' {
       package { 'srvadmin-racadm5':
         ensure => 'installed'
       }
     }
	 
	 elsif $idracversion == '6' {
       package { 'srvadmin-idrac':
         ensure => 'installed'
       }
     }
	 elsif $idracversion == '7' {
       package { 'srvadmin-idrac7':
         ensure => 'installed'
       }
     }
#Changing all necessary parameters unless they are what we want them to be. That is if DHCP is not set to TRUE.

if $dhcp != '1' {
  exec {'setstatic':
  command => 'racadm config -g cfgLanNetworking -o cfgNicUseDHCP 0',
  path    => '/opt/dell/srvadmin/sbin/',
  before  => EXEC['setip'],
  } 
  exec {'setracname':
  command => "racadm config -g cfgLanNetworking -o cfgDNSRacName ${racname}",
  path    => '/opt/dell/srvadmin/sbin/',
  before  => EXEC['setdhcp'],
  }
   
  if $staticip != $::idrac_staticip {
   exec {'setip':
   command => "racadm config -g cfgLanNetworking -o cfgNicIpAddress ${staticip}",
   path    => '/opt/dell/srvadmin/sbin/',
   before  => EXEC['setmask'],
   }
  }
  if $netmask != $::idrac_netmask {
   exec {'setmask':
   command => "racadm config -g cfgLanNetworking -o cfgNicNetmask ${netmask}",
    path   => '/opt/dell/srvadmin/sbin/',
    before => EXEC['setgw'],
   }
  } 
  if $gateway != $::idrac_gateway {
   exec {'setgw':
   command => "racadm config -g cfgLanNetworking -o cfgNicGateway ${gateway}",
   path    => '/opt/dell/srvadmin/sbin/',      
   before  => EXEC['setpridns'],
   }
  }
  if $pridns != $::idrac_dns1 {
   exec {'setpridns':
   command => "racadm config -g cfgLanNetworking -o cfgDNSServer1 ${pridns}",
   path    => '/opt/dell/srvadmin/sbin/',
   before  => EXEC['setsecdns'],
   }
  }
  if $secdns != $::idrac_dns2 {
   exec {'setsecdns':
   command => "racadm config -g cfgLanNetworking -o cfgDNSServer1 ${secdns}",  
   path    => '/opt/dell/srvadmin/sbin/',
   before  => EXEC['racrestart'],
   }
  }
  exec { 'racrestart':
   command => "racadm racreset",
   path    => '/opt/dell/srvadmin/sbin/',
   before  => EXEC['idrac-inventory'],
  }
  exec { 'idrac-inventory':
   command => "$scriptpath/idrac_delay.sh 3m $scriptpath/idrac_inventory.sh",
  }
}
elsif $dhcp == '1' and  $racname != $::idrac_hostname {
  exec {'setracname':
   command => "racadm config -g cfgLanNetworking -o cfgDNSRacName ${racname}",
   path    => '/opt/dell/srvadmin/sbin/',
   before  => EXEC['racrestart'],
   }
  exec {'racrestart':
   command => "racadm racreset",
   path    => '/opt/dell/srvadmin/sbin/',
   before  =>   EXEC['idrac-inventory'],
   }
  exec { 'idrac-inventory':
   command =>  "$scriptpath/idrac_delay.sh 3m $scriptpath/idrac_inventory.sh",
   } 
  }
 }
elsif $ensure == 'absent' {
  package { $allsoftware:
   ensure =>  'absent',
  }
  file { "$scriptpath/idrac_inventory.sh":
   ensure =>   absent,
  }
  file { "$scriptpath/idrac_delay.sh":
   ensure =>    absent,
  }
 }
}
