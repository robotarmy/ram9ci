load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
