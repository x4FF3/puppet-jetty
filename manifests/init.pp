##
# = class: jetty - This class helps to install a Jetty Web Server
class jetty(
  String                    $version,
  String                    $checksum,
  Enum['md5', 'sha1']       $checksum_type,
  Stdlib::Absolutepath      $home,
  Enum['running', 'stoped'] $ensure,
  Boolean                   $manage_user,
  String                    $user,
  String                    $group,
  ) {

  class { '::jetty::install' } ->
  class { '::jetty::config'  } ~>
  class { '::jetty::service' } ->
  Class['::jetty']
}

