##
# = class: jetty::install - The installation of jetty's stuff 
class jetty::install inherits jetty {

  $jetty_home            = "${jetty::root}/jetty"
  $download_directory    = "jetty-distribution-${jetty::version}"
  $download_file_name    = "${download_directory}.${jetty::archive_type}"
  $download_url          = "${jetty::mirror}/org/eclipse/jetty/jetty-distribution/${jetty::version}/${download_file_name}"
  $download_url_checksum = "${download_url}.sha1"

  include '::archive'

  if $jetty::manage_user {
    ensure_resource('user', $jetty::user, {
      shell  => '/bin/false',
      system => false,
      home   => "${jetty_home}/tmp",
      gid    => $jetty::group,
    })

    ensure_resource('group', $jetty::group, {
      ensure => present,
    })
  }

  file { '/etc/init.d/jetty':
    ensure => link,
    target => "${jetty_home}/bin/jetty.sh",
  } ->
  file { '/var/log/jetty':
    ensure => link,
    target => "${jetty_home}/logs",
  } ->
  file { "${jetty_home}/tmp":
    ensure => directory,
    owner  => $jetty::user,
    group  => $jetty::group,
    mode   => '0775',
  } ->
  file { $jetty_home:
    ensure => link,
    target => "${jetty::root}/${download_directory}",
  } ->
  file { "${jetty::root}/${download_directory}":
    ensure => directory,
    owner  => $jetty::user,
    group  => $jetty::group,
    mode   => '0754',
  } ->
  archive { "/tmp/${download_file_name}":
    ensure          => present,
    source          => $download_url,
    checksum_url    => $download_url_checksum,
    checksum_verify => true,
    allow_insecure  => true,
    extract         => true,
    extract_path    => $jetty::root,
    cleanup         => true,
    creates         => "${jetty::root}/jetty-installed",
    user            => $jetty::user,
    group           => $jetty::group,
    require         => User[$jetty::user],
  }

  # Jetty Base setup
  file { "${jetty::root}/web/base/webapps":
    ensure => directory,
    owner  => $jetty::user,
    group  => $jetty::group,
    mode   => '0754',
  } ->
  file { "${jetty::root}/web/base":
    ensure => directory,
    owner  => $jetty::user,
    group  => $jetty::group,
    mode   => '0754',
  } ->
  file { "${jetty::root}/web":
    ensure => directory,
    owner  => $jetty::user,
    group  => $jetty::group,
    mode   => '0754',
  }
}
