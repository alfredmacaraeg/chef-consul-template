require 'spec_helper'

describe 'consul-template-spec::consul_template_config' do
  cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '7.1.1503', step_into: ['consul_template_config'], file_cache_path: '/var/chef/cache') do |node|
        Chef::Config[:client_key] = "/etc/chef/client.pem"
      end.converge(described_recipe)
    end

  describe 'create' do
    it 'should create the consul_template_config' do
      expect(chef_run).to create_consul_template_config('test')
    end

    it 'should create the config file' do
      expect(chef_run).to create_template('/etc/consul-template.d/test')
    end

    it 'should create the ctmplfile' do
      expect(chef_run).to create_template('/tmp/test.config.ctmpl')
    end

    it 'should add the test key/value' do
      expect(chef_run).to run_execute('add test key/value')
    end

    it 'should notify consul-template to restart' do
      consul_template = chef_run.consul_template_config('test')
      expect(consul_template).to notify('service[consul-template]').to(:restart).delayed
    end
  end
end
