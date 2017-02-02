##
#
define jetty::instance(
  String $path,
  String $log4j_version = '1.2.16',
  String $sf4j_version  = '1.6.6',
  Hash   $logconfig     = {
    level     => 'INFO',
    appenders => ['Console'],
    target    => 'System.out'
  }
  ) {

  include '::jetty'

  File {
    owner => $::jetty::user,
    group => $::jetty::group,
    mode  => '0775'
  }

  file { [
    $path,
    "${path}/logs",
    "${path}/lib",
    "${path}/lib/logging",
    "${path}/resources",
    "${path}/modules",
    "${path}/webapps"
    ]:
    ensure => directory,
  }

  file { "${path}/modules/logging.conf":
    ensure  => present,
    source  => 'puppet:///modules/jetty/logging.mod',
    mode    => '0740',
    require => File["${path}/modules"],
  }

  file { "${path}/resources/jetty-logging.properties":
    ensure  => present,
    source  => 'puppet:///modules/jetty/jetty-logging.properties',
    mode    => '0740',
    require => File["${path}/resources"],
  }

  file { "${path}/resources/log4j.properties":
    ensure  => present,
    content => template('jetty/log4j.properties.erb'),
    mode    => '0740',
    require => File["${path}/resources"],
  }

  archive { "${path}/lib/logging/slf4-api-${sf4j_version}.jar":
    ensure  => present,
    extract => false,
    source  => "${::jetty::mirror}/org/slf4j/slf4j-api/${sf4j_version}/slf4j-api-${sf4j_version}.jar",
    require => File["${path}/lib/logging"],
  }

  archive { "${path}/lib/logging/slf4-log4j2-${sf4j_version}.jar":
    ensure  => present,
    extract => false,
    source  => "${::jetty::mirror}/org/slf4j/slf4j-log4j12/${sf4j_version}/slf4j-log4j12-${sf4j_version}.jar",
    require => File["${path}/lib/logging"],
  }

  archive { "${path}/lib/logging/log4j-${log4j_version}.jar":
    ensure  => present,
    extract => false,
    source  => "${::jetty::mirror}/log4j/log4j/${log4j_version}/log4j-${log4j_version}.jar",
    require => File["${path}/lib/logging"],
  }

  exec { 'Libraries permissions':
    command => "chown -R ${::jetty::user}:${::jetty::group} ${path}/lib",
    path    => [ '/bin', '/usr/bin' ],
  }
}
