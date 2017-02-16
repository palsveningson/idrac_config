#Class to handle all parameter default values for static IP

class idrac_config::params  { 
$scriptpath     = '/usr/local/sbin'
$idracversion   = 'all'
$staticip       = '192.168.0.1'
$netmask        = '255.255.255.0'
$gateway        = '192.168.0.254'
$pridns         = '8.8.8.8'
$secdn          = '8.8.8.8'

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
