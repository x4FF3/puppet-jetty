##
# = class: jetty::install - The installation of jetty's stuff 
class jetty::install inherits jetty {

  if $jetty::manage_user {

    ensure_resource('user', $jetty::user, {
      managehome => true,
      system     => true,
      gid        => $jetty::group,
    })

    ensure_resource('group', $jetty::group, {
      ensure => present,
    })
  }

  include '::archive'

  $download_url = "${jetty::mirror}/org/eclipse/jetty/jetty-distribution-${jetty::version}/jetty-distribution-${jetty::version}.tar.gz"

  archive { 'Jetty download':
    ensure        => present,
    path          => "/tmp/jetty-distribution-${jetty::version}.tar.gz",
    source        => $download_url,
    checksum      => $jetty::checksum,
    checksum_type => $jetty::checksum_type,
    cleanup       => false,
    user          => $jetty::user,
    group         => $jetty::group,
    notify        => Service['jetty'],
    require       => User[$jetty::user],
  }

  file { "${jetty::home}/jetty":
    ensure => "${jetty::home}/jetty-distribution-${jetty::version}",
  } ->

  file { '/var/log/jetty':
    ensure => "${jetty::home}/jetty/logs",
  } ->

  file { '/etc/init.d/jetty':
    ensure  => "${jetty::home}/jetty-distribution-${jetty::version}/bin/jetty.sh",
    require => File['/etc/default/jetty']
  }
}

