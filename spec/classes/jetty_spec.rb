require 'spec_helper'

describe 'jetty' do

  context 'On a CentOS 6' do
    let :facts do
      {
      :osfamily       => 'RedHat',
      :osname         => 'CentOS',
      :osreleasemajor => '6'
      }
    end

    let :params do
      {
      :root            => '/opt',
      :base            => '/opt/web',
      :version         => '9.2.20.v20161216',
      :service_ensure  => 'running',
      :manage_user     => true,
      :user            => 'jettyuser',
      :group           => 'jettygroup',
      :mirror          => 'http://central.maven.org/maven2',
      :archive_type    => 'tar.gz',
      :checksum_type   => 'sha1',
      :jetty_arguments => 'jetty.bizarre_option=bizarre_value',
      :java            => '/usr/bin/java',
      :java_options    => '-Xms64 -Xmx128 -Djvm_option=jvm_value',
      :configuration   => { 'modules' =>{  } }
      }
    end

    it do
      is_expected.to compile.with_all_deps
    end

    it do
      is_expected.to contain_user('jettyuser').with({
        'system' => false,
        'shell'  => '/bin/false',
        'home'   => '/opt/jetty/tmp',
        'gid'    => 'jettygroup'
       })
    end

    it do
      is_expected.to contain_file('/opt/jetty-distribution-9.2.20.v20161216').with({
        'ensure' => 'directory',
        'owner'  => 'jettyuser',
        'group'  => 'jettygroup',
      })
    end

    it do
      is_expected.to contain_file('/opt/jetty').with({
        'ensure' => 'link',
        'target' => '/opt/jetty-distribution-9.2.20.v20161216',
      })
    end

    it do
      is_expected.to contain_file('/opt/jetty/tmp').with({
        'ensure' => 'directory',
        'owner'  => 'jettyuser',
        'group'  => 'jettygroup',
        'mode'   => '0774',
      })
    end

    it do
      is_expected.to contain_file('/opt/web').with({
        'ensure' => 'directory',
        'owner'  => 'jettyuser',
        'group'  => 'jettygroup',
      })
    end

    it do
      is_expected.to contain_file('/opt/web/webapps').with({
        'ensure' => 'directory',
        'owner'  => 'jettyuser',
        'group'  => 'jettygroup',
      })
    end

    it do
      is_expected.to contain_file('/etc/default/jetty').with({
        'ensure' => 'present',
        'path'   => '/etc/default/jetty',
        'owner'  => 'jettyuser',
        'group'  => 'jettygroup',
      })
    end

    # Test for the minimum content in the file
    it do
      is_expected.to contain_file('/etc/default/jetty') \
        .with_content(/^JETTY_HOME="\/opt\/jetty"$/) \
        .with_content(/^JETTY_BASE="\/opt\/web"$/) \
        .with_content(/^JETTY_USER="jettyuser"$/) \
        .with_content(/^JETTY_SHELL="\/bin\/sh"$/) \
        .with_content(/^JETTY_ARGS="jetty.bizarre_option=bizarre_value"$/) \
        .with_content(/^TMPDIR="\/opt\/jetty\/tmp"$/) \
        .with_content(/^JAVA="\/usr\/bin\/java"$/) \
        .with_content(/^JAVA_OPTIONS="-Xms64 -Xmx128 -Djvm_option=jvm_value"$/)
    end

    it do
      is_expected.to contain_service('Jetty Service').with({
        'ensure'     => 'running',
        'name'       => 'jetty',
        'enable'     => true,
        'hasrestart' => true,
        'hasstatus'  => true,
      })
    end
  end
end
