# Puppet-Jetty

A module to install Jetty and configure the service. This module has been highly inspired on maestroweb/jetty module

## Usage

### Minimal setup
    class { '::jetty':
      version => '9.2.20.v20161216',
      root    => '/opt',
    }

### More sofisticated setup
    class { '::jetty':
      root         => '/opt',
      base         => '/opt/web/base',
      tmpdir       => '/opt/jetty/tmp',
      version      => '9.2.20.v20161216',
      http_port    => 8080,
      manage_user  => true,
      user         => 'jettyuser',
      group        => 'jettygroup',
      mirror       => 'http://central.maven.org/maven2/',
      archive_type => 'tar.gz',
      java         => '/usr/java/jdk1.8.0_51/bin/java',
      java_options => '-Xms128M -Xmx1G -Dsolr.process=_SOLR_',
    }


This is a puppet 4 module, the recomendation is to use the binding capabilities of this puppet version. First configure in your hiera hierarchy the options that you want to setup

    ---
      jetty::root: '/opt',
      jetty::base: '/opt/web/base',
      jetty::tmpdir: '/opt/jetty/tmp',
      jetty::version: '9.2.20.v20161216',
      jetty::http_port: 8080,
      jetty::manage_user: true,
      jetty::user: 'jettyuser',
      jetty::group: 'jettygroup',
      jetty::mirror: 'http://central.maven.org/maven2/',
      jetty::archive_type: 'tar.gz',
      jetty::java: '/usr/java/jdk1.8.0_51/bin/java',
      jetty::java_options: '-Xms128M -Xmx1G -Dsolr.process=_SOLR_',
    ...

Then include the class in your profile class

    include '::jetty'

