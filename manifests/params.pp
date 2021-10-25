# == Class: getssl::params
#
#   This class sets all the sufficient default settings
#
class getssl::params {
  $manage_cron = true
  $exec_path = '/usr/local/bin/getssl'
  $config_path = '/etc/getssl'
  $script_source = 'https://raw.githubusercontent.com/srvrco/getssl/v2.45/getssl'

  $ca = 'https://acme-v02.api.letsencrypt.org'
  $reload_cmd = 'systemctl reload nginx'
  $chain = 'ISRG Root X1'

  case $::operatingsystem {
      'Debian': {
          case $::lsbdistcodename {
              'stretch', 'buster', 'bullseye': {

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
