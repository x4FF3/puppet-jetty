##
# = class: jetty::service - This class manages the Jetty service
class jetty::service inherits jetty {

  service { 'jetty':
    ensure     => $jetty::service_ensure,
    hasstatus  => false,
    hasrestart => true,
  }
}

