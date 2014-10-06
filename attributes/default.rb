# Encoding: utf-8

default[:openstack][:identity][:service_types] = %w(application_deployment image identity compute storage ec2 volume object-store metering network orchestration cloudformation database data-processing)

default[:openstack][:paas][:install_type] = 'git'

default[:openstack][:paas][:git][:install_dir] = '/opt/solum'
default[:openstack][:paas][:git][:repository] = 'https://github.com/stackforge/solum.git'
default[:openstack][:paas][:git][:revision] = 'master'

default[:openstack][:paas][:tgz][:base_dir] = '/opt'
default[:openstack][:paas][:tgz][:install_dir] = "#{node[:openstack][:paas][:tgz][:base_dir]}/solum"
default[:openstack][:paas][:tgz][:source_file] = 'solum-master.tar.gz'

default[:openstack][:paas][:install_dir] = node[:openstack][:paas][node[:openstack][:paas][:install_type]][:install_dir]

default[:openstack][:paas][:client][:install_type] = 'git'
default[:openstack][:paas][:client][:git][:install_dir] = '/opt/solumclient'
default[:openstack][:paas][:client][:git][:repository] = 'https://github.com/stackforge/python-solumclient.git'
default[:openstack][:paas][:client][:git][:revision] = 'master'

default[:openstack][:paas][:custom_template_banner] = '
# This file autogenerated by Chef
# Do not edit, changes will be overwritten
'

# Keystone settings
default[:openstack][:paas][:api][:auth_strategy] = 'keystone'
default[:openstack][:paas][:api][:auth][:version] = node[:openstack][:api][:auth][:version]
default[:openstack][:paas][:service_user] = 'solum'
default[:openstack][:paas][:service_tenant_name] = 'service'
default[:openstack][:paas][:service_role] = 'admin'
default[:openstack][:paas][:region] = node[:openstack][:region]
# hash of config settings - see /opt/solum/etc/solum.conf.example
default[:openstack][:paas][:config] = {
  'DEFAULT' => {
  },
  api: {
    image_format: 'docker',
    host: '127.0.0.1',
    port: 9777
  },
  builder: {
    host: '127.0.0.1',
    port: 9778
  },
  conductor: {
    topic: 'solum-conductor',
    host: '127.0.0.1'
  },
  deployer: {
    handler: 'heat',
    topic: 'solum-deployer',
    host: '127.0.0.1'
  },
  worker: {
    handler: 'shell',
    topic: 'solum-worker',
    host: '127.0.0.1'
  },
  database: {},
  glance_client: {},
  heat_client: {},
  keystone_authtoken: {
    signing_dir: '/var/cache/solum'
  },
  matchmaker_ring: {},
  neutron_client: {},
  swift_client: {}
}

default[:openstack][:paas][:syslog][:use] = false
default[:openstack][:paas][:syslog][:facility] = 'LOCAL2'
default[:openstack][:paas][:syslog][:config_facility] = 'local2'

# platform defaults
case platform_family
when 'debian'
  default[:openstack][:paas][:user] = 'solum'
  default[:openstack][:paas][:group] = 'solum'
  default[:openstack][:paas][:home] = '/usr/local/solum'
  default[:openstack][:paas][:platform] = {
    prereq_packages: ['libffi-dev'],
    mysql_python_packages: ['python-mysqldb'],
    postgresql_python_packages: ['python-psycopg2'],
    memcache_python_packages: ['python-memcache'],
    solum_packages: [:solum],
    solum_client_packages: ['python-solumclient'],
    solum_service: 'solum',
    solum_process_name: 'solum-all',
    package_options: "-o Dpkg::Options::='--force-confold' -o Dpkg::Options::='--force-confdef'"
  }
end

default[:openstack][:paas][:services] = []

default[:openstack][:paas][:number_of_workers] = 1
