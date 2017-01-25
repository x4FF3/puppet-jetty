define jetty::instance(
  String $path = $title
  ) {

  $_logging_module_configuration = "${path}/modules/logging.conf"

  File {
    owner => $::jetty::user,
    group => $::jetty::group,
    mode  => '0775'
  }

  file { $_logging_module_configuration:
    ensure => present,
    source => 'puppet:///modules/jetty/logging.mod',
  } ->
  file { [
    $path,
    "${path}/lib",
    "${path}/resources",
    "${path}/modules",
    "${path}/webapps"
    ]:
    ensure => directory,
  }
}

