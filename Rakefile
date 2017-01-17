require 'bundler'
Bundler.require(:rake)
require 'rake/clean'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet_blacksmith/rake_tasks'

CLEAN.include('spec/fixtures/', 'doc', 'pkg')
CLOBBER.include('.tmp')

# Puppet list permissive with this kind of Taliban rules
PuppetLint.configuration.send("disable_80chars")

task :default => [:clean, :spec]

