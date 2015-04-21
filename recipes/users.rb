#
# Cookbook Name:: linux2-vm
# Recipe:: users
#

# Find any users listed in data_bags/users/*.json that
# are members of sysadmin group and not being removed
# then create those users
include_recipe 'users::sysadmins'

# Configure sudo access to disable insecure login methods
# (i.e. passwords). See attributes/ssh.rb for details.
include_recipe 'sudo'

# Find any users listed in data_bags/users/*.json that
# are members of sysadmin group and not being removed
# then configure those users
search('users', "groups:sysadmin NOT action:remove") do |u|

  # Enable password-less sudo access for this user
  sudo u['id'] do
    user      u['id']
    nopasswd  true
  end

  # Remove password for user
  execute "Remove password for #{u['id']}" do
    command "sudo passwd -d #{u['id']}"
  end

  if u['ssh_keys'].length == 0 then
    fail "#{u['id']} does not have an ssh-key specified."
  end
end

if platform?("ubuntu")
  execute "set boot timeout to 0" do
    user 'root'
    command "sed --in-place=.bak -r -e 's/GRUB_TIMEOUT=[0-9]+/GRUB_TIMEOUT=0/' /etc/default/grub && update-grub"
    not_if "grep -q 'GRUB_TIMEOUT=0' /etc/default/grub"
  end
else
  execute "set boot timeout=0" do
    user 'root'
    command "sed --in-place=.bak -r -e 's/timeout=[0-9]+/timeout=0/' /boot/grub/grub.conf"
  end
end
