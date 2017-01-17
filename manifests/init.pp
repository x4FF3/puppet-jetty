##
# = class: jetty - This class helps to install a Jetty Web Server
class jetty(
  String                    $version,
  Stdlib::Httpurl           $mirror,
  Enum['tar.gz', 'zip']     $archive_type,
  Stdlib::Absolutepath      $home,
  Optional[String]          $args,
  Enum['running', 'stoped'] $service_ensure,
  Boolean                   $manage_user,
  String                    $user,
  String                    $group,
  ) {

  contain jetty::install
  contain jetty::config
  contain jetty::service

  Class['::jetty::install'] ->
  Class['::jetty::config'] ~>
  Class['::jetty::service']
}

