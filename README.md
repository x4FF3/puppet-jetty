# Puppet-Jetty 
[![Build Status](https://travis-ci.org/jjuarez/puppet-jetty.svg?branch=master)](https://travis-ci.org/jjuarez/puppet-jetty)
[![Github Tag](https://img.shields.io/github/tag/jjuarez/puppet-jetty.svg)](https://github.com/jjuarez/puppet-jetty)
[![Puppet Forge Downloads](http://img.shields.io/puppetforge/dt/jjuarez/puppet-jetty.svg)](https://forge.puppetlabs.com/jjuarez/puppet-jetty)

A module to install Jetty and configure the service. This module has been highly inspired on maestroweb/jetty module

## Usage

### Minimal setup

```puppet
  class { '::jetty':
    version => '9.2.20.v20161216',
  }
```

### More sofisticated setup

```puppet
  class { '::jetty':
    root            => '/opt',
    base            => '/opt/web/base',
    version         => '9.2.20.v20161216',
    service_ensure  => 'running',
    manage_user     => true,
    user            => 'jettyuser',
    group           => 'jettygroup',
    mirror          => 'http://central.maven.org/maven2/',
    archive_type    => 'tar.gz',
    checksum_type   => 'sha1',
    jetty_arguments => 'jetty.some_option=some_value'
    java            => '/usr/java/jdk1.8.0_51/bin/java',
    java_options    => '-Xms128M -Xmx1G -Djvm_key=jvm_value',
  }
```

This is a puppet 4 module, the recomendation is to use the binding capabilities of this puppet version. First configure in your hiera hierarchy the options that you want to setup

```yaml
---
    jetty::root: '/opt'
    jetty::base: '/opt/web/base'
    jetty::version: '9.2.20.v20161216'
    jetty::service_ensure: 'running'
    jetty::manage_user: true
    jetty::user: 'jettyuser'
    jetty::group: 'jettygroup'
    jetty::mirror: 'http://central.maven.org/maven2/'
    jetty::archive_type: 'tar.gz'
    jetty::checksum_type: 'sha1'
    jetty_arguments: 'jetty.some_option=some_value'
    jetty::java: '/usr/java/jdk1.8.0_51/bin/java'
    jetty::java_options: '-Xms128M -Xmx1G -Djvm_key=jvm_value
```

Then you only need to include the class in your profile class

```puppet
  include '::jetty'
```

### For a complete customization for the start.ini config file.

You must include an additional parameter in the manifest called configuration, which is an optional Hash, in the form:

```yaml
  ---
    jetty::root: '/opt',
    jetty::base: '/opt/web/base'
    jetty::version: '9.2.20.v20161216'
    jetty::service_ensure: 'running'
    jetty::manage_user: true
    jetty::user: 'jettyuser'
    jetty::group: 'jettygroup'
    jetty::mirror: 'http://central.maven.org/maven2/'
    jetty::archive_type: 'tar.gz'
    jetty::checksum_type: 'sha1'
    jetty_arguments: 'jetty.some_option=some_value'
    jetty::java: '/usr/java/jdk1.8.0_51/bin/java'
    jetty::java_options: '-Xms128M -Xmx1G -Djvm_key=jvm_value'
    jetty::configuration:
      modules:
        server:
          threads.min: 10
          threads.max: 20
          threads.timeout: 60000
          jetty.output.buffer.size: 32768
          jetty.request.header.size: 8192
          jetty.response.header.size: 8192
          jetty.send.server.version: false
          jetty.send.date.header: false
          jetty.dump.start: false
          jetty.dump.stop: false
          jetty.delayDispatchUntilContent: false
        deploy:
          jetty.deploy.monitoredDirName: webapps
        http:
          jetty.port: 8081
          http.timeout: 30000
          http.soLingerTime: -1
          http.selectors: 1
          http.acceptors: 1
          http.selectorPriorityDelta: 
          http.acceptorPriorityDelta: 0
        jsp:
```

