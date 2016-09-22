require 'spec_helper'
require 'fauxhai'

describe 'consul-template::install_source' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '7.1.1503') do |node|
        Chef::Config[:client_key] = "/etc/chef/client.pem"
        stub_command("/usr/local/go/bin/go version | grep \"go1.2.2 \"").and_return('derp')
      end.converge(described_recipe)
    end

  it 'should include golang::default' do
    expect(chef_run).to include_recipe('golang::default')
  end

  it 'should create the hashicorp go directory' do
    expect(chef_run).to create_directory('/opt/go/src/github.com/hashicorp')
  end

  it 'should checkout the consul-template git repo' do
    expect(chef_run).to checkout_git('/opt/go/src/github.com/hashicorp/consul-template')
  end

  it 'should install consul-template with go' do
    expect(chef_run).to install_golang_package('github.com/hashicorp/consul-template')
  end

  it 'should link consul-template to its install directory' do
    expect(chef_run).to create_link('/usr/local/bin/consul-template')
  end
end
