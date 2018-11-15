define nginx::vhost (
  Integer $port                        = 80,
  String $priority                     = '50',
  String $server_aliases               = '',
  Boolean $enable                      = true,
  String $config_owner                 = $::nginx::config_owner,
  String $config_group                 = $::nginx::config_group,
  String $config_mode                  = $::nginx::config_mode,
  Optional[String] $config_vdir_enable = $::nginx::config_vdir_enable,
  String $config_log_dir               = $::nginx::config_log_dir,
  String $vhost_dir                    = $::nginx::vhost_dir,
) {
  file { "${vhost_dir}/${priority}-${name}.conf":
    ensure  => file,
    content => template("${module_name}/vhost/vhost.conf.erb"),
    mode    => $config_mode,
    owner   => $config_owner,
    group   => $config_group,
    notify  => Service['nginx_service'],
  }
}
