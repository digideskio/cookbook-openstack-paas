# encoding: UTF-8
#
# Cookbook Name:: openstack-paas
# Recipe:: paas_worker
#
# Copyright 2014, Rackspace, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'runit::default'

for count in 1..node[:openstack][:paas][:number_of_workers] do
  runit_service "solum-worker-#{count}" do
    default_logger true
    run_template_name 'solum-worker'
    options(
      user: node[:openstack][:paas][:user],
      group: node[:openstack][:paas][:group],
      home: node[:openstack][:paas][:run_dir],
      homedir: node[:openstack][:paas][:home]
    )
    subscribes :restart, 'template[/etc/solum/solum.conf]'
    action [:enable]
  end
end
