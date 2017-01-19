##
# = class: jetty::config - This module manages the jetty Web Server configuration
class jetty::config inherits jetty {

  $_start_ini = "${jetty::base}/start.ini"

  file { '/etc/default/jetty':
    ensure  => present,
    owner   => $jetty::user,
    group   => $jetty::group,
    mode    => '0740',
    content => epp('jetty/jetty-defaults.epp'),
  }

  file { $_start_ini:
    ensure  => present,
    owner   => $jetty::user,
    group   => $jetty::group,
    mode    => '0740',
    content => epp('jetty/start.ini.epp'),
  }
}

