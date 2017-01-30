##
# 
define jetty::instance(
  String $path      = $title,
  Hash   $logconfig = {
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

  archive { "${path}/lib/logging/slf4-api-1.6.6.jar":
    ensure  => present,
    extract => false,
    source  => 'http://central.maven.org/maven2/org/slf4j/slf4j-api/1.6.6/slf4j-api-1.6.6.jar',
    require => File["${path}/lib/logging"],
  }

  archive { "${path}/lib/logging/slf4-log4j2-1.6.6.jar":
    ensure  => present,
    extract => false,
    source  => 'http://central.maven.org/maven2/org/slf4j/slf4j-log4j12/1.6.6/slf4j-log4j12-1.6.6.jar',
    require => File["${path}/lib/logging"],
  }

  archive { "${path}/lib/logging/log4j-1.2.17.jar":
    ensure  => present,
    extract => false,
    source  => 'http://central.maven.org/maven2/log4j/log4j/1.2.17/log4j-1.2.17.jar',
    require => File["${path}/lib/logging"],
  }

  exec { 'Libraries permissions':
    command => "chown ${::jetty::user}:${::jetty::group} ${path}/lib",
    path    => [ "/bin", "/usr/bin" ],
  }
}

