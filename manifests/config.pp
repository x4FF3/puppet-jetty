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
    content => epp('jetty/jetty-defaults.epp'),
  }

  file { "${::jetty::base}/start.ini":
    ensure  => present,
    content => epp('jetty/start.ini.epp'),
  }
}

