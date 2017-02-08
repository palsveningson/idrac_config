class idrac_config::activedirectory inherits ::idrac_config { 

$AD_Enable                   = '0'
$AD_AuthTimeout              = '120'
$AD_CertValidationEnable     = 'Disabled'
$AD_Schema                   = '2'
$AD_DCLookupByUserDomain     = 'Disabled'
$AD_DCLookupDomainName       = 'UNDEF'
$AD_DCLookupEnable           = 'Disabled'
$AD_DC1                      = 'UNDEF'
$AD_DC2                      = 'UNDEF'
$AD_DC3                      = 'UNDEF'
$AD_GCLookupEnable           = 'Disabled'
$AD_GCRootDomain             = 'UNDEF'
$AD_GC1                      = 'UNDEF'
$AD_GC2                      = 'UNDEF'
$AD_GC3                      = 'UNDEF'
$AD_RacDomain                = 'UNDEF'
$AD_Racname                  = 'UNDEF'
$AD_SSOEnable                = 'Disabled'

$AD_G1Name                  = 'UNDEF'
$AD_G1Dom                   = 'UNDEF'
$AD_G1Priv                  = 'UNDEF'

$AD_G2Name                  = 'UNDEF'
$AD_G2Dom                   = 'UNDEF'
$AD_G2Priv                  = 'UNDEF'

$AD_G3Name                  = 'UNDEF'
$AD_G3Dom                   = 'UNDEF'
$AD_G3Priv                  = 'UNDEF'

$AD_G4Name                  = 'UNDEF'
$AD_G4Dom                   = 'UNDEF'
$AD_G4Priv                  = 'UNDEF'

$AD_G5Name                  = 'UNDEF'
$AD_G5Dom                   = 'UNDEF'
$AD_G5Priv                  = 'UNDEF'
}

