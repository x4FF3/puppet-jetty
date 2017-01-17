# Puppet-Jetty

A module to install Jetty and configure the service. This module has been highly inspired on maestroweb/jetty module

## Usage

    class { '::jetty':
      version => '9.2.20.v20161216',
      home    => '/opt',
      user    => 'jetty',
      group   => 'jetty',
    }

This is a puppet 4 module, the recomendation is to use the binding capabilities of this puppet version

    ---
      jetty::version: '9.2.20.v20161216'
      jetty::home: /opt
      jetty::user: jetty
      jetty::group: servers

    include '::jetty'

