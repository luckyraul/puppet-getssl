# == Class: getssl::params
#
#   This class sets all the sufficient default settings
#
class getssl::install(
  $source  = $getssl::script_source,
  $confdir = $getssl::config_path,
  $dest    = $getssl::exec_path,
  $cron    = $getssl::manage_cron,
  ) {

  ensure_packages(['curl'], {'ensure' => 'present'})

  Package['curl'] -> archive { $dest:
      ensure => 'present',
      source => $source,
  } -> file { $dest:
      mode   => '0755',
  }

  # Create Base Directories
  file { $confdir:
      ensure => directory,
      owner  => root,
      group  => root,
      mode   => '0644',
  }

  $cron_ensure = $cron ? { true => 'present', default => 'absent' }

  cron { 'getssl_renew':
    ensure  => $cron_ensure,
    command => "${dest} -w ${confdir} -a -q -u",
    user    => 'root',
    hour    => '23',
    minute  => '5',
  }

}
