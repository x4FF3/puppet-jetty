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

  archive { "/tmp/${download_file_name}":
    ensure        => present,
    source        => $download_url,
    checksum_url  => "$download_url.sha1"
    extract       => true,
    extract_path  => $jetty::home,
    cleanup       => true,
    creates       => $jetty::home/jetty-installed,
    user          => $jetty::user,
    group         => $jetty::group,
    require       => User[$jetty::user],
  }

  file { "${jetty::home}/jetty":
    ensure => link,
    target => "${jetty::home}/${download_directory}",
  } ->
  file { '/var/log/jetty':
    ensure => link,
    target => "${jetty::home}/jetty/logs",
  } ->
  file { '/etc/init.d/jetty':
    ensure => link,
    target => "${jetty::home}/jetty/bin/jetty.sh",
  }
}

