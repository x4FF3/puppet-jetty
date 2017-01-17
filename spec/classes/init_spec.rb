require 'spec_helper'

describe 'jetty' do

  let(:params) {{
    :version        => '9.2.20.v20161216',
    :http_port      => 8081,
    :mirror         => 'http://central.maven.org/maven2',
    :archive_type   => 'tar.gz',
    :home           => '/opt',
    :service_ensure => 'running',
    :manage_user    => true,
    :user           => 'jettyuser',
    :group          => 'jettygroup'
  }}

  it { should compile.with_all_deps }

  it { should contain_file('/opt/jetty').with_ensure('link').with_target('/opt/jetty-distribution-9.2.20.v20161216') }
  it { should contain_service('jetty').with_ensure("running") }
end

