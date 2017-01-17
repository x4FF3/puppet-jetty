##
# = class: jetty::config - This module manages the jetty Web Server configuration
class jetty::config inherits jetty {

  file { '/etc/default/jetty':
    ensure  => present,
    owner   => $jetty::user,
    group   => $jetty::group,
    mode    => '0760',
    content => template('jetty/jetty-defaults')
  }
}

