##
# = class: jetty::config - This module manages the jetty Web Server configuration
class jetty::config inherits jetty {

  file { '/etc/default/jetty':
    ensure  => present,
    owner   => $jetty::user,
    group   => $jetty::group,
    mode    => '0760',
    content => epp('jetty/jetty-defaults.epp')
  }

  file { "${jetty::base}/start.ini":
    ensure  => present,
    owner   => $jetty::user,
    group   => $jetty::group,
    mode    => '0750',
    content => epp('jetty/start.ini.epp')
  }
}

