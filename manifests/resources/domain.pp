# define: getssl::resources::domain
define getssl::resources::domain (
  String $acl,
  String $domain               = $name,
  String $confdir              = $getssl::config_path,
  String $ca                   = $getssl::params::ca,
  String $ssl_cert             = "/etc/ssl/${domain}.crt",
  String $ssl_key              = "/etc/ssl/${domain}.key",
  String $ssl_chain            = "/etc/ssl/${domain}.chain.crt",
  String $ca_cert              = "/etc/ssl/${domain}.ca.crt",
  $ensure                      = 'present',
  Optional[Array] $additional  = [],
  Optional[String] $reload_cmd = $getssl::params::reload_cmd,
  Optional[String] $chain      = $getssl::params::chain,
) {
  if ($ensure != 'absent') {
    file { "${confdir}/${domain}":
      ensure => directory,
      owner  => root,
      group  => root,
      mode   => '0644',
    } -> file { "${confdir}/${domain}/getssl.cfg":
      ensure  => 'file',
      replace => 'no',
      mode    => '0644',
      owner   => root,
      group   => root,
    }

    $defaults = {
      path              => "${confdir}/${domain}/getssl.cfg",
      key_val_separator => '=',
      require           => File["${confdir}/${domain}/getssl.cfg"],
    }

    $sans = empty($additional) ? { true => [], default => $additional }

    $params = { ''             => {
        'CA'                    => $ca,
        'SANS'                  => join($sans, ','),
        'ACL'                   => "('${acl}')",
        'USE_SINGLE_ACL'        => true,
        'PREFERRED_CHAIN'       => "\"${chain}\"",
        'DOMAIN_CERT_LOCATION'  => $ssl_cert,
        'DOMAIN_KEY_LOCATION'   => $ssl_key,
        'DOMAIN_CHAIN_LOCATION' => $ssl_chain,
        'CA_CERT_LOCATION'      => $ca_cert,
        'RELOAD_CMD'            => "\"${reload_cmd}\"",
      },
    }

    inifile::create_ini_settings($params, $defaults)
  } else {
    file { "${confdir}/${domain}":
      ensure  => $ensure,
      recurse => true,
      purge   => true,
      force   => true,
    }
  }
}
