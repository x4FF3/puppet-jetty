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

  $download_directory = "jetty-distribution-${jetty::version}"
  $download_file_name = "${download_directory}.${jetty::archive_type}"
  $download_url       = "${jetty::mirror}/org/eclipse/jetty/jetty-distribution/${jetty::version}/${download_file_name}"

  archive { 'Jetty download':
    ensure        => present,
    path          => "${jetty::home}/${download_directory}",
    source        => $download_url,
    checksum      => $jetty::checksum,
    checksum_type => $jetty::checksum_type,
    extract       => true,
    cleanup       => false,
    user          => $jetty::user,
    group         => $jetty::group,
    require       => User[$jetty::user],
  }

  file { "${jetty::home}/jetty":
    ensure => link,
    target => "${jetty::home}/jetty-distribution-${jetty::version}",
  } ->

  file { '/var/log/jetty':
    ensure => "${jetty::home}/jetty/logs",
  } ->

  file { '/etc/init.d/jetty':
    ensure  => "${jetty::home}/jetty-distribution-${jetty::version}/bin/jetty.sh",
  }
}

