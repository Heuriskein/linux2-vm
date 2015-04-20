#
# Cookbook Name:: linux-vm
# Recipe:: desktop
#

case node['platform_family']
when "debian"
  include_recipe "linux-vm::desktop_debian"
end

# Install IntelliJ IDEA
directory "/opt/idea" do
  action :create
end

node.normal['idea']['setup_dir'] = '/opt/idea'
include_recipe "idea::default"