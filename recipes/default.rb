#
# Cookbook Name:: consul-template
# Recipe:: default
#
# Copyright (C) 2014
#
#
#

# install base tools & daemons
include_recipe 'gdp-base-linux'

service 'consul' do
  action :start
end

firewall_rule 'http' do
  port 8500
  source '0.0.0.0/0'
  firewall_name 'default'
  protocol :tcp
  command :allow
  action :create
  notifies :restart, 'firewall[default]', :delayed
end

if node['platform'] == 'windows'
  include_recipe "consul-template::install_windows_#{node['consul_template']['install_method']}"
  include_recipe 'consul-template::service_windows'
else
  include_recipe "consul-template::install_#{node['consul_template']['install_method']}"
  include_recipe 'consul-template::service'
end
