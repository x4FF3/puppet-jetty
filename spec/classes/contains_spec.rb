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
      :configuration   => { 'modules' => {  } },
      :logconfig       => { 'loglevel' => 'INFO', 'appenders' => ['Console'] }
      }
    end

    it { is_expected.to compile.with_all_deps }

    describe "Testing the dependencies among the classes" do
      it { should contain_class('jetty::install') }
      it { should contain_class('jetty::config') }
      it { should contain_class('jetty::service') }
      it { is_expected.to contain_class('jetty::install').that_comes_before('Class[jetty::config]') }
      it { is_expected.to contain_class('jetty::service').that_subscribes_to('Class[jetty::config]') }
    end
  end
end
