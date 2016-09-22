name             'consul-template'
maintainer       'Adam Krone'
maintainer_email 'krone.adam@gmail.com'
license          'Apache v2.0'
description      'Installs/Configures consul-template'
long_description 'Installs/Configures consul-template'
version          '0.11.0'

supports 'centos', '>= 6.7'

depends 'gdp-base-linux', '= 3.0.1'
depends 'apt', '= 2.9.2'
depends 'consul', '= 2.1.3'
depends 'ark', '= 0.9.0'
depends 'chef-sugar', '= 3.3.0'
depends 'libarchive', '= 0.6.2'
depends 'firewall', '= 2.3.0'
depends 'golang', '= 1.4'
depends 'runit', '= 1.8.0'
depends 'nssm', '= 1.2.1'

issues_url 'https://github.com/adamkrone/chef-consul-template/issues' if respond_to?(:issues_url)
source_url 'https://github.com/adamkrone/chef-consul-template' if respond_to?(:source_url)
