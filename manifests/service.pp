##
# = class: jetty::service - This class manages the Jetty service
class jetty::service inherits jetty {

  service { 'Jetty Service':
    ensure     => $jetty::service_ensure,
    name       => 'jetty',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
