##
# = class: jetty - This class helps to install a Jetty Web Server
class jetty(
  Stdlib::Absolutepath      $root,
  Stdlib::Absolutepath      $base,
  String                    $version,
  Integer                   $http_port,
  Enum['running', 'stoped'] $service_ensure,
  Boolean                   $manage_user,
  String                    $user,
  String                    $group,
  Stdlib::Httpurl           $mirror,
  Enum['tar.gz', 'zip']     $archive_type,
  Enum['sha1', 'md5']       $checksum_type,
  Optional[String]          $java,
  Optional[String]          $java_options,
  Optional[Hash]            $options,
  ) {

  contain jetty::install
  contain jetty::config
  contain jetty::service

  Class['::jetty::install'] ->
  Class['::jetty::config'] ~>
  Class['::jetty::service']
}
