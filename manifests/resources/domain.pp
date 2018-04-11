# define: getssl::resources::domain
define getssl::resources::domain (
  String $domain  = $name,
  String $confdir = $getssl::config_path,
  )
{
  file { "${confdir}/${domain}":
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0644',
  }
}
