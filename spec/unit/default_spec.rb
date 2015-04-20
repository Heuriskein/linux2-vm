require_relative '../spec_helper'

rmills_data = {
  "id" => "rmills",
  "shell" => "/bin/bash",
  "comment" => "Ryan Mills",
  "desktop-autologin" => "true",
  "disable-screensaver" => "true",
  "dotfiles-repo" => "https://github.com/Heuriskein/dotfiles",
  "groups" => ["sysadmin"]
}

describe 'linux-vm::default' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04') do |node, server|
      server.create_data_bag(:users, rmills_data)
    end.converge(described_recipe)
  end

  it 'requires proper recipes to build a single box stack' do
    expect(chef_run).to include_recipe('linux-vm::locale')
    expect(chef_run).to include_recipe('linux-vm::desktop')
    expect(chef_run).to include_recipe('linux-vm::develoepr')
  end
end