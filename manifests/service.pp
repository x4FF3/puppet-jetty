##
# = class: jetty::service - This class manages the Jetty service
class jetty::service inherits jetty {

  case $::facts['osfamily'] {
    'Debian': {
      #Create systemd file and start service
      ::systemd::service {$::jetty::instance::title: }

    }
    default: {
      service { 'Jetty Service':
        ensure     => $jetty::service_ensure,
        name       => 'jetty',
        enable     => true,
        hasstatus  => true,
        hasrestart => true,
      }
    }
  }
}
