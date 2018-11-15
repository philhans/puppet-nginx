class nginx::config (
  String $config_ensure                 = $::nginx::config_ensure,
  String $config_dir                    = $::nginx::config_dir,
  String $config_mode                   = $::nginx::config_mode,
  String $config_owner                  = $::nginx::config_owner,
  String $config_group                  = $::nginx::config_group,
  String $config_confd                  = $::nginx::config_confd,
  String $config_log_dir                = $::nginx::config_log_dir,
  String $config_pid_file               = $::nginx::config_pid_file,
  Optional[String] $config_vdir_enable  = $::nginx::config_vdir_enable,
  String $config_process_user           = $::nginx::config_process_user,
  String $docroot                       = $::nginx::docroot,
) {
  file { 'nginx_conf':
    ensure  => $config_ensure,
    path    => "${config_dir}/nginx.conf",
    mode    => $config_mode,
    owner   => $config_owner,
    group   => $config_group,
    content => template("${module_name}/conf.d/nginx.conf.erb"),
  }
  
  file { $config_log_dir:
    ensure  => directory,
    recurse => true
  }

  file { $docroot:
    ensure  => directory,
    recurse => true,
    mode    => $config_mode,
    owner   => $config_owner,
    group   => $config_group,
  }
}
