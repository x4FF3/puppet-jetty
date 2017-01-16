##
# = class: jetty::install - The installation of jetty's stuff 
class jetty::install inherits jetty {

  if $jetty::manage_user {

    ensure_resource('user', $jetty::user, {
      mangehome => true,
      system    => true,
      git       => $jetty::group,
    }

    ensure_resource('group', $jetty::group, {
      ensure => present,
    }
  }

  include '::archive'

  archive { 'jetty_download':
    ensure        => present,
    source        => "http://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/${jetty::version}/jetty-distribution-${jetty::version}.tar.gz",
    checksum      => $jetty::checksum,
    checksum_type => $jetty::checksum_type,
    cleanup       => false,
    user          => $solr::user,
    group         => $solr::group,
    notify        => Service['jetty'],
    require       => [File[$solr::home],User[$solr::user]],
  }

  file { "${jetty::home}/jetty":
    ensure => "${jetty::home}/jetty-distribution-${version}",
  } ->

  file { '/var/log/jetty':
    ensure => "${jetty::home}/jetty/logs",
  } ->

  $jetty_default_config_file = ? $facts['os']['name'] : {
    'RedHat', 'CentOS' => '/etc/sysconfig/jetty',
    'Debian', 'Ubuntu' => '/etc/default/jetty',
    default            => '/etc/default/jetty'
  }

  file { $jetty_default_config_file:
    content => template('jetty/defaults'),
  } ->

  file { '/etc/init.d/jetty':
    ensure => "${home}/jetty-distribution-${version}/bin/jetty.sh",
  }
}

