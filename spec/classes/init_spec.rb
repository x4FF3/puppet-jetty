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

    it { should compile.with_all_deps }
    it { should contain_user('jettyuser').with_gid('jettygroup') }
    it { should contain_file('/opt/jetty-distribution-9.2.20.v20161216').with_ensure('directory') }
    it { should contain_file('/opt/jetty').with_ensure('link').with_target('/opt/jetty-distribution-9.2.20.v20161216') }
    it { should contain_service('jetty').with_ensure('running') }
  end
end