if $::manufacturer == 'Dell Inc.' and $ensure == 'present' and $ad == '1' {
  if $::idrac_ad != 'Enabled' {
    exec {'enable_ad':
      command => "racadm set idrac.activedirectory.enable enabled",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_authtimeout']
    }
  }
  if $AD_AuthTimeout != $::idrac_ad_AuthTimeout {
    exec {'set_authtimeout':
      command => "racadm set idrac.activedirectory.authtimeout $AD_Authtimeout",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_CertValidation'],
    }
  }

  if $AD_CertValidationEnable != $::idrac_ad_CertValidationEnable {
    exec {'set_CertValidation':
      command => "racadm set idrac.activedirectory.CertValidationEnable $AD_CertValidationEnable",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_adschema'],
    }
  }

  if $AD_Schema != $::idrac_Schema {
    exec {'set_adschema':
      command => "racadm set idrac.activedirectory.schema 2 $AD_Schema",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_dc1'],
    }
  }

  if $AD_DC1 != $::idrac_ad_DomainController1 {
    exec {'set_dc1':
      command => "racadm set idrac.activedirectory.DomainController1 $AD_DC1",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_dc2'],
    }
  }

  if $AD_DC2 != $::idrac_ad_DomainController2 {
    exec {'set_dc2':
      command => "racadm set idrac.activedirectory.DomainController2 $AD_DC2",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_dc3'],
    }
  }

  if $AD_DC3 != $::idrac_ad_DomainController3 {
    exec {'set_dc3':
      command => "racadm set idrac.activedirectory.DomainController3 $AD_DC3",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_gce'],
    }
  }

  if $AD_GCLookupEnable != $::idrac_ad_gclookupenable {
    exec {'set_gce':
      command => "racadm set idrac.activedirectory.GCLookupEnable $AD_GCLookupEnable",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['nextcommand'],
    }
  }



  if $AD_GC1 != $::idrac_ad_GlobalCatalog1 {
    exec {'set_gc1':
      command => "racadm set idrac.activedirectory.GlobalCatalog1 '$AD_GC1",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_gc1'],
    }
  }

  if $AD_GC2 != $::idrac_ad_GlobalCatalog2 {
    exec {'set_gc2':
      command => "racadm set idrac.activedirectory.GlobalCatalog2 $AD_GC2",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_gc3'],
    }
  }

  if $AD_GC3 != $::idrac_ad_GlobalCatalog3 {
    exec {'set_gc3':
      command => "racadm set idrac.activedirectory.GlobalCatalog3 $AD_GC3",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_sso'],
    }
  }

  if $AD_SSOEnable != $::idrac_ad_SSOEnable {
    exec {'set_sso':
      command => "racadm set idrac.activedirectory.SSOEnable $AD_SSOEnable",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_dclookup'],
    }
  }

  if $AD_DCLookupEnable != $::idrac_ad_DCLookupEnable {
    exec {'set_dclookup':
      command => "racadm set idrac.activedirectory.DCLookupEnable $AD_DCLookupEnable",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_udlookup'],
    }
  }

  if $AD_DCLookupByUserDomain != $::idrac_ad_DCLookupByUserDomain {
    exec {'set_udlookup':
      command => "racadm set idrac.activedirectory.DCLookupByUserDomain $AD_DCLookupByUserDomain",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_dnlookup'],
    }
  }

  if $AD_DCLookupDomainName != $::idrac_ad_DCLookupDomainName {
    exec {'set_dnlookup':
      command => "racadm set idrac.activedirectory.DCLookupDomainName $AD_DCLookupDomainName",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_gcroot'],
    }
  }

  if $AD_GCRootDomain != $::idrac_ad_GCRootDomain {
    exec {'set_gcroot':
      command => "racadm set idrac.activedirectory.GCRootDomain $AD_GCRootDomain",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_racdom'],
    }
  }
  if $AD_RacDomain != $::idrac_ad_RacDomain {
    exec {'set_racdom':
      command => "racadm set idrac.activedirectory.RacDomain $AD_RacDomain",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_racname'],
    }
  }

  if $AD_Racname != $::idrac_ad_RacName {
    exec {'set_racname':
      command => "racadm set idrac.activedirectory.RacName $AD_Racname",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_gcroot'],
    }
  }


  if defined($::idrac_ad_grp1_Name) and $AD_G1Name  != $::idrac_ad_grp1_Name {
    exec {'set_adgrp1':
      command => "racadm get idrac.adgroup.1.name $AD_G1Name",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_addom1'],
    }
  }
  if defined($::idrac_ad_grp1_Domain) and $AD_G1Dom  != $::idrac_ad_grp1_Domain {
    exec {'set_addom1':
      command => "racadm get idrac.adgroup.1.domain $AD_G1Dom",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_adpri1'],
    }
  }
  if defined($::idrac_ad_grp1_Privilege) and $AD_G1Priv  != $::idrac_ad_grp1_Privilege {
    exec {'set_adpri1':
      command => "racadm get idrac.adgroup.1.privilege $AD_G1Priv",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_adgrp2'],
    }
  }


  if defined($::idrac_ad_grp2_Name) and $AD_G2Name  != $::idrac_ad_grp2_Name {
    exec {'set_adgrp2':
      command => "racadm get idrac.adgroup.2.name $AD_G2Name",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_addom2'],
    }
  }
   if defined($::idrac_ad_grp2_Domain) and $AD_G2Dom  != $::idrac_ad_grp2_Domain {
    exec {'set_addom2':
      command => "racadm get idrac.adgroup.2.domain $AD_G2Dom",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_adpri2'],
    }
   }
   if defined($::idrac_ad_grp2_Privilege) and $AD_G2Priv  != $::idrac_ad_grp2_Privilege {
    exec {'set_adpri2':
      command => "racadm get idrac.adgroup.2.privilege $AD_G2Priv",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_adgrp3'],
    }
  }


  if defined($::idrac_ad_grp3_Name) and $AD_G3Name  != $::idrac_ad_grp3_Name  {
    exec {'set_adgrp3':
      command => "racadm get idrac.adgroup.3.name $AD_G3Name",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_addom3'],
    }
  }
   if defined($::idrac_ad_grp3_Domain) and $AD_G3Dom  != $::idrac_ad_grp3_Domain {
    exec {'set_addom3':
      command => "racadm get idrac.adgroup.3.domain $AD_G3Dom",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_adpri3'],
    }
   }
   if defined($::idrac_ad_grp3_Privilege) and $AD_G3Priv  != $::idrac_ad_grp3_Privilege {
    exec {'set_adpri3':
      command => "racadm get idrac.adgroup.3.privilege $AD_G3Priv",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_adgrp4'],
    }
  }


  if defined($::idrac_ad_grp4_Name) and $AD_G4Name  != $::idrac_ad_grp4_Name  {
    exec {'set_adgrp4':
      command => "racadm get idrac.adgroup.4.name $AD_G4Name",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_addom4'],
    }
  }
   if defined($::idrac_ad_grp4_Domain) and $AD_G4Dom  != $::idrac_ad_grp4_Domain {
    exec {'set_addom4':
      command => "racadm get idrac.adgroup.4.domain $AD_G4Dom",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_adpri4'],
    }
   }
   if defined($::idrac_ad_grp4_Privilege) and $AD_G4Priv  != $::idrac_ad_grp4_Privilege {
    exec {'set_adpri4':
      command => "racadm get idrac.adgroup.4.privilege $AD_G4Priv",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_adgrp5'],
    }
  }


  if defined($::idrac_ad_grp5_Name) and $AD_G5Name  != $::idrac_ad_grp5_Name  {
    exec {'set_adgrp5':
      command => "racadm get idrac.adgroup.5.name $AD_G5Name",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_addom5'],
    }
  }
   if defined($::idrac_ad_grp5_Domain) and $AD_G5Dom  != $::idrac_ad_grp5_Domain {
    exec {'set_addom5':
      command => "racadm get idrac.adgroup.5.domain $AD_G5Dom",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_adpri5'],
    }
   }
   if defined($::idrac_ad_grp5_Privilege) and $AD_G5Priv  != $::idrac_ad_grp5_Privilege {
    exec {'set_adpri5':
      command => "racadm get idrac.adgroup.5.privilege $AD_G1Priv",
      path    => '/opt/dell/srvadmin/sbin/',
      before  => EXEC['set_adgrp5'],
    }
  }
}
