#
# Cookbook Name:: linux2-vm
# Recipe:: desktop_debian
#

include_recipe "desktop"

# Install desktop
  package "gnome-shell"


# Disable screensaver
  search("users", "disable-screensaver:true NOT action:remove") do |u|
    desktop_settings "idle-activation-enabled" do
      schema "org.gnome.desktop.screensaver"
      user u['id']
      value "false"
      type "bool"
    end
  end

# Browser
  package "firefox"

# Copy/paste from command-line
  package "xsel"
