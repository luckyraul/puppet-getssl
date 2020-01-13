# == Class: getssl::params
#
#   This class sets all the sufficient default settings
#
class getssl::params {
  $manage_cron = true
  $exec_path = '/usr/local/bin/getssl'
  $config_path = '/etc/getssl'
  $script_source = 'https://raw.githubusercontent.com/srvrco/getssl/v2.15/getssl'

  $ca = 'https://acme-v02.api.letsencrypt.org'
  $reload_cmd = 'systemctl reload nginx'

  case $::operatingsystem {
      'Debian': {
          case $::lsbdistcodename {
              'jessie', 'stretch', 'buster': {

              }
              default: {
                  fail("Unsupported release: ${::lsbdistcodename}")
              }
          }
      }
      default: {
          fail("Unsupported os: ${::operatingsystem}")
      }
  }
}
