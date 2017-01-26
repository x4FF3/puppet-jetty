##
# 
define jetty::instance(
  String $path = $title
  ) {

  File {
    owner => $::jetty::user,
    group => $::jetty::group,
    mode  => '0775'
  }

  file { [
    $path,
    "${path}/lib",
    "${path}/lib/logging",
    "${path}/resources",
    "${path}/modules",
    "${path}/webapps"
    ]:
    ensure => directory,
  } ->
  file { "${path}/modules/logging.conf":
    ensure => present,
    source => 'puppet:///modules/jetty/logging.mod',
  } ->
  file { "${path}/resources/jetty-logging.properties":
    ensure => present,
    source => 'puppet:///modules/jetty/jetty-logging.properties',
  } ->
  file { "${path}/resources/log4j.properties":
    ensure  => present,
    content => epp('jetty/log4j.properties.epp'),
  }

  archive { "${path}/lib/logging/slf4-api-1.6.6.jar":
    ensure  => present,
    extract => false,
    source  => 'http://central.maven.org/maven2/org/slf4j/slf4j-api/1.6.6/slf4j-api-1.6.6.jar',
  }

  archive { "${path}/lib/logging/slf4-log4j2-1.6.6.jar":
    ensure  => present,
    extract => false,
    source  => 'http://central.maven.org/maven2/org/slf4j/slf4j-log4j12/1.6.6/slf4j-log4j12-1.6.6.jar',
  }

  archive { "${path}/lib/logging/log4j-1.2.17.jar":
    ensure  => present,
    extract => false,
    source  => 'http://central.maven.org/maven2/log4j/log4j/1.2.17/log4j-1.2.17.jar',
  }
}
