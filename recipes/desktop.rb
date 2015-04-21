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

package "openjdk-7-jre"
package "openjdk-7-jdk"

node.normal['idea']['setup_dir'] = '/opt/idea'
node.normal['idea']['version'] = '14.1.1'
include_recipe "idea::default"