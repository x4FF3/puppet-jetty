# Puppet-Jetty

A module to install Jetty and configure the service

## Usage

    class { 'jetty':
      version => "9.0.4.v20130625",
      home    => "/opt",
      user    => "jetty",
      group   => "jetty",
    }

## Upgrading

### From 1.0.0

The class now accepts parameters, change $jetty_home, $jetty_version, $jetty_group and $jetty_user to class parameters as described in usage

