##
# = class: jetty::service - This class manages the Jetty service
class jetty::service inherits jetty {

  service { 'jetty':
    ensure     => $jetty::ensure,
    hasstatus  => false,
    hasrestart => true,
  }
}

