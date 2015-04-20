#
# Cookbook Name:: linux-vm
# Recipe:: default
#

# Include other internal recipes from this repo
include_recipe "linux-vm::users"
include_recipe "linux-vm::desktop"