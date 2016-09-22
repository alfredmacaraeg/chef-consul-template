require 'spec_helper'
require 'fauxhai'

describe 'consul-template::default' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '7.1.1503') do |node|
        Chef::Config[:client_key] = "/etc/chef/client.pem"
      end.converge(described_recipe)
    end

  it 'should start consul service' do
    expect(chef_run).to start_service('consul')
  end

  it 'creates a firewall rule' do
      expect(chef_run).to create_firewall_rule('http')
   end

  it 'includes consul-template::install_binary' do
    expect(chef_run).to include_recipe('consul-template::install_binary')
  end

  it 'includes consul-template::service' do
    expect(chef_run).to include_recipe('consul-template::service')
  end
end
