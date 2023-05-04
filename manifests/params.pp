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

  case $facts['os']['name'] {
    'Debian': {
      case $facts['os']['distro']['codename'] {
        'buster', 'bullseye', 'bookworm': {}
        default: {
          fail("Unsupported release: ${facts['os']['distro']['codename']}")
        }
      }
    }
    default: {
      fail("Unsupported os: ${facts['os']['name']}")
    }
  }
}
