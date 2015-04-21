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

package "git"      # required for this recipe to work
package "wget"


# Install Idea and provide it an up-to-date version to use.
node.normal['idea']['setup_dir'] = '/opt/idea'
node.normal['idea']['version'] = '14.1.1'
include_recipe "idea::default"

# Grab a newer version of the jdk and update the JAVA_HOME variable to point to it.
package "openjdk-7-jdk"
file '/etc/profile.d/jdk.sh' do
  action :create
  owner "root"
  group "root"
  mode "0644"
  content "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64"
end