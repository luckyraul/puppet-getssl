# == Class: getssl
# === Parameters

class getssl (
  String $account_mail,
  String $script_source  = $getssl::params::script_source,
  String $config_path    = $getssl::params::config_path,
  String $exec_path      = $getssl::params::exec_path,
  Boolean $manage_cron   = $getssl::params::manage_cron,

  Hash $domains          = {},
  Hash $domains_defaults = { require => Class['getssl::install'] },

) inherits getssl::params {
  anchor { 'getssl::begin': }
  -> class { 'getssl::install': }
  -> anchor { 'getssl::end': }

  create_resources('getssl::resources::domain', $domains, $domains_defaults)
}
