require 'spec_helper'

describe 'jetty' do

  context 'On a CentOS 6' do
    let :facts do
      {
      :osfamily  => 'RedHat',
      :osname    => 'CentOS',
      :osreleasemajor => '6'
      }
    end

    let :params do
      {
      :version        => '9.2.20.v20161216',
      :http_port      => 8081,
      :mirror         => 'http://central.maven.org/maven2',
      :archive_type   => 'tar.gz',
      :home           => '/opt',
      :service_ensure => 'running',
      :manage_user    => true,
      :user           => 'jettyuser',
      :group          => 'jettygroup',
      :java_options   => '-Xms64 -Xmx128 -Dmy_test_option=test_value'
      }
    end

    it { is_expected.to compile.with_all_deps }

    it do
      is_expected.to contain_user('jettyuser').with({
        'gid' =>'jettygroup'
      })
    end

    it do
      is_expected.to contain_file('/opt/jetty-distribution-9.2.20.v20161216').with({
        'ensure' =>'directory',
        'owner'  =>'jettyuser',
        'group'  =>'jettygroup',
      })
    end

    it do
      is_expected.to contain_file('/opt/jetty').with({
        'ensure' =>'link',
        'target' =>'/opt/jetty-distribution-9.2.20.v20161216',
      })
    end

    it do is_expected.to contain_file('/etc/default/jetty').with({
      'ensure' =>'present',
      'owner'  =>'jettyuser',
      'group'  =>'jettygroup',
      })
    end

    it do is_expected.to contain_service('jetty').with({
      'ensure' =>'running',
    })
    end
  end
end

