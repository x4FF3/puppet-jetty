##
# = class: jetty::config - This module manages the jetty Web Server configuration
class jetty::config inherits jetty {

  File {
    owner => $jetty::user,
    group => $jetty::group,
    mode  => '0740',
  }

  file { '/etc/default/jetty':
    ensure  => present,
    content => template('jetty/jetty-defaults.erb'),
  }

  file { "${::jetty::base}/resources/log4j.properties":
    ensure  => present,
    content => template('jetty/log4j.properties.erb'),
  }

  file { "${::jetty::base}/start.ini":
    ensure  => present,
    content => template('jetty/start.ini.erb'),
  }
}

