##
# = class: jetty::config - This module manages the jetty Web Server configuration
class jetty::config inherits jetty {

  File {
    owner => $jetty::user,
    group => $jetty::group,
  }

  file { '/etc/default/jetty':
    ensure  => present,
    mode    => '0740',
    content => template('jetty/jetty-defaults.erb'),
  }

  file { "${::jetty::base}/start.ini":
    ensure  => present,
    mode    => '0740',
    content => template('jetty/start.ini.erb'),
    require => File[$::jetty::base],
  }

  # Configures a complete base (instance)
  ::jetty::instance { $::jetty::base:
    logconfig => $::jetty::logconfig,
  }
}
