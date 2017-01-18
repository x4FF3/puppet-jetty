source :rubygems

puppet_version = ENV.key?('PUPPET_VERSION') ? "= #{ENV['PUPPET_VERSION']}" : ['>=4.0.0']

group :rake do
  gem 'puppet', puppet_version
  gem 'puppetlabs_spec_helper'
  gem 'rspec-puppet'
  gem 'rake'
  gem 'puppet-lint'
  gem 'metadata-json-lint'
  gem 'puppet-blacksmith'
end

